package com.kmbeast.pojo.vo;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 聊天消息视图对象
 */
@Data
public class ChatMessageVO {
    private Integer id;
    private String role;
    private String content;
    private LocalDateTime createTime;
}
