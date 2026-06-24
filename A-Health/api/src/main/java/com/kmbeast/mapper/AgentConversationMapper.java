package com.kmbeast.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kmbeast.pojo.entity.AgentConversation;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Agent 对话记录持久化接口
 */
@Mapper
public interface AgentConversationMapper extends BaseMapper<AgentConversation> {

    /**
     * 插入对话记录
     */
    void insertConversation(AgentConversation conversation);

    /**
     * 获取用户最近的对话记录
     */
    List<AgentConversation> getRecentByUserId(@Param("userId") Integer userId, @Param("limit") Integer limit);

    /**
     * 清理用户指定天数前的旧对话
     */
    void cleanOldConversations(@Param("userId") Integer userId, @Param("daysAgo") Integer daysAgo);
}
