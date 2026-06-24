-- ============================================================
-- 协同过滤推荐效果测试数据构造脚本
-- 用途：为 xiaolizi 和 dalizi 两个账号生成差异化行为数据
--       使协同过滤算法能为每个账号推荐对方喜欢的内容
-- ============================================================

-- ==================== 第一步：确认/创建测试账号 ====================

-- 如果 xiaolizi 账号不存在则创建
INSERT IGNORE INTO `user` (`account`, `username`, `password`, `avatar`, `email`, `role`, `gender`, `create_time`)
VALUES ('xiaolizi', '小李子', '14e1b600b1fd579f47433b88e8d85291', NULL, 'xiaolizi@test.com', 2, 2, NOW());

-- 如果 dalizi 账号不存在则创建  
INSERT IGNORE INTO `user` (`account`, `username`, `password`, `avatar`, `email`, `role`, `gender`, `create_time`)
VALUES ('dalizi', '大李子', '14e1b600b1fd579f47433b88e8d85291', NULL, 'dalizi@test.com', 2, 1, NOW());


-- ==================== 第二步：获取两个用户的ID ====================
-- 执行后请记录返回的ID值，用于后续INSERT
-- SELECT id, account FROM user WHERE account IN ('xiaolizi', 'dalizi');
-- 假设: xiaolizi的ID = 79, dalizi的ID = 80 (实际以查询结果为准)


-- ==================== 第三步：清理旧数据（可选）====================
-- 如果之前测试过，先清理避免数据重复影响评分
DELETE FROM flow_index WHERE user_id IN (SELECT id FROM user WHERE account IN ('xiaolizi', 'dalizi'));


-- ==================== 第四步：xiaolizi 的行为数据 ====================
-- 人设：饮食指南爱好者 —— 重点互动 type_id=2 (饮食营养) 类资讯
-- 互动对象：资讯ID 1(早餐搭配), 10(均衡饮食), 18(控糖指南), 23(地中海饮食)

-- --- xiaolizi 对 资讯1(早餐吃不对...) 的强交互 ---
INSERT INTO flow_index (type, content_module, content_id, times, user_id, create_time) VALUES
(2, 'HEALTH_NEWS', 1, NULL, (SELECT id FROM user WHERE account='xiaolizi'), NOW()),
(3, 'HEALTH_NEWS', 1, NULL, (SELECT id FROM user WHERE account='xiaolizi'), DATE_ADD(NOW(), INTERVAL 30 SECOND)),
(4, 'HEALTH_NEWS', 1, NULL, (SELECT id FROM user WHERE account='xiaolizi'), DATE_ADD(NOW(), INTERVAL 60 SECOND)),
(5, 'HEALTH_NEWS', 1, 25000, (SELECT id FROM user WHERE account='xiaolizi'), DATE_ADD(NOW(), INTERVAL 90 SECOND));

-- --- xiaolizi 对 资讯10(均衡饮食金字塔...) 的强交互 ---
INSERT INTO flow_index (type, content_module, content_id, times, user_id, create_time) VALUES
(2, 'HEALTH_NEWS', 10, NULL, (SELECT id FROM user WHERE account='xiaolizi'), DATE_ADD(NOW(), INTERVAL 2 MINUTE)),
(3, 'HEALTH_NEWS', 10, NULL, (SELECT id FROM user WHERE account='xiaolizi'), DATE_ADD(NOW(), INTERVAL 2 MINUTE 30 SECOND)),
(4, 'HEALTH_NEWS', 10, NULL, (SELECT id FROM user WHERE account='xiaolizi'), DATE_ADD(NOW(), INTERVAL 3 MINUTE)),
(5, 'HEALTH_NEWS', 10, 35000, (SELECT id FROM user WHERE account='xiaolizi'), DATE_ADD(NOW(), INTERVAL 3 MINUTE 30 SECOND));

-- --- xiaolizi 对 资讯18(控糖饮食指南...) 的中交互 ---
INSERT INTO flow_index (type, content_module, content_id, times, user_id, create_time) VALUES
(2, 'HEALTH_NEWS', 18, NULL, (SELECT id FROM user WHERE account='xiaolizi'), DATE_ADD(NOW(), INTERVAL 5 MINUTE)),
(3, 'HEALTH_NEWS', 18, NULL, (SELECT id FROM user WHERE account='xiaolizi'), DATE_ADD(NOW(), INTERVAL 5 MINUTE 30 SECOND)),
(5, 'HEALTH_NEWS', 18, 15000, (SELECT id FROM user WHERE account='xiaolizi'), DATE_ADD(NOW(), INTERVAL 6 MINUTE));

-- --- xiaolizi 对 资讯23(地中海饮食模式...) 的中交互 ---
INSERT INTO flow_index (type, content_module, content_id, times, user_id, create_time) VALUES
(2, 'HEALTH_NEWS', 23, NULL, (SELECT id FROM user WHERE account='xiaolizi'), DATE_ADD(NOW(), INTERVAL 7 MINUTE)),
(4, 'HEALTH_NEWS', 23, NULL, (SELECT id FROM user WHERE account='xiaolizi'), DATE_ADD(NOW(), INTERVAL 7 MINUTE 30 SECOND)),
(5, 'HEALTH_NEWS', 23, 20000, (SELECT id FROM user WHERE account='xiaolizi'), DATE_ADD(NOW(), INTERVAL 8 MINUTE));


-- ==================== 第五步：dalizi 的行为数据 ====================
-- 人设：心理健康关注者 —— 重点互动 type_id=3 (心理睡眠) 类资讯
-- 互动对象：资讯ID 11(正念冥想), 19(职场焦虑), 25(数字排毒), 30(季节性情绪)

-- --- dalizi 对 资讯11(正念冥想入门...) 的强交互 ---
INSERT INTO flow_index (type, content_module, content_id, times, user_id, create_time) VALUES
(2, 'HEALTH_NEWS', 11, NULL, (SELECT id FROM user WHERE account='dalizi'), NOW()),
(3, 'HEALTH_NEWS', 11, NULL, (SELECT id FROM user WHERE account='dalizi'), DATE_ADD(NOW(), INTERVAL 30 SECOND)),
(4, 'HEALTH_NEWS', 11, NULL, (SELECT id FROM user WHERE account='dalizi'), DATE_ADD(NOW(), INTERVAL 60 SECOND)),
(5, 'HEALTH_NEWS', 11, 30000, (SELECT id FROM user WHERE account='dalizi'), DATE_ADD(NOW(), INTERVAL 90 SECOND));

-- --- dalizi 对 资讯19(职场焦虑自救手册...) 的强交互 ---
INSERT INTO flow_index (type, content_module, content_id, times, user_id, create_time) VALUES
(2, 'HEALTH_NEWS', 19, NULL, (SELECT id FROM user WHERE account='dalizi'), DATE_ADD(NOW(), INTERVAL 2 MINUTE)),
(3, 'HEALTH_NEWS', 19, NULL, (SELECT id FROM user WHERE account='dalizi'), DATE_ADD(NOW(), INTERVAL 2 MINUTE 30 SECOND)),
(4, 'HEALTH_NEWS', 19, NULL, (SELECT id FROM user WHERE account='dalizi'), DATE_ADD(NOW(), INTERVAL 3 MINUTE)),
(5, 'HEALTH_NEWS', 19, 40000, (SELECT id FROM user WHERE account='dalizi'), DATE_ADD(NOW(), INTERVAL 3 MINUTE 30 SECOND));

-- --- dalizi 对 资讯25(数字排毒挑战...) 的中交互 ---
INSERT INTO flow_index (type, content_module, content_id, times, user_id, create_time) VALUES
(2, 'HEALTH_NEWS', 25, NULL, (SELECT id FROM user WHERE account='dalizi'), DATE_ADD(NOW(), INTERVAL 5 MINUTE)),
(3, 'HEALTH_NEWS', 25, NULL, (SELECT id FROM user WHERE account='dalizi'), DATE_ADD(NOW(), INTERVAL 5 MINUTE 30 SECOND)),
(5, 'HEALTH_NEWS', 25, 18000, (SELECT id FROM user WHERE account='dalizi'), DATE_ADD(NOW(), INTERVAL 6 MINUTE));

-- --- dalizi 对 资讯30(季节性情绪障碍...) 的中交互 ---
INSERT INTO flow_index (type, content_module, content_id, times, user_id, create_time) VALUES
(2, 'HEALTH_NEWS', 30, NULL, (SELECT id FROM user WHERE account='dalizi'), DATE_ADD(NOW(), INTERVAL 7 MINUTE)),
(4, 'HEALTH_NEWS', 30, NULL, (SELECT id FROM user WHERE account='dalizi'), DATE_ADD(NOW(), INTERVAL 7 MINUTE 30 SECOND)),
(5, 'HEALTH_NEWS', 30, 22000, (SELECT id FROM user WHERE account='dalizi'), DATE_ADD(NOW(), INTERVAL 8 MINUTE));


-- ==================== 第六步：验证数据 ====================
-- 执行以下SQL查看两个用户的行为分布是否正确

-- 查看 xiaolizi 的行为统计
/*
SELECT 
    hn.type_id AS 分类,
    hn.title AS 资讯标题,
    fi.type AS 行为类型,
    COUNT(*) AS 行为次数
FROM flow_index fi
JOIN health_news hn ON fi.content_id = hn.id
WHERE fi.user_id = (SELECT id FROM user WHERE account='xiaolizi')
  AND fi.content_module = 'HEALTH_NEWS'
GROUP BY hn.id, fi.type
ORDER BY hn.id, fi.type;
*/

-- 查看 dalizi 的行为统计
/*
SELECT 
    hn.type_id AS 分类,
    hn.title AS 资讯标题,
    fi.type AS 行为类型,
    COUNT(*) AS 行为次数
FROM flow_index fi
JOIN health_news hn ON fi.content_id = hn.id
WHERE fi.user_id = (SELECT id FROM user WHERE account='dalizi')
  AND fi.content_module = 'HEALTH_NEWS'
GROUP BY hn.id, fi.type
ORDER BY hn.id, fi.type;
*/


-- ==================== 第七步：预期推荐结果 ====================
--
--  xiaolizi 登录首页 → 推荐位应出现:
--    ✅ 资讯11(正念冥想) - dalizi强交互, xiaolizi未看过
--    ✅ 资讯19(职场焦虑) - dalizi强交互, xiaolizi未看过
--    ✅ 资讯25(数字排毒) / 30(季节性情绪) - dalizi交互过, xiaolizi未看过
--    ❌ 不应出现: 1, 10, 18, 23 (xiaolizi自己已交互过的)
--
--  dalizi 登录首页 → 推荐位应出现:
--    ✅ 资讯1(早餐搭配) - xiaolizi强交互, dalizi未看过
--    ✅ 资讯10(均衡饮食) - xiaolizi强交互, dalizi未看过
--    ✅ 资讯18(控糖指南) / 23(地中海饮食) - xiaolizi交互过, dalizi未看过
--    ❌ 不应出现: 11, 19, 25, 30 (dalizi自己已交互过的)
--

-- ============================================================
-- 使用方法：
-- 1. 在MySQL客户端执行此SQL文件
-- 2. 重启后端服务（确保代码已使用修复后的UserBasedCFUtil.java）
-- 3. 用 xiaolizi 账号登录 → 刷新首页 → 截图推荐位
-- 4. 用 dalizi 账号登录 → 刷新首页 → 截图推荐位
-- 5. 对比两张截图，推荐内容应当明显不同
-- ============================================================
