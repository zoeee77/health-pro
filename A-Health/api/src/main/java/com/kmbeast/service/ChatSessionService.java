package com.kmbeast.service;

import com.kmbeast.mapper.ChatMessageMapper;
import com.kmbeast.mapper.ChatSessionMapper;
import com.kmbeast.pojo.entity.ChatMessage;
import com.kmbeast.pojo.entity.ChatSession;
import com.kmbeast.pojo.vo.ChatMessageVO;
import com.kmbeast.pojo.vo.ChatSessionVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 聊天会话管理服务
 * 提供会话创建、列表查询、消息持久化、历史加载等功能
 */
@Slf4j
@Service
public class ChatSessionService {

    private final ChatSessionMapper chatSessionMapper;
    private final ChatMessageMapper chatMessageMapper;

    public ChatSessionService(ChatSessionMapper chatSessionMapper,
                              ChatMessageMapper chatMessageMapper) {
        this.chatSessionMapper = chatSessionMapper;
        this.chatMessageMapper = chatMessageMapper;
    }

    /**
     * 创建新会话
     * @param userId 用户ID
     * @param title 会话标题（如果为空则使用默认值）
     * @return 新创建的会话ID
     */
    public Integer createSession(Integer userId, String title) {
        if (title == null || title.trim().isEmpty()) {
            title = "新对话";
        }
        ChatSession session = ChatSession.builder()
                .userId(userId)
                .title(title)
                .isActive(true)
                .createTime(LocalDateTime.now())
                .updateTime(LocalDateTime.now())
                .build();
        chatSessionMapper.insertSession(session);
        log.info("创建新会话, sessionId={}, userId={}, title={}", session.getId(), userId, title);
        return session.getId();
    }

    /**
     * 获取用户最新的活跃会话，如果没有则自动创建
     * @param userId 用户ID
     * @return 活跃会话ID
     */
    public Integer getOrCreateActiveSession(Integer userId) {
        ChatSession session = chatSessionMapper.getLatestActiveSession(userId);
        if (session != null) {
            return session.getId();
        }
        return createSession(userId, null);
    }

    /**
     * 获取用户的会话列表
     * @param userId 用户ID
     * @return 会话列表
     */
    public List<ChatSessionVO> listSessions(Integer userId) {
        List<ChatSession> sessions = chatSessionMapper.listByUserId(userId);
        return sessions.stream().map(s -> {
            ChatSessionVO vo = new ChatSessionVO();
            vo.setId(s.getId());
            vo.setTitle(s.getTitle());
            vo.setCreateTime(s.getCreateTime());
            vo.setUpdateTime(s.getUpdateTime());
            return vo;
        }).collect(Collectors.toList());
    }

    /**
     * 获取指定会话的完整消息历史
     * @param sessionId 会话ID
     * @return 消息列表（按时间正序）
     */
    public List<ChatMessageVO> getSessionMessages(Integer sessionId) {
        List<ChatMessage> messages = chatMessageMapper.getBySessionId(sessionId);
        return messages.stream().map(m -> {
            ChatMessageVO vo = new ChatMessageVO();
            vo.setId(m.getId());
            vo.setRole(m.getRole());
            vo.setContent(m.getContent());
            vo.setCreateTime(m.getCreateTime());
            return vo;
        }).collect(Collectors.toList());
    }

    /**
     * 获取指定会话最近的N条消息（用于构建上下文）
     * @param sessionId 会话ID
     * @param limit 数量限制
     * @return 消息列表（按时间正序）
     */
    public List<ChatMessageVO> getRecentMessages(Integer sessionId, int limit) {
        List<ChatMessage> messages = chatMessageMapper.getRecentBySessionId(sessionId, limit);
        return messages.stream().map(m -> {
            ChatMessageVO vo = new ChatMessageVO();
            vo.setId(m.getId());
            vo.setRole(m.getRole());
            vo.setContent(m.getContent());
            vo.setCreateTime(m.getCreateTime());
            return vo;
        }).collect(Collectors.toList());
    }

    /**
     * 保存用户消息
     */
    public void saveUserMessage(Integer sessionId, String content) {
        saveMessage(sessionId, "user", content);
    }

    /**
     * 保存助手消息
     */
    public void saveAssistantMessage(Integer sessionId, String content) {
        saveMessage(sessionId, "assistant", content);
    }

    private void saveMessage(Integer sessionId, String role, String content) {
        ChatMessage message = ChatMessage.builder()
                .sessionId(sessionId)
                .role(role)
                .content(content)
                .createTime(LocalDateTime.now())
                .build();
        chatMessageMapper.insertMessage(message);
    }

    /**
     * 更新会话标题（用于将第一条消息设为标题）
     */
    public void updateSessionTitle(Integer sessionId, String title) {
        // 截断标题长度
        if (title.length() > 50) {
            title = title.substring(0, 50) + "...";
        }
        ChatSession session = chatSessionMapper.selectById(sessionId);
        if (session != null && "新对话".equals(session.getTitle())) {
            session.setTitle(title);
            session.setUpdateTime(LocalDateTime.now());
            chatSessionMapper.updateById(session);
        }
    }

    /**
     * 结束指定会话
     */
    public void closeSession(Integer sessionId) {
        chatSessionMapper.closeSession(sessionId);
        log.info("结束会话, sessionId={}", sessionId);
    }

    /**
     * 删除会话及其所有消息
     */
    public void deleteSession(Integer sessionId) {
        chatSessionMapper.deleteSession(sessionId);
        log.info("删除会话, sessionId={}", sessionId);
    }
}
