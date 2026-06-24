package com.kmbeast.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kmbeast.pojo.entity.ChatSession;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * AI聊天会话持久化接口
 */
@Mapper
public interface ChatSessionMapper extends BaseMapper<ChatSession> {

    /**
     * 获取用户的会话列表（按更新时间倒序）
     */
    List<ChatSession> listByUserId(@Param("userId") Integer userId);

    /**
     * 获取用户最新的活跃会话
     */
    ChatSession getLatestActiveSession(@Param("userId") Integer userId);

    /**
     * 创建新会话
     */
    void insertSession(ChatSession chatSession);

    /**
     * 结束指定会话
     */
    void closeSession(@Param("sessionId") Integer sessionId);

    /**
     * 删除指定会话及其所有消息
     */
    void deleteSession(@Param("sessionId") Integer sessionId);
}
