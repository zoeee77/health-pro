package com.kmbeast.pojo.vo;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 聊天会话视图对象
 */
@Data
public class ChatSessionVO {
    private Integer id;
    private String title;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
