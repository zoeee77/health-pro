package com.kmbeast.agent;

import lombok.extern.slf4j.Slf4j;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * 混合意图识别器
 * Phase 2: 规则 + LLM 辅助决策
 *
 * 工作流程：
 * 1. 先用关键词匹配快速识别（高置信度直接返回）
 * 2. 置信度不足时，调用 LLM 辅助判断意图
 * 3. LLM 也无法确定时返回 GENERAL_CHAT
 */
@Slf4j
@Component
public class HybridIntentRecognizer {

    private final IntentRecognizer ruleRecognizer;
    private final ChatClient chatClient;

    @Value("${agent.hybrid.enabled:true}")
    private boolean hybridEnabled;

    @Value("${agent.hybrid.high-confidence-threshold:0.6}")
    private double highConfidenceThreshold;

    public HybridIntentRecognizer(IntentRecognizer ruleRecognizer,
                                   ChatClient chatClient) {
        this.ruleRecognizer = ruleRecognizer;
        this.chatClient = chatClient;
    }

    /**
     * 识别用户消息的意图类型（混合模式）
     *
     * @param message 用户消息
     * @return 识别到的意图类型
     */
    public IntentType recognize(String message) {
        if (message == null || message.trim().isEmpty()) {
            return IntentType.GENERAL_CHAT;
        }

        // 第一步：规则匹配
        IntentType ruleIntent = ruleRecognizer.recognize(message);

        // 如果是 GENERAL_CHAT 且混合模式未启用，直接返回
        if (ruleIntent == IntentType.GENERAL_CHAT && !hybridEnabled) {
            return IntentType.GENERAL_CHAT;
        }

        // 如果规则已经识别为非 GENERAL_CHAT，直接返回（高置信度）
        if (ruleIntent != IntentType.GENERAL_CHAT) {
            log.debug("规则匹配高置信度意图: {}", ruleIntent);
            return ruleIntent;
        }

        // 第二步：LLM 辅助判断 GENERAL_CHAT 是否真的是通用聊天
        if (hybridEnabled) {
            return llmAssistRecognize(message);
        }

        return IntentType.GENERAL_CHAT;
    }

    /**
     * 使用 LLM 辅助判断意图
     */
    private IntentType llmAssistRecognize(String message) {
        try {
            String prompt = buildLlmPrompt(message);
            String response = chatClient.prompt()
                    .user(prompt)
                    .call()
                    .content();

            IntentType llmIntent = parseLlmResponse(response);
            log.info("LLM 辅助识别意图: {}, 原始消息: {}", llmIntent, truncate(message, 30));
            return llmIntent != null ? llmIntent : IntentType.GENERAL_CHAT;
        } catch (Exception e) {
            log.warn("LLM 意图识别失败，降级为 GENERAL_CHAT: {}", e.getMessage());
            return IntentType.GENERAL_CHAT;
        }
    }

    /**
     * 构建 LLM 意图识别提示词
     */
    private String buildLlmPrompt(String message) {
        return String.format(
                "你是一个意图识别助手。请判断以下用户消息属于哪个意图类别。\n\n" +
                "可选的意图类别：\n" +
                "- DIET_ANALYSIS: 与饮食、营养、减肥、食谱相关\n" +
                "- EXERCISE_ADVICE: 与运动、锻炼、健身、跑步相关\n" +
                "- SLEEP_ANALYSIS: 与睡眠、失眠、熬夜、作息相关\n" +
                "- MEDICAL_REMINDER: 与吃药、就医、体检、药物提醒相关\n" +
                "- HEALTH_REPORT: 与健康报告、数据分析、指标趋势相关\n" +
                "- GENERAL_CHAT: 普通聊天，不属于以上任何类别\n\n" +
                "用户消息: \"%s\"\n\n" +
                "请只返回意图类别名称（如 DIET_ANALYSIS），不要返回任何其他内容。",
                message
        );
    }

    /**
     * 解析 LLM 返回的意图类型
     */
    private IntentType parseLlmResponse(String response) {
        if (response == null || response.trim().isEmpty()) {
            return IntentType.GENERAL_CHAT;
        }

        String trimmed = response.trim().toUpperCase();

        // 清理可能的前后缀（如 "DIET_ANALYSIS" 或 "Intent: DIET_ANALYSIS"）
        for (IntentType type : IntentType.values()) {
            if (trimmed.contains(type.name())) {
                return type;
            }
        }

        return IntentType.GENERAL_CHAT;
    }

    /**
     * 截断字符串用于日志
     */
    private String truncate(String str, int maxLength) {
        return str.length() > maxLength ? str.substring(0, maxLength) + "..." : str;
    }
}
