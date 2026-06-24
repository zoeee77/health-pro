package com.kmbeast.agent;

import com.kmbeast.agent.skills.AlertSkill;
import com.kmbeast.agent.skills.DietAnalysisSkill;
import com.kmbeast.agent.skills.ExerciseAdviceSkill;
import com.kmbeast.agent.skills.HealthSkill;
import com.kmbeast.agent.skills.SleepAnalysisSkill;
import com.kmbeast.agent.tools.HealthSkillsAsTools;
import com.kmbeast.mapper.AgentConversationMapper;
import com.kmbeast.mapper.DietHistoryMapper;
import com.kmbeast.mapper.HealthRecordMapper;
import com.kmbeast.pojo.entity.DietHistory;
import com.kmbeast.pojo.entity.HealthRecord;
import com.kmbeast.pojo.vo.ChatMessageVO;
import com.kmbeast.service.ChatSessionService;
import com.kmbeast.utils.AESUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import jakarta.annotation.PostConstruct;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 核心自主健康智能体（Spring AI 重构版）：
 * 1. 维护每个用户的对话记忆
 * 2. 组装健康档案上下文
 * 3. 使用 ChatClient 调用 LLM（替代原 RestTemplate）
 * 4. 支持规则驱动 + LLM 辅助意图识别（混合模式）
 * 5. 支持 Function Calling 触发技能分析
 */
@Slf4j
@Service
public class HealthAgent {

    private final ChatClient chatClient;
    private final HealthProfileBuilder profileBuilder;
    private final DietHistoryMapper dietHistoryMapper;
    private final HealthRecordMapper healthRecordMapper;
    private final AESUtil aesUtil;
    private final IntentRecognizer intentRecognizer;
    private final HybridIntentRecognizer hybridIntentRecognizer;
    private final AgentConversationMapper agentConversationMapper;
    private final HealthSkillsAsTools healthSkillsAsTools;
    private final ChatSessionService chatSessionService;

    // 技能实现
    private final DietAnalysisSkill dietAnalysisSkill;
    private final ExerciseAdviceSkill exerciseAdviceSkill;
    private final SleepAnalysisSkill sleepAnalysisSkill;
    private final AlertSkill alertSkill;

    @Value("${deepseek.api.enabled:true}")
    private boolean apiEnabled;

    @Value("${agent.hybrid.function-calling-enabled:true}")
    private boolean functionCallingEnabled;

    public HealthAgent(ChatClient chatClient,
                       HealthProfileBuilder profileBuilder,
                       DietHistoryMapper dietHistoryMapper,
                       HealthRecordMapper healthRecordMapper,
                       AESUtil aesUtil,
                       IntentRecognizer intentRecognizer,
                       HybridIntentRecognizer hybridIntentRecognizer,
                       AgentConversationMapper agentConversationMapper,
                       HealthSkillsAsTools healthSkillsAsTools,
                       DietAnalysisSkill dietAnalysisSkill,
                       ExerciseAdviceSkill exerciseAdviceSkill,
                       SleepAnalysisSkill sleepAnalysisSkill,
                       AlertSkill alertSkill,
                       ChatSessionService chatSessionService) {
        this.chatClient = chatClient;
        this.profileBuilder = profileBuilder;
        this.dietHistoryMapper = dietHistoryMapper;
        this.healthRecordMapper = healthRecordMapper;
        this.aesUtil = aesUtil;
        this.intentRecognizer = intentRecognizer;
        this.hybridIntentRecognizer = hybridIntentRecognizer;
        this.agentConversationMapper = agentConversationMapper;
        this.healthSkillsAsTools = healthSkillsAsTools;
        this.dietAnalysisSkill = dietAnalysisSkill;
        this.exerciseAdviceSkill = exerciseAdviceSkill;
        this.sleepAnalysisSkill = sleepAnalysisSkill;
        this.alertSkill = alertSkill;
        this.chatSessionService = chatSessionService;
    }

    @PostConstruct
    public void init() {
        log.info("HealthAgent 初始化完成，Spring AI 模式已启用");
    }

    public boolean isApiEnabled() {
        return apiEnabled;
    }

    // Per-session conversation memory (thread-safe)
    // Key: sessionId, Value: ConversationMemory
    private final Map<Integer, ConversationMemory> memoryStore = new ConcurrentHashMap<>();
    // 记录每个会话最后保存到的消息索引
    private final Map<Integer, Integer> lastSavedIndexStore = new ConcurrentHashMap<>();

    // 每 N 条消息保存一次到数据库
    private static final int SAVE_THRESHOLD = 2;

    /**
     * 获取指定会话的对话记忆（优先从数据库加载历史）
     */
    public ConversationMemory getMemory(Integer sessionId) {
        return memoryStore.computeIfAbsent(sessionId, k -> {
            ConversationMemory memory = new ConversationMemory();
            // 从数据库加载历史消息
            loadSessionHistoryToMemory(sessionId, memory);
            // 初始化保存索引为已加载的历史记录数量
            lastSavedIndexStore.put(sessionId, memory.getTurns().size());
            return memory;
        });
    }

    /**
     * 从数据库加载会话历史消息到内存
     */
    private void loadSessionHistoryToMemory(Integer sessionId, ConversationMemory memory) {
        try {
            List<ChatMessageVO> messages = chatSessionService.getRecentMessages(sessionId, 20);
            if (messages == null || messages.isEmpty()) {
                return;
            }
            for (ChatMessageVO msg : messages) {
                memory.getTurns().add(new ConversationMemory.Turn(
                        msg.getRole(), msg.getContent(), msg.getCreateTime()));
            }
            log.info("从数据库加载了 {} 条历史消息，会话ID: {}", messages.size(), sessionId);
        } catch (Exception e) {
            log.warn("加载会话历史失败，会话ID: {}, 错误: {}", sessionId, e.getMessage());
        }
    }

    /**
     * 发送聊天消息（统一入口）
     * 核心流程：
     * 1. 混合意图识别（规则 → LLM 辅助）
     * 2. 高置信度 → 走原 Skill 路由
     * 3. 低置信度 / Function Calling 场景 → 让 LLM 自动调用 Tool
     *
     * @param userId    用户ID
     * @param sessionId 会话ID（为空则自动创建/获取最新活跃会话）
     * @param message   用户消息
     */
    public String chat(Integer userId, Integer sessionId, String message) {
        // 自动获取或创建会话
        if (sessionId == null) {
            sessionId = chatSessionService.getOrCreateActiveSession(userId);
        }

        if (!apiEnabled) {
            return "AI助手服务暂时不可用，请联系管理员。";
        }

        ConversationMemory memory = getMemory(sessionId);
        memory.addUserMessage(message);

        // 立即保存用户消息
        chatSessionService.saveUserMessage(sessionId, message);
        // 如果第一条消息，更新会话标题
        chatSessionService.updateSessionTitle(sessionId, message);

        // 构建健康档案
        HealthProfile profile = profileBuilder.build(userId);

        // 第一步：混合意图识别
        IntentType intent = hybridIntentRecognizer.recognize(message);
        log.info("意图识别结果: {}", intent);

        // 第二步：根据意图和配置决定执行路径
        String skillContext = "";
        boolean useFunctionCalling = shouldUseFunctionCalling(intent);

        if (useFunctionCalling && functionCallingEnabled) {
            // Phase 3: 使用 Function Calling 让 LLM 自动选择 Tool
            String reply = chatWithFunctionCalling(sessionId, userId, memory, profile, message);
            memory.addAssistantMessage(reply);
            // 立即保存助手消息
            chatSessionService.saveAssistantMessage(sessionId, reply);
            return reply;
        } else if (intent != IntentType.GENERAL_CHAT) {
            // 高置信度意图 → 走原 Skill 路由（保留现有逻辑）
            skillContext = executeSkill(intent, profile);
            log.info("规则路由技能执行, 技能上下文长度: {}", skillContext.length());
        }

        // 第三步：构建系统提示（含技能分析结果）
        String systemPrompt = buildSystemPrompt(profile, skillContext);

        // 第四步：构建包含对话历史的 prompt
        String prompt = buildPrompt(systemPrompt, memory, message);

        // 第五步：调用 LLM
        String reply = callAi(prompt);
        if (reply == null) {
            reply = "抱歉，我暂时无法回答您的问题，请稍后重试。";
        }

        memory.addAssistantMessage(reply);
        // 立即保存助手消息
        chatSessionService.saveAssistantMessage(sessionId, reply);

        return reply;
    }

    /**
     * 兼容旧接口（无 sessionId 版本，自动使用最新活跃会话）
     */
    public String chat(Integer userId, String message) {
        return chat(userId, null, message);
    }

    /**
     * 判断是否使用 Function Calling
     * 策略：
     * - 健康报告场景 → 启用（需要组合多个技能）
     * - 通用聊天但混合识别置信度低 → 启用（让 LLM 自主决定）
     * - 明确的单一意图 → 不启用（走规则路由更快更可控）
     */
    private boolean shouldUseFunctionCalling(IntentType intent) {
        return intent == IntentType.HEALTH_REPORT || intent == IntentType.GENERAL_CHAT;
    }

    /**
     * 使用 Function Calling 模式调用 LLM
     * LLM 会自动判断是否需要调用 Tool 分析健康数据
     */
    private String chatWithFunctionCalling(Integer sessionId, Integer userId, ConversationMemory memory,
                                            HealthProfile profile, String userMessage) {
        String systemPrompt = buildSystemPrompt(profile, "");

        // 构建完整的 user prompt
        String fullPrompt = systemPrompt + "\n\n用户：" + userMessage + "\n助手：";

        // 调用 ChatClient，注册可用的 Tools
        // Spring AI 会自动扫描 @Tool 注解的方法并注册为 function calling
        try {
            return chatClient.prompt()
                    .user(fullPrompt)
                    .toolContext(Map.of("userId", userId))
                    .tools(healthSkillsAsTools)
                    .call()
                    .content();
        } catch (Exception e) {
            log.error("Function Calling 调用失败，降级为普通模式: {}", e.getMessage());
            // 降级：走普通调用
            return callAi(systemPrompt + "\n\n用户：" + userMessage + "\n助手：");
        }
    }

    /**
     * 根据意图执行对应的技能分析（保留现有 Skill 路由逻辑）
     */
    private String executeSkill(IntentType intent, HealthProfile profile) {
        // 健康报告特殊处理：组合多个技能的分析结果
        if (intent == IntentType.HEALTH_REPORT) {
            StringBuilder sb = new StringBuilder();
            sb.append(dietAnalysisSkill.analyze(profile)).append("\n");
            sb.append(exerciseAdviceSkill.analyze(profile)).append("\n");
            sb.append(sleepAnalysisSkill.analyze(profile)).append("\n");
            sb.append(alertSkill.analyze(profile)).append("\n");
            return sb.toString();
        }

        // 普通意图：直接调用对应技能
        HealthSkill skill = getSkillByIntent(intent);
        if (skill != null) {
            return skill.analyze(profile);
        }
        return "";
    }

    /**
     * 根据意图获取对应的技能实现
     */
    private HealthSkill getSkillByIntent(IntentType intent) {
        switch (intent) {
            case DIET_ANALYSIS:
                return dietAnalysisSkill;
            case EXERCISE_ADVICE:
                return exerciseAdviceSkill;
            case SLEEP_ANALYSIS:
                return sleepAnalysisSkill;
            case MEDICAL_REMINDER:
                return alertSkill;
            default:
                return null;
        }
    }

    /**
     * Generate a daily health summary for the user.
     */
    public String generateDailySummary(Integer userId) {
        HealthProfile profile = profileBuilder.build(userId);
        String systemPrompt = buildSystemPrompt(profile, "");

        String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

        // Gather today's data
        List<DietHistory> todayDiet = dietHistoryMapper.selectList(
                new com.baomidou.mybatisplus.core.conditions.query.QueryWrapper<DietHistory>()
                        .eq("user_id", userId)
                        .ge("create_time", today + " 00:00:00")
                        .le("create_time", today + " 23:59:59")
        );

        List<HealthRecord> todayRecords = healthRecordMapper.selectList(
                new com.baomidou.mybatisplus.core.conditions.query.QueryWrapper<HealthRecord>()
                        .eq("user_id", userId)
                        .ge("create_time", today + " 00:00:00")
                        .le("create_time", today + " 23:59:59")
        );

        StringBuilder sb = new StringBuilder();
        sb.append("请根据以下数据为用户生成一份今日健康总结与明日建议。\n\n");

        sb.append("今日饮食：\n");
        if (todayDiet.isEmpty()) {
            sb.append("  暂无记录\n");
        } else {
            for (DietHistory d : todayDiet) {
                double value = d.getValue() != null ? d.getValue() : 0;
                if (Math.abs(value) > 10000) {
                    value = aesUtil.decryptValue(value);
                }
                sb.append(String.format("  - %s: %.0fg\n",
                        d.getDetail() != null ? d.getDetail() : "未知", value));
            }
        }

        sb.append("\n今日健康记录：\n");
        if (todayRecords.isEmpty()) {
            sb.append("  暂无记录\n");
        } else {
            for (HealthRecord r : todayRecords) {
                double value = r.getValue() != null ? r.getValue() : 0;
                if (Math.abs(value) > 10000) {
                    value = aesUtil.decryptValue(value);
                }
                sb.append(String.format("  - 指标ID %s: %.1f\n", r.getHealthModelId(), value));
            }
        }

        sb.append("\n请用中文回复，包含：\n");
        sb.append("1. 今日饮食评价\n");
        sb.append("2. 健康指标分析\n");
        sb.append("3. 明日改善建议\n");

        return callAi(systemPrompt + "\n\n" + sb.toString());
    }

    /**
     * Get proactive reminder based on user profile patterns.
     */
    public String generateReminder(Integer userId) {
        HealthProfile profile = profileBuilder.build(userId);
        String systemPrompt = buildSystemPrompt(profile, "");

        String reminderPrompt = systemPrompt + "\n\n" +
                "请分析用户的健康数据，给出一个简短的健康提醒（50字以内）。\n" +
                "例如：\n" +
                "- \"您最近3天没有记录饮食，建议坚持记录以便分析。\"\n" +
                "- \"您的血糖值偏高，请注意控制碳水化合物摄入。\"\n" +
                "- \"今日PM2.5较高，建议户外运动佩戴口罩。\"\n\n" +
                "如果数据正常，则返回null。";

        return callAi(reminderPrompt);
    }

    // ---------- private helpers ----------

    /**
     * 构建系统提示，支持附加技能分析上下文
     */
    private String buildSystemPrompt(HealthProfile profile, String skillContext) {
        StringBuilder sb = new StringBuilder();
        sb.append("你是一个智能健康助手，专注于提供个性化的健康管理建议。\n\n");

        if (profile != null) {
            sb.append("【用户档案】\n");
            sb.append("用户名：").append(profile.getUsername() != null ? profile.getUsername() : "未知").append("\n");
            if (profile.getAge() != null) sb.append("年龄：").append(profile.getAge()).append("\n");
            if (profile.getGender() != null) {
                sb.append("性别：").append(profile.getGender() == 1 ? "女" : "男").append("\n");
            }
            sb.append("\n");

            if (profile.getRecentDietSummary() != null && !profile.getRecentDietSummary().isEmpty()) {
                sb.append("【近期饮食记录】\n").append(profile.getRecentDietSummary()).append("\n");
            }

            if (profile.getVitalSigns() != null && !profile.getVitalSigns().isEmpty()) {
                sb.append("【健康指标趋势】\n");
                for (HealthProfile.MetricTrend mt : profile.getVitalSigns()) {
                    sb.append(String.format("- %s: %.1f %s (趋势: %s, 评估: %s)%n",
                            mt.getModelName(), mt.getLatestValue(),
                            mt.getUnit(), mt.getTrend(), mt.getEvaluation()));
                }
                sb.append("\n");
            }
        }

        // 附加技能分析上下文
        if (skillContext != null && !skillContext.isEmpty()) {
            sb.append("【技能分析结果】\n").append(skillContext).append("\n");
        }

        sb.append("请遵守以下原则：\n");
        sb.append("1. 基于用户的真实健康数据提供个性化建议\n");
        sb.append("2. 回答科学、准确、有帮助\n");
        sb.append("3. 对于不确定的问题，建议用户咨询专业医生\n");
        sb.append("4. 仅回答健康、医疗、饮食、运动、睡眠等相关领域的问题\n");
        sb.append("5. 用中文回复，语气温暖专业\n");

        return sb.toString();
    }

    private String buildPrompt(String systemPrompt, ConversationMemory memory, String userMessage) {
        StringBuilder sb = new StringBuilder();
        sb.append(systemPrompt).append("\n\n");

        List<ConversationMemory.Turn> recent = memory.getRecentTurns(6);
        if (recent.size() > 1) {
            sb.append("【对话历史】\n");
            for (ConversationMemory.Turn turn : recent) {
                String role = "user".equals(turn.getRole()) ? "用户" : "助手";
                sb.append(role).append("：").append(turn.getContent()).append("\n");
            }
            sb.append("\n");
        }

        sb.append("用户：").append(userMessage).append("\n");
        sb.append("助手：");
        return sb.toString();
    }

    /**
     * 使用 Spring AI ChatClient 调用 LLM（替代原 callDeepSeek）
     */
    private String callAi(String prompt) {
        try {
            return chatClient.prompt()
                    .user(prompt)
                    .call()
                    .content();
        } catch (Exception e) {
            log.error("HealthAgent ChatClient call failed: {}", e.getMessage());
            return null;
        }
    }
}
