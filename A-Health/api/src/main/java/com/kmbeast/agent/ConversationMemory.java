package com.kmbeast.agent;

import com.kmbeast.mapper.AgentConversationMapper;
import com.kmbeast.pojo.entity.AgentConversation;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * 智能体对话记忆管理
 * 保留最近的对话轮次，为 LLM 提供连贯的多轮上下文
 */
@Slf4j
@Data
public class ConversationMemory {
    private final int maxTurns = 20;
    private final List<Turn> turns = new ArrayList<>();
    // 用于跟踪自上次保存以来新增的消息数量
    private int unsavedCount = 0;

    /**
     * 添加用户消息
     */
    public void addUserMessage(String content) {
        turns.add(new Turn("user", content, LocalDateTime.now()));
        trim();
    }

    /**
     * 添加助手消息
     */
    public void addAssistantMessage(String content) {
        turns.add(new Turn("assistant", content, LocalDateTime.now()));
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
    }

    /**
     * 从数据库加载历史对话
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
                        .createTime(turn.getTimestamp())
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
     * 对话轮次
     */
    @Data
    public static class Turn {
        private final String role;
        private final String content;
        private final LocalDateTime timestamp;
    }
}
