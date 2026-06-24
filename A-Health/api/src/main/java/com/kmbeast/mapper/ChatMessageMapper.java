package com.kmbeast.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kmbeast.pojo.entity.ChatMessage;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * AI聊天消息持久化接口
 */
@Mapper
public interface ChatMessageMapper extends BaseMapper<ChatMessage> {

    /**
     * 获取指定会话的所有消息（按时间正序）
     */
    List<ChatMessage> getBySessionId(@Param("sessionId") Integer sessionId);

    /**
     * 获取指定会话最新的N条消息（按时间正序）
     */
    List<ChatMessage> getRecentBySessionId(@Param("sessionId") Integer sessionId, @Param("limit") Integer limit);

    /**
     * 插入消息
     */
    void insertMessage(ChatMessage chatMessage);
}
