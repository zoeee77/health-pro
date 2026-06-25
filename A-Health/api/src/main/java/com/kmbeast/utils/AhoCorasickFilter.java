package com.kmbeast.utils;

import com.kmbeast.mapper.SensitiveWordMapper;
import lombok.extern.slf4j.Slf4j;

import java.util.*;

/**
 * AC自动机敏感词过滤器
 * 支持从 Redis 缓存或数据库动态加载敏感词词典
 * 算法：Aho-Corasick 多模式匹配，一次遍历完成所有敏感词检测
 *
 * 数学表达 ：
 * 设：S = {w₁, w₂, ..., wₙ} 为敏感词集合，T = t₁t₂...tₘ 为待检测文本，δ: Trie节点转移函数，F ⊆ Q 为接受状态（敏感词结束节点）
 * 匹配过程可表示为：
 * 对于文本T中的每个位置i，检查是否存在j使得：δ*(root, tᵢ...t) ∈ F，其中δ*表示状态转移的闭包。
 *
 * 性能优化：
 * - 词典通过 Redis Hash 缓存，避免每次重建 Trie 树
 * - Redis 缓存未命中时，从数据库加载并同步到 Redis
 */
@Slf4j
public class AhoCorasickFilter {

    private final AcNode root = new AcNode();
    private RedisService redisService;
    private SensitiveWordMapper sensitiveWordMapper;

    /**
     * 默认构造函数：使用内置敏感词
     */
    public AhoCorasickFilter() {
        buildFromDefaultWords();
    }

    /**
     * 构造函数：使用 Redis 缓存词典
     */
    public AhoCorasickFilter(RedisService redisService) {
        this.redisService = redisService;
        buildFromRedis();
    }

    /**
     * 构造函数：使用 Redis + 数据库（完整方案）
     */
    public AhoCorasickFilter(RedisService redisService, SensitiveWordMapper sensitiveWordMapper) {
        this.redisService = redisService;
        this.sensitiveWordMapper = sensitiveWordMapper;
        buildFromRedis();
    }

    private static final String REDIS_KEY = "filter:sensitive_words";

    /**
     * 默认敏感词列表
     */
    private static final List<String> DEFAULT_WORDS = Arrays.asList(
            "暴力", "色情", "赌博", "毒品"
    );

    /**
     * 从 Redis 加载敏感词词典构建 Trie 树
     * 加载策略：Redis 缓存 → 数据库加载 → 内置默认词
     */
    private void buildFromRedis() {
        List<String> words = loadWords();
        build(words);
    }

    /**
     * 从内置默认词构建
     */
    private void buildFromDefaultWords() {
        build(DEFAULT_WORDS);
    }

    /**
     * 加载敏感词词典（三级缓存策略）
     */
    private List<String> loadWords() {
        // 1. 尝试从 Redis 加载
        if (redisService != null) {
            try {
                var entries = redisService.hGetAll(REDIS_KEY);
                if (entries != null && !entries.isEmpty()) {
                    List<String> words = new ArrayList<>(entries.values().size());
                    entries.values().forEach(v -> words.add(v.toString()));
                    log.info("从 Redis 加载了 {} 个敏感词", words.size());
                    return words;
                }
            } catch (Exception e) {
                log.warn("Redis 加载敏感词失败，降级到数据库: {}", e.getMessage());
            }
        }

        // 2. 从数据库加载
        if (sensitiveWordMapper != null) {
            try {
                List<String> words = sensitiveWordMapper.selectSensitiveWords();
                if (words != null && !words.isEmpty()) {
                    // 同步到 Redis 缓存（24小时过期）
                    if (redisService != null) {
                        syncToRedis(words);
                    }
                    log.info("从数据库加载了 {} 个敏感词", words.size());
                    return words;
                }
            } catch (Exception e) {
                log.warn("数据库加载敏感词失败，降级到默认词: {}", e.getMessage());
            }
        }

        // 3. 使用默认词
        log.info("使用内置默认敏感词: {} 个", DEFAULT_WORDS.size());
        return DEFAULT_WORDS;
    }

    /**
     * 同步敏感词到 Redis 缓存
     */
    private void syncToRedis(List<String> words) {
        if (redisService == null) return;
        try {
            for (int i = 0; i < words.size(); i++) {
                redisService.hSet(REDIS_KEY, "word:" + i, words.get(i));
            }
            redisService.expire(REDIS_KEY, 86400, java.util.concurrent.TimeUnit.SECONDS);
            log.info("已同步 {} 个敏感词到 Redis 缓存", words.size());
        } catch (Exception e) {
            log.warn("同步敏感词到 Redis 失败: {}", e.getMessage());
        }
    }

    /**
     * 添加单个敏感词（动态扩展）
     */
    public void addWord(String word) {
        AcNode node = root;
        for (char c : word.toCharArray()) {
            node.children.putIfAbsent(c, new AcNode());
            node = node.children.get(c);
        }
        node.isEnd = true;
        node.length = word.length();
        // 同步到 Redis
        if (redisService != null) {
            try {
                redisService.sAdd(REDIS_KEY + ":new", word);
            } catch (Exception e) {
                log.warn("添加敏感词到 Redis 失败: {}", e.getMessage());
            }
        }
    }

    /**
     * 批量构建 Trie 树和失败指针
     */
    public void build(List<String> words) {
        // 构建 Trie 树
        for (String word : words) {
            addWordToTrie(word);
        }
        // 构建失败指针
        buildFailurePointer();
    }

    private void addWordToTrie(String word) {
        AcNode node = root;
        for (char c : word.toCharArray()) {
            node.children.putIfAbsent(c, new AcNode());
            node = node.children.get(c);
        }
        node.isEnd = true;
        node.length = word.length();
    }

    /**
     * 构建 AC 自动机失败指针
     */
    public void buildFailurePointer() {
        Queue<AcNode> queue = new LinkedList<>();
        root.fail = null;
        queue.offer(root);

        while (!queue.isEmpty()) {
            AcNode p = queue.poll();
            for (Map.Entry<Character, AcNode> entry : p.children.entrySet()) {
                char c = entry.getKey();
                AcNode pc = entry.getValue();

                if (p == root) {
                    pc.fail = root;
                } else {
                    AcNode q = p.fail;
                    while (q != null) {
                        if (q.children.containsKey(c)) {
                            pc.fail = q.children.get(c);
                            break;
                        }
                        q = q.fail;
                    }
                    if (q == null) {
                        pc.fail = root;
                    }
                }
                queue.offer(pc);
            }
        }
    }

    /**
     * 过滤文本中的敏感词
     * @param text 待过滤文本
     * @return 过滤后的文本
     */
    public String filter(String text) {
        if (text == null || text.isEmpty()) {
            return text;
        }
        char[] chars = text.toCharArray();
        AcNode p = root;

        for (int i = 0; i < chars.length; i++) {
            char c = chars[i];
            while (p != root && !p.children.containsKey(c)) {
                p = p.fail;
            }
            if (p.children.containsKey(c)) {
                p = p.children.get(c);
            }
            if (p.isEnd) {
                // 替换敏感词
                int start = i - p.length + 1;
                Arrays.fill(chars, start, i + 1, '*');
                p = root; // 重置到根节点
            }
        }
        return new String(chars);
    }

    /**
     * 检测文本是否包含敏感词
     * @param text 待检测文本
     * @return 包含的敏感词列表
     */
    public List<String> detect(String text) {
        List<String> detected = new ArrayList<>();
        if (text == null || text.isEmpty()) {
            return detected;
        }
        char[] chars = text.toCharArray();
        AcNode p = root;

        for (int i = 0; i < chars.length; i++) {
            char c = chars[i];
            while (p != root && !p.children.containsKey(c)) {
                p = p.fail;
            }
            if (p.children.containsKey(c)) {
                p = p.children.get(c);
            }
            if (p.isEnd) {
                int start = i - p.length + 1;
                String word = new String(chars, start, p.length);
                if (!detected.contains(word)) {
                    detected.add(word);
                }
                p = root;
            }
        }
        return detected;
    }

    /**
     * Trie 树节点
     */
    private static class AcNode {
        Map<Character, AcNode> children = new HashMap<>();
        AcNode fail;
        boolean isEnd;
        int length; // 敏感词长度
    }
}
