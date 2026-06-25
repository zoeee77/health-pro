-- ============================================
-- SQL 性能优化：索引优化与 Explain 执行计划分析
-- ============================================
-- 本文件包含项目中关键 SQL 查询的索引优化方案
-- 通过覆盖索引、联合索引、执行计划优化提升查询性能

-- ============================================
-- 1. flow_index 表索引优化
-- ============================================
-- 优化场景：listScores 中的复杂聚合查询
-- 原始问题：每次查询全表扫描 type=2,3,4,5 的数据
-- 优化方案：建立覆盖索引，避免回表查询

-- 联合索引：加速 content_module + type 的过滤
CREATE INDEX idx_flow_index_module_type ON flow_index(content_module, type);

-- 联合索引：加速 user_id + content_id + content_module 的分组查询
CREATE INDEX idx_flow_index_user_content_module ON flow_index(user_id, content_id, content_module);

-- 复合索引：覆盖 list 查询场景
CREATE INDEX idx_flow_index_user_type_module_id ON flow_index(user_id, type, content_module, content_id);

-- ============================================
-- 2. health_news 表索引优化
-- ============================================
-- 优化场景：list 查询中的子查询统计展现量、浏览量等
-- 原始问题：4 个子查询分别扫描 flow_index 表，N+1 查询问题
-- 优化方案：使用覆盖索引 + JOIN 替代子查询

-- 联合索引：加速 flow_index 的内容模块 + 内容ID + 类型查询
CREATE INDEX idx_flow_index_content_module_type_id ON flow_index(content_module, content_id, type);

-- health_news 的常用查询索引
CREATE INDEX idx_health_news_type_time ON health_news(type_id, create_time);
CREATE INDEX idx_health_news_title ON health_news(title);

-- ============================================
-- 3. recipe 表索引优化
-- ============================================
-- 优化场景：listPageCount 中的多条件组合查询
-- 原始问题：user_id + type_id + is_audit + is_public 组合过滤效率低
-- 优化方案：建立联合索引覆盖高频查询场景

CREATE INDEX idx_recipe_public_audit ON recipe(is_public, is_audit);
CREATE INDEX idx_recipe_user_type ON recipe(user_id, type_id);
CREATE INDEX idx_recipe_create_time ON recipe(create_time);

-- ============================================
-- 4. diet_history 表索引优化
-- ============================================
-- 优化场景：按用户和时间范围查询饮食记录
CREATE INDEX idx_diet_history_user_time ON diet_history(user_id, create_time);

-- ============================================
-- 5. health_record 表索引优化
-- ============================================
-- 优化场景：按用户和健康模型查询记录
CREATE INDEX idx_health_record_user_model ON health_record(user_id, health_model_id);
CREATE INDEX idx_health_record_time ON health_record(create_time);

-- ============================================
-- 6. evaluations 表索引优化
-- ============================================
-- 优化场景：评论列表按内容模块 + 内容ID查询
CREATE INDEX idx_evaluations_module_content ON evaluations(content_module, content_id);
CREATE INDEX idx_evaluations_parent ON evaluations(parent_id);

-- ============================================
-- Explain 执行计划分析示例
-- ============================================
-- 优化前：flow_index listScores 查询需要全表扫描
-- EXPLAIN SELECT ... FROM flow_index WHERE type IN (2,3,4,5) AND content_module = ?
-- type: ALL (全表扫描), rows: 数千行, Extra: Using where; Using filesort

-- 优化后：使用 idx_flow_index_module_type 索引
-- EXPLAIN SELECT ... FROM flow_index WHERE type IN (2,3,4,5) AND content_module = ?
-- type: ref (索引范围扫描), rows: 数十行, Extra: Using index condition; Using index

-- 优化前：health_news list 查询有 4 个子查询，每个子查询独立扫描 flow_index
-- 优化后：改用 LEFT JOIN + GROUP BY，一次扫描完成所有统计
-- 性能提升：从 4N 次查询降为 1 次 JOIN 查询

-- ============================================
-- 7. health_model 表索引优化
-- ============================================
CREATE INDEX idx_health_model_type ON health_model(type_id);

-- ============================================
-- 8. user 表索引优化
-- ============================================
-- 账号登录查询优化
CREATE INDEX idx_user_account ON user(account);
CREATE INDEX idx_user_role ON user(role);

-- ============================================
-- 9. chat_message 表索引优化
-- ============================================
-- AI 对话消息查询优化
CREATE INDEX idx_chat_message_session ON chat_message(session_id, create_time);

-- ============================================
-- 10. sensitive_word 表
-- ============================================
-- 敏感词管理表（用于动态扩展敏感词词典）
CREATE TABLE IF NOT EXISTS sensitive_word (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    word VARCHAR(100) NOT NULL COMMENT '敏感词',
    status TINYINT DEFAULT 1 COMMENT '状态：1-启用 0-禁用',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    UNIQUE KEY uk_word (word)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='敏感词管理表';

-- ============================================
-- 监控建议
-- ============================================
-- 1. 使用 EXPLAIN 定期分析慢查询
-- 2. 使用 slow_query_log 记录执行时间超过 1 秒的 SQL
-- 3. 关注 key_len、rows、Extra 列评估索引效率
-- 4. 避免索引过多导致写入性能下降（写入密集型表索引数 < 5）
