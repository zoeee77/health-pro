-- =============================================
-- 会话管理表结构
-- 用于支持多会话、持久化对话历史
-- =============================================

-- 1. 会话表
CREATE TABLE IF NOT EXISTS `chat_session` (
    `id` INT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `user_id` INT NOT NULL COMMENT '用户ID',
    `title` VARCHAR(200) NOT NULL DEFAULT '新对话' COMMENT '会话标题',
    `is_active` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '是否激活: 1=激活, 0=已结束',
    `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_user_id` (`user_id`),
    KEY `idx_user_active` (`user_id`, `is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='AI聊天会话表';

-- 2. 消息表
CREATE TABLE IF NOT EXISTS `chat_message` (
    `id` INT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `session_id` INT NOT NULL COMMENT '会话ID',
    `role` VARCHAR(20) NOT NULL COMMENT '角色: user/assistant',
    `content` TEXT NOT NULL COMMENT '消息内容',
    `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`),
    KEY `idx_session_id` (`session_id`),
    KEY `idx_session_time` (`session_id`, `create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='AI聊天消息表';
