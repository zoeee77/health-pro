/*
 ============================================================
  自我健康管理系统 - 增强版测试数据补充脚本（第二部分）
  Self Health Management System - Enhanced Test Data (Part 2)
  
  包含：健康记录、饮食记录、评论、点赞、流量指标
  基于第一部分新增的用户(79-90)、资讯(33-44)、食谱(29-38)、模型(19-22)
 ============================================================
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;


-- ============================================================
-- 五、新增健康记录（ID: 51~120）
-- 为新用户(79-90)和老用户(64-78)生成多维度健康数据
-- 覆盖所有health_model ID: 2,4,5,6,9,10,11,12,13,14,15,16,17,18,19,20,21,22
-- 模拟真实的多时间点监测数据
-- ============================================================

-- === 用户79 (杨洋) 的健康数据 ===
INSERT INTO `health_record` VALUES (51, 79, 4, 72.5, '2025-09-18 08:00:00');
INSERT INTO `health_record` VALUES (52, 79, 5, 8.5, '2025-09-18 08:00:00');
INSERT INTO `health_record` VALUES (53, 79, 6, 22.1, '2025-09-18 08:00:00');
INSERT INTO `health_record` VALUES (54, 79, 2, 85, '2025-09-18 08:00:00');
INSERT INTO `health_record` VALUES (55, 79, 15, 9500, '2025-09-18 20:30:00');
INSERT INTO `health_record` VALUES (56, 79, 16, 1800, '2025-09-18 21:00:00');
INSERT INTO `health_record` VALUES (57, 79, 4, 72.0, '2025-09-22 08:15:00');
INSERT INTO `health_record` VALUES (58, 79, 5, 8.3, '2025-09-22 08:15:00');
INSERT INTO `health_record` VALUES (59, 79, 6, 21.8, '2025-09-22 08:15:00');
INSERT INTO `health_record` VALUES (60, 79, 11, 5.1, '2025-09-22 08:15:00');

-- === 用户80 (李霞) 的健康数据 ===
INSERT INTO `health_record` VALUES (61, 80, 4, 48.2, '2025-09-19 07:45:00');
INSERT INTO `health_record` VALUES (62, 80, 5, 7.0, '2025-09-19 07:45:00');
INSERT INTO `health_record` VALUES (63, 80, 6, 17.9, '2025-09-19 07:45:00');
INSERT INTO `health_record` VALUES (64, 80, 12, 98, '2025-09-19 07:45:00');
INSERT INTO `health_record` VALUES (65, 80, 14, 0.6, '2025-09-19 13:00:00');
INSERT INTO `health_record` VALUES (66, 80, 4, 47.8, '2025-09-24 08:00:00');
INSERT INTO `health_record` VALUES (67, 80, 5, 7.2, '2025-09-24 08:00:00');
INSERT INTO `health_record` VALUES (68, 80, 13, 22.0, '2025-09-24 08:00:00');

-- === 用户81 (吴健) 的健康数据 ===
INSERT INTO `health_record` VALUES (69, 81, 4, 78.0, '2025-09-20 06:30:00');
INSERT INTO `health_record` VALUES (70, 81, 5, 7.5, '2025-09-20 06:30:00');
INSERT INTO `health_record` VALUES (71, 81, 6, 24.5, '2025-09-20 06:30:00');
INSERT INTO `health_record` VALUES (72, 81, 9, 82, '2025-09-20 06:30:00');
INSERT INTO `health_record` VALUES (73, 81, 10, 135, '2025-09-20 06:30:00');
INSERT INTO `health_record` VALUES (74, 81, 18, 45, '2025-09-20 18:30:00');
INSERT INTO `health_record` VALUES (75, 81, 4, 77.2, '2025-09-25 06:35:00');
INSERT INTO `health_record` VALUES (76, 81, 10, 128, '2025-09-25 06:35:00');
INSERT INTO `health_record` VALUES (77, 81, 17, 88, '2025-09-25 06:35:00');

-- === 用户82 (赵蕾) 的健康数据 ===
INSERT INTO `health_record` VALUES (78, 82, 4, 46.5, '2025-09-21 09:00:00');
INSERT INTO `health_record` VALUES (79, 82, 5, 8.8, '2025-09-21 09:00:00');
INSERT INTO `health_record` VALUES (80, 82, 6, 18.5, '2025-09-21 09:00:00');
INSERT INTO `health_record` VALUES (81, 82, 2, 110, '2025-09-21 09:00:00');
INSERT INTO `health_record` VALUES (82, 82, 13, 19.5, '2025-09-26 09:10:00');
INSERT INTO `health_record` VALUES (83, 82, 4, 46.0, '2025-09-26 09:10:00');

-- === 用户83 (孙鹏) 的健康数据 ===
INSERT INTO `health_record` VALUES (84, 83, 4, 75.0, '2025-09-22 07:00:00');
INSERT INTO `health_record` VALUES (85, 83, 5, 7.8, '2025-09-22 07:00:00');
INSERT INTO `health_record` VALUES (86, 83, 6, 23.2, '2025-09-22 07:00:00');
INSERT INTO `health_record` VALUES (87, 83, 2, 95, '2025-09-22 07:00:00');
INSERT INTO `health_record` VALUES (88, 83, 15, 12500, '2025-09-22 21:00:00');
INSERT INTO `health_record` VALUES (89, 83, 16, 2200, '2025-09-22 21:30:00');
INSERT INTO `health_record` VALUES (90, 83, 18, 55, '2025-09-22 19:00:00');
INSERT INTO `health_record` VALUES (91, 83, 19, 42, '2025-09-27 07:05:00');
INSERT INTO `health_record` VALUES (92, 83, 4, 74.5, '2025-09-27 07:05:00');

-- === 用户84 (周雨) 的健康数据 ===
INSERT INTO `health_record` VALUES (93, 84, 4, 50.0, '2025-09-23 08:30:00');
INSERT INTO `health_record` VALUES (94, 84, 5, 8.0, '2025-09-23 08:30:00');
INSERT INTO `health_record` VALUES (95, 84, 6, 19.0, '2025-09-23 08:30:00');
INSERT INTO `health_record` VALUES (96, 84, 14, 0.5, '2025-09-23 13:30:00');
INSERT INTO `health_record` VALUES (97, 84, 4, 49.5, '2025-09-28 08:25:00');
INSERT INTO `health_record` VALUES (98, 84, 5, 8.2, '2025-09-28 08:25:00');
INSERT INTO `health_record` VALUES (99, 84, 11, 5.3, '2025-09-28 08:25:00');
INSERT INTO `health_record` VALUES (100, 84, 12, 97, '2025-09-28 08:25:00');

-- === 用户85-90 (陈曦~徐阳) 各自的健康数据 ===
INSERT INTO `health_record` VALUES (101, 85, 4, 47.8, '2025-09-24 09:15:00');
INSERT INTO `health_record` VALUES (102, 85, 5, 8.6, '2025-09-24 09:15:00');
INSERT INTO `health_record` VALUES (103, 85, 6, 18.2, '2025-09-24 09:15:00');
INSERT INTO `health_record` VALUES (104, 86, 4, 68.5, '2025-09-25 08:00:00');
INSERT INTO `health_record` VALUES (105, 86, 5, 7.2, '2025-09-25 08:00:00');
INSERT INTO `health_record` VALUES (106, 86, 6, 22.8, '2025-09-25 08:00:00');
INSERT INTO `health_record` VALUES (107, 86, 9, 78, '2025-09-25 08:00:00');
INSERT INTO `health_record` VALUES (108, 86, 10, 125, '2025-09-25 08:00:00');
INSERT INTO `health_record` VALUES (109, 87, 4, 52.0, '2025-09-26 10:00:00');
INSERT INTO `health_record` VALUES (110, 87, 5, 7.8, '2025-09-26 10:00:00');
INSERT INTO `health_record` VALUES (111, 87, 6, 20.5, '2025-09-26 10:00:00');
INSERT INTO `health_record` VALUES (112, 88, 4, 73.0, '2025-09-27 07:30:00');
INSERT INTO `health_record` VALUES (113, 88, 5, 8.0, '2025-09-27 07:30:00');
INSERT INTO `health_record` VALUES (114, 88, 6, 23.5, '2025-09-27 07:30:00');
INSERT INTO `health_record` VALUES (115, 88, 17, 92, '2025-09-27 07:30:00');
INSERT INTO `health_record` VALUES (116, 89, 4, 49.5, '2025-09-28 09:00:00');
INSERT INTO `health_record` VALUES (117, 89, 5, 8.3, '2025-09-28 09:00:00');
INSERT INTO `health_record` VALUES (118, 89, 6, 19.8, '2025-09-28 09:00:00');
INSERT INTO `health_record` VALUES (119, 90, 4, 70.0, '2025-09-29 08:00:00');
INSERT INTO `health_record` VALUES (120, 90, 5, 7.5, '2025-09-29 08:00:00');


-- ============================================================
-- 六、新增饮食记录（ID: 33~75）
-- 新用户和老用户的饮食历史，关联到新增的食谱(ID:29-38)和已有食谱
-- ============================================================

-- === 用户79-84 的饮食记录 ===
INSERT INTO `diet_history` VALUES (33, 79, 29, '午餐主菜', 250, '2025-09-18 12:30:00');
INSERT INTO `diet_history` VALUES (34, 79, 20, '晚餐配菜', 150, '2025-09-18 19:00:00');
INSERT INTO `diet_history` VALUES (35, 79, 19, '早餐主食', 200, '2025-09-19 07:45:00');
INSERT INTO `diet_history` VALUES (36, 80, 30, '午餐轻食', 280, '2025-09-19 12:15:00');
INSERT INTO `diet_history` VALUES (37, 80, 24, '晚餐凉菜', 120, '2025-09-19 18:45:00');
INSERT INTO `diet_history` VALUES (38, 80, 26, '下午茶甜品', 180, '2025-09-20 15:30:00');
INSERT INTO `diet_history` VALUES (39, 81, 31, '午餐', 450, '2025-09-20 12:00:00');
INSERT INTO `diet_history` VALUES (40, 81, 18, '晚餐汤品', 300, '2025-09-20 19:30:00');
INSERT INTO `diet_history` VALUES (41, 82, 32, '晚餐主食', 480, '2025-09-21 18:00:00');
INSERT INTO `diet_history` VALUES (42, 82, 22, '午餐健身餐', 280, '2025-09-22 12:30:00');
INSERT INTO `diet_history` VALUES (43, 83, 33, '午餐', 380, '2025-09-22 12:00:00');
INSERT INTO `diet_history` VALUES (44, 83, 16, '早餐', 180, '2025-09-23 08:00:00');
INSERT INTO `diet_history` VALUES (45, 84, 34, '午餐沙拉', 350, '2025-09-23 12:30:00');
INSERT INTO `diet_history` VALUES (46, 84, 28, '晚餐汤', 200, '2025-09-23 19:30:00');

-- === 用户85-90 的饮食记录 ===
INSERT INTO `diet_history` VALUES (47, 85, 17, '午餐', 220, '2025-09-24 12:00:00');
INSERT INTO `diet_history` VALUES (48, 85, 35, '素食碗', 420, '2025-09-25 12:30:00');
INSERT INTO `diet_history` VALUES (49, 86, 36, '午餐主菜', 400, '2025-09-25 12:00:00');
INSERT INTO `diet_history` VALUES (50, 86, 2, '晚餐配菜', 100, '2025-09-25 19:00:00');
INSERT INTO `diet_history` VALUES (51, 87, 37, '海鲜大餐', 500, '2025-09-26 18:30:00');
INSERT INTO `diet_history` VALUES (52, 87, 21, '汤品', 320, '2025-09-26 18:30:00');
INSERT INTO `diet_history` VALUES (53, 88, 31, '午餐', 450, '2025-09-27 12:00:00');
INSERT INTO `diet_history` VALUES (54, 88, 19, '早餐粥', 250, '2025-09-28 07:30:00');
INSERT INTO `diet_history` VALUES (55, 89, 38, '甜品', 280, '2025-09-28 20:30:00');
INSERT INTO `diet_history` VALUES (56, 89, 20, '晚餐蔬菜', 160, '2025-09-29 18:45:00');
INSERT INTO `diet_history` VALUES (57, 90, 33, '午餐快手菜', 360, '2025-09-29 12:15:00');
INSERT INTO `diet_history` VALUES (58, 90, 29, '西餐', 400, '2025-09-30 19:00:00');

-- === 老用户(64-78) 对新食谱的饮食记录 ===
INSERT INTO `diet_history` VALUES (59, 64, 29, '周末改善伙食', 260, '2025-09-19 12:00:00');
INSERT INTO `diet_history` VALUES (60, 65, 30, '尝试新口味', 290, '2025-09-20 12:30:00');
INSERT INTO `diet_history` VALUES (61, 66, 32, '韩餐体验', 480, '2025-09-25 18:30:00');
INSERT INTO `diet_history` VALUES (62, 67, 34, '减脂餐', 350, '2025-09-24 12:00:00');
INSERT INTO `diet_history` VALUES (63, 68, 35, '素食日', 430, '2025-09-26 12:30:00');
INSERT INTO `diet_history` VALUES (64, 69, 26, '养生甜品', 210, '2025-09-27 15:00:00');
INSERT INTO `diet_history` VALUES (65, 70, 36, '增肌餐', 420, '2025-09-28 12:00:00');
INSERT INTO `diet_history` VALUES (66, 71, 37, '海鲜宴客', 520, '2025-09-29 19:00:00');
INSERT INTO `diet_history` VALUES (67, 72, 33, '快手小炒', 370, '2025-09-30 12:15:00');
INSERT INTO `diet_history` VALUES (68, 73, 38, '甜品慰劳', 290, '2025-09-29 20:30:00');
INSERT INTO `diet_history` VALUES (69, 74, 29, '三文鱼日', 390, '2025-09-26 12:00:00');
INSERT INTO `diet_history` VALUES (70, 75, 34, '蒸蛋早餐', 100, '2025-09-23 07:30:00');
INSERT INTO `diet_history` VALUES (71, 76, 31, '韩式拌饭', 460, '2025-09-27 13:00:00');
INSERT INTO `diet_history` VALUES (72, 77, 30, '泰式清爽', 290, '2025-09-25 12:00:00');
INSERT INTO `diet_history` VALUES (73, 78, 32, '意面日', 450, '2025-09-28 19:00:00');
INSERT INTO `diet_history` VALUES (74, 62, 29, '尝鲜', 260, '2025-09-20 12:30:00');
INSERT INTO `diet_history` VALUES (75, 61, 35, '素食尝试', 430, '2025-09-24 12:00:00');


-- ============================================================
-- 七、新增评论数据（ID: 20~44）
-- 包含对新健康资讯(33-44)和新食谱(29-38)的评论及回复
-- content_type: 'HEALTH-NEWS' 或 'RECIPE'
-- ============================================================

-- === 对新健康资讯的评论 ===
INSERT INTO `evaluations` VALUES (20, NULL, 79, NULL, 'HEALTH-NEWS', 33, '瑜伽入门这篇写得太实用了！我按照文中的5个体式练习了一周，感觉背部真的挺直了很多。特别是猫牛式，每次做完脊柱都感觉被打开了。请问作者有推荐的进阶课程吗？', '2025-09-18 14:30:00');
INSERT INTO `evaluations` VALUES (21, NULL, 80, NULL, 'HEALTH-NEWS', 33, '+1 猫牛式对腰痛真的很有效！我之前久坐导致腰椎间盘突出，医生建议做康复训练，猫牛式就是其中之一。坚持了两个月，疼痛明显减轻。建议大家一定要配合呼吸，不要憋气！', '2025-09-18 16:45:00');
INSERT INTO `evaluations` VALUES (22, 21, 82, 80, 'HEALTH-NEWS', 33, '请问腰椎间盘突出做猫牛式有什么需要注意的吗？我老公也是类似情况，想让他试试但怕动作不当加重病情。', '2025-09-19 09:15:00');
INSERT INTO `evaluations` VALUES (23, NULL, 64, NULL, 'HEALTH-NEWS', 34, '间歇性断食我也在尝试！目前坚持16:8模式一个月了，体重降了3公斤，最明显的感觉是下午不再犯困了。不过有个问题：断食期间可以喝黑咖啡吗？', '2025-09-19 11:00:00');
INSERT INTO `evaluations` VALUES (24, 23, 81, 64, 'HEALTH-NEWS', 34, '可以喝！黑咖啡不仅不会打破断食状态，还能帮助抑制食欲、提升脂肪燃烧效率。建议选择美式或浓缩，不要加奶加糖。另外断食期间多喝水很重要！', '2025-09-19 14:20:00');
INSERT INTO `evaluations` VALUES (25, NULL, 66, NULL, 'HEALTH-NEWS', 35, '社交焦虑这段真的戳中我了😭...作为一个程序员，每次code review或者给客户演示产品时都紧张到手抖。4-7-8呼吸法我试了一下，确实有用！准备开始系统性地练习CBT技巧了。', '2025-09-20 10:30:00');
INSERT INTO `evaluations` VALUES (26, NULL, 67, NULL, 'HEALTH-NEWS', 36, '普拉提vs瑜伽的对比太清晰了！我之前一直搞不清两者的区别。现在知道我应该先练普拉提强化核心（我有骨盆前倾），再配合瑜伽提高柔韧性。感谢作者的详细分析！', '2025-09-23 15:00:00');
INSERT INTO `evaluations` VALUES (27, NULL, 69, NULL, 'HEALTH-NEWS', 37, '发酵食品爱好者来报到！🙋‍♀️ 我每天早上都会喝自制的康普茶，已经坚持半年了，肠胃明显比以前好很多。最近在尝试自制泡菜，第一次就成功了超开心！', '2025-09-24 09:45:00');
INSERT INTO `evaluations` VALUES (28, 27, 70, 69, 'HEALTH-NEWS', 37, '求泡菜制作教程！我买了白菜和胡萝卜但不知道具体比例和调料用量，怕做出来不安全。另外康普茶是买菌粉自己发酵还是直接买成品的？', '2025-09-24 16:30:00');
INSERT INTO `evaluations` VALUES (29, NULL, 71, NULL, 'HEALTH-NEWS', 40, '睡眠环境优化这篇文章太及时了！刚搬了新家一直在调整卧室布置。按照文章的建议换了遮光窗帘（原来那款漏光严重）加了白噪音机，现在入睡时间从原来的1小时缩短到15分钟！', '2025-09-26 08:20:00');
INSERT INTO `evaluations` VALUES (30, NULL, 62, NULL, 'HEALTH-NEWS', 42, '体检报告解读每年都需要！去年查出来尿酸偏高（580），一开始没当回事，结果今年痛风发作疼得下不了地😭 现在严格控制嘌呤饮食+吃非布司他，终于降到正常范围了。大家一定要重视体检异常指标！', '2025-09-27 11:30:00');
INSERT INTO `evaluations` VALUES (31, NULL, 63, NULL, 'HEALTH-NEWS', 43, '家庭健身房搭建指南收藏了！💪 作为学生党预算有限，先入手了瑜伽垫和弹力带套装（总共不到200元）。已经在B站跟着视频练了两周，感觉效果不错。下一步想入一副可调节哑铃。', '2025-09-28 16:00:00');

-- === 对新食谱的评论 ===
INSERT INTO `evaluations` VALUES (32, NULL, 79, NULL, 'RECIPE', 29, '香煎三文鱼太赞了！🐟 第一次煎出了完美的酥皮，关键就是拍干水分这一步。配上芦笋颜值也超高，拍照发朋友圈收获了一大波点赞～ 三文鱼选的是挪威进口的，肉质特别鲜嫩！', '2025-09-18 19:30:00');
INSERT INTO `evaluations` VALUES (33, NULL, 80, NULL, 'RECIPE', 30, '芒果虾 salad 好吃到哭！😭 酸甜咸辣的口感层次太丰富了。我额外加了一些牛油果增加creamy感，还撒了炸过的椰丝脆脆的超好吃！强烈推荐大家试试这个搭配！', '2025-09-19 13:20:00');
INSERT INTO `evaluations` VALUES (34, NULL, 81, NULL, 'RECIPE', 31, '石锅拌饭在家也能做出餐厅的味道？本来不信，按着步骤做了之后真香！锅巴酥脆的程度刚刚好，蛋液包裹着米饭每一口都是满足感。下次想试试加芝士拉丝版本～', '2025-09-20 14:00:00');
INSERT INTO `evaluations` VALUES (35, NULL, 82, NULL, 'RECIPE', 34, '蒸蛋的顺滑程度完全取决于过滤蛋液这一步！我以前总是偷懒不过滤，结果蒸出来全是蜂窝孔。这次乖乖过了两遍，成品像丝绸一样滑嫩，入口即化！', '2025-09-23 08:15:00');
INSERT INTO `evaluations` VALUES (36, 34, 84, 82, 'RECIPE', 34, '分享一个小技巧：除了过筛，还可以在蛋液表面盖一层保鲜膜再蒸，这样表面也不会产生气泡孔。另外加点虾仁和瑶柱进去就是豪华版蒸蛋啦～', '2025-09-23 18:45:00');
INSERT INTO `evaluations` VALUES (37, NULL, 83, NULL, 'RECIPE', 36, '蒜蓉粉丝扇贝宴客级别！🦪 在家做成本不到外面餐馆的三分之一，味道却不输。金银蒜的做法学到了，以后炒任何菜都可以用这个方法提香。扇贝选的是大连产的，个头大肉厚实！', '2025-09-25 20:00:00');
INSERT INTO `evaluations` VALUES (38, NULL, 85, NULL, 'RECIPE', 37, '桂花糯米藕是秋天的味道啊 🍂🍂 切片后晶莹剔透的，糯米的软糯、藕的清甜、桂花的香气完美融合。冷藏后第二天吃风味更佳！作为饭后甜品既满足又不腻。', '2025-09-27 21:00:00');
INSERT INTO `evaluations` VALUES (39, NULL, 86, NULL, 'RECIPE', 38, '意面乳化这一步真的是灵魂！🍝 以前煮完面总是水水的挂不上酱，现在知道了要加煮面水一起翻炒让淀粉和油脂结合。罗勒叶用手撕碎确实比刀切的更香！', '2025-09-26 19:30:00');
INSERT INTO `evaluations` VALUES (40, NULL, 87, NULL, 'RECIPE', 33, '彩椒牛肉粒已加入我的每周菜单循环！🌶️ 高蛋白低脂而且五颜六色的看着就有食欲。我通常一次多做一点分装好，上班带便当超级方便。同事都问我要食谱哈哈', '2025-09-22 12:45:00');
INSERT INTO `evaluations` VALUES (41, NULL, 88, NULL, 'RECIPE', 32, '奶油蘑菇汤居然这么简单？！用了料理棒打碎一部分后口感层次丰富多了——既有细腻的奶油质感又有蘑菇颗粒的嚼劲。下次想试试加些培根碎进去增加咸鲜味。', '2025-09-21 18:00:00');
INSERT INTO `evaluations` VALUES (42, NULL, 89, NULL, 'RECIPE', 35, '藜麦素食bowl颜值太高了！📸 摆盘的时候就像在创作艺术品一样开心。营养也很均衡，吃完一整天都不饿。tahini酱是自己做的吗还是买的？推荐什么牌子？', '2025-09-24 13:30:00');
INSERT INTO `evaluations` VALUES (43, 42, 79, 89, 'RECIPE', 35, '我是自己做的！超市就能买到tahini（芝麻酱）。做法很简单：tahini + 柠檬汁 + 水 + 盐 + 蒜末，用搅拌机打匀就行。比例可以根据喜好调整浓稠度哦～', '2025-09-24 19:00:00');
INSERT INTO `evaluations` VALUES (44, NULL, 90, NULL, 'RECIPE', 30, '泰式芒果虾沙拉夏天吃太爽了！🥭 不过我稍微改动了配方：把虾仁换成了烤鸡胸肉丝（蛋白质更高热量更低），还加了一些青木瓜丝增加脆感口感。清爽开胃！', '2025-09-28 12:30:00');


-- ============================================================
-- 八、新增评论点赞数据（ID: 9~28）
-- 为新增评论生成真实的点赞互动
-- ============================================================

INSERT INTO `evaluations_upvote` VALUES (9, 61, 20);
INSERT INTO `evaluations_upvote` VALUES (10, 62, 20);
INSERT INTO `evaluations_upvote` VALUES (11, 64, 21);
INSERT INTO `evaluations_upvote` VALUES (12, 65, 21);
INSERT INTO `evaluations_upvote` VALUES (13, 66, 22);
INSERT INTO `evaluations_upvote` VALUES (14, 67, 22);
INSERT INTO `evaluations_upvote` VALUES (15, 68, 23);
INSERT INTO `evaluations_upvote` VALUES (16, 69, 24);
INSERT INTO `evaluations_upvote` VALUES (17, 70, 24);
INSERT INTO `evaluations_upvote` VALUES (18, 71, 25);
INSERT INTO `evaluations_upvote` VALUES (19, 72, 25);
INSERT INTO `evaluations_upvote` VALUES (20, 73, 26);
INSERT INTO `evaluations_upvote` VALUES (21, 74, 26);
INSERT INTO `evaluations_upvote` VALUES (22, 75, 27);
INSERT INTO `evaluations_upvote` VALUES (23, 76, 27);
INSERT INTO `evaluations_upvote` VALUES (24, 77, 28);
INSERT INTO `evaluations_upvote` VALUES (25, 78, 28);
INSERT INTO `evaluations_upvote` VALUES (26, 79, 29);
INSERT INTO `evaluations_upvote` VALUES (27, 80, 30);
INSERT INTO `evaluations_upvote` VALUES (28, 81, 31);
INSERT INTO `evaluations_upvote` VALUES (29, 82, 32);
INSERT INTO `evaluations_upvote` VALUES (30, 83, 32);
INSERT INTO `evaluations_upvote` VALUES (31, 84, 33);
INSERT INTO `evaluations_upvote` VALUES (32, 85, 34);
INSERT INTO `evaluations_upvote` VALUES (33, 86, 35);
INSERT INTO `evaluations_upvote` VALUES (34, 87, 36);
INSERT INTO `evaluations_upvote` VALUES (35, 88, 37);
INSERT INTO `evaluations_upvote` VALUES (36, 89, 38);
INSERT INTO `evaluations_upvote` VALUES (37, 90, 39);
INSERT INTO `evaluations_upvote` VALUES (38, 79, 40);
INSERT INTO `evaluations_upvote` VALUES (39, 80, 41);


SET FOREIGN_KEY_CHECKS = 1;
