package com.kmbeast.agent;

import com.kmbeast.mapper.AgentConversationMapper;
import com.kmbeast.pojo.entity.AgentConversation;
import com.kmbeast.utils.RedisService;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * 智能体对话记忆管理
 * 采用三层缓存架构：Redis 缓存 → 数据库 → 内存窗口
 * 保留最近的对话轮次，为 LLM 提供连贯的多轮上下文
 */
@Slf4j
@Data
public class ConversationMemory {
    private final int maxTurns = 20;
    private final List<Turn> turns = new ArrayList<>();
    private final RedisService redisService;
    private final String memoryKey;
    // 用于跟踪自上次保存以来新增的消息数量
    private int unsavedCount = 0;
    // Redis 缓存过期时间：24 小时
    private static final long REDIS_TTL_HOURS = 24;

    /**
     * 构造函数：使用 Redis 缓存
     */
    public ConversationMemory(RedisService redisService, Integer userId) {
        this.redisService = redisService;
        this.memoryKey = "agent:conversation:" + userId;
    }

    /**
     * 构造函数：不使用 Redis（降级模式）
     */
    public ConversationMemory() {
        this.redisService = null;
        this.memoryKey = null;
    }

    /**
     * 添加用户消息
     */
    public void addUserMessage(String content) {
        turns.add(new Turn("user", content, LocalDateTime.now()));
        syncToRedis();
        trim();
    }

    /**
     * 添加助手消息
     */
    public void addAssistantMessage(String content) {
        turns.add(new Turn("assistant", content, LocalDateTime.now()));
        syncToRedis();
        trim();
    }

    /**
     * 获取最近的对话轮次
     */
    public List<Turn> getRecentTurns(int n) {
        int size = turns.size();
        return turns.subList(Math.max(0, size - n), size);
    }

    /**
     * 裁剪超出最大轮次的旧消息
     */
    private void trim() {
        while (turns.size() > maxTurns) {
            turns.remove(0);
        }
        // 同步裁剪后的状态到 Redis
        syncToRedis();
    }

    /**
     * 同步对话历史到 Redis 缓存
     * 使用 Hash 结构存储，key 为 message:{index}，便于增量更新
     */
    private void syncToRedis() {
        if (redisService == null || memoryKey == null) {
            return;
        }
        try {
            // 清空旧缓存，写入当前完整窗口
            redisService.delete(memoryKey);
            for (int i = 0; i < turns.size(); i++) {
                Turn turn = turns.get(i);
                redisService.hSet(memoryKey, "msg:" + i, turn.getRole() + "|" + turn.getContent());
            }
            redisService.expire(memoryKey, REDIS_TTL_HOURS, TimeUnit.HOURS);
        } catch (Exception e) {
            log.warn("同步对话到 Redis 失败: {}", e.getMessage());
        }
    }

    /**
     * 从 Redis 缓存加载历史对话（优先于数据库）
     * @return 是否加载成功
     */
    public boolean loadFromRedis() {
        if (redisService == null || memoryKey == null) {
            return false;
        }
        try {
            var entries = redisService.hGetAll(memoryKey);
            if (entries != null && !entries.isEmpty()) {
                // 按索引排序恢复
                entries.entrySet().stream()
                        .sorted((a, b) -> {
                            int ia = Integer.parseInt(a.getKey().toString().replace("msg:", ""));
                            int ib = Integer.parseInt(b.getKey().toString().replace("msg:", ""));
                            return Integer.compare(ia, ib);
                        })
                        .forEach(entry -> {
                            String val = entry.getValue().toString();
                            int sepIdx = val.indexOf('|');
                            if (sepIdx > 0) {
                                String role = val.substring(0, sepIdx);
                                String content = val.substring(sepIdx + 1);
                                turns.add(new Turn(role, content, LocalDateTime.now()));
                            }
                        });
                log.info("从 Redis 缓存加载了 {} 条对话历史", turns.size());
                return true;
            }
        } catch (Exception e) {
            log.warn("从 Redis 加载对话失败: {}", e.getMessage());
        }
        return false;
    }

    /**
     * 从数据库加载历史对话（Redis 未命中时的降级方案）
     * @param mapper 对话记录 Mapper
     * @param userId 用户ID
     */
    public void loadFromDatabase(AgentConversationMapper mapper, Integer userId) {
        if (mapper == null || userId == null) {
            return;
        }
        try {
            List<AgentConversation> records = mapper.getRecentByUserId(userId, maxTurns);
            for (AgentConversation record : records) {
                Turn turn = new Turn(record.getRole(), record.getContent(), record.getCreateTime());
                turns.add(turn);
            }
            // 加载后同步到 Redis 缓存
            syncToRedis();
            log.info("从数据库加载了 {} 条历史对话，用户ID: {}", records.size(), userId);
        } catch (Exception e) {
            log.warn("加载历史对话失败，用户ID: {}, 错误: {}", userId, e.getMessage());
        }
    }

    /**
     * 保存新对话到数据库
     * @param mapper 对话记录 Mapper
     * @param userId 用户ID
     * @param lastSavedIndex 上次保存的最后一个消息索引
     * @return 更新后的最后保存索引
     */
    public int saveToDatabase(AgentConversationMapper mapper, Integer userId, int lastSavedIndex) {
        if (mapper == null || userId == null) {
            return lastSavedIndex;
        }
        try {
            int currentSize = turns.size();
            for (int i = lastSavedIndex; i < currentSize; i++) {
                Turn turn = turns.get(i);
                AgentConversation conversation = AgentConversation.builder()
                        .userId(userId)
                        .role(turn.getRole())
                        .content(turn.getContent())
                        .createTime(turn.getCreateTime())
                        .build();
                mapper.insertConversation(conversation);
                unsavedCount++;
            }
            log.info("保存了 {} 条新对话到数据库，用户ID: {}", currentSize - lastSavedIndex, userId);
            return currentSize;
        } catch (Exception e) {
            log.warn("保存对话到数据库失败，用户ID: {}, 错误: {}", userId, e.getMessage());
            return lastSavedIndex;
        }
    }

    /**
     * 获取未保存消息数量
     */
    public int getUnsavedCount() {
        return unsavedCount;
    }

    /**
     * 重置未保存计数
     */
    public void resetUnsavedCount() {
        unsavedCount = 0;
    }

    /**
     * 清除 Redis 缓存（用户登出或会话结束时调用）
     */
    public void clearCache() {
        if (redisService != null && memoryKey != null) {
            redisService.delete(memoryKey);
            log.info("已清除用户对话 Redis 缓存: {}", memoryKey);
        }
        turns.clear();
    }

    /**
     * 对话轮次
     */
    @Data
    public static class Turn {
        private final String role;
        private final String content;
        private final LocalDateTime timestamp;
    }
}
