package com.kmbeast.pojo.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * 健康提醒实体
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "health_reminder")
public class HealthReminder {
    /**
     * 主键ID
     */
    private Integer id;
    /**
     * 用户ID
     */
    private Integer userId;
    /**
     * 提醒类型: DAILY/DIET/EXERCISE/SLEEP/MEDICAL/ALERT
     */
    private String reminderType;
    /**
     * 提醒内容
     */
    private String content;
    /**
     * 状态: 0-未读, 1-已读
     */
    private Integer status;
    /**
     * 计划提醒时间
     */
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime scheduledTime;
    /**
     * 创建时间
     */
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;
}
