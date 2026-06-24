package com.kmbeast.pojo.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * Agent 对话记录实体
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "agent_conversation")
public class AgentConversation {
    /**
     * 主键ID
     */
    private Integer id;
    /**
     * 用户ID
     */
    private Integer userId;
    /**
     * 角色: user/assistant
     */
    private String role;
    /**
     * 对话内容
     */
    private String content;
    /**
     * 意图类型
     */
    private String intentType;
    /**
     * 创建时间
     */
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;
}
