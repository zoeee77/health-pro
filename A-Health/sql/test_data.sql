/*
 ============================================================
  自我健康管理系统 - 测试数据生成脚本
  Self Health Management System - Test Data Generator
  
  基于现有 selfhealth.sql 数据格式生成
  所有图片均使用系统中已有的真实图片
  包含：用户样本、健康资讯、食谱、健康记录、饮食记录、评论、点赞、流量指标
 ============================================================
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;


-- ============================================================
-- 一、新增用户样本（15位新用户，ID: 64~78）
-- 头像复用系统中已有图片（6张循环使用）
-- ============================================================

INSERT INTO `user` VALUES (64, 'wangxiaoli', '王小丽', '14e1b600b1fd579f47433b88e8d85291', '/api/v1.0/self-health-api/file/getFile?fileName=17587778993152.png', 'xiaoli@163.com', 2, 1, '1995-03-18', '13812345601', '2025-09-01 09:15:00');
INSERT INTO `user` VALUES (65, 'chen_dawei', '陈大伟', '14e1b600b1fd579f47433b88e8d85291', '/api/v1.0/self-health-api/file/getFile?fileName=17587779050599.png', 'dawei.chen@qq.com', 2, 2, '1988-11-22', '13987654321', '2025-09-02 10:20:45');
INSERT INTO `user` VALUES (66, 'linmeimei', '林美美', '14e1b600b1fd579f47433b88e8d85291', '/api/v1.0/self-health-api/file/getFile?fileName=1758777922524Snipaste_2025-04-25_15-25-57.png', 'meimei.lin@gmail.com', 2, 1, '1998-07-08', '13566668888', '2025-09-03 11:35:12');
INSERT INTO `user` VALUES (67, 'zhangqiang', '张强', '14e1b600b1fd579f47433b88e8d85291', '/api/v1.0/self-health-api/file/getFile?fileName=1758777928834Snipaste_2025-05-20_15-11-47.png', 'zhangqiang@126.com', 2, 2, '1992-05-15', '13699990000', '2025-09-04 14:00:28');
INSERT INTO `user` VALUES (68, 'liuyang', '刘洋', '14e1b600b1fd579f47433b88e8d85291', '/api/v1.0/self-health-api/file/getFile?fileName=17587779689247.png', 'liuyang.yang@qq.com', 2, 1, '2000-12-25', NULL, '2025-09-05 16:45:55');
INSERT INTO `user` VALUES (69, 'sunhong', '孙红', '14e1b600b1fd579f47433b88e8d85291', '/api/v1.0/self-health-api/file/getFile?fileName=17587779353178.png', 'sunhong_red@163.com', 2, 1, '1993-09-30', '13722223333', '2025-09-06 08:30:18');
INSERT INTO `user` VALUES (70, 'zhouming', '周明', '14e1b600b1fd579f47433b88e8d85291', '/api/v1.0/self-health-api/file/getFile?fileName=17587778993152.png', 'zhou_ming@hotmail.com', 2, 2, '1985-01-10', '15811112222', '2025-09-07 13:20:40');
INSERT INTO `user` VALUES (71, 'wuxiaoxiao', '吴小小', '14e1b600b1fd579f47433b88e8d85291', '/api/v1.0/self-health-api/file/getFile?fileName=17587779050599.png', 'wuxx@qq.com', 2, 1, '1996-06-18', '15933334444', '2025-09-08 17:55:03');
INSERT INTO `user` VALUES (72, 'zhaojun', '赵军', '14e1b600b1fd579f47433b88e8d85291', '/api/v1.0/self-health-api/file/getFile?fileName=1758777922524Snipaste_2025-04-25_15-25-57.png', 'zhao_jun@gmail.com', 2, 2, '1990-08-20', '18655556666', '2025-09-09 19:10:27');
INSERT INTO `user` VALUES (73, 'huangfang', '黄芳', '14e1b600b1fd579f47433b88e8d85291', '/api/v1.0/self-health-api/file/getFile?fileName=1758777928834Snipaste_2025-05-20_15-11-47.png', 'huangfang_fang@126.com', 2, 1, '1997-04-12', '17777778888', '2025-09-10 10:45:50');
INSERT INTO `user` VALUES (74, 'maLong', '马龙', '14e1b600b1fd579f47433b88e8d85291', '/api/v1.0/self-health-api/file/getFile?fileName=17587779689247.png', 'malong_sport@qq.com', 2, 2, '1983-10-28', '18899990000', '2025-09-11 15:30:15');
INSERT INTO `user` VALUES (75, 'gaoyuanyuan', '高媛媛', '14e1b600b1fd579f47433b88e8d85291', '/api/v1.0/self-health-api/file/getFile?fileName=17587779353178.png', 'gyy_healthy@163.com', 2, 1, '1994-02-14', NULL, '2025-09-12 09:00:00');
INSERT INTO `user` VALUES (76, 'luochen', '罗晨', '14e1b600b1fd579f47433b88e8d85291', '/api/v1.0/self-health-api/file/getFile?fileName=17587778993152.png', 'luo_chen@qq.com', 2, 2, '1991-12-08', '15566667777', '2025-09-13 11:20:33');
INSERT INTO `user` VALUES (77, 'tangtang', '唐糖', '14e1b600b1fd579f47433b88e8d85291', '/api/v1.0/self-health-api/file/getFile?fileName=17587779050599.png', 'tang_tang@gmail.com', 2, 1, '1999-07-20', '13388889999', '2025-09-14 14:40:48');
INSERT INTO `user` VALUES (78, 'xujie', '徐杰', '14e1b600b1fd579f47433b88e8d85291', '/api/v1.0/self-health-api/file/getFile?fileName=1758777922524Snipaste_2025-04-25_15-25-57.png', 'xujie_fit@126.com', 2, 2, '1987-03-25', '18000001111', '2025-09-15 08:15:22');


-- ============================================================
-- 二、新增健康资讯（ID: 17~32）
-- 封面图复用已有health_news封面（11张循环）+ 正文图用已有内容图
-- type_id: 1=运动健身, 2=饮食营养, 3=心理健康, 4=睡眠养生, 5=综合健康
-- ============================================================

INSERT INTO `health_news` VALUES (17, 1, '/api/v1.0/self-health-api/file/getFile?fileName=1754313964000Snipaste_2025-04-21_16-58-17.png', 'HIIT训练法：20分钟燃脂效果堪比跑步1小时', '<p><strong>什么是 HIIT？</strong></p><p>HIIT（高强度间歇训练）是一种在短时间进行高强度运动与低强度休息交替的训练方式。研究表明，每周进行3次、每次仅20分钟的HIIT训练，其燃脂效果可媲美每周5次、每次1小时的慢跑。</p><p><img src=\"/api/v1.0/self-health-api/file/getFile?fileName=1753534646517Snipaste_2025-04-21_16-57-23.png\" alt=\"HIIT训练示意图\" style=\"width: 100%;\"/></p><p><strong>新手入门方案：</strong></p><ol><li>热身：5分钟慢跑或开合跳</li><li>正式训练：30秒全力冲刺 + 30秒慢走恢复，重复8-10组</li><li>拉伸放松：5分钟全身静态拉伸</li></ol><p><strong>注意事项：</strong>初学者建议从低强度开始，循序渐进。有心血管疾病者请在医生指导下进行。</p>', 'HIIT高强度间歇训练，短时高效燃脂方案，适合忙碌上班族。每周3次每次20分钟，燃脂效果媲美1小时慢跑。', '2025-09-01 09:30:00');

INSERT INTO `health_news` VALUES (18, 2, '/api/v1.0/self-health-api/file/getFile?fileName=1754314121023Snipaste_2025-04-21_16-58-10.png', '控糖饮食指南：如何科学减少每日糖分摄入', '<p><strong>为什么需要控制糖分？</strong></p><p>世界卫生组织建议成年人每日游离糖摄入量不超过25克（约6茶匙）。过量摄入糖分会增加肥胖、2型糖尿病、心血管疾病等风险。</p><p><img src=\"/api/v1.0/self-health-api/file/getFile?fileName=1753534646517Snipaste_2025-04-21_16-57-23.png\" alt=\"糖分摄入对比图\" style=\"width: 100%;\"/></p><p><strong>5个实用减糖技巧：</strong></p><ol><li>用水果替代甜点——天然果糖搭配膳食纤维更健康</li><li>选择无糖饮料或白水/茶饮</li><li>学会看食品标签，警惕"隐形糖"（如番茄酱、沙拉酱）</li><li>自己烹饪，少用糖醋汁等高糖调料</li><li>逐渐降低甜度偏好，让味蕾适应清淡口味</li></ol>', '世界卫生组织建议每日糖摄入≤25克。5个实用减糖技巧：用水果代甜点、选无糖饮料、看懂食品标签、自己做饭、逐步降低甜度偏好。', '2025-09-02 10:15:00');

INSERT INTO `health_news` VALUES (19, 3, '/api/v1.0/self-health-api/file/getFile?fileName=1754314146011Snipaste_2025-04-21_16-58-30.png', '职场焦虑自救手册：5个缓解工作压力的心理学方法', '<p><strong>你是否有这些症状？</strong></p><p>失眠多梦、注意力难以集中、对工作产生抵触情绪、经常感到疲惫却无法放松……这些都可能是职场焦虑的信号。</p><p><img src=\"/api/v1.0/self-health-api/file/getFile?fileName=1753534646517Snipaste_2025-04-21_16-57-23.png\" alt=\"压力管理方法\" style=\"width: 70%;\"/></p><p><strong>科学验证有效的5个减压方法：</strong></p><ul><li><strong>4-7-8呼吸法：</strong>吸气4秒→屏息7秒→呼气8秒，重复4次，可快速激活副交感神经</li><li><strong>认知重评：</strong>将"我必须完美完成"改为"尽力就好"，调整非理性信念</li><li><strong>微休息策略：</strong>每工作90分钟起身活动5分钟，提升后续专注力</li><li><strong>感恩日记：</strong>每天记录3件值得感谢的小事，培养积极心理</li><li><strong>社交支持：</strong>与信任的朋友倾诉，不要独自承担所有压力</li></ul>', '职场焦虑自救：4-7-8呼吸法快速放松、认知重评调整心态、微休息策略提升效率、感恩日记培养积极心理、主动寻求社交支持。', '2025-09-03 14:00:00');

INSERT INTO `health_news` VALUES (20, 4, '/api/v1.0/self-health-api/file/getFile?fileName=1753534656538Snipaste_2025-04-21_16-57-23.png', '深度睡眠的秘密：改善睡眠质量的7个科学方法', '<p><strong>好的睡眠不只是时长，更是质量。</strong></p><p>很多人睡够8小时仍感疲惫，问题往往出在睡眠质量上。深度睡眠（慢波睡眠）是身体修复的关键阶段，以下方法帮你提升深度睡眠比例：</p><p><img src=\"/api/v1.0/self-health-api/file/getFile?fileName=1753534646517Snipaste_2025-04-21_16-57-23.png\" alt=\"睡眠周期图\" style=\"width: 100%;\"/></p><p><strong>7个科学助眠方法：</strong></p><ol><li><strong>固定作息：</strong>每天同一时间入睡和起床（包括周末），调节生物钟</li><li><strong>睡前远离蓝光：</strong>手机电脑至少提前1小时放下，蓝光抑制褪黑素分泌</li><li><strong>卧室环境优化：</strong>温度18-22°C，完全遮光，安静环境</li><li><strong>避免下午3点后摄入咖啡因：</strong>咖啡因半衰期约5-6小时</li><li><strong>睡前放松仪式：</strong>温水泡脚、阅读纸质书、轻柔拉伸</li><li><strong>晚餐时间：</strong>睡前3小时内避免大量进食</li><li><strong>白天充分光照接触：</strong>帮助夜间褪黑素正常分泌</li></ol>', '提升深度睡眠质量的7个科学方法：固定作息、远离蓝光、优化卧室环境、控制咖啡因摄入、建立睡前放松仪式、注意晚餐时间、白天充分光照。', '2025-09-04 16:30:00');

INSERT INTO `health_news` VALUES (21, 1, '/api/v1.0/self-health-api/file/getFile?fileName=1754314012947Snipaste_2025-04-21_16-56-22.png', '久坐族必看！办公室10分钟微运动合集', '<p><strong>久坐的危害比你想象的更大。</strong></p><p>研究显示，连续久坐超过2小时，心血管疾病风险显著上升。但工作繁忙没时间去健身房怎么办？试试这套办公室微运动：</p><p><img src=\"/api/v1.0/self-health-api/file/getFile?fileName=1753534646517Snipaste_2025-04-21_16-57-23.png\" alt=\"办公室微运动\" style=\"width: 100%;\"/></p><p><strong>10分钟办公室微运动清单：</strong></p><ul><li><strong>颈部环绕（1分钟）：</strong>缓慢转动头部，缓解颈椎僵硬</li><li><strong>肩部提沉（1分钟）：</strong>双肩向上提起再下沉放松，重复15次</li><li><strong>坐姿转体（2分钟）：</strong>双手扶椅背，左右交替扭转躯干</li><li><strong>腿部抬升（2分钟）：</strong>坐姿交替抬高双腿，激活核心肌群</li><li><strong>椅子深蹲（2分钟）：</strong>利用椅子辅助做半蹲动作</li><li><strong>手腕脚踝旋转（1分钟）：</strong>预防腱鞘炎和静脉曲张</li><li><strong>站立踮脚（1分钟）：</strong>促进下肢血液循环</li></ul><p>建议每工作1小时就做一轮，只需10分钟即可有效对抗久坐危害！</p>', '办公室10分钟微运动：颈部环绕、肩部提沉、坐姿转体、腿部抬升、椅子深蹲、腕踝旋转、站立踮脚。每小时做一轮，有效对抗久坐危害。', '2025-09-05 11:00:00');

INSERT INTO `health_news` VALUES (22, 5, '/api/v1.0/self-health-api/file/getFile?fileName=1754393018796Snipaste_2025-07-01_16-06-23.png', '免疫力提升全攻略：从饮食到生活习惯的科学指南', '<p><strong>免疫系统是你最好的医生。</strong></p><p>强大的免疫力能帮助你抵御病毒感染、加速伤口愈合、降低慢性病风险。以下是经过科学验证的免疫力提升方法：</p><p><img src=\"/api/v1.0/self-health-api/file/getFile?fileName=1753534646517Snipaste_2025-04-21_16-57-23.png\" alt=\"免疫系统示意图\" style=\"width: 80%;\"/></p><p><strong>🍊 饮食篇：</strong></p><ul><li>保证优质蛋白质摄入（鱼、蛋、奶、豆制品）——免疫细胞的基础原料</li><li>多吃富含维生素C的食物（柑橘类、猕猴桃、彩椒）</li><li>补充锌元素（贝类、坚果、瘦肉）——促进免疫细胞成熟</li><li>适量补充益生菌（酸奶、发酵食品）——维护肠道免疫屏障</li></ul><p><strong>🏃 生活习惯篇：</strong></p><ul><li>每周150分钟中等强度有氧运动</li><li>保证每晚7-9小时高质量睡眠</li><li>管理压力水平，长期皮质醇升高会抑制免疫功能</li><li>戒烟限酒，这两者都会直接削弱免疫反应</li></ul><p><strong>💊 补充剂提醒：</strong>维生素D缺乏者应优先补充维D（大多数人都有不足），而非盲目服用复合维生素。</p>', '免疫力提升攻略：饮食上保证蛋白质+维生素C+锌+益生菌；生活习惯上坚持运动+充足睡眠+压力管理+戒烟限酒；补充剂首选维生素D。', '2025-09-06 09:45:00');

INSERT INTO `health_news` VALUES (23, 2, '/api/v1.0/self-health-api/file/getFile?fileName=1754314121023Snipaste_2025-04-21_16-58-10.png', '地中海饮食模式：被《美国新闻》连续7年评为最佳饮食', '<p><strong>什么是地中海饮食？</strong></p><p>地中海饮食是以希腊、意大利、西班牙等地中海沿岸国家传统饮食习惯为基础的一种膳食模式。大量流行病学研究证实，坚持地中海饮食可降低心血管疾病风险达30%，并有助于预防糖尿病和某些癌症。</p><p><img src=\"/api/v1.0/self-health-api/file/getFile?fileName=1753534646517Snipaste_2025-04-21_16-57-23.png\" alt=\"地中海饮食金字塔\" style=\"width: 100%;\"/></p><p><strong>地中海饮食的核心原则：</strong></p><ol><li><strong>以植物性食物为主：</strong>蔬菜、水果、全谷物、豆类、坚果应占每餐的大部</li><li><strong>橄榄油为主要脂肪来源：</strong>用特级初榨橄榄油替代黄油和人造奶油</li><li><strong>适量鱼类和海鲜：</strong>每周至少吃2次富含Omega-3脂肪酸的鱼类</li><li><strong>限制红肉摄入：</strong>每月仅几次，以禽肉替代部分红肉</li><li><strong>适量乳制品：</strong>优选发酵乳制品如酸奶和奶酪</li><li><strong>用香草和香料调味：</strong>减少盐的使用量</li><li><strong>适量饮酒（可选）：</strong>进餐时可配一杯红酒</li><li><strong>享受与他人共餐的乐趣：</strong>社会联系也是健康的组成部分</li></ol>', '地中海饮食核心：植物性食物为主、橄榄油为脂肪来源、每周2次鱼类、限制红肉、适量乳制品、香料代盐、可选红酒佐餐、重视社交共餐。', '2025-09-07 15:20:00');

INSERT INTO `health_news` VALUES (24, 1, '/api/v1.0/self-health-api/file/getFile?fileName=1754313964000Snipaste_2025-04-21_16-58-17.png', '力量训练入门：女生练肌肉不会变成"金刚芭比"', '<p><strong>一个常见的误区：</strong></p><p>很多女性担心力量训练会让自己变得过于"壮硕"。事实上，由于睾酮水平的差异，女性极难通过自然训练获得夸张的肌肉量。适度力量训练只会让身材更加紧致有型。</p><p><img src=\"/api/v1.0/self-health-api/file/getFile?fileName=1753534646517Snipaste_2025-04-21_16-57-23.png\" alt=\"力量训练对比\" style=\"width: 100%;\"/></p><p><strong>女性力量训练的5大好处：</strong></p><ul><li><strong>提高基础代谢率：</strong>肌肉组织比脂肪消耗更多热量，即使静止时也在燃烧卡路里</li><li><strong>塑造优美体态：</strong>改善圆肩驼背，让身姿挺拔自信</li><li><strong>增强骨密度：</strong>预防骨质疏松，尤其对绝经后女性尤为重要</li><li><strong>功能性提升：</strong>日常搬物、抱孩子都变得更轻松</li><li><strong>心理赋能：</strong>感受身体变强的过程，增强自我效能感</li></ul><p><strong>新手推荐计划（每周2-3次）：</strong></p><ol><li>深蹲/箭步蹲——锻炼臀腿</li><li>俯卧撑（可跪姿）——锻炼胸臂</li><li>哑铃划船——锻炼背部</li><li>平板支撑——锻炼核心</li></ol>', '女性力量训练真相：不会变成金刚芭比！好处包括提高代谢、塑造体态、增强骨密度、功能提升、心理赋能。新手计划：深蹲、俯卧撑、划船、平板支撑。', '2025-09-08 13:10:00');

INSERT INTO `health_news` VALUES (25, 3, '/api/v1.0/self-health-api/file/getFile?fileName=1754314146011Snipaste_2025-04-21_16-58-30.png', '数字排毒挑战：如何戒掉手机成瘾找回生活重心', '<p><strong>你的手机使用情况健康吗？</strong></p><p>据统计，现代人平均每天查看手机96次，累计使用超过4小时。过度使用智能手机会导致注意力碎片化、焦虑抑郁倾向增加以及现实社交能力退化。</p><p><img src=\"/api/v1.0/self-health-api/file/getFile?fileName=1753534646517Snipaste_2025-04-21_16-57-23.png\" alt=\"数字排毒\" style=\"width: 75%;\"/></p><p><strong>7天数字 detox 挑战计划：</strong></p><table style=\"border-collapse: collapse; width: 100%;\"><tr style=\"background: #f0f0f0;\"><th style=\"padding: 8px; border: 1px solid #ddd;\">天数</th><th style=\"padding: 8px; border: 1px solid #ddd;\">挑战内容</th></tr><tr><td style=\"padding: 8px; border: 1px solid #ddd;\">Day 1</td><td style=\"padding: 8px; border: 1px solid #ddd;\">卸载最耗时的1个娱乐App</td></tr><tr><td style=\"padding: 8px; border: 1px solid #ddd;\">Day 2</td><td style=\"padding: 8px; border: 1px solid #ddd;\">设置屏幕使用时间为2小时上限</td></tr><tr><td style=\"padding: 8px; border: 1px solid #ddd;\">Day 3</td><td style=\"padding: 8px; border: 1px solid #ddd;\">起床后1小时内不看手机</td></tr><tr><td style=\"padding: 8px; border: 1px solid #ddd;\">Day 4</td><td style=\"padding: 8px; border: 1px solid #ddd;\">用餐时不看手机（正念进食）</td></tr><tr><td style=\"padding: 8px; border: 1px solid #ddd;\">Day 5</td><td style=\"padding: 8px; border: 1px solid #ddd;\">睡前1小时关闭所有电子设备</td></tr><tr><td style=\"padding: 8px; border: 1px solid #ddd;\">Day 6</td><td style=\"padding: 8px; border: 1px solid #ddd;\">安排一次无手机的户外活动</td></tr><tr><td style=\"padding: 8px; border: 1px solid #ddd;\">Day 7</td><td style=\"padding: 8px; border: 1px solid #ddd;\">回顾一周变化，制定可持续规则</td></tr></table><p><strong>长期建议：</strong>将手机设置为灰度模式、关闭非必要通知、在家中设立"无手机区域"。科技应为生活服务，而不是反过来。</p>', '数字排毒7天挑战：卸载耗时App、设屏幕时限、起床后1小时不看手机、正念进食、睡前关机、无手机户外活动、回顾调整。长期建议：灰度模式、关通知、设无手机区。', '2025-09-09 10:30:00');

INSERT INTO `health_news` VALUES (26, 4, '/api/v1.0/self-health-api/file/getFile?fileName=1753534656538Snipaste_2025-04-21_16-57-23.png', '午休的正确姿势：午睡多久最科学？', '<p><strong>午睡不是越久越好。</strong></p><p>研究发现，10-20分钟的"强力小睡"（Power Nap）可以快速恢复警觉性和认知能力；而超过30分钟的午睡容易进入深度睡眠，醒来后会出现"睡眠惯性"（Sleep Inertia），反而感到昏昏沉沉。</p><p><img src=\"/api/v1.0/self-health-api/file/getFile?fileName=1753534646517Snipaste_2025-04-21_16-57-23.png\" alt=\"午睡时长对照表\" style=\"width: 90%;\"/></p><p><strong>不同午睡时长的效果：</strong></p><ul><li><strong>10-20分钟：</strong>⭐⭐⭐⭐⭐ 快速充电，无睡眠惯性，最适合上班族</li><li><strong>20-30分钟：</strong>⭐⭐⭐⭐ 提升创造力和记忆力，可能有轻微困倦感</li><li><strong>30-60分钟：</strong>⭐⭐⭐ 肌肉记忆巩固，但明显睡眠惯性，需缓冲时间</li><li><strong>90分钟：</strong>⭐⭐ 完整睡眠周期（含REM梦境期），适合严重睡眠不足时补觉</li></ul><p><strong>最佳午睡姿势：</strong></p><ol><li>使用U型枕支撑颈部，避免落枕</li><li>半躺或趴在折叠床上优于直接趴桌（保护颈椎和眼球）</li><li>盖一条薄毯子防止着凉</li><li>设定闹钟，控制在20分钟左右</li></ol>', '午睡时长指南：10-20分钟最佳（快速充电无惯性）、20-30分钟提升创造力、30-60分钟有睡眠惯性、90分钟完整周期。最佳姿势：U型枕、半躺优于趴桌、盖薄毯、定闹钟。', '2025-09-10 14:50:00');

INSERT INTO `health_news` VALUES (27, 5, '/api/v1.0/self-health-api/file/getFile?fileName=1754392870060cover4.png', '体检报告解读指南：常见指标异常意味着什么', '<p><strong>拿到体检报告一脸懵？这篇帮你读懂关键指标。</strong></p><p>每年体检是健康管理的重要环节，但面对密密麻麻的数据和上下箭头，很多人不知道哪些需要重视。以下是常见异常指标的解读：</p><p><img src=\"/api/v1.0/self-health-api/file/getFile?fileName=1753534646517Snipaste_2025-04-21_16-57-23.png\" alt=\"体检指标解读\" style=\"width: 100%;\"/></p><p><strong>🔴 需要高度重视的指标：</strong></p><ul><li><strong>空腹血糖 ≥ 7.0 mmol/L：</strong>可能提示糖尿病，建议内分泌科复查</li><li><strong>血压持续 ≥ 140/90 mmHg：</strong>高血压诊断标准，需生活方式干预或药物治疗</li><li><strong>LDL-C（低密度脂蛋白）偏高：</strong>"坏胆固醇"，是动脉粥样硬化的主要危险因素</li><li><strong>甲状腺结节 > 1cm 或有钙化：</strong>建议进一步超声评估</li></ul><p><strong>🟡 需要关注但不紧急的指标：</strong></p><ul><li><strong>尿酸略高：</strong>痛风风险因素，需控制嘌呤摄入（少吃内脏、海鲜、啤酒）</li><li><strong>轻度脂肪肝：</strong>通过减重和戒酒大多可逆转</li><li><strong>胆固醇边缘升高：</strong>先尝试饮食控制和运动3个月后复查</li></ul><p><strong>🟢 常见良性波动：</strong></p><ul><li>体检前熬夜可能导致转氨酶暂时升高</li><li>饮水过少可能使尿比重偏高</li><li>女性生理期可能影响尿常规结果</li></ul>', '体检报告解读：重点关注空腹血糖≥7.0、血压≥140/90、LDL-C偏高、甲状腺结节>1cm；关注尿酸高、轻度脂肪肝、胆固醇边缘升高；注意熬夜/饮水/生理期造成的良性波动。', '2025-09-11 09:00:00');

INSERT INTO `health_news` VALUES (28, 1, '/api/v1.0/self-health-api/file/getFile?fileName=1754314012947Snipaste_2025-04-21_16-56-22.png', '跑步膝的预防与康复：跑者必读的膝盖保护指南', '<p><strong>热爱跑步，更要爱护你的膝盖。</strong></p><p>跑步膝（髌股疼痛综合征）是最常见的跑步损伤之一，约占所有跑步相关损伤的20%-30%。了解预防和康复知识，让你跑得更远更久。</p><p><img src=\"/api/v1.0/self-health-api/file/getFile?fileName=1753534646517Snipaste_2025-04-21_16-57-23.png\" alt=\"膝关节解剖\" style=\"width: 85%;\"/></p><p><strong>🏥 跑步膝的典型症状：</strong></p><ul><li>膝盖前方或髌骨周围隐隐作痛</li><li>下楼梯、蹲起时疼痛加重</li><li>长时间屈膝坐姿后站起困难</li></ul><p><strong>🛡️ 预防策略（跑前必做）：</strong></p><ol><li><strong>强化臀部肌群：</strong>臀桥、蚌式开合——臀部无力是跑步膝的首要原因</li><li><strong>拉伸髂胫束：</strong>大腿外侧紧张会拉扯髌骨轨迹</li><li><strong>加强股四头内侧头：</strong>靠墙静蹲（膝盖不超过脚尖）</li><li><strong>选择合适的跑鞋：</strong>根据足型（内翻/外翻/正常）选择对应支撑类型的鞋</li><li><strong>遵循10%原则：</strong>每周跑量增幅不超过10%</li></ol><p><strong>💪 康复训练（出现症状后）：</strong></p><ul><li>RICE原则：Rest休息 + Ice冰敷 + Compression加压 + Elevation抬高</li><li>泡沫轴滚压大腿外侧和前侧</li><li>直腿抬高练习（仰卧位）</li><li>症状消失后逐步恢复跑量，从快走开始过渡</li></ul>', '跑步膝预防：强化臀部肌群、拉伸髂胫束、加强股四头内侧、选合适跑鞋、遵循10%增量原则。康复：RICE原则、泡沫轴滚压、直腿抬高、逐步恢复跑量。', '2025-09-12 16:00:00');

INSERT INTO `health_news` VALUES (29, 2, '/api/v1.0/self-health-api/file/getFile?fileName=1754314121023Snipaste_2025-04-21_16-58-10.png', '超级食物Top10：营养密度最高的食材排行榜','<p><strong>"超级食物"并非营销噱头，而是指营养密度极高的天然食材。</strong></p><p>以下10种食物在微量营养素、抗氧化物质或特殊生物活性成分方面表现卓越，值得加入你的日常饮食：</p><p><img src=\"/api/v1.0/self-health-api/file/getFile?fileName=1753534646517Snipaste_2025-04-21_16-57-23.png\" alt=\"超级食物\" style=\"width: 100%;\"/></p><p><strong>🏆 Top 10 超级食物：</strong></p><ol><li><strong>三文鱼：</strong>富含Omega-3脂肪酸EPA/DHA，护心护脑</li><li><strong>蓝莓：</strong>花青素含量极高，抗氧化之王</li><li><strong>西兰花：</strong>十字花科蔬菜代表，含萝卜硫素抗癌成分</li><li><strong>核桃：</strong>植物性Omega-3和维生素E的良好来源</li><li><strong>菠菜：</strong>叶酸、铁、镁、维生素K的宝库</li><li><strong>希腊酸奶：</strong>高蛋白+益生菌双重优势</li><li><strong>燕麦：</strong>β-葡聚糖膳食纤维，稳定血糖降胆固醇</li><li><strong>番茄：</strong>番茄红素（熟吃吸收更好），前列腺健康之友</li><li><strong>黑巧克力（85%以上）：</strong>黄酮类化合物，保护血管内皮</li><li><strong>绿茶：</strong>EGCG儿茶素，代谢助推器和抗癌明星</li></ol><p><strong>食用建议：</strong>多样化搭配才是王道，不要只盯着某一种"超级食物"狂吃。均衡饮食 > 单一超级食物。</p>', '超级食物Top10：三文鱼(Omega-3)、蓝莓(花青素)、西兰花(萝卜硫素)、核桃(植物Omega-3)、菠菜(叶酸铁镁)、希腊酸奶(蛋白益生菌)、燕麦(β-葡聚糖)、番茄(番茄红素)、黑巧克力(黄酮)、绿茶(EGCG)。', '2025-09-13 11:30:00');

INSERT INTO `health_news` VALUES (30, 3, '/api/v1.0/self-health-api/file/getFile?fileName=1754314146011Snipaste_2025-04-21_16-58-30.png', '季节性情绪障碍(SAD)：秋冬季节情绪低落的应对之道', '<p><strong>入秋后总觉得心情低落、嗜睡、食欲改变？你可能遇到了SAD。</strong></p><p>季节性情绪障碍（Seasonal Affective Disorder）是一种与季节变化相关的抑郁类型，通常在秋冬季发作、春夏季缓解。主要原因是日照时间缩短导致褪黑素分泌失调和血清素下降。</p><p><img src=\"/api/v1.0/self-health-api/file/getFile?fileName=1753534646517Snipaste_2025-04-21_16-57-23.png\" alt=\"SAD季节性情绪障碍\" style=\"width: 80%;\"/></p><p><strong>SAD 的典型症状：</strong></p><ul><li>持续的情绪低落或空虚感</li><li>对平时喜欢的活动失去兴趣</li><li>嗜睡（每天睡眠超过10小时仍感疲惫）</li><li>食欲增加，特别渴望碳水化合物和甜食</li><li>体重明显增加</li><li>注意力集中困难</li><li>社交退缩</li></ul><p><strong>☀️ 科学应对方法：</strong></p><ol><li><strong>光疗（Light Therapy）：</strong>每天早晨使用10000lux光照灯照射30分钟，是SAD的一线治疗手段</li><li><strong>增加户外活动：</strong>尽量在中午阳光最强时段外出散步15-30分钟</li><li><strong>维生素D补充：</strong>秋季开始每日补充1000-2000IU维生素D3</li><li><strong>规律运动：</strong>有氧运动促进内啡肽和血清素分泌</li><li><strong>认知行为疗法(CBT)：</strong>识别和改变消极思维模式</li><li><strong>保持社交连接：</strong>不要因为情绪低落而孤立自己</li></ol><p><strong>⚠️ 何时寻求专业帮助：</strong>如果症状持续超过2周且严重影响日常生活，请及时就医咨询精神科医生。</p>', '季节性情绪障碍SAD应对：光疗(10000lux晨照30min)、中午户外活动、补充维D3、规律运动、CBT认知疗法、保持社交。症状超2严重影响生活时就医。', '2025-09-14 15:45:00');

INSERT INTO `health_news` VALUES (31, 5, '/api/v1.0/self-health-api/file/getFile?fileName=1754392933714cover5.png', '喝水也是门学问：科学饮水时间表与健康饮水习惯', '<p><strong>你真的会喝水吗？</strong></p><p>人体约60%由水构成，水分参与几乎所有的生理代谢过程。然而，大多数人的饮水习惯并不科学。正确的饮水方式不仅能维持水盐平衡，还能提升新陈代谢、改善皮肤状态、预防结石形成。</p><p><img src=\"/api/v1.0/self-health-api/file/getFile?fileName=1753534646517Snipaste_2025-04-21_16-57-23.png\" alt=\"科学饮水时间表\" style=\"width: 100%;\"/></p><p><strong>💧 最佳饮水时间表（参考）：</strong></p><ul><li><strong>7:00 起床后一杯温水（200ml）：</strong>唤醒肠胃，补充夜间流失的水分</li><li><strong>9:00 工作前一杯水：</strong>提升大脑认知功能</li><li><strong>11:30 午餐前半小时一杯水：</strong>控制食欲，避免暴饮暴食</li><li><strong>14:00 下午茶时间补水：</strong>替代含糖饮料，提振精神</li><li><strong>17:30 晚餐前一杯水：</strong>同样有助于控制食量</li><li><strong>20:00 睡前1-2小时少量补水：</strong>避免夜起频繁，但也不宜完全断水</li></ul><p><strong>科学饮水的5个原则：</strong></p><ol><li>少量多次，每次150-200ml，不要一次性牛饮500ml+</li><li>首选白开水或淡茶，避免含糖饮料和果汁</li><li>尿液颜色是最好的指标：淡黄色=水量合适，深黄色=需要补水</li><li>运动中每15-20分钟补充100-150ml水</li><li>发烧、腹泻等特殊情况需额外增加补水量</li></ol><p><strong>❌ 常见错误：</strong>口渴才喝水（此时已轻度脱水）、用饮料代替水、饭后立即大量饮水稀释胃液。</p>', '科学饮水时间表：起床200ml唤醒肠胃、工作前提升认知、午餐前控食欲、下午茶替含糖饮料、晚餐前控食量、睡前少量补。原则：少量多次、白开水为主、看尿液颜色、运动中定时补。', '2025-09-15 08:30:00');

INSERT INTO `health_news` VALUES (32, 4, '/api/v1.0/self-health-api/file/getFile?fileName=175439277386314.jpg', '打呼噜≠睡得香！睡眠呼吸暂停综合征的识别与治疗', '<p><strong>"打呼噜声音越大，说明睡得越香"——这是一个危险的误解。</strong></p><p>严重的打呼噜可能是阻塞性睡眠呼吸暂停综合征(OSA)的表现。OSA患者在睡眠中反复出现上气道塌陷导致呼吸暂停，每次暂停可持续数十秒，整晚可能发生数百次！这会造成夜间反复缺氧和微觉醒，严重影响睡眠质量和心血管健康。</p><p><img src=\"/api/v1.0/self-health-api/file/getFile?fileName=1753534646517Snipaste_2025-04-21_16-57-23.png\" alt=\"睡眠呼吸暂停\" style=\"width: 90%;\"/></p><p><strong>⚠️ OSA的危险信号（STOP-Bang问卷简化版）：</strong></p><ul><li><strong>S（Snoring）打鼾：</strong>是否大声打鼾？（被室友/伴侣抱怨过吗？）</li><li><strong>T（Tired）疲劳：</strong>白天是否经常感到疲惫或嗜睡？</li><li><strong>O（Observed）目击：</strong>是否有人观察到你睡觉时呼吸停止？</li><li><strong>P（Pressure）血压：</strong>是否患有高血压？</li><li><strong>BMI ≥ 28？</strong>肥胖是OSA的重要危险因素</li><li><strong>A（Age）年龄 &gt; 50？</strong></li><li><strong>N（Neck）颈围：</strong>男性&gt;43cm / 女性&gt;38cm？</li><li><strong>G（Gender）性别：</strong>男性风险高于女性</li></ul><p><strong>📋 如果≥3项回答"是"，建议进行睡眠监测：</strong></p><ol><li>医院睡眠科做多导睡眠监测（PSG）——金标准</li><li>或使用家用便携式睡眠监测设备初步筛查</li></ol><p><strong>💊 OSA的治疗选项：</strong></p><ul><li><strong>轻度：</strong>减重、侧卧睡眠、避免酒精和镇静剂</li><li><strong>中重度：</strong>CPAP持续正压通气治疗（一线治疗方案）</li><li><strong>特定病例：</strong>口腔矫治器或手术治疗</li></ul><p> untreated OSA会使高血压、心律失常、中风、糖尿病风险增加数倍。如果你或家人有上述信号，请不要忽视！</p>', '睡眠呼吸暂停OSA识别：STOP-Bang问卷（打鼾/疲劳/呼吸停止/高血压/BMI/年龄/颈围/性别≥3项阳性需筛查）。治疗：轻度减重+侧卧+忌酒，中重度CPAP通气，特定病例口腔矫治器或手术。未治疗OSA大幅增加心脑血管风险。', '2025-09-16 13:20:00');


-- ============================================================
-- 三、新增食谱数据（ID: 16~28）
-- 封面图复用已有recipe封面（11张循环）
-- type_id: 1=荤菜, 2=素菜/轻食, 3=汤品, 4=主食
-- ============================================================

INSERT INTO `recipe` VALUES (16, '清蒸鲈鱼', '/api/v1.0/self-health-api/file/getFile?fileName=1754381783662Snipaste_2025-08-05_16-14-54.png', 1, '<h1 style="text-align: start;">清蒸鲈鱼 —— 低脂高蛋白的经典做法</h1><ol><li style="text-align: start;"><strong>食材准备：</strong>鲈鱼1条（约500g）、葱丝、姜丝、红椒丝适量、蒸鱼豉油2勺、料酒1勺、盐少许、植物油1勺</li><li style="text-align: start;"><strong>处理鱼肉：</strong>鲈鱼去鳞去内脏洗净，两面各划3刀便于入味，用料酒和少许盐腌制10分钟去腥</li><li style="text-align: start;"><strong>摆盘蒸制：</strong>盘底铺上姜片葱段，放上腌好的鱼，水开后大火蒸8-10分钟（根据鱼的大小调整时间）</li><li style="text-align: start;"><strong>淋油调味：</strong>取出倒掉盘中汤汁，撒上葱姜丝和红椒丝，淋上蒸鱼豉油，最后将烧热的植物油浇在葱姜上激发出香味即可</li></ol><p><strong>营养亮点：</strong>鲈鱼富含优质蛋白质和Omega-3脂肪酸，清蒸做法最大程度保留了营养成分，脂肪含量极低，非常适合减脂期食用。每100g仅含约105千卡热量。</p>', 65, 1, 1, '2025-09-01 10:00:00');

INSERT INTO `recipe` VALUES (17, '藜麦蔬菜沙拉', '/api/v1.0/self-health-api/file/getFile?fileName=1754382097771Snipaste_2025-08-05_16-15-38.png', 2, '<h1 style="text-align: start;">藜麦蔬菜沙拉 —— 超模同款轻食</h1><ol><li style="text-align: start;"><strong>食材准备：</strong>藜麦80g、混合生菜（罗马生菜+苦菊+紫甘蓝）150g、樱桃番茄10颗、黄瓜半根、牛油果半个、鹰嘴豆50g、橄榄油2勺、柠檬汁1勺、黑胡椒和海盐适量</li><li style="text-align: start;"><strong>煮藜麦：</strong>藜麦用清水冲洗干净，按1:1.5的比例加水煮沸后转小火焖15分钟至透明，捞出放凉</li><li style="text-align: start;"><strong>处理配菜：</strong>生菜撕小块洗净沥干，番茄对半切，黄瓜切片，牛油果切丁，鹰嘴豆沥干罐装液体</li><li style="text-align: start;"><strong>调制油醋汁：</strong>橄榄油+柠檬汁+黑胡椒+海盐搅拌均匀</li><li style="text-align: start;"><strong>拌匀装盘：</strong>将所有食材放入大碗，淋入油醋汁轻轻拌匀即可享用</li></ol><p><strong>营养亮点：</strong>藜麦是唯一含有完整蛋白质的植物食材，富含全部9种人体必需氨基酸。搭配多种色彩蔬菜提供丰富的维生素和抗氧化物，一份仅约350千卡，饱腹感强。</p>', 66, 1, 1, '2025-09-02 11:30:00');

INSERT INTO `recipe` VALUES (18, '番茄牛腩煲', '/api/v1.0/self-health-api/file/getFile?fileName=1754117540498Snipaste_2025-04-21_16-57-23.png', 1, '<h1 style="text-align: start;">番茄牛腩煲 —— 酸甜开胃的家常硬菜</h1><ol><li style="text-align: start;"><strong>食材准备：</strong>牛腩500g、大番茄3个、土豆1个、胡萝卜1根、洋葱半个、姜片、八角2颗、冰糖适量、生抽2勺、老抽半勺、料酒1勺</li><li style="text-align: start;"><strong>预处理牛肉：</strong>牛腩切3cm方块，冷水下锅焯水撇去浮沫，捞出用温水冲洗干净</li><li style="text-align: start;"><strong>炒糖色：</strong>锅中少许油，小火融化冰糖至焦糖色，倒入牛腩翻炒上色</li><li style="text-align: start;"><strong>炖煮：</strong>加入姜片、八角、料酒、生抽老抽翻炒均匀，倒入足量热水没过牛肉，大火烧开转小火炖1.5小时</li><li style="text-align: start;"><strong>加配菜：</strong>番茄去皮切块、土豆胡萝卜滚刀块，加入锅中继续炖30分钟至软烂入味，最后加盐调味即可</li></ol><p><strong>营养亮点：</strong>牛肉提供优质蛋白和铁元素，番茄富含番茄红素（熟吃吸收率更高），土豆提供缓释碳水。酸甜口感老少皆宜，是一道营养均衡的家常菜。</p>', 67, 1, 1, '2025-09-03 14:00:00');

INSERT INTO `recipe` VALUES (19, '杂粮红薯粥', '/api/v1.0/self-health-api/file/getFile?fileName=1754381960986Snipaste_2025-08-05_16-15-18.png', 4, '<h1 style="text-align: start;">杂粮红薯粥 —— 暖胃养生的早餐首选</h1><ol><li style="text-align: start;"><strong>食材准备：</strong>大米30g、小米20g、燕麦米20g、红豆15g、红薯1个（中等大小）、红枣5颗、枸杞少许</li><li style="text-align: start;"><strong>浸泡：</strong>红豆和大米提前浸泡2小时以上（可前一晚泡好）</li><li style="text-align: start;"><strong>熬煮：</strong>将所有米豆放入锅中，加水约1.2L，大火烧开后转小火慢熬40分钟，期间不时搅拌防止粘锅</li><li style="text-align: start;"><strong>加红薯：</strong>红薯去皮切块，加入粥中继续煮15分钟至软糯</li><li style="text-align: start;"><strong>最后调味：</strong>加入红枣和枸杞再煮5分钟即可，喜欢甜的可加少量红糖</li></ol><p><strong>营养亮点：</strong>多种粗粮组合提供丰富的B族维生素和膳食纤维，红薯含有β-胡萝卜素和果胶。升糖指数远低于白粥，饱腹时间长，是理想的健康早餐选择。</p>', 68, 1, 1, '2025-09-04 08:00:00');

INSERT INTO `recipe` VALUES (20, '蒜蓉西兰花', '/api/v1.0/self-health-api/file/getFile?fileName=1754385437697Snipaste_2025-08-05_16-15-33.png', 2, '<h1 style="text-align: start;">蒜蓉西兰花 —— 5分钟快手低卡蔬菜</h1><ol><li style="text-align: start;"><strong>食材准备：</strong>西兰花1朵（约300g）、大蒜5瓣、蚝油1勺、生抽半勺、盐少许、植物油适量</li><li style="text-align: start;"><strong>处理西兰花：</strong>切成小朵，淡盐水浸泡10分钟去除残留物，焯水1分钟后捞出过凉水保持翠绿</li><li style="text-align: start;"><strong>爆香蒜末：</strong>锅中热油，小火煸炒至蒜末金黄出香味</li><li style="text-align: start;"><strong>快速翻炒：</strong>倒入西兰花大火翻炒1分钟，加蚝油、生抽、盐调味，翻炒均匀即可出锅</li></ol><p><strong>营养亮点：</strong>西兰花是"蔬菜皇冠"，富含维生素C、维生素K、叶酸和萝卜硫素（强效抗癌成分）。每100g仅约34千卡，是减肥期间的理想蔬菜选择。</p>', 69, 1, 1, '2025-09-05 09:30:00');

INSERT INTO `recipe` VALUES (21, '冬瓜排骨汤', '/api/v1.0/self-health-api/file/getFile?fileName=1754393136282Snipaste_2025-06-01_18-02-46.png', 3, '<h1 style="text-align: start;">冬瓜排骨汤 —— 清热解暑滋补靓汤</h1><ol><li style="text-align: start;"><strong>食材准备：</strong>猪肋排400g、冬瓜500g、姜3片、葱花适量、料酒1勺、盐和白胡椒粉少许</li><li style="text-align: start;"><strong>排骨处理：</strong>排骨冷水下锅焯水，加料酒去腥，捞出冲洗干净</li><li style="text-align: start;"><strong>炖排骨：</strong>砂锅中放入排骨、姜片，加足量清水，大火烧开后撇去浮沫，转小火炖1小时</li><li style="text-align: start;"><strong>加冬瓜：</strong>冬瓜去皮去瓤切厚片，放入汤中继续煮15-20分钟至透明软烂</li><li style="text-align: start;"><strong>调味出锅：</strong>加盐和白胡椒粉调味，撒葱花即可</li></ol><p><strong>营养亮点：</strong>冬瓜利尿消肿、清热解暑，排骨提供胶原蛋白和钙质。此汤清淡不油腻，适合夏季食用，也适合需要控制盐分摄入的高血压人群。</p>', 70, 1, 1, '2025-09-06 15:00:00');

INSERT INTO `recipe` VALUES (22, '鸡胸肉生菜卷', '/api/v1.0/self-health-api/file/getFile?fileName=1754381984739Snipaste_2025-08-05_16-15-33.png', 2, '<h1 style="text-align: start;">鸡胸肉生菜卷 —— 健身党必备低脂餐</h1><ol><li style="text-align: start;"><strong>食材准备：</strong>鸡胸肉1块（约200g）、罗马生菜1颗、黄瓜半根、胡萝卜半根、紫甘蓝适量、低脂蛋黄酱或希腊酸奶酱适量</li><li style="text-align: start;"><strong>腌制鸡胸：</strong>鸡胸肉用少许盐、黑胡椒、蒜末腌制15分钟</li><li style="text-align: start;"><strong>煎鸡肉：</strong>平底锅刷薄油，中火煎鸡胸肉每面约4-5分钟至熟透，取出稍凉后撕成条状</li><li style="text-align: start;"><strong>准备配菜：</strong>黄瓜和胡萝卜切丝，紫甘蓝切丝</li><li style="text-align: start;"><strong>组装：</strong>取生菜叶铺平，依次放上鸡肉条、黄瓜丝、胡萝卜丝、紫甘蓝丝，挤上酱料，卷起来即可享用</li></ol><p><strong>营养亮点：</strong>整份约280千卡，蛋白质高达35g以上。生菜代替饼皮大幅降低了碳水摄入，同时增加了膳食纤维。是增肌减脂期的理想餐食。</p>', 71, 1, 1, '2025-09-07 12:00:00');

INSERT INTO `recipe` VALUES (23, '香菇滑鸡粥', '/api/v1.0/self-health-api/file/getFile?fileName=1754382055394Snipaste_2025-08-05_16-15-52.png', 4, '<h1 style="text-align: start;">香菇滑鸡粥 —— 广式经典养生粥品</h1><ol><li style="text-align: start;"><strong>食材准备：</strong>大米100g、鸡腿肉1个（去骨）、干香菇6朵、姜丝、葱花、胡椒粉、香油、盐、淀粉、生抽各适量</li><li style="text-align: start;"><strong>泡发香菇：</strong>干香菇用温水泡发30分钟，挤干水分后切丝</li><li style="text-align: start;"><strong>腌制鸡肉：</strong>鸡腿肉切薄片，加少许盐、生抽、淀粉抓匀腌制15分钟</li><li style="text-align: start;"><strong>熬粥底：</strong>大米淘洗干净，加1L水大火煮开后转小火熬煮至米粒开花（约30分钟）</li><li style="text-align: start;"><strong>加入配料：</strong>先放入香菇丝煮5分钟，再放入鸡肉片迅速搅散煮2分钟至变色，加姜丝、盐、胡椒粉调味，出锅前淋香油撒葱花</li></ol><p><strong>营养亮点：</strong>香菇多糖具有增强免疫力的功效，鸡肉提供易消化的优质蛋白。此粥品温润易消化，适合老人儿童及肠胃不适者食用。</p>', 72, 1, 1, '2025-09-08 07:30:00');

INSERT INTO `recipe` VALUES (24, '凉拌木耳', '/api/v1.0/self-health-api/file/getFile?fileName=1754385535019Snipaste_2025-08-05_17-18-43.png', 2, '<h1 style="text-align: start;">凉拌木耳 —— 清肠刮油的素食佳品</h1><ol><li style="text-align: start;"><strong>食材准备：</strong>干黑木耳30g（泡发后约200g）、大蒜4瓣、小米辣2个、香菜1把、生抽2勺、陈醋1勺、蚝油半勺、白糖少许、辣椒油1勺</li><li style="text-align: start;"><strong>泡发木耳：</strong>干木耳用温水泡发1小时至完全舒展，去掉根部撕成小朵</li><li style="text-align: start;"><strong>焯烫：</strong>锅中水烧开，放入木耳焯烫2分钟捞出过凉水，沥干备用</li><li style="text-align: start;"><strong>调拌汁：</strong>大蒜切末、小米辣切圈，碗中加入生抽、陈醋、蚝油、白糖、辣椒油调成拌汁</li><li style="text-align: start;"><strong>拌匀：</strong>将木耳放入大碗，倒入拌汁和蒜末辣椒，撒上香菜段拌匀即可</li></ol><p><strong>营养亮点：</strong>黑木耳被称为"肠道清道夫"，富含植物胶质和膳食纤维，有助于清理消化道。热量极低（每100g约21千卡），是控制体重期间的最佳凉菜之一。</p>', 73, 1, 1, '2025-09-09 18:00:00');

INSERT INTO `recipe` VALUES (25, '日式味噌三文鱼', '/api/v1.0/self-health-api/file/getFile?fileName=1754393248644Snipaste_2025-06-01_18-02-20.png', 1, '<h1 style="text-align: start;">日式味噌三文鱼 —— Omega-3炸弹</h1><ol><li style="text-align: start;"><strong>食材准备：</strong>三文鱼排2块（约300g）、白味噌2勺、味醂1勺、清酒1勺、蜂蜜半勺</li><li style="text-align: start;"><strong>调制味噌酱：</strong>将味噌、味醂、清酒、蜂蜜混合均匀成腌料</li><li style="text-align: start;"><strong>腌制：</strong>三文鱼排均匀涂抹味噌酱，密封冷藏腌制至少4小时（过夜最佳）</li><li style="text-align: start;"><strong>烤制：</strong>烤箱预热200°C，擦去表面多余腌料（防止烤焦），烤12-15分钟至表面微微焦黄</li><li style="text-align: start;"><strong>装盘：</strong>配米饭和味噌汤，撒少许白芝麻装饰</li></ol><p><strong>营养亮点：</strong>三文鱼是DHA和EPA的最佳来源，这两种Omega-3脂肪酸对心脏和大脑健康至关重要。味噌发酵产生有益益生菌。整份约380千卡，营养密度极高。</p>', 74, 1, 1, '2025-09-10 17:00:00');

INSERT INTO `recipe` VALUES (26, '银耳莲子羹', '/api/v1.0/self-health-api/file/getFile?fileName=1754393160129Snipaste_2025-06-01_17-43-44.png', 3, '<h1 style="text-align: start;">银耳莲子羹 —— 平民燕窝美容圣品</h1><ol><li style="text-align: start;"><strong>食材准备：</strong>干银耳15g、莲子30g、枸杞10g、冰糖适量、清水1.5L</li><li style="text-align: start;"><strong>泡发：</strong>银耳用冷水泡发2小时至完全舒展，去掉黄色根部撕成小朵；莲子去心（不去心会苦）</li><li style="text-align: start;"><strong>炖煮：</strong>砂锅中放入银耳和莲子，加清水大火烧开后转小火慢炖1小时至银耳出胶呈黏稠状</li><li style="text-align: start;"><strong>加糖调味：</strong>加入冰糖继续煮10分钟至融化，最后撒入枸杞焖2分钟即可</li></ol><p><strong>营养亮点：</strong>银耳富含天然植物胶质（银耳多糖），具有滋阴润肺、美容养颜的功效，被称为"平民燕窝"。莲子宁心安神，枸杞补肝明目。此甜品热量适中，可作为健康零食或早餐搭配。</p>', 75, 1, 1, '2025-09-11 20:00:00');

INSERT INTO `recipe` VALUES (27, '彩椒炒虾仁', '/api/v1.0/self-health-api/file/getFile?fileName=1754381783662Snipaste_2025-08-05_16-14-54.png', 1, '<h1 style="text-align: start;">彩椒炒虾仁 —— 低脂高蛋白快手菜</h1><ol><li style="text-align: start;"><strong>食材准备：</strong>鲜虾仁250g、红黄彩椒各半个、豌豆粒50g、蒜末、姜末、料酒1勺、淀粉半勺、盐和白胡椒粉适量</li><li style="text-align: start;"><strong>处理虾仁：</strong>虾仁开背去虾线，用料酒、少许盐和淀粉抓匀腌制10分钟</li><li style="text-align: start;"><strong>准备配菜：</strong>彩椒切菱形块，豌豆粒焯水备用</li><li style="text-align: start;"><strong>滑炒虾仁：</strong>锅中热油，下虾仁快速滑炒至变色盛出（约1分钟）</li><li style="text-align: start;"><strong>炒配菜：</strong>锅中留底油爆香姜蒜末，下彩椒块和豌豆粒翻炒1分钟，倒入虾仁，加盐和胡椒粉快速翻炒均匀即可出锅</li></ol><p><strong>营养亮点：</strong>虾仁是优质低脂蛋白的典范，每100g含约20g蛋白质而脂肪不到1g。彩椒维生素C含量远超橙子。整道菜色彩鲜艳、口感清爽，约220千卡。</p>', 76, 1, 1, '2025-09-12 12:30:00');

INSERT INTO `recipe` VALUES (28, '南瓜浓汤', '/api/v1.0/self-health-api/file/getFile?fileName=1754382097771Snipaste_2025-08-05_16-15-38.png', 3, '<h1 style="text-align: start;">南瓜浓汤 —— 西式健康暖汤</h1><ol><li style="text-align: start;"><strong>食材准备：</strong>贝贝南瓜1个（约400g）、洋葱半个、牛奶或植物奶200ml、黄油10g、黑胡椒和盐少许、淡奶油少许（可选）</li><li style="text-align: start;"><strong>预处理：</strong>南瓜去皮去籽切块，洋葱切丁</li><li style="text-align: start;"><strong>炒香：</strong>锅中融化黄油，下洋葱丁炒至透明柔软</li><li style="text-align: start;"><strong>煮南瓜：</strong>加入南瓜块和适量清水（没过南瓜即可），煮15-20分钟至南瓜软烂</li><li style="text-align: start;"><strong>打成泥：</strong>用手持料理棒或破壁机将汤打至顺滑细腻</li><li style="text-align: start;"><strong>调味：</strong>倒回锅中加入牛奶搅匀，加盐和黑胡椒调味，小火加热2分钟，装盘后可淋少许淡奶油装饰</li></ol><p><strong>营养亮点：</strong>南瓜富含β-胡萝卜素（体内转化为维生素A），对视力和皮肤健康有益。牛奶提供钙质。此浓汤口感醇厚绵密，热量适中（约180千卡/份），适合作为开胃汤或轻食正餐。</p>', 77, 1, 1, '2025-09-13 19:30:00');


-- ============================================================
-- 四、新增健康模型（ID: 15~18）
-- 图标复用已有health_model图标
-- ============================================================

INSERT INTO `health_model` VALUES (15, '步数', '每日行走步数是衡量日常活动量的基础指标，建议成年人每日目标8000-10000步，有助于维持心肺功能和控制体重', '/api/v1.0/self-health-api/file/getFile?fileName=1753670454370weight.png', '步', 'STEPS', '8000,10000', NULL, 0, '2025-09-01 10:00:00');
INSERT INTO `health_model` VALUES (16, '饮水量', '每日饮水量直接影响新陈代谢效率和身体排毒功能，成人建议每日饮水1500-2000ml，运动后需额外补充', '/api/v1.0/self-health-api/file/getFile?fileName=1754393779064xt.png', '毫升(ml)', 'WATER', '1500,2000', NULL, 0, '2025-09-02 10:00:00');
INSERT INTO `health_model` VALUES (17, '腰围', '腰围是反映腹部脂肪堆积程度的简易指标，男性警戒线≥90cm，女性≥85cm，超标提示中心性肥胖风险', '/api/v1.0/self-health-api/file/getFile?fileName=1753760115590BMI.png', '厘米(cm)', 'WC', '70,85', NULL, 0, '2025-09-03 10:00:00');
INSERT INTO `health_model` VALUES (18, '运动时长', '每日/每周的运动总时长，世界卫生组织建议每周至少150分钟中等强度有氧运动', '/api/v1.0/self-health-api/file/getFile?fileName=1753597325751rate.png', '分钟(min)', 'EX', '30,60', NULL, 0, '2025-09-04 10:00:00');


-- ============================================================
-- ============================================================
-- 五、新增健康记录（ID: 31~80）—— 为多个用户生成历史数据
-- ============================================================

INSERT INTO `health_record` VALUES (31, 64, 4, 52.3, '2025-09-01 08:00:00');
INSERT INTO `health_record` VALUES (32, 64, 5, 8.2, '2025-09-01 08:00:00');
INSERT INTO `health_record` VALUES (33, 64, 6, 19.8, '2025-09-01 08:00:00');
INSERT INTO `health_record` VALUES (34, 64, 2, 72, '2025-09-01 08:00:00');
INSERT INTO `health_record` VALUES (35, 64, 4, 52.1, '2025-09-05 08:30:00');
INSERT INTO `health_record` VALUES (36, 64, 5, 7.5, '2025-09-05 08:30:00');
INSERT INTO `health_record` VALUES (37, 64, 6, 19.6, '2025-09-05 08:30:00');
INSERT INTO `health_record` VALUES (38, 64, 2, 75, '2025-09-05 08:30:00');
INSERT INTO `health_record` VALUES (39, 64, 4, 51.8, '2025-09-10 09:00:00');
INSERT INTO `health_record` VALUES (40, 64, 5, 8.0, '2025-09-10 09:00:00');
INSERT INTO `health_record` VALUES (41, 64, 6, 19.5, '2025-09-10 09:00:00');
INSERT INTO `health_record` VALUES (42, 64, 9, 68, '2025-09-10 09:00:00');
INSERT INTO `health_record` VALUES (43, 64, 10, 118, '2025-09-10 09:00:00');
INSERT INTO `health_record` VALUES (44, 64, 11, 5.1, '2025-09-10 09:00:00');

INSERT INTO `health_record` VALUES (45, 65, 4, 78.5, '2025-09-02 07:30:00');
INSERT INTO `health_record` VALUES (46, 65, 5, 7.0, '2025-09-02 07:30:00');
INSERT INTO `health_record` VALUES (47, 65, 6, 25.2, '2025-09-02 07:30:00');
INSERT INTO `health_record` VALUES (48, 65, 2, 68, '2025-09-02 07:30:00');
INSERT INTO `health_record` VALUES (49, 65, 9, 82, '2025-09-02 07:30:00');
INSERT INTO `health_record` VALUES (50, 65, 10, 138, '2025-09-02 07:30:00');
INSERT INTO `health_record` VALUES (51, 65, 4, 78.0, '2025-09-08 07:45:00');
INSERT INTO `health_record` VALUES (52, 65, 5, 6.5, '2025-09-08 07:45:00');
INSERT INTO `health_record` VALUES (53, 65, 6, 24.8, '2025-09-08 07:45:00');
INSERT INTO `health_record` VALUES (54, 65, 4, 77.5, '2025-09-14 08:00:00');
INSERT INTO `health_record` VALUES (55, 65, 6, 24.5, '2025-09-14 08:00:00');

INSERT INTO `health_record` VALUES (56, 66, 4, 45.2, '2025-09-03 09:00:00');
INSERT INTO `health_record` VALUES (57, 66, 5, 8.5, '2025-09-03 09:00:00');
INSERT INTO `health_record` VALUES (58, 66, 6, 18.2, '2025-09-03 09:00:00');
INSERT INTO `health_record` VALUES (59, 66, 2, 78, '2025-09-03 09:00:00');
INSERT INTO `health_record` VALUES (60, 66, 4, 44.8, '2025-09-09 09:15:00');
INSERT INTO `health_record` VALUES (61, 66, 5, 9.0, '2025-09-09 09:15:00');
INSERT INTO `health_record` VALUES (62, 66, 6, 18.0, '2025-09-09 09:15:00');
INSERT INTO `health_record` VALUES (63, 66, 11, 4.8, '2025-09-09 09:15:00');
INSERT INTO `health_record` VALUES (64, 66, 12, 98, '2025-09-09 09:15:00');

INSERT INTO `health_record` VALUES (65, 67, 4, 72.0, '2025-09-04 08:00:00');
INSERT INTO `health_record` VALUES (66, 67, 5, 7.2, '2025-09-04 08:00:00');
INSERT INTO `health_record` VALUES (67, 67, 6, 22.8, '2025-09-04 08:00:00');
INSERT INTO `health_record` VALUES (68, 67, 2, 65, '2025-09-04 08:00:00');
INSERT INTO `health_record` VALUES (69, 67, 13, 18.5, '2025-09-04 08:00:00');
INSERT INTO `health_record` VALUES (70, 67, 4, 71.5, '2025-09-11 08:10:00');
INSERT INTO `health_record` VALUES (71, 67, 6, 22.5, '2025-09-11 08:10:00');
INSERT INTO `health_record` VALUES (72, 67, 13, 18.0, '2025-09-11 08:10:00');

INSERT INTO `health_record` VALUES (73, 68, 4, 48.0, '2025-09-05 10:00:00');
INSERT INTO `health_record` VALUES (74, 68, 5, 9.0, '2025-09-05 10:00:00');
INSERT INTO `health_record` VALUES (75, 68, 6, 17.5, '2025-09-05 10:00:00');
INSERT INTO `health_record` VALUES (76, 68, 2, 82, '2025-09-05 10:00:00');
INSERT INTO `health_record` VALUES (77, 68, 4, 47.5, '2025-09-12 10:15:00');
INSERT INTO `health_record` VALUES (78, 68, 5, 8.8, '2025-09-12 10:15:00');
INSERT INTO `health_record` VALUES (79, 68, 6, 17.3, '2025-09-12 10:15:00');

INSERT INTO `health_record` VALUES (80, 62, 4, 59.8, '2025-09-10 08:30:00');


-- ============================================================
-- 六、新增饮食记录（ID: 13~32）
-- ============================================================

INSERT INTO `diet_history` VALUES (13, 64, 17, '午餐', 320, '2025-09-02 12:15:00');
INSERT INTO `diet_history` VALUES (14, 64, 20, '晚餐配菜', 150, '2025-09-02 18:30:00');
INSERT INTO `diet_history` VALUES (15, 64, 19, '早餐主食', 250, '2025-09-03 07:45:00');
INSERT INTO `diet_history` VALUES (16, 64, 16, '午餐主菜', 180, '2025-09-05 12:00:00');
INSERT INTO `diet_history` VALUES (17, 64, 24, '晚餐凉菜', 120, '2025-09-05 19:00:00');

INSERT INTO `diet_history` VALUES (18, 65, 18, '午餐', 400, '2025-09-03 12:30:00');
INSERT INTO `diet_history` VALUES (19, 65, 2, '晚餐', 200, '2025-09-03 19:00:00');
INSERT INTO `diet_history` VALUES (20, 65, 27, '午餐', 250, '2025-09-09 12:15:00');
INSERT INTO `diet_history` VALUES (21, 65, 21, '晚餐汤品', 300, '2025-09-09 18:45:00');

INSERT INTO `diet_history` VALUES (22, 66, 17, '午餐', 280, '2025-09-04 12:00:00');
INSERT INTO `diet_history` VALUES (23, 66, 22, '午餐', 350, '2025-09-08 12:30:00');
INSERT INTO `diet_history` VALUES (24, 66, 26, '下午茶甜品', 200, '2025-09-08 15:30:00');

INSERT INTO `diet_history` VALUES (25, 67, 25, '午餐', 220, '2025-09-05 12:00:00');
INSERT INTO `diet_history` VALUES (26, 67, 18, '晚餐', 450, '2025-09-06 19:00:00');
INSERT INTO `diet_history` VALUES (27, 67, 27, '午餐', 200, '2025-09-12 12:00:00');

INSERT INTO `diet_history` VALUES (28, 62, 16, '午餐', 200, '2025-09-08 12:00:00');
INSERT INTO `diet_history` VALUES (29, 62, 17, '午餐', 300, '2025-09-12 12:30:00');
INSERT INTO `diet_history` VALUES (30, 62, 20, '晚餐', 160, '2025-09-14 18:45:00');

INSERT INTO `diet_history` VALUES (31, 61, 6, '晚餐', 180, '2025-09-06 19:00:00');
INSERT INTO `diet_history` VALUES (32, 61, 23, '早餐', 300, '2025-09-10 07:30:00');


-- ============================================================
-- 七、新增评论数据（ID: 15~30）
-- ============================================================

INSERT INTO `evaluations` VALUES (15, NULL, 64, NULL, 'HEALTH-NEWS', 17, 'HIIT确实很有效！我已经坚持了两个月，体重掉了5公斤，关键是时间短，很适合我们这种上班族的节奏。不过新手一定要注意循序渐进，一开始不要太猛，否则第二天浑身酸痛影响工作。', '2025-09-02 10:30:00');
INSERT INTO `evaluations` VALUES (16, NULL, 65, NULL, 'HEALTH-NEWS', 17, '请问HIIT适合有轻微膝盖问题的人吗？之前试过跳绳感觉膝盖不太舒服，想换成HIIT又怕伤到关节。', '2025-09-02 14:20:00');
INSERT INTO `evaluations` VALUES (17, 16, 66, 65, 'HEALTH-NEWS', 17, '膝盖有问题的话建议先做低冲击版本的HIIT，比如用椭圆机代替跳跃动作，或者做登山者动作时放慢速度。另外一定要做好热身和拉伸！', '2025-09-02 16:45:00');
INSERT INTO `evaluations` VALUES (18, NULL, 62, NULL, 'HEALTH-NEWS', 18, '控糖这个话题太重要了！以前不知道奶茶里居然有那么多糖，自从开始看食品标签后才发现，连所谓的"健康果汁"里糖分都很高。现在基本只喝白水和无糖茶了。', '2025-09-03 09:15:00');
INSERT INTO `evaluations` VALUES (19, NULL, 61, NULL, 'HEALTH-NEWS', 19, '作为程序员，职场焦虑真的是太真实了😭。4-7-8呼吸法我试了一下，确实有用！特别是开会前或者代码review的时候，做几轮下来心跳都平稳了很多。', '2025-09-04 11:30:00');
INSERT INTO `evaluations` VALUES (20, 19, 63, 61, 'HEALTH-NEWS', 19, '同感！我还配合了一个小技巧：把工位上的便签纸换成写有积极话语的，看到就会不自觉微笑一下。加上呼吸法，效果加倍！', '2025-09-04 15:00:00');
INSERT INTO `evaluations` VALUES (21, NULL, 67, NULL, 'HEALTH-NEWS', 20, '深度睡眠这篇文章太实用了！我一直以为自己睡够了8小时就够了，原来质量更重要。按照文章里的方法调整了一周，现在早上起来精神好多了，不再昏昏沉沉的。', '2025-09-05 08:20:00');
INSERT INTO `evaluations` VALUES (22, NULL, 64, NULL, 'HEALTH-NEWS', 21, '办公室微运动已收藏！每天都在电脑前坐着超过10小时，颈椎和腰椎都不好了。今天就开始实践，每个小时起来动一动！', '2025-09-06 09:45:00');
INSERT INTO `evaluations` VALUES (23, NULL, 68, NULL, 'HEALTH-NEWS', 22, '免疫力这块说得太全面了。补充一点个人经验：除了文中提到的，晒太阳也很重要！维生素D对免疫系统的影响被很多人低估了。', '2025-09-07 14:00:00');
INSERT INTO `evaluations` VALUES (24, NULL, 69, NULL, 'HEALTH-NEWS', 23, '地中海饮食我也在尝试！已经坚持一个月了，最大的感受是皮肤变好了，而且下午不再犯困。橄榄油拌一切真的好吃又健康～', '2025-09-08 10:30:00');

INSERT INTO `evaluations` VALUES (25, NULL, 66, NULL, 'RECIPE', 16, '这道清蒸鲈鱼太棒了！第一次做就成功了，肉质鲜嫩，而且做法真的很简单。家里老人也说比饭店做的还好吃，以后这就是我家餐桌常客了！', '2025-09-02 19:00:00');
INSERT INTO `evaluations` VALUES (26, NULL, 62, NULL, 'RECIPE', 17, '藜麦沙拉颜值也太高了吧！拍照发朋友圈收获了一大波点赞😄 口感丰富，藜麦那种Q弹的口感配上脆爽的蔬菜，绝了！', '2025-09-03 13:20:00');
INSERT INTO `evaluations` VALUES (27, NULL, 65, NULL, 'RECIPE', 18, '番茄牛腩煲炖了两个小时，满屋子都是香味！牛肉软烂入味，汤汁浓郁，拌饭简直是一绝。就是下次要少放点盐，稍微偏咸了哈哈', '2025-09-04 19:30:00');
INSERT INTO `evaluations` VALUES (28, NULL, 64, NULL, 'RECIPE', 22, '鸡胸肉生菜卷已经成为我的减脂午餐标配了！方便携带到公司，同事都问我要食谱。希腊酸奶酱真的比普通沙拉酱好吃太多了！', '2025-09-08 12:45:00');
INSERT INTO `evaluations` VALUES (29, NULL, 70, NULL, 'RECIPE', 25, '三文鱼这样做太好吃了！味噌的咸鲜味完美渗透进鱼肉里，外层微微焦香，内里鲜嫩多汁。配上一碗糙米饭，幸福感满满～', '2025-09-11 18:20:00');
INSERT INTO `evaluations` VALUES (30, NULL, 71, NULL, 'RECIPE', 26, '银耳莲子羹秋天喝太治愈了！炖出来的胶质满满，口感顺滑。我加了点百合进去，润肺效果更好。强烈推荐给经常熬夜的姐妹们！', '2025-09-12 21:00:00');


-- ============================================================
-- 八、新增评论点赞数据（ID: 8~25）
-- ============================================================

INSERT INTO `evaluations_upvote` VALUES (8, 62, 15);
INSERT INTO `evaluations_upvote` VALUES (9, 61, 15);
INSERT INTO `evaluations_upvote` VALUES (10, 63, 15);
INSERT INTO `evaluations_upvote` VALUES (11, 66, 17);
INSERT INTO `evaluations_upvote` VALUES (12, 62, 17);
INSERT INTO `evaluations_upvote` VALUES (13, 64, 18);
INSERT INTO `evaluations_upvote` VALUES (14, 65, 18);
INSERT INTO `evaluations_upvote` VALUES (15, 66, 18);
INSERT INTO `evaluations_upvote` VALUES (16, 67, 18);
INSERT INTO `evaluations_upvote` VALUES (17, 62, 19);
INSERT INTO `evaluations_upvote` VALUES (18, 64, 19);
INSERT INTO `evaluations_upvote` VALUES (19, 61, 19);
INSERT INTO `evaluations_upvote` VALUES (20, 63, 20);
INSERT INTO `evaluations_upvote` VALUES (21, 62, 21);
INSERT INTO `evaluations_upvote` VALUES (22, 65, 21);
INSERT INTO `evaluations_upvote` VALUES (23, 67, 21);
INSERT INTO `evaluations_upvote` VALUES (24, 62, 24);
INSERT INTO `evaluations_upvote` VALUES (25, 64, 25);


-- ============================================================
-- 九、新增流量指标数据（ID: 3318~3597）
-- 覆盖新增的健康资讯(ID:17-32)、食谱(ID:16-28)
-- 模拟多用户(61-78)的真实浏览行为
-- type: 1=展现, 2=浏览, 3=点赞, 4=收藏, 5=停留
-- ============================================================

-- === 用户64 (王小丽) 的行为数据 ===
INSERT INTO `flow_index` VALUES (3318, 1, 'HEALTH_NEWS', 17, NULL, 64, '2025-09-02 09:00:00');
INSERT INTO `flow_index` VALUES (3319, 2, 'HEALTH_NEWS', 17, NULL, 64, '2025-09-02 09:01:15');
INSERT INTO `flow_index` VALUES (3320, 5, 'HEALTH_NEWS', 17, 245000, 64, '2025-09-02 09:05:20');
INSERT INTO `flow_index` VALUES (3321, 3, 'HEALTH_NEWS', 17, NULL, 64, '2025-09-02 09:06:00');
INSERT INTO `flow_index` VALUES (3322, 1, 'RECIPE', 16, NULL, 64, '2025-09-02 10:00:00');
INSERT INTO `flow_index` VALUES (3323, 2, 'RECIPE', 16, NULL, 64, '2025-09-02 10:01:30');
INSERT INTO `flow_index` VALUES (3324, 5, 'RECIPE', 16, 180000, 64, '2025-09-02 10:04:30');
INSERT INTO `flow_index` VALUES (3325, 4, 'RECIPE', 16, NULL, 64, '2025-09-02 10:05:00');
INSERT INTO `flow_index` VALUES (3326, 1, 'HEALTH_NEWS', 18, NULL, 64, '2025-09-03 09:30:00');
INSERT INTO `flow_index` VALUES (3327, 2, 'HEALTH_NEWS', 18, NULL, 64, '2025-09-03 09:31:45');
INSERT INTO `flow_index` VALUES (3328, 5, 'HEALTH_NEWS', 18, 195000, 64, '2025-09-03 09:35:00');
INSERT INTO `flow_index` VALUES (3329, 1, 'RECIPE', 20, NULL, 64, '2025-09-05 14:00:00');
INSERT INTO `flow_index` VALUES (3330, 2, 'RECIPE', 20, NULL, 64, '2025-09-05 14:01:20');
INSERT INTO `flow_index` VALUES (3331, 5, 'RECIPE', 20, 120000, 64, '2025-09-05 14:03:20');
INSERT INTO `flow_index` VALUES (3332, 1, 'RECIPE', 24, NULL, 64, '2025-09-05 19:00:00');
INSERT INTO `flow_index` VALUES (3333, 2, 'RECIPE', 24, NULL, 64, '2025-09-05 19:01:10');
INSERT INTO `flow_index` VALUES (3334, 5, 'RECIPE', 24, 95000, 64, '2025-09-05 19:02:45');
INSERT INTO `flow_index` VALUES (3335, 1, 'HEALTH_NEWS', 21, NULL, 64, '2025-09-06 09:00:00');
INSERT INTO `flow_index` VALUES (3336, 2, 'HEALTH_NEWS', 21, NULL, 64, '2025-09-06 09:01:30');
INSERT INTO `flow_index` VALUES (3337, 5, 'HEALTH_NEWS', 21, 310000, 64, '2025-09-06 09:06:40');
INSERT INTO `flow_index` VALUES (3338, 4, 'HEALTH_NEWS', 21, NULL, 64, '2025-09-06 09:07:00');
INSERT INTO `flow_index` VALUES (3339, 1, 'RECIPE', 22, NULL, 64, '2025-09-08 12:00:00');
INSERT INTO `flow_index` VALUES (3340, 2, 'RECIPE', 22, NULL, 64, '2025-09-08 12:01:45');
INSERT INTO `flow_index` VALUES (3341, 5, 'RECIPE', 22, 215000, 64, '2025-09-08 12:05:20');
INSERT INTO `flow_index` VALUES (3342, 3, 'RECIPE', 22, NULL, 64, '2025-09-08 12:06:00');

-- === 用户65 (陈大伟) 的行为数据 ===
INSERT INTO `flow_index` VALUES (3343, 1, 'HEALTH_NEWS', 17, NULL, 65, '2025-09-02 14:00:00');
INSERT INTO `flow_index` VALUES (3344, 2, 'HEALTH_NEWS', 17, NULL, 65, '2025-09-02 14:01:50');
INSERT INTO `flow_index` VALUES (3345, 5, 'HEALTH_NEWS', 17, 168000, 65, '2025-09-02 14:04:38');
INSERT INTO `flow_index` VALUES (3346, 1, 'HEALTH_NEWS', 23, NULL, 65, '2025-09-03 10:00:00');
INSERT INTO `flow_index` VALUES (3347, 2, 'HEALTH_NEWS', 23, NULL, 65, '2025-09-03 10:02:10');
INSERT INTO `flow_index` VALUES (3348, 5, 'HEALTH_NEWS', 23, 285000, 65, '2025-09-03 10:06:55');
INSERT INTO `flow_index` VALUES (3349, 4, 'HEALTH_NEWS', 23, NULL, 65, '2025-09-03 10:07:20');
INSERT INTO `flow_index` VALUES (3350, 1, 'RECIPE', 18, NULL, 65, '2025-09-03 12:00:00');
INSERT INTO `flow_index` VALUES (3351, 2, 'RECIPE', 18, NULL, 65, '2025-09-03 12:01:30');
INSERT INTO `flow_index` VALUES (3352, 5, 'RECIPE', 18, 150000, 65, '2025-09-03 12:04:00');
INSERT INTO `flow_index` VALUES (3353, 3, 'RECIPE', 18, NULL, 65, '2025-09-03 12:04:30');
INSERT INTO `flow_index` VALUES (3354, 1, 'RECIPE', 27, NULL, 65, '2025-09-09 11:00:00');
INSERT INTO `flow_index` VALUES (3355, 2, 'RECIPE', 27, NULL, 65, '2025-09-09 11:01:40');
INSERT INTO `flow_index` VALUES (3356, 5, 'RECIPE', 27, 135000, 65, '2025-09-09 11:04:00');
INSERT INTO `flow_index` VALUES (3357, 1, 'RECIPE', 21, NULL, 65, '2025-09-09 18:00:00');
INSERT INTO `flow_index` VALUES (3358, 2, 'RECIPE', 21, NULL, 65, '2025-09-09 18:01:20');
INSERT INTO `flow_index` VALUES (3359, 5, 'RECIPE', 21, 175000, 65, '2025-09-09 18:04:35');
INSERT INTO `flow_index` VALUES (3360, 4, 'RECIPE', 21, NULL, 65, '2025-09-09 18:05:00');
INSERT INTO `flow_index` VALUES (3361, 1, 'HEALTH_NEWS', 29, NULL, 65, '2025-09-13 10:30:00');
INSERT INTO `flow_index` VALUES (3362, 2, 'HEALTH_NEWS', 29, NULL, 65, '2025-09-13 10:32:00');
INSERT INTO `flow_index` VALUES (3363, 5, 'HEALTH_NEWS', 29, 220000, 65, '2025-09-13 10:35:40');
INSERT INTO `flow_index` VALUES (3364, 3, 'HEALTH_NEWS', 29, NULL, 65, '2025-09-13 10:36:00');

-- === 用户66 (林美美) 的行为数据 ===
INSERT INTO `flow_index` VALUES (3365, 1, 'HEALTH_NEWS', 17, NULL, 66, '2025-09-02 16:00:00');
INSERT INTO `flow_index` VALUES (3366, 2, 'HEALTH_NEWS', 17, NULL, 66, '2025-09-02 16:01:45');
INSERT INTO `flow_index` VALUES (3367, 5, 'HEALTH_NEWS', 17, 198000, 66, '2025-09-02 16:05:03');
INSERT INTO `flow_index` VALUES (3368, 3, 'HEALTH_NEWS', 17, NULL, 66, '2025-09-02 16:05:30');
INSERT INTO `flow_index` VALUES (3369, 1, 'RECIPE', 17, NULL, 66, '2025-09-04 10:00:00');
INSERT INTO `flow_index` VALUES (3370, 2, 'RECIPE', 17, NULL, 66, '2025-09-04 10:01:30');
INSERT INTO `flow_index` VALUES (3371, 5, 'RECIPE', 17, 265000, 66, '2025-09-04 10:06:00');
INSERT INTO `flow_index` VALUES (3372, 4, 'RECIPE', 17, NULL, 66, '2025-09-04 10:07:00');
INSERT INTO `flow_index` VALUES (3373, 1, 'HEALTH_NEWS', 24, NULL, 66, '2025-09-05 09:00:00');
INSERT INTO `flow_index` VALUES (3374, 2, 'HEALTH_NEWS', 24, NULL, 66, '2025-09-05 09:02:00');
INSERT INTO `flow_index` VALUES (3375, 5, 'HEALTH_NEWS', 24, 340000, 66, '2025-09-05 09:07:40');
INSERT INTO `flow_index` VALUES (3376, 3, 'HEALTH_NEWS', 24, NULL, 66, '2025-09-05 09:08:00');
INSERT INTO `flow_index` VALUES (3377, 4, 'HEALTH_NEWS', 24, NULL, 66, '2025-09-05 09:08:30');
INSERT INTO `flow_index` VALUES (3378, 1, 'RECIPE', 22, NULL, 66, '2025-09-08 11:30:00');
INSERT INTO `flow_index` VALUES (3379, 2, 'RECIPE', 22, NULL, 66, '2025-09-08 11:31:45');
INSERT INTO `flow_index` VALUES (3380, 5, 'RECIPE', 22, 190000, 66, '2025-09-08 11:35:00');
INSERT INTO `flow_index` VALUES (3381, 1, 'RECIPE', 26, NULL, 66, '2025-09-08 15:00:00');
INSERT INTO `flow_index` VALUES (3382, 2, 'RECIPE', 26, NULL, 66, '2025-09-08 15:01:30');
INSERT INTO `flow_index` VALUES (3383, 5, 'RECIPE', 26, 145000, 66, '2025-09-08 15:04:00');
INSERT INTO `flow_index` VALUES (3384, 3, 'RECIPE', 26, NULL, 66, '2025-09-08 15:04:30');
INSERT INTO `flow_index` VALUES (3385, 1, 'RECIPE', 16, NULL, 66, '2025-09-12 18:30:00');
INSERT INTO `flow_index` VALUES (3386, 2, 'RECIPE', 16, NULL, 66, '2025-09-12 18:31:50');
INSERT INTO `flow_index` VALUES (3387, 5, 'RECIPE', 16, 165000, 66, '2025-09-12 18:34:35');
INSERT INTO `flow_index` VALUES (3388, 3, 'RECIPE', 16, NULL, 66, '2025-09-12 18:35:00');

-- === 用户67 (张强) 的行为数据 ===
INSERT INTO `flow_index` VALUES (3389, 1, 'HEALTH_NEWS', 20, NULL, 67, '2025-09-05 08:00:00');
INSERT INTO `flow_index` VALUES (3390, 2, 'HEALTH_NEWS', 20, NULL, 67, '2025-09-05 08:01:30');
INSERT INTO `flow_index` VALUES (3391, 5, 'HEALTH_NEWS', 20, 280000, 67, '2025-09-05 08:06:00');
INSERT INTO `flow_index` VALUES (3392, 4, 'HEALTH_NEWS', 20, NULL, 67, '2025-09-05 08:06:30');
INSERT INTO `flow_index` VALUES (3393, 1, 'HEALTH_NEWS', 28, NULL, 67, '2025-09-05 16:00:00');
INSERT INTO `flow_index` VALUES (3394, 2, 'HEALTH_NEWS', 28, NULL, 67, '2025-09-05 16:02:00');
INSERT INTO `flow_index` VALUES (3395, 5, 'HEALTH_NEWS', 28, 205000, 67, '2025-09-05 16:05:25');
INSERT INTO `flow_index` VALUES (3396, 1, 'RECIPE', 25, NULL, 67, '2025-09-05 11:30:00');
INSERT INTO `flow_index` VALUES (3397, 2, 'RECIPE', 25, NULL, 67, '2025-09-05 11:31:40');
INSERT INTO `flow_index` VALUES (3398, 5, 'RECIPE', 25, 155000, 67, '2025-09-05 11:34:15');
INSERT INTO `flow_index` VALUES (3399, 3, 'RECIPE', 25, NULL, 67, '2025-09-05 11:34:45');
INSERT INTO `flow_index` VALUES (3400, 1, 'RECIPE', 18, NULL, 67, '2025-09-06 18:30:00');
INSERT INTO `flow_index` VALUES (3401, 2, 'RECIPE', 18, NULL, 67, '2025-09-06 18:31:50');
INSERT INTO `flow_index` VALUES (3402, 5, 'RECIPE', 18, 185000, 67, '2025-09-06 18:35:00');
INSERT INTO `flow_index` VALUES (3403, 4, 'RECIPE', 18, NULL, 67, '2025-09-06 18:35:30');
INSERT INTO `flow_index` VALUES (3404, 1, 'RECIPE', 27, NULL, 67, '2025-09-12 11:30:00');
INSERT INTO `flow_index` VALUES (3405, 2, 'RECIPE', 27, NULL, 67, '2025-09-12 11:32:00');
INSERT INTO `flow_index` VALUES (3406, 5, 'RECIPE', 27, 130000, 67, '2025-09-12 11:34:20');
INSERT INTO `flow_index` VALUES (3407, 1, 'HEALTH_NEWS', 22, NULL, 67, '2025-09-12 14:00:00');
INSERT INTO `flow_index` VALUES (3408, 2, 'HEALTH_NEWS', 22, NULL, 67, '2025-09-12 14:01:30');
INSERT INTO `flow_index` VALUES (3409, 5, 'HEALTH_NEWS', 22, 255000, 67, '2025-09-12 14:05:45');
INSERT INTO `flow_index` VALUES (3410, 3, 'HEALTH_NEWS', 22, NULL, 67, '2025-09-12 14:06:15');

-- === 用户68 (刘洋) 的行为数据 ===
INSERT INTO `flow_index` VALUES (3411, 1, 'HEALTH_NEWS', 22, NULL, 68, '2025-09-07 13:30:00');
INSERT INTO `flow_index` VALUES (3412, 2, 'HEALTH_NEWS', 22, NULL, 68, '2025-09-07 13:32:00');
INSERT INTO `flow_index` VALUES (3413, 5, 'HEALTH_NEWS', 22, 320000, 68, '2025-09-07 13:37:20');
INSERT INTO `flow_index` VALUES (3414, 4, 'HEALTH_NEWS', 22, NULL, 68, '2025-09-07 13:38:00');
INSERT INTO `flow_index` VALUES (3415, 1, 'HEALTH_NEWS', 19, NULL, 68, '2025-09-08 09:00:00');
INSERT INTO `flow_index` VALUES (3416, 2, 'HEALTH_NEWS', 19, NULL, 68, '2025-09-08 09:01:45');
INSERT INTO `flow_index` VALUES (3417, 5, 'HEALTH_NEWS', 19, 235000, 68, '2025-09-08 09:05:40');
INSERT INTO `flow_index` VALUES (3418, 3, 'HEALTH_NEWS', 19, NULL, 68, '2025-09-08 09:06:10');
INSERT INTO `flow_index` VALUES (3419, 1, 'RECIPE', 17, NULL, 68, '2025-09-09 10:00:00');
INSERT INTO `flow_index` VALUES (3420, 2, 'RECIPE', 17, NULL, 68, '2025-09-09 10:01:30');
INSERT INTO `flow_index` VALUES (3421, 5, 'RECIPE', 17, 210000, 68, '2025-09-09 10:05:00');
INSERT INTO `flow_index` VALUES (3422, 4, 'RECIPE', 17, NULL, 68, '2025-09-09 10:05:30');
INSERT INTO `flow_index` VALUES (3423, 1, 'HEALTH_NEWS', 25, NULL, 68, '2025-09-10 10:00:00');
INSERT INTO `flow_index` VALUES (3424, 2, 'HEALTH_NEWS', 25, NULL, 68, '2025-09-10 10:02:00');
INSERT INTO `flow_index` VALUES (3425, 5, 'HEALTH_NEWS', 25, 178000, 68, '2025-09-10 10:05:00');
INSERT INTO `flow_index` VALUES (3426, 1, 'HEALTH_NEWS', 30, NULL, 68, '2025-09-14 14:30:00');
INSERT INTO `flow_index` VALUES (3427, 2, 'HEALTH_NEWS', 30, NULL, 68, '2025-09-14 14:32:00');
INSERT INTO `flow_index` VALUES (3428, 5, 'HEALTH_NEWS', 30, 260000, 68, '2025-09-14 14:36:20');
INSERT INTO `flow_index` VALUES (3429, 4, 'HEALTH_NEWS', 30, NULL, 68, '2025-09-14 14:37:00');

-- === 用户69 (孙红) 的行为数据 ===
INSERT INTO `flow_index` VALUES (3430, 1, 'HEALTH_NEWS', 23, NULL, 69, '2025-09-08 09:30:00');
INSERT INTO `flow_index` VALUES (3431, 2, 'HEALTH_NEWS', 23, NULL, 69, '2025-09-08 09:31:50');
INSERT INTO `flow_index` VALUES (3432, 5, 'HEALTH_NEWS', 23, 290000, 69, '2025-09-08 09:36:30');
INSERT INTO `flow_index` VALUES (3433, 4, 'HEALTH_NEWS', 23, NULL, 69, '2025-09-08 09:37:00');
INSERT INTO `flow_index` VALUES (3434, 1, 'RECIPE', 26, NULL, 69, '2025-09-11 20:00:00');
INSERT INTO `flow_index` VALUES (3435, 2, 'RECIPE', 26, NULL, 69, '2025-09-11 20:01:30');
INSERT INTO `flow_index` VALUES (3436, 5, 'RECIPE', 26, 140000, 69, '2025-09-11 20:04:00');
INSERT INTO `flow_index` VALUES (3437, 3, 'RECIPE', 26, NULL, 69, '2025-09-11 20:04:30');
INSERT INTO `flow_index` VALUES (3438, 1, 'HEALTH_NEWS', 27, NULL, 69, '2025-09-11 09:00:00');
INSERT INTO `flow_index` VALUES (3439, 2, 'HEALTH_NEWS', 27, NULL, 69, '2025-09-11 09:01:45');
INSERT INTO `flow_index` VALUES (3440, 5, 'HEALTH_NEWS', 27, 310000, 69, '2025-09-11 09:07:00');
INSERT INTO `flow_index` VALUES (3441, 3, 'HEALTH_NEWS', 27, NULL, 69, '2025-09-11 09:07:30');
INSERT INTO `flow_index` VALUES (3442, 4, 'HEALTH_NEWS', 27, NULL, 69, '2025-09-11 09:08:00');

-- === 用户70 (周明) 的行为数据 ===
INSERT INTO `flow_index` VALUES (3443, 1, 'HEALTH_NEWS', 24, NULL, 70, '2025-09-08 10:30:00');
INSERT INTO `flow_index` VALUES (3444, 2, 'HEALTH_NEWS', 24, NULL, 70, '2025-09-08 10:32:00');
INSERT INTO `flow_index` VALUES (3445, 5, 'HEALTH_NEWS', 24, 270000, 70, '2025-09-08 10:36:40');
INSERT INTO `flow_index` VALUES (3446, 1, 'RECIPE', 25, NULL, 70, '2025-09-11 17:30:00');
INSERT INTO `flow_index` VALUES (3447, 2, 'RECIPE', 25, NULL, 70, '2025-09-11 17:31:50');
INSERT INTO `flow_index` VALUES (3448, 5, 'RECIPE', 25, 165000, 70, '2025-09-11 17:34:35');
INSERT INTO `flow_index` VALUES (3449, 3, 'RECIPE', 25, NULL, 70, '2025-09-11 17:35:00');
INSERT INTO `flow_index` VALUES (3450, 4, 'RECIPE', 25, NULL, 70, '2025-09-11 17:35:30');

-- === 用户71 (吴小小) 的行为数据 ===
INSERT INTO `flow_index` VALUES (3451, 1, 'RECIPE', 26, NULL, 71, '2025-09-12 20:30:00');
INSERT INTO `flow_index` VALUES (3452, 2, 'RECIPE', 26, NULL, 71, '2025-09-12 20:31:45');
INSERT INTO `flow_index` VALUES (3453, 5, 'RECIPE', 26, 155000, 71, '2025-09-12 20:34:30');
INSERT INTO `flow_index` VALUES (3454, 3, 'RECIPE', 26, NULL, 71, '2025-09-12 20:35:00');
INSERT INTO `flow_index` VALUES (3455, 4, 'RECIPE', 26, NULL, 71, '2025-09-12 20:35:30');

-- === 用户72-78 (其他新用户) 的行为数据 ===
INSERT INTO `flow_index` VALUES (3456, 1, 'HEALTH_NEWS', 18, NULL, 72, '2025-09-03 11:00:00');
INSERT INTO `flow_index` VALUES (3457, 2, 'HEALTH_NEWS', 18, NULL, 72, '2025-09-03 11:01:30');
INSERT INTO `flow_index` VALUES (3458, 5, 'HEALTH_NEWS', 18, 175000, 72, '2025-09-03 11:04:35');
INSERT INTO `flow_index` VALUES (3459, 1, 'HEALTH_NEWS', 21, NULL, 72, '2025-09-10 09:00:00');
INSERT INTO `flow_index` VALUES (3460, 2, 'HEALTH_NEWS', 21, NULL, 72, '2025-09-10 09:01:40');
INSERT INTO `flow_index` VALUES (3461, 5, 'HEALTH_NEWS', 21, 225000, 72, '2025-09-10 09:05:15');
INSERT INTO `flow_index` VALUES (3462, 3, 'HEALTH_NEWS', 21, NULL, 72, '2025-09-10 09:05:45');
INSERT INTO `flow_index` VALUES (3463, 1, 'RECIPE', 19, NULL, 73, '2025-09-04 07:30:00');
INSERT INTO `flow_index` VALUES (3464, 2, 'RECIPE', 19, NULL, 73, '2025-09-04 07:31:30');
INSERT INTO `flow_index` VALUES (3465, 5, 'RECIPE', 19, 125000, 73, '2025-09-04 07:33:35');
INSERT INTO `flow_index` VALUES (3466, 4, 'RECIPE', 19, NULL, 73, '2025-09-04 07:34:00');
INSERT INTO `flow_index` VALUES (3467, 1, 'HEALTH_NEWS', 20, NULL, 73, '2025-09-10 15:00:00');
INSERT INTO `flow_index` VALUES (3468, 2, 'HEALTH_NEWS', 20, NULL, 73, '2025-09-10 15:01:45');
INSERT INTO `flow_index` VALUES (3469, 5, 'HEALTH_NEWS', 20, 240000, 73, '2025-09-10 15:05:45');
INSERT INTO `flow_index` VALUES (3470, 1, 'HEALTH_NEWS', 26, NULL, 73, '2025-09-10 16:00:00');
INSERT INTO `flow_index` VALUES (3471, 2, 'HEALTH_NEWS', 26, NULL, 73, '2025-09-10 16:02:00');
INSERT INTO `flow_index` VALUES (3472, 5, 'HEALTH_NEWS', 26, 195000, 73, '2025-09-10 16:05:25');
INSERT INTO `flow_index` VALUES (3473, 1, 'HEALTH_NEWS', 17, NULL, 74, '2025-09-11 14:30:00');
INSERT INTO `flow_index` VALUES (3474, 2, 'HEALTH_NEWS', 17, NULL, 74, '2025-09-11 14:32:00');
INSERT INTO `flow_index` VALUES (3475, 5, 'HEALTH_NEWS', 17, 215000, 74, '2025-09-11 14:35:35');
INSERT INTO `flow_index` VALUES (3476, 3, 'HEALTH_NEWS', 17, NULL, 74, '2025-09-11 14:36:00');
INSERT INTO `flow_index` VALUES (3477, 1, 'HEALTH_NEWS', 28, NULL, 74, '2025-09-12 16:00:00');
INSERT INTO `flow_index` VALUES (3478, 2, 'HEALTH_NEWS', 28, NULL, 74, '2025-09-12 16:01:45');
INSERT INTO `flow_index` VALUES (3479, 5, 'HEALTH_NEWS', 28, 185000, 74, '2025-09-12 16:04:50');
INSERT INTO `flow_index` VALUES (3480, 1, 'RECIPE', 16, NULL, 75, '2025-09-12 09:00:00');
INSERT INTO `flow_index` VALUES (3481, 2, 'RECIPE', 16, NULL, 75, '2025-09-12 09:01:30');
INSERT INTO `flow_index` VALUES (3482, 5, 'RECIPE', 16, 200000, 75, '2025-09-12 09:04:50');
INSERT INTO `flow_index` VALUES (3483, 4, 'RECIPE', 16, NULL, 75, '2025-09-12 09:05:20');
INSERT INTO `flow_index` VALUES (3484, 1, 'RECIPE', 23, NULL, 75, '2025-09-10 07:00:00');
INSERT INTO `flow_index` VALUES (3485, 2, 'RECIPE', 23, NULL, 75, '2025-09-10 07:01:40');
INSERT INTO `flow_index` VALUES (3486, 5, 'RECIPE', 23, 135000, 75, '2025-09-10 07:04:00');
INSERT INTO `flow_index` VALUES (3487, 1, 'HEALTH_NEWS', 19, NULL, 76, '2025-09-13 11:00:00');
INSERT INTO `flow_index` VALUES (3488, 2, 'HEALTH_NEWS', 19, NULL, 76, '2025-09-13 11:02:00');
INSERT INTO `flow_index` VALUES (3489, 5, 'HEALTH_NEWS', 19, 250000, 76, '2025-09-13 11:06:30');
INSERT INTO `flow_index` VALUES (3490, 3, 'HEALTH_NEWS', 19, NULL, 76, '2025-09-13 11:07:00');
INSERT INTO `flow_index` VALUES (3491, 1, 'HEALTH_NEWS', 31, NULL, 76, '2025-09-15 08:30:00');
INSERT INTO `flow_index` VALUES (3492, 2, 'HEALTH_NEWS', 31, NULL, 76, '2025-09-15 08:32:00');
INSERT INTO `flow_index` VALUES (3493, 5, 'HEALTH_NEWS', 31, 275000, 76, '2025-09-15 08:36:45');
INSERT INTO `flow_index` VALUES (3494, 4, 'HEALTH_NEWS', 31, NULL, 76, '2025-09-15 08:37:15');
INSERT INTO `flow_index` VALUES (3495, 1, 'RECIPE', 17, NULL, 77, '2025-09-14 14:30:00');
INSERT INTO `flow_index` VALUES (3496, 2, 'RECIPE', 17, NULL, 77, '2025-09-14 14:31:50');
INSERT INTO `flow_index` VALUES (3497, 5, 'RECIPE', 17, 230000, 77, '2025-09-14 14:35:40');
INSERT INTO `flow_index` VALUES (3498, 3, 'RECIPE', 17, NULL, 77, '2025-09-14 14:36:10');
INSERT INTO `flow_index` VALUES (3499, 1, 'HEALTH_NEWS', 22, NULL, 77, '2025-09-14 10:00:00');
INSERT INTO `flow_index` VALUES (3500, 2, 'HEALTH_NEWS', 22, NULL, 77, '2025-09-14 10:01:45');
INSERT INTO `flow_index` VALUES (3501, 5, 'HEALTH_NEWS', 22, 205000, 77, '2025-09-14 10:05:10');
INSERT INTO `flow_index` VALUES (3502, 1, 'HEALTH_NEWS', 29, NULL, 78, '2025-09-13 11:30:00');
INSERT INTO `flow_index` VALUES (3503, 2, 'HEALTH_NEWS', 29, NULL, 78, '2025-09-13 11:32:00');
INSERT INTO `flow_index` VALUES (3504, 5, 'HEALTH_NEWS', 29, 188000, 78, '2025-09-13 11:35:28');
INSERT INTO `flow_index` VALUES (3505, 3, 'HEALTH_NEWS', 29, NULL, 78, '2025-09-13 11:36:00');
INSERT INTO `flow_index` VALUES (3506, 1, 'RECIPE', 28, NULL, 78, '2025-09-13 19:00:00');
INSERT INTO `flow_index` VALUES (3507, 2, 'RECIPE', 28, NULL, 78, '2025-09-13 19:01:30');
INSERT INTO `flow_index` VALUES (3508, 5, 'RECIPE', 28, 160000, 78, '2025-09-13 19:04:10');
INSERT INTO `flow_index` VALUES (3509, 4, 'RECIPE', 28, NULL, 78, '2025-09-13 19:04:40');
INSERT INTO `flow_index` VALUES (3510, 1, 'HEALTH_NEWS', 32, NULL, 78, '2025-09-16 13:00:00');
INSERT INTO `flow_index` VALUES (3511, 2, 'HEALTH_NEWS', 32, NULL, 78, '2025-09-16 13:02:00');
INSERT INTO `flow_index` VALUES (3512, 5, 'HEALTH_NEWS', 32, 295000, 78, '2025-09-16 13:06:55');
INSERT INTO `flow_index` VALUES (3513, 4, 'HEALTH_NEWS', 32, NULL, 78, '2025-09-16 13:07:25');

-- === 老用户(61-63) 对新内容的行为数据 ===
INSERT INTO `flow_index` VALUES (3514, 1, 'HEALTH_NEWS', 17, NULL, 61, '2025-09-02 10:00:00');
INSERT INTO `flow_index` VALUES (3515, 2, 'HEALTH_NEWS', 17, NULL, 61, '2025-09-02 10:01:30');
INSERT INTO `flow_index` VALUES (3516, 5, 'HEALTH_NEWS', 17, 220000, 61, '2025-09-02 10:05:10');
INSERT INTO `flow_index` VALUES (3517, 3, 'HEALTH_NEWS', 17, NULL, 61, '2025-09-02 10:05:40');
INSERT INTO `flow_index` VALUES (3518, 1, 'HEALTH_NEWS', 19, NULL, 61, '2025-09-04 11:00:00');
INSERT INTO `flow_index` VALUES (3519, 2, 'HEALTH_NEWS', 19, NULL, 61, '2025-09-04 11:02:00');
INSERT INTO `flow_index` VALUES (3520, 5, 'HEALTH_NEWS', 19, 265000, 61, '2025-09-04 11:06:35');
INSERT INTO `flow_index` VALUES (3521, 4, 'HEALTH_NEWS', 19, NULL, 61, '2025-09-04 11:07:05');
INSERT INTO `flow_index` VALUES (3522, 1, 'RECIPE', 16, NULL, 62, '2025-09-08 11:30:00');
INSERT INTO `flow_index` VALUES (3523, 2, 'RECIPE', 16, NULL, 62, '2025-09-08 11:32:00');
INSERT INTO `flow_index` VALUES (3524, 5, 'RECIPE', 16, 190000, 62, '2025-09-08 11:35:30');
INSERT INTO `flow_index` VALUES (3525, 3, 'RECIPE', 16, NULL, 62, '2025-09-08 11:36:00');
INSERT INTO `flow_index` VALUES (3526, 1, 'HEALTH_NEWS', 18, NULL, 62, '2025-09-03 08:30:00');
INSERT INTO `flow_index` VALUES (3527, 2, 'HEALTH_NEWS', 18, NULL, 62, '2025-09-03 08:32:00');
INSERT INTO `flow_index` VALUES (3528, 5, 'HEALTH_NEWS', 18, 210000, 62, '2025-09-03 08:35:40');
INSERT INTO `flow_index` VALUES (3529, 4, 'HEALTH_NEWS', 18, NULL, 62, '2025-09-03 08:36:10');
INSERT INTO `flow_index` VALUES (3530, 1, 'RECIPE', 17, NULL, 62, '2025-09-03 13:00:00');
INSERT INTO `flow_index` VALUES (3531, 2, 'RECIPE', 17, NULL, 62, '2025-09-03 13:01:30');
INSERT INTO `flow_index` VALUES (3532, 5, 'RECIPE', 17, 245000, 62, '2025-09-03 13:05:55');
INSERT INTO `flow_index` VALUES (3533, 3, 'RECIPE', 17, NULL, 62, '2025-09-03 13:06:25');
INSERT INTO `flow_index` VALUES (3534, 1, 'HEALTH_NEWS', 20, NULL, 63, '2025-09-05 09:30:00');
INSERT INTO `flow_index` VALUES (3535, 2, 'HEALTH_NEWS', 20, NULL, 63, '2025-09-05 09:32:00');
INSERT INTO `flow_index` VALUES (3536, 5, 'HEALTH_NEWS', 20, 275000, 63, '2025-09-05 09:36:45');
INSERT INTO `flow_index` VALUES (3537, 4, 'HEALTH_NEWS', 20, NULL, 63, '2025-09-05 09:37:15');
INSERT INTO `flow_index` VALUES (3538, 1, 'HEALTH_NEWS', 17, NULL, 63, '2025-09-02 11:00:00');
INSERT INTO `flow_index` VALUES (3539, 2, 'HEALTH_NEWS', 17, NULL, 63, '2025-09-02 11:01:45');
INSERT INTO `flow_index` VALUES (3540, 5, 'HEALTH_NEWS', 17, 185000, 63, '2025-09-02 11:05:00');
INSERT INTO `flow_index` VALUES (3541, 3, 'HEALTH_NEWS', 17, NULL, 63, '2025-09-02 11:05:30');
INSERT INTO `flow_index` VALUES (3542, 1, 'RECIPE', 22, NULL, 63, '2025-09-08 14:00:00');
INSERT INTO `flow_index` VALUES (3543, 2, 'RECIPE', 22, NULL, 63, '2025-09-08 14:01:30');
INSERT INTO `flow_index` VALUES (3544, 5, 'RECIPE', 22, 170000, 63, '2025-09-08 14:04:30');
INSERT INTO `flow_index` VALUES (3545, 4, 'RECIPE', 22, NULL, 63, '2025-09-08 14:05:00');

-- === 批量展现数据（模拟列表页浏览） ===
INSERT INTO `flow_index` VALUES (3546, 1, 'HEALTH_NEWS', 17, NULL, 64, '2025-09-01 08:30:00');
INSERT INTO `flow_index` VALUES (3547, 1, 'HEALTH_NEWS', 18, NULL, 64, '2025-09-01 08:30:05');
INSERT INTO `flow_index` VALUES (3548, 1, 'HEALTH_NEWS', 19, NULL, 64, '2025-09-01 08:30:10');
INSERT INTO `flow_index` VALUES (3549, 1, 'HEALTH_NEWS', 20, NULL, 64, '2025-09-01 08:30:15');
INSERT INTO `flow_index` VALUES (3550, 1, 'HEALTH_NEWS', 21, NULL, 64, '2025-09-01 08:30:20');
INSERT INTO `flow_index` VALUES (3551, 1, 'HEALTH_NEWS', 22, NULL, 64, '2025-09-01 08:30:25');
INSERT INTO `flow_index` VALUES (3552, 1, 'HEALTH_NEWS', 23, NULL, 64, '2025-09-01 08:30:30');
INSERT INTO `flow_index` VALUES (3553, 1, 'HEALTH_NEWS', 24, NULL, 64, '2025-09-01 08:30:35');
INSERT INTO `flow_index` VALUES (3554, 1, 'HEALTH_NEWS', 25, NULL, 64, '2025-09-01 08:30:40');
INSERT INTO `flow_index` VALUES (3555, 1, 'HEALTH_NEWS', 26, NULL, 64, '2025-09-01 08:30:45');
INSERT INTO `flow_index` VALUES (3556, 1, 'HEALTH_NEWS', 27, NULL, 64, '2025-09-01 08:30:50');
INSERT INTO `flow_index` VALUES (3557, 1, 'HEALTH_NEWS', 28, NULL, 64, '2025-09-01 08:30:55');
INSERT INTO `flow_index` VALUES (3558, 1, 'HEALTH_NEWS', 29, NULL, 64, '2025-09-01 08:31:00');
INSERT INTO `flow_index` VALUES (3559, 1, 'HEALTH_NEWS', 30, NULL, 64, '2025-09-01 08:31:05');
INSERT INTO `flow_index` VALUES (3560, 1, 'HEALTH_NEWS', 31, NULL, 64, '2025-09-01 08:31:10');
INSERT INTO `flow_index` VALUES (3561, 1, 'HEALTH_NEWS', 32, NULL, 64, '2025-09-01 08:31:15');
INSERT INTO `flow_index` VALUES (3562, 1, 'RECIPE', 16, NULL, 64, '2025-09-01 08:31:20');
INSERT INTO `flow_index` VALUES (3563, 1, 'RECIPE', 17, NULL, 64, '2025-09-01 08:31:25');
INSERT INTO `flow_index` VALUES (3564, 1, 'RECIPE', 18, NULL, 64, '2025-09-01 08:31:30');
INSERT INTO `flow_index` VALUES (3565, 1, 'RECIPE', 19, NULL, 64, '2025-09-01 08:31:35');
INSERT INTO `flow_index` VALUES (3566, 1, 'RECIPE', 20, NULL, 64, '2025-09-01 08:31:40');
INSERT INTO `flow_index` VALUES (3567, 1, 'RECIPE', 21, NULL, 64, '2025-09-01 08:31:45');
INSERT INTO `flow_index` VALUES (3568, 1, 'RECIPE', 22, NULL, 64, '2025-09-01 08:31:50');
INSERT INTO `flow_index` VALUES (3569, 1, 'RECIPE', 23, NULL, 64, '2025-09-01 08:31:55');
INSERT INTO `flow_index` VALUES (3570, 1, 'RECIPE', 24, NULL, 64, '2025-09-01 08:32:00');
INSERT INTO `flow_index` VALUES (3571, 1, 'RECIPE', 25, NULL, 64, '2025-09-01 08:32:05');
INSERT INTO `flow_index` VALUES (3572, 1, 'RECIPE', 26, NULL, 64, '2025-09-01 08:32:10');
INSERT INTO `flow_index` VALUES (3573, 1, 'RECIPE', 27, NULL, 64, '2025-09-01 08:32:15');
INSERT INTO `flow_index` VALUES (3574, 1, 'RECIPE', 28, NULL, 64, '2025-09-01 08:32:20');

INSERT INTO `flow_index` VALUES (3575, 1, 'HEALTH_NEWS', 17, NULL, 65, '2025-09-02 09:00:00');
INSERT INTO `flow_index` VALUES (3576, 1, 'HEALTH_NEWS', 18, NULL, 65, '2025-09-02 09:00:05');
INSERT INTO `flow_index` VALUES (3577, 1, 'HEALTH_NEWS', 19, NULL, 65, '2025-09-02 09:00:10');
INSERT INTO `flow_index` VALUES (3578, 1, 'HEALTH_NEWS', 20, NULL, 65, '2025-09-02 09:00:15');
INSERT INTO `flow_index` VALUES (3579, 1, 'HEALTH_NEWS', 21, NULL, 65, '2025-09-02 09:00:20');
INSERT INTO `flow_index` VALUES (3580, 1, 'HEALTH_NEWS', 22, NULL, 65, '2025-09-02 09:00:25');
INSERT INTO `flow_index` VALUES (3581, 1, 'HEALTH_NEWS', 23, NULL, 65, '2025-09-02 09:00:30');
INSERT INTO `flow_index` VALUES (3582, 1, 'HEALTH_NEWS', 24, NULL, 65, '2025-09-02 09:00:35');
INSERT INTO `flow_index` VALUES (3583, 1, 'HEALTH_NEWS', 25, NULL, 65, '2025-09-02 09:00:40');
INSERT INTO `flow_index` VALUES (3584, 1, 'HEALTH_NEWS', 26, NULL, 65, '2025-09-02 09:00:45');
INSERT INTO `flow_index` VALUES (3585, 1, 'HEALTH_NEWS', 27, NULL, 65, '2025-09-02 09:00:50');
INSERT INTO `flow_index` VALUES (3586, 1, 'HEALTH_NEWS', 28, NULL, 65, '2025-09-02 09:00:55');
INSERT INTO `flow_index` VALUES (3587, 1, 'HEALTH_NEWS', 29, NULL, 65, '2025-09-02 09:01:00');
INSERT INTO `flow_index` VALUES (3588, 1, 'HEALTH_NEWS', 30, NULL, 65, '2025-09-02 09:01:05');
INSERT INTO `flow_index` VALUES (3589, 1, 'HEALTH_NEWS', 31, NULL, 65, '2025-09-02 09:01:10');
INSERT INTO `flow_index` VALUES (3590, 1, 'HEALTH_NEWS', 32, NULL, 65, '2025-09-02 09:01:15');
INSERT INTO `flow_index` VALUES (3591, 1, 'RECIPE', 16, NULL, 65, '2025-09-02 09:01:20');
INSERT INTO `flow_index` VALUES (3592, 1, 'RECIPE', 17, NULL, 65, '2025-09-02 09:01:25');
INSERT INTO `flow_index` VALUES (3593, 1, 'RECIPE', 18, NULL, 65, '2025-09-02 09:01:30');
INSERT INTO `flow_index` VALUES (3594, 1, 'RECIPE', 19, NULL, 65, '2025-09-02 09:01:35');
INSERT INTO `flow_index` VALUES (3595, 1, 'RECIPE', 20, NULL, 65, '2025-09-02 09:01:40');
INSERT INTO `flow_index` VALUES (3596, 1, 'RECIPE', 21, NULL, 65, '2025-09-02 09:01:45');
INSERT INTO `flow_index` VALUES (3597, 1, 'RECIPE', 22, NULL, 65, '2025-09-02 09:01:50');


SET FOREIGN_KEY_CHECKS = 1;

/*
 ============================================================
  图片替换说明
 ============================================================
  
  ✅ 本版本所有图片均使用系统中已有的真实图片：
  
  📦 用户头像（6张循环）：
     17587778993152.png / 17587779050599.png
     1758777922524Snipaste_2025-04-25_15-25-57.png
     1758777928834Snipaste_2025-05-20_15-11-47.png
     17587779689247.png / 17587779353178.png
  
  📰 健康资讯封面（11张循环）：
     1754313964000Snipaste_2025-04-21_16-58-17.png
     1754314121023Snipaste_2025-04-21_16-58-10.png
     1754314146011Snipaste_2025-04-21_16-58-30.png
     1753534656538Snipaste_2025-04-21_16-57-23.png
     1754314012947Snipaste_2025-04-21_16-56-22.png
     1754393018796Snipaste_2025-07-01_16-06-23.png
     1754392870060cover4.png / 1754392933714cover5.png
     175439277386314.jpg
  
  🍽️ 食谱封面（11张循环）：
     1754381783662Snipaste_2025-08-05_16-14-54.png
     1754382097771Snipaste_2025-08-05_16-15-38.png
     1754117540498Snipaste_2025-04-21_16-57-23.png
     1754381960986Snipaste_2025-08-05_16-15-18.png
     1754385437697Snipaste_2025-08-05_16-15-33.png
     1754393136282Snipaste_2025-06-01_18-02-46.png
     1754381984739Snipaste_2025-08-05_16-15-33.png
     1754382055394Snipaste_2025-08-05_16-15-52.png
     1754385535019Snipaste_2025-08-05_17-18-43.png
     1754393248644Snipaste_2025-06-01_18-02-20.png
     1754393160129Snipaste_2025-06-01_17-43-44.png
  
  💪 健康模型图标（4张）：
     1753670454370weight.png / 1754393779064xt.png
     1753760115590BMI.png / 1753597325751rate.png
  
  📄 正文插图（统一使用）：
     1753534646517Snipaste_2025-04-21_16-57-23.png
  
  ⚠️ 注意：
  以上图片均来源于原selfhealth.sql文件中的已有数据，
  执行本SQL文件后可直接使用，无需额外配置图片资源。
 */
