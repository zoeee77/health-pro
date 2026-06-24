-- ====================================================
-- 健康管理系统 v2 升级脚本
-- 版本: v2.0
-- 描述: 新增 Agent 对话持久化、健康提醒、健康预警功能
-- 日期: 2026-06-10
-- ====================================================

-- ====================================================
-- 1. Agent 对话记录表
-- ====================================================
CREATE TABLE IF NOT EXISTS `agent_conversation` (
    `id` INT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `user_id` INT NOT NULL COMMENT '用户ID',
    `role` VARCHAR(20) NOT NULL COMMENT '角色: user/assistant',
    `content` TEXT NOT NULL COMMENT '对话内容',
    `intent_type` VARCHAR(50) DEFAULT NULL COMMENT '意图类型',
    `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`),
    INDEX `idx_user_id` (`user_id`),
    INDEX `idx_create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Agent 对话记录表';

-- ====================================================
-- 2. 健康提醒表
-- ====================================================
CREATE TABLE IF NOT EXISTS `health_reminder` (
    `id` INT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `user_id` INT NOT NULL COMMENT '用户ID',
    `reminder_type` VARCHAR(20) NOT NULL COMMENT '提醒类型: DAILY/DIET/EXERCISE/SLEEP/MEDICAL/ALERT',
    `content` TEXT NOT NULL COMMENT '提醒内容',
    `status` TINYINT NOT NULL DEFAULT 0 COMMENT '状态: 0-未读, 1-已读',
    `scheduled_time` DATETIME NOT NULL COMMENT '计划提醒时间',
    `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`),
    INDEX `idx_user_id` (`user_id`),
    INDEX `idx_status` (`status`),
    INDEX `idx_scheduled_time` (`scheduled_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='健康提醒表';

-- ====================================================
-- 3. 健康预警表
-- ====================================================
CREATE TABLE IF NOT EXISTS `health_alert` (
    `id` INT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `user_id` INT NOT NULL COMMENT '用户ID',
    `alert_level` VARCHAR(10) NOT NULL COMMENT '预警级别: 低/中/高',
    `model_name` VARCHAR(50) NOT NULL COMMENT '指标名称',
    `current_value` VARCHAR(50) DEFAULT NULL COMMENT '当前值',
    `content` TEXT NOT NULL COMMENT '预警内容',
    `status` TINYINT NOT NULL DEFAULT 0 COMMENT '状态: 0-未处理, 1-已处理',
    `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`),
    INDEX `idx_user_id` (`user_id`),
    INDEX `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='健康预警表';
