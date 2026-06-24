package com.kmbeast.pojo.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * 健康预警实体
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "health_alert")
public class HealthAlert {
    /**
     * 主键ID
     */
    private Integer id;
    /**
     * 用户ID
     */
    private Integer userId;
    /**
     * 预警级别: 低/中/高
     */
    private String alertLevel;
    /**
     * 指标名称
     */
    private String modelName;
    /**
     * 当前值
     */
    private String currentValue;
    /**
     * 预警内容
     */
    private String content;
    /**
     * 状态: 0-未处理, 1-已处理
     */
    private Integer status;
    /**
     * 创建时间
     */
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;
}
