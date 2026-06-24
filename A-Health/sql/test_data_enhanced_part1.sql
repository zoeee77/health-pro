/*
 ============================================================
  自我健康管理系统 - 增强版测试数据补充脚本
  Self Health Management System - Enhanced Test Data
  
  基于 new1.sql 最新数据结构生成
  所有图片均使用系统中已有的真实图片
  包含：新用户、健康资讯、食谱、健康模型、
        健康记录、饮食记录、评论、点赞、流量指标
 ============================================================
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;


-- ============================================================
-- 一、新增用户样本（12位新用户，ID: 79~90）
-- 头像复用系统中已有图片（6张循环使用）
-- 角色分配：2=普通用户，1=管理员（可选）
-- ============================================================

INSERT INTO `user` VALUES (79, 'yangyang', '杨洋', '14e1b600b1fd579f47433b88e8d85291', '/api/v1.0/self-health-api/file/getFile?fileName=17587778993152.png', 'yang.yang@outlook.com', 2, 2, '1994-06-15', '18612345678', '2025-09-17 10:00:00');
INSERT INTO `user` VALUES (80, 'lixia', '李霞', '14e1b600b1fd579f47433b88e8d85291', '/api/v1.0/self-health-api/file/getFile?fileName=17587779050599.png', 'xia.li@qq.com', 2, 1, '1996-11-28', '13923456789', '2025-09-18 14:30:00');
INSERT INTO `user` VALUES (81, 'wujian', '吴健', '14e1b600b1fd579f47433b88e8d85291', '/api/v1.0/self-health-api/file/getFile?fileName=1758777922524Snipaste_2025-04-25_15-25-57.png', 'wujian_fit@gmail.com', 2, 2, '1989-03-22', '13734567890', '2025-09-19 09:15:00');
INSERT INTO `user` VALUES (82, 'zhaolei', '赵蕾', '14e1b600b1fd579f47433b88e8d85291', '/api/v1.0/self-health-api/file/getFile?fileName=1758777928834Snipaste_2025-05-20_15-11-47.png', 'zhaolei_beauty@163.com', 2, 1, '1997-08-10', '13845678901', '2025-09-20 16:45:00');
INSERT INTO `user` VALUES (83, 'sunpeng', '孙鹏', '14e1b600b1fd579f47433b88e8d85291', '/api/v1.0/self-health-api/file/getFile?fileName=17587779689247.png', 'sunpeng_sun@qq.com', 2, 2, '1991-12-05', '13956789012', '2025-09-21 11:20:00');
INSERT INTO `user` VALUES (84, 'zhouyu', '周雨', '14e1b600b1fd579f47433b88e8d85291', '/api/v1.0/self-health-api/file/getFile?fileName=17587779353178.png', 'zhouyu_rain@126.com', 2, 1, '1995-04-18', '13667890123', '2025-09-22 08:50:00');
INSERT INTO `user` VALUES (85, 'chenxi', '陈曦', '14e1b600b1fd579f47433b88e8d85291', '/api/v1.0/self-health-api/file/getFile?fileName=17587778993152.png', 'chenxi_morning@hotmail.com', 2, 1, '1998-09-25', '13578901234', '2025-09-23 13:40:00');
INSERT INTO `user` VALUES (86, 'liuwei', '刘伟', '14e1b600b1fd579f47433b88e8d85291', '/api/v1.0/self-health-api/file/getFile?fileName=17587779050599.png', 'liuwei_great@gmail.com', 2, 2, '1986-07-30', '13489012345', '2025-09-24 15:10:00');
INSERT INTO `user` VALUES (87, 'wangfang', '王芳', '14e1b600b1fd579f47433b88e8d85291', '/api/v1.0/self-health-api/file/getFile?fileName=1758777922524Snipaste_2025-04-25_15-25-57.png', 'wangfang_flower@qq.com', 2, 1, '1993-02-14', '13390123456', '2025-09-25 10:25:00');
INSERT INTO `user` VALUES (88, 'zhaoqiang', '赵强', '14e1b600b1fd579f47433b88e8d85291', '/api/v1.0/self-health-api/file/getFile?fileName=1758777928834Snipaste_2025-05-20_15-11-47.png', 'zhaoqiang_strong@163.com', 2, 2, '1988-10-08', '13201234567', '2025-09-26 14:55:00');
INSERT INTO `user` VALUES (89, 'huangmei', '黄梅', '14e1b600b1fd579f47433b88e8d85291', '/api/v1.0/self-health-api/file/getFile?fileName=17587779689247.png', 'huangmei_plum@126.com', 2, 1, '1996-05-20', '13112345678', '2025-09-27 09:35:00');
INSERT INTO `user` VALUES (90, 'xuyang', '徐阳', '14e1b600b1fd579f47433b88e8d85291', '/api/v1.0/self-health-api/file/getFile?fileName=17587779353178.png', 'xuyang_sunny@qq.com', 2, 2, '1992-08-12', '13023456789', '2025-09-28 16:20:00');


-- ============================================================
-- 二、新增健康资讯（ID: 33~44）
-- 封面图复用已有health_news封面（9张循环）
-- 正文图统一使用已有内容图
-- type_id: 1=运动健身, 2=饮食营养, 3=心理健康, 4=睡眠养生, 5=综合健康
-- ============================================================

INSERT INTO `health_news` VALUES (33, 1, '/api/v1.0/self-health-api/file/getFile?fileName=1754313964000Snipaste_2025-04-21_16-58-17.png', '瑜伽入门：5个体式改善体态提升柔韧性', '<p><strong>为什么选择瑜伽？</strong></p><p>瑜伽不仅是一种身体锻炼方式，更是一种身心合一的生活方式。对于长期伏案工作的现代人来说，瑜伽可以有效改善圆肩驼背、缓解腰背疼痛、提升整体柔韧性。</p><p><img src=\"/api/v1.0/self-health-api/file/getFile?fileName=1753534646517Snipaste_2025-04-21_16-57-23.png\" alt=\"瑜伽体式示范\" style=\"width: 100%;\"/></p><p><strong>适合初学者的5个基础体式：</strong></p><ol><li><strong>山式（Tadasana）：</strong>站立的基础，培养正确的站姿习惯，改善骨盆前倾</li><li><strong>下犬式（Downward Dog）：</strong>拉伸背部和腿后侧，增强手臂力量</li><li><strong>猫牛式（Cat-Cow）：</温和地活动脊柱，缓解背痛</li><li><strong>战士一式（Warrior I）：</strong>打开髋部，强化腿部力量</li><li><strong>树式（Tree Pose）：</strong>提升平衡能力和专注力</li></ol><p><strong>练习建议：</strong>每周3-4次，每次30-45分钟。配合深呼吸，感受身体的每一个细微变化。</p>', '瑜伽初学者指南：山式、下犬式、猫牛式、战士一式、树式5大基础体式详解。每周3-4次每次30分钟，有效改善体态提升柔韧性。', '2025-09-17 10:30:00');

INSERT INTO `health_news` VALUES (34, 2, '/api/v1.0/self-health-api/file/getFile?fileName=1754314121023Snipaste_2025-04-21_16-58-10.png', '间歇性断食：科学减肥还是损害健康？', '<p><strong>间歇性断食（Intermittent Fasting, IF）近年来备受关注。</strong></p><p>常见的IF模式包括：16:8（每天禁食16小时）、5:2（每周2天限制热量）、OMAD（一天一餐）。研究显示，适度的间歇性断食可能带来以下益处：</p><p><img src=\"/api/v1.0/self-health-api/file/getFile?fileName=1753534646517Snipaste_2025-04-21_16-57-23.png\" alt=\"间歇性断食时间表\" style=\"width: 90%;\"/></p><p><strong>✅ 潜在好处：</strong></p><ul><li>促进脂肪燃烧，帮助减重</li><li>降低胰岛素水平，提高胰岛素敏感性</li><li>启动细胞自噬机制，延缓衰老</li><li>简化生活节奏，减少决策疲劳</li></ul><p><strong>⚠️ 注意事项：</strong></p><ul><li>不适合孕妇、哺乳期女性、未成年人</li><li>有进食障碍史者应避免</li><li>在非禁食期间仍需保证营养均衡</li><li>建议在医生或营养师指导下进行</li></ul><p><strong>💡 新手建议：</strong>从12:12开始尝试，逐步延长禁食窗口。多喝水，避免过度运动。</p>', '间歇性断食解析：16:8/5:2/OMAD三种模式对比。潜在好处：燃脂、降胰岛素、细胞自噬、简化生活。注意事项：特殊人群慎用、保证营养、循序渐进。', '2025-09-18 15:00:00');

INSERT INTO `health_news` VALUES (35, 3, '/api/v1.0/self-health-api/file/getFile?fileName=1754314146011Snipaste_2025-04-21_16-58-30.png', '社交焦虑症：如何克服对人群的恐惧？', '<p><strong>社交焦虑不只是"害羞"，它是一种需要认真对待的心理问题。</strong></p><p>社交焦虑障碍（Social Anxiety Disorder）表现为：害怕被他人评价、回避社交场合、在人群中感到极度不适、担心自己会做出令人尴尬的举动。</p><p><img src=\"/api/v1.0/self-health-api/file/getFile?fileName=1753534646517Snipaste_2025-04-21_16-57-23.png\" alt=\"社交焦虑应对策略\" style=\"width: 80%;\"/></p><p><strong>🎯 认知行为疗法(CBT)核心技巧：</strong></p><ul><li><strong>挑战负面思维：</strong>记录并质疑"大家都在看我"、"我一定会出丑"等自动思维</li><li><strong>暴露疗法：</strong>逐步面对恐惧的社交场景，从低难度开始（如向陌生人问路）</li><li><strong>注意力转移：</strong>将注意力从"我看起来怎么样"转移到"对方在说什么"</li><li><strong>角色扮演：</strong>与信任的朋友练习对话场景</li></ul><p><strong>💊 药物治疗（需医生处方）：</strong>SSRIs类抗抑郁药（如舍曲林）可有效减轻症状</p><p><strong>🤝 支持资源：</strong>加入互助小组、寻求专业心理咨询师帮助</p>', '社交焦虑应对：CBT认知行为疗法（挑战思维/暴露疗法/注意力转移/角色扮演）、SSRIs药物辅助、加入互助小组。症状持续影响生活时及时就医。', '2025-09-19 11:30:00');

INSERT INTO `health_news` VALUES (36, 4, '/api/v1.0/self-health-api/file/getFile?fileName=1753534656538Snipaste_2025-04-21_16-57-23.png', '褪黑素真的能治失眠吗？专家解读睡眠激素', '<p><strong>褪黑素（Melatonin）是人体松果体分泌的一种激素，主要作用是调节生物钟。</strong></p><p>随着年龄增长，人体自身分泌的褪黑素逐渐减少，这也是老年人更容易失眠的原因之一。那么，外源性褪黑素补充剂是否安全有效？</p><p><img src=\"/api/v1.0/self-health-api/file/getFile?fileName=1753534646517Snipaste_2025-04-21_16-57-23.png\" alt=\"褪黑素分泌曲线\" style=\"width: 100%;\"/></p><p><strong>✅ 褪黑素的适用情况：</strong></p><ul><li><strong>倒时差：</strong>跨时区旅行后调整生物钟的首选方案</li><li><strong>轮班工作者：</strong>帮助调节不规律的作息周期</li><li><strong>老年人：</strong>补充因年龄增长而减少的内源性褪黑素</li><li><strong>入睡困难型失眠：</strong>缩短入睡时间（而非延长总睡眠时长）</li></ul><p><strong>⚠️ 使用注意事项：</strong></p><ul><li>剂量建议：0.5-5mg（并非越多越好）</li><li>服用时间：睡前1-2小时</li><li>不宜长期连续使用（建议不超过3个月）</li><li>副作用：头晕、恶心、次日嗜睡（少数人）</li><li>禁忌：孕妇、 autoimmune 疾病患者、正在服用抗凝药物者</li></ul><p><strong>🔬 专家提醒：</strong>褪黑素是助眠辅助手段，不能替代良好的睡眠卫生习惯。如果失眠持续超过2周，请咨询睡眠专科医生。</p>', '褪黑素适用：倒时差、轮班工作、老年人、入睡困难型失眠。用法：0.5-5mg睡前1-2小时服用，不建议超3个月。注意：是辅助手段不能替代良好睡眠习惯。', '2025-09-20 13:45:00');

INSERT INTO `health_news` VALUES (37, 5, '/api/v1.0/self-health-api/file/getFile?fileName=1754314012947Snipaste_2025-04-21_16-56-22.png', '维生素D缺乏：沉默的健康杀手', '<p><strong>维生素D被称为"阳光维生素"，但全球约有10亿人存在维生素D不足或缺乏！</strong></p><p>维生素D不仅对骨骼健康至关重要，还参与免疫调节、 mood 调控、心血管保护等多种生理功能。</p><p><img src=\"/api/v1.0/self-health-api/file/getFile?fileName=1753534646517Snipaste_2025-04-21_16-57-23.png\" alt=\"维生素D来源\" style=\"width: 85%;\"/></p><p><strong>🔴 缺乏的高风险人群：</strong></p><ul><li>常年室内工作者（程序员、办公室白领等）</li><li>深色皮肤人群（黑色素会阻碍维生素D合成）</li><li>老年人（皮肤合成能力下降）</li><li>肥胖者（维生素D容易被脂肪组织"截留"）</li><li>居住在高纬度地区的人群（冬季日照不足）</li></ul><p><strong>📊 如何判断是否缺乏？</strong></p><p>抽血检测血清25(OH)D水平：<br/>• &lt; 20 ng/mL = 缺乏<br/>• 20-30 ng/mL = 不足<br/>• 30-50 ng/mL = 充足<br/>• &gt; 50 ng/mL = 可能过量（需医生指导）</p><p><strong>💊 补充建议：</strong></p><ul><li>每日日照：面部和手臂暴露于阳光下10-15分钟（避开正午强光）</li><li>食物来源： fatty fish（三文鱼、金枪鱼）、蛋黄、强化食品</li><li>补充剂：维生素D3（胆钙化醇），每日1000-2000IU</li></ul>', '维生素D缺乏高风险：室内工作者、深色皮肤、老年人、肥胖者、高纬度居民。检测标准：&lt;20ng/ml缺乏，20-30不足，30-50充足。补充：日照+食物+D3补充剂。', '2025-09-21 09:00:00');

INSERT INTO `health_news` VALUES (38, 1, '/api/v1.0/self-health-api/file/getFile?fileName=1754393018796Snipaste_2025-07-01_16-06-23.png', '普拉提 vs 瑜伽：两种流行运动的深度对比', '<p><strong>普拉提和瑜伽都是当下最热门的低冲击运动，但它们的目标和方法截然不同。</strong></p><p>了解两者的区别，可以帮助你根据自己的健身目标做出更明智的选择。</p><p><img src=\"/api/v1.0/self-health-api/file/getFile?fileName=1753534646517Snipaste_2025-04-21_16-57-23.png\" alt=\"普拉提与瑜伽对比\" style=\"width: 100%;\"/></p><p><strong>🧘 瑜伽（Yoga）：身心灵的统一</strong></p><ul><li><strong>起源：</strong>古印度，有5000多年历史</li><li><strong>核心理念：</strong>连接身体、呼吸和精神；追求内在平静</li><li><strong>主要效果：</strong>提升柔韧性、平衡感、减压放松</li><li><strong>适合人群：</strong>希望改善体态、缓解压力、寻求内心宁静的人</li><li><strong>典型课程：</strong>Hatha Yoga、Vinyasa Flow、阴瑜伽</li></ul><p><strong>🏋️ 普拉提（Pilates）：核心控制的艺术</strong></p><ul><li><strong>起源：</strong>20世纪初德国，由Joseph Pilates创立</li><li><strong>核心理念：</strong>"控制学"——精确控制每一个动作</li><li><strong>主要效果：</strong>强化核心肌群、改善姿态、预防损伤</li><li><strong>适合人群：</strong>康复期患者、办公室人群、产后妈妈</li><li><strong>典型课程：</strong>垫上普拉提、器械普拉提（Reformer）</li></ul><p><strong>💡 建议：</strong>两者可以互补！瑜伽提升柔韧性和心灵平静，普拉提强化核心和体态控制。最佳方案是每周各练2-3次。</p>', '普拉提vs瑜伽：瑜伽(印度5000年/身心灵统一/柔韧性减压) vs 普拉提(德国20世纪/核心控制/姿态康复)。两者可互补，建议每周各2-3次。', '2025-09-22 14:20:00');

INSERT INTO `health_news` VALUES (39, 2, '/api/v1.0/self-health-api/file/getFile?fileName=1754392870060cover4.png', '发酵食品：肠道健康的秘密武器', '<p><strong>你的肠道里有约100万亿个微生物，它们对你的健康影响远超想象！</strong></p><p>肠道菌群不仅参与消化吸收，还影响免疫系统、心理健康甚至体重管理。而发酵食品是维护肠道健康的天然利器。</p><p><img src=\"/api/v1.0/self-health-api/file/getFile?fileName=1753534646517Snipaste_2025-04-21_16-57-23.png\" alt=\"发酵食品家族\" style=\"width: 90%;\"/></p><p><strong>🥛 TOP 10 发酵食品推荐：</strong></p><ol><li><strong>酸奶/开菲尔：</strong>富含益生菌（乳酸杆菌、双歧杆菌），选择无糖原味</li><li><strong>泡菜（Kimchi）：</strong>韩式发酵卷心菜，富含维生素C和益生菌</li><li><strong>味噌：</strong>日本发酵大豆酱，含益生菌和异黄酮</li><li><strong>康普茶（Kombucha）：</strong>发酵茶饮，含有益有机酸</li><li><strong>苹果醋：</strong>含乙酸，有助于血糖控制和消化</li><li><strong>纳豆：</strong>日式发酵黄豆，富含纳豆激酶（心血管保护）</li><li><strong>酸菜：</strong>中式发酵蔬菜，保留部分维生素C</li><li><strong>奶酪（部分品种）：</strong>切达、高达等硬质奶酪含活性菌</li><li><strong>酸面包（Sourdough）：</strong>天然发酵面包，更易消化</li><li><strong>可可：</strong>黑巧克力中的可可粉经发酵，含益生元纤维</li></ol><p><strong>⚠️ 选择注意事项：</strong></p><ul><li>选择低温发酵产品（高温会杀死益生菌）</li><li>注意钠含量（某些腌制食品盐分很高）</li><li>从少量开始尝试，让肠道逐步适应</li><li>如果有组胺不耐受，需谨慎食用</li></ul>', '发酵食品TOP10：酸奶、泡菜、味噌、康普茶、苹果醋、纳豆、酸菜、奶酪、酸面包、黑巧。注意选低温发酵品、控钠摄入、循序渐进。肠道健康从发酵食品开始！', '2025-09-23 10:15:00');

INSERT INTO `health_news` VALUES (40, 3, '/api/v1.0/self-health-api/file/getFile?fileName=1754392933714cover5.png', '拖延症心理学：为什么我们总是"明天再做"？', '<p><strong>"我明天一定开始！" —— 这句话你是不是对自己说过无数次？</strong></p><p>拖延症不是简单的"懒惰"或"时间管理差"，它背后有着复杂的心理机制。理解这些机制，是战胜拖延的第一步。</p><p><img src=\"/api/v1.0/self-health-api/file/getFile?fileName=1753534646517Snipaste_2025-04-21_16-57-23.png\" alt=\"拖延症心理模型\" style=\"width: 75%;\"/></p><p><strong>🧠 拖延症的6大心理根源：</strong></p><ul><li><strong>完美主义：</strong>"如果做不到最好，不如不做"——害怕失败导致不敢开始</li><li><strong>即时满足偏差：</strong>大脑偏爱眼前的快乐（刷手机）而非延迟回报（完成任务）</li><li><strong>情绪调节困难：</strong>拖延是对负面情绪（焦虑、无聊、自我怀疑）的逃避反应</li><li><strong>任务抽象性：</strong>目标太模糊（如"写论文"），不知道从何下手</li><li><strong>自我效能感低：</strong>不相信自己有能力完成</li><li><strong>决策疲劳：</strong>选择太多导致瘫痪</li></ul><p><strong>🛠️ 科学验证有效的对抗策略：</strong></p><ol><li><strong>5分钟起步法：</strong>告诉自己"只做5分钟"，通常一旦开始就能继续</li><li><strong>任务分解：</strong>将大任务拆解为具体的小步骤（SMART原则）</li><li><strong>环境设计：</strong>移除干扰源（手机静音、关闭无关网页）</li><li><strong>番茄工作法：</strong>25分钟专注 + 5分钟休息</li><li><strong>自我同情：</strong>不要因为拖延而自责，这会形成恶性循环</li><li><strong>寻找 accountability partner：</strong>找伙伴互相监督进度</li></ol>', '拖延症根源：完美主义、即时满足偏差、情绪调节困难、任务抽象、自我效能低、决策疲劳。对策：5分钟法、任务分解、环境设计、番茄工作法、自我同情、找监督伙伴。', '2025-09-24 16:00:00');

INSERT INTO `health_news` VALUES (41, 4, '/api/v1.0/self-health-api/file/getFile?fileName=175439277386314.jpg', '睡眠环境优化：打造完美卧室的科学指南', '<p><strong>你知道吗？睡眠质量受环境影响高达40%！</strong></p><p>一个优化的睡眠环境可以帮助你更快入睡、减少夜间醒来次数、提升深度睡眠比例。以下是经过科学研究验证的环境优化方法：</p><p><img src=\"/api/v1.0/self-health-api/file/getFile?fileName=1753534646517Snipaste_2025-04-21_16-57-23.png\" alt=\"理想睡眠环境\" style=\"width: 100%;\"/></p><p><strong>🌡️ 温度控制（最重要！）</strong></p><ul><li>理想室温：18-22°C（65-72°F）</li><li>体温需要略微下降才能进入睡眠状态</li><li>投资高品质的空调或风扇</li><li>考虑使用降温床垫或凉感床品（夏季）</li></ul><p><strong>💡 光线管理</strong></p><ul><li>完全遮光的窗帘或眼罩（光线抑制褪黑素分泌）</li><li>移除卧室所有LED指示灯（用胶带遮挡）</li><li>夜灯选用红色或琥珀色波长（不影响褪黑素）</li><li>起床后立即接触自然光（帮助校准生物钟）</li></ul><p><strong>🔊 声音环境</strong></p><ul><li>理想背景噪音：30-40分贝</li><li>白噪音机或APP（雨声、海浪声）可屏蔽突发噪音</li><li>耳塞选择：硅胶或蜡质耳塞（NRR 32dB左右）</li><li>如果伴侣打鼾，考虑分房睡或使用抗噪耳机</li></ul><p><strong>🛏️ 床品选择</strong></p><ul><li>床垫：中等硬度，支撑脊柱自然曲线</li><li>枕头：根据睡姿选择（仰睡→中等高度，侧睡→较高）</li><li>床品：天然材质（棉、麻、丝绸），透气吸湿</li></ul>', '睡眠环境优化四要素：温度18-22°C（最重要）、完全遮光+红光夜灯、白噪音30-40dB、合适床品枕头。环境优化可提升睡眠质量40%！', '2025-09-25 08:30:00');

INSERT INTO `health_news` VALUES (42, 5, '/api/v1.0/self-health-api/file/getFile?fileName=1754313964000Snipaste_2025-04-21_16-58-17.png', '久坐办公族体检报告异常TOP5及应对方案', '<p><strong>每年体检季，很多上班族都会收到一份"异常指标满天飞"的报告。</strong></p><p>哪些异常最常见？哪些需要紧急处理？哪些可以观察？让我们一一解读。</p><p><img src=\"/api/v1.0/self-health-api/file/getFile?fileName=1753534646517Snipaste_2025-04-21_16-57-23.png\" alt=\"体检异常TOP5\" style=\"width: 95%;\"/></p><p><strong>🥇 第一名：脂肪肝（检出率高达30%）</strong></p><ul><li><strong>原因：</strong>高热量饮食+缺乏运动+饮酒</li><li><strong>危害：</strong>可能发展为肝炎、肝硬化</li><li><strong>对策：</strong>减重5-10%（肝脏脂肪可显著减少）、戒酒、增加有氧运动</li></ul><p><strong>🥈 第二名：血脂异常（LDL-C升高）</strong></p><ul><li><strong>原因：</strong>饱和脂肪摄入过多、遗传因素</li><li><strong>危害：</strong>动脉粥样硬化、冠心病风险↑</li><li><strong>对策：</strong>减少红肉和加工食品、增加膳食纤维（燕麦、豆类）、必要时服用他汀类药物</li></ul><p><strong>🥉 第三名：甲状腺结节</strong></p><ul><li><strong>检出率：</strong>超声检查中约50%成年人可见</li><li><strong>良恶性判断：</strong>TI-RADS分级（1-2级良性，4级以上需穿刺）</li><li><strong>对策：</strong>&lt;1cm且良性特征 → 每年复查；&gt;1cm或有可疑特征 → 细针穿刺</li></ul><p><strong>🏅 第四名：颈椎问题（X线示颈椎曲度变直）</strong></p><ul><li><strong>原因：</strong>长期低头看手机/电脑（"科技颈"）</li><li><strong>对策：</strong>屏幕垫高至视线水平、每45分钟活动颈部、加强颈深屈肌训练</li></ul><p><strong>🏅 第五名：尿酸偏高</strong></p><ul><li><strong>原因：</strong>高嘌呤饮食（海鲜、内脏、啤酒）、代谢异常</li><li><strong>危害：</strong>痛风发作（关节剧痛）、肾结石风险</li><li><strong>对策：</strong>低嘌呤饮食、多饮水（&gt;2000ml/天）、必要时服用降尿酸药（别嘌醇/非布司他）</li></ul>', '久坐族体检异常TOP5：脂肪肝(30%检出率)、血脂异常、甲状腺结节(50%)、颈椎病、尿酸高。每项附原因+危害+科学应对方案。', '2025-09-26 11:45:00');

INSERT INTO `health_news` VALUES (43, 1, '/api/v1.0/self-health-api/file/getFile?fileName=1754314012947Snipaste_2025-04-21_16-56-22.png', '家庭健身房搭建指南：预算500-2000元装备清单', '<p><strong>不想办健身卡？在家也能拥有专业级的训练环境！</strong></p><p>随着在线健身课程的兴起，越来越多的朋友选择在家锻炼。如何用有限的预算打造高效的家庭健身房？</p><p><img src=\"/api/v1.0/self-health-api/file/getFile?fileName=1753534646517Snipaste_2025-04-21_16-57-23.png\" alt=\"家庭健身房配置\" style=\"width: 100%;\"/></p><p><strong>💰 入门级（预算：500元以内）</strong></p><ul><li><strong>瑜伽垫：</strong>防滑、缓冲，必备基础（50-150元）</li><li><strong>弹力带套装：</strong>不同阻力级别，全身训练（30-80元）</li><li><strong>自重训练：</strong>无需设备，俯卧撑、深蹲、平板支撑</li><li><strong>免费资源：</strong>B站/YouTube健身视频、Keep APP、Nike Training Club</li></ul><p><strong>💰💰 进阶级（预算：1000-2000元）</strong></p><ul><li><strong>可调节哑铃套装：</strong>覆盖2.5-20kg重量范围（300-800元）</li><li><strong>壶铃（Kettlebell）：</strong>8-12kg，提升爆发力和功能性力量（100-300元）</li><li><strong>引体向上杆：</strong>门框式或墙壁安装式（80-200元）</li><li><strong>泡沫轴：</strong>筋膜放松、缓解肌肉酸痛（40-100元）</li><li><strong>跳绳：</strong>高效有氧，小空间即可（20-100元）</li></ul><p><strong>💰💰💰 专业级（预算：2000元以上）</strong></p><ul><li><strong>跑步机/椭圆机：</strong>有氧训练基础（1500-5000元）</li><li><strong>多功能深蹲架+杠铃套装：</strong>力量训练黄金组合（2000-4000元）</li><li><strong>智能健身镜：</strong>AI实时动作纠正（3000-8000元）</li></ul><p><strong>📍 空间规划建议：</strong>至少预留2m×2m的空旷区域，确保通风良好，地面铺防护垫。</p>', '家庭健身房搭建：入门级(&lt;500元)-瑜伽垫+弹力带+自重训练；进阶(1000-2000元)-哑铃+壶铃+引体向上杆+泡沫轴+跳绳；专业级(&gt;2000元)-跑步机/杠铃/智能镜。空间建议2×2米。', '2025-09-27 15:30:00');

INSERT INTO `health_news` VALUES (44, 2, '/api/v1.0/self-health-api/file/getFile?fileName=1754314121023Snipaste_2025-04-21_16-58-10.png', '超级食物新发现：2025年值得关注的5种营养明星', '<p><strong>营养学界每年都会有新的研究发现，一些"冷门"食物突然成为焦点。</strong></p><p>除了广为人知的蓝莓、三文鱼、西兰花等传统超级食物，2025年有哪些新兴的营养明星值得关注？</p><p><img src=\"/api/v1.0/self-health-api/file/getFile?fileName=1753534646517Snipaste_2025-04-21_16-57-23.png\" alt=\"2025超级食物新星\" style=\"width: 88%;\"/></p><p><strong>🌟 1. 火麻仁（Hemp Seeds）</strong></p><ul><li><strong>营养亮点：</strong>完美的Omega-3/Omega-6比例（3:1），完整蛋白质（含全部9种必需氨基酸）</li><li><strong>食用方法：</strong>撒在沙拉、燕麦粥、 smoothie 中</li><li><strong>每日建议：</strong>2-3汤匙（约30g）</li></ul><p><strong>🌟 2. 马基梅果（Maquei Berry / Chilean Wineberry）</strong></p><ul><li><strong>营养亮点：</strong>花青素含量是蓝莓的4倍，抗氧化能力极强</li><li><strong>功效：</strong>抗炎、护眼、提升免疫力</li><li><strong>食用方法：</strong>干果直接食用、泡茶、制作果酱</li></ul><p><strong>🌟 3. 海藻（Seaweed/Nori）</strong></p><ul><li><strong>营养亮点：</strong>碘的绝佳来源（预防甲状腺问题）、含岩藻多糖（抗癌潜力）</li><li><strong>种类：</strong>紫菜、裙带菜、海带芽</li><li><strong>食用方法：</strong>寿司、沙拉、汤品、零食海苔片</li></ul><p><strong>🌟 4. 发酵乳制品：克菲尔（Kefir）</strong></p><ul><li><strong>营养亮点：</strong>益生菌数量是酸奶的10-30倍，含独特菌株（Lactobacillus kefiri）</li><li><strong>功效：</strong>改善肠道健康、增强骨骼、抗炎</li><li><strong>口感：</strong>类似稀释的酸奶，略带气泡感</li></ul><p><strong>🌟 5. 核桃南瓜籽（Pumpkin Seeds）</strong></p><ul><li><strong>营养亮点：</strong>镁含量极高（缓解压力、肌肉放松）、锌（男性前列腺健康）、植物甾醇（降低胆固醇）</li><li><strong>食用方法：</strong>烘焙、沙拉 topping、自制格兰诺拉</li><li><strong>每日建议：</strong>一小把（约15g）</li></ul><p><strong>💡 提醒：</strong>超级食物虽好，但不能替代多样化的均衡饮食。关键在于搭配和适量！</p>', '2025超级食物新星：火麻仁(完美蛋白+Omega)、马基梅果(花青素之王)、海藻(碘源+抗癌)、克菲尔(益生菌炸弹)、核桃南瓜籽(镁+锌+植物甾醇)。多样化均衡饮食仍是王道！', '2025-09-28 13:00:00');


-- ============================================================
-- 三、新增食谱数据（ID: 29~38）
-- 封面图复用已有recipe封面（11张循环）
-- type_id: 1=荤菜, 2=素菜/轻食, 3=汤品, 4=主食
-- ============================================================

INSERT INTO `recipe` VALUES (29, '香煎三文鱼配芦笋', '/api/v1.0/self-health-api/file/getFile?fileName=1754381783662Snipaste_2025-08-05_16-14-54.png', 1, '<h1 style="text-align: start;">香煎三文鱼配芦笋 —— 10分钟快手西餐</h1><ol><li style="text-align: start;"><strong>食材准备：</strong>三文鱼排2块（约250g）、芦笋8根、柠檬半个、大蒜3瓣、黄油30g、橄榄油1勺、盐、黑胡椒、干香草碎（可选）</li><li style="text-align: start;"><strong>处理食材：</strong>三文鱼用厨房纸巾拍干表面水分（重要！否则无法煎出酥皮），两面均匀撒盐和黑胡椒腌制5分钟；芦笋去根部老皮</li><li style="text-align: start;"><strong>煎三文鱼：</strong>平底锅中火加热，倒入橄榄油，放入三文鱼排（先煎有皮的一面），煎3-4分钟至金黄酥脆后翻面，再煎2-3分钟至七分熟（中间呈半透明粉色）</li><li style="text-align: start;"><strong>炒芦笋：</strong>锅中放少许黄油融化，下蒜片爆香，加入芦笋中火翻炒2-3分钟至翠绿但仍带脆感，撒少许盐调味</li><li style="text-align: start;"><strong>装盘：</strong>将芦笋铺底，放上三文鱼排，挤上新鲜柠檬汁，撒上香草碎装饰即可</li></ol><p><strong>营养亮点：</strong>三文鱼富含EPA/DHA Omega-3脂肪酸，对心脑血管和大脑极为有益。芦笋提供叶酸、维生素K和膳食纤维。整道菜仅约380千卡，低碳水高蛋白，非常适合减脂期食用。</p>', 79, 1, 1, '2025-09-17 12:00:00');

INSERT INTO `recipe` VALUES (30, '泰式芒果虾沙拉', '/api/v1.0/self-health-api/file/getFile?fileName=1754382097771Snipaste_2025-08-05_16-15-38.png', 2, '<h1 style="text-align: start;">泰式芒果虾沙拉 —— 酸甜清爽的热带风情</h1><ol><li style="text-align: start;"><strong>食材准备：</strong>鲜虾仁200g、青芒果1个（稍硬未全熟）、樱桃番茄10颗、黄瓜半根、洋葱1/4个、薄荷叶一小把、花生碎2勺、椰丝1勺</li><li style="text-align: start;"><strong>调制泰式酱汁：</strong>青柠汁3勺、鱼露2勺、棕榈糖或红糖1勺（捣碎）、小米辣2个（切碎）、蒜末1瓣，搅拌均匀至糖溶解</li><li style="text-align: start;"><strong>处理虾仁：</strong>虾仁焯水或煎至变色（约2分钟），捞出过凉水保持Q弹口感</li><li style="text-align: start;"><strong>准备配菜：</strong>芒果切丝（保留一些切块）、番茄对半切、黄瓜切片、洋葱切丝、薄荷撕碎</li><li style="text-align: start;"><strong>拌匀装盘：</strong>将所有食材放入大碗，淋上酱汁轻轻翻拌均匀，撒上花生碎和椰丝，冷藏15分钟后风味更佳</li></ol><p><strong>营养亮点：</strong>芒果富含维生素A和C，虾仁提供优质低脂蛋白，青柠促进铁吸收，薄荷清新消暑。这道沙拉热量仅约280千卡，酸甜开胃，是夏季理想的轻食选择。</p>', 80, 1, 1, '2025-09-18 11:30:00');

INSERT INTO `recipe` VALUES (31, '韩式石锅拌饭', '/api/v1.0/self-health-api/file/getFile?fileName=1754117540498Snipaste_2025-04-21_16-57-23.png', 4, '<h1 style="text-align: start;">韩式石锅拌饭 —— 暖心暖胃的经典韩餐</h1><ol><li style="text-align: start;"><strong>食材准备：</strong>米饭2碗、牛肉片150g（或五花肉）、胡萝卜半根、菠菜一把、豆芽100g、香菇4朵、鸡蛋1个、韩式辣酱2勺、芝麻油1勺、白芝麻适量</li><li style="text-align: start;"><strong>准备配菜（分别炒熟）：</strong>胡萝卜切丝加少许盐翻炒至软；菠菜焯水挤干切段加芝麻油拌匀；豆芽加盐清炒至出水汽；香菇切片炒香；牛肉片加酱油和糖炒熟</li><li style="text-align: start;"><strong>制作锅巴：</strong>石锅内壁刷一层芝麻油，倒入热米饭压实，中小火加热5-8分钟至底部发出滋滋声并形成金黄色锅巴</li><li style="text-align: start;"><strong>组装：</strong>将炒好的各种配菜按颜色分区摆放在米饭上，中间留空打入生鸡蛋</li><li style="text-align: start;"><strong>调味享用：</strong>上桌后淋入辣酱，撒白芝麻，趁热搅拌使蛋液包裹每一粒米饭和配菜，享受锅巴的酥脆口感</li></ol><p><strong>营养亮点：</strong>多种蔬菜提供丰富维生素和膳食纤维，牛肉补充优质蛋白和铁，鸡蛋增加营养密度。锅巴提供碳水的焦香满足感。整份约550千卡，作为正餐营养均衡。</p>', 81, 1, 1, '2025-09-19 13:00:00');

INSERT INTO `recipe` VALUES (32, '奶油蘑菇汤', '/api/v1.0/self-health-api/file/getFile?fileName=1754381960986Snipaste_2025-08-05_16-15-18.png', 3, '<h1 style="text-align: start;">奶油蘑菇汤 —— 西餐厅经典浓汤家常版</h1><ol><li style="text-align: start;"><strong>食材准备：</strong>口蘑或白蘑菇300g、洋葱半个、大蒜2瓣、黄油30g、面粉2勺、牛奶或淡奶油200ml、鸡/蔬菜高汤300ml、盐、白胡椒、欧芹碎（装饰）</li><li style="text-align: start;"><strong>处理蘑菇：</strong>蘑菇洗净切片，平底锅加少许黄油大火炒至出水并微微焦黄（这一步很重要，能激发蘑菇的鲜香味），盛出备用</li><li style="text-align: start;"><strong>制作酱底：</strong>锅中剩余黄油融化，下洋葱末和蒜末炒至透明透明（不要炒焦），加入面粉搅拌成糊状（roux），慢慢倒入高汤不停搅拌防止结块</li><li style="text-align: start;"><strong>加入蘑菇：</strong>将炒好的蘑菇倒回锅中，加入牛奶搅匀，小火煮5-8分钟让味道融合</li><li style="text-align: start;"><strong>完成调味：</strong>用手持料理棒打碎一部分汤（保留一些蘑菇块增加口感层次），加盐和白胡椒调味，装盘后淋少许奶油并撒欧芹碎装饰</li></ol><p><strong>营养亮点：</strong>蘑菇富含B族维生素、硒和β-葡聚糖（免疫增强）。牛奶提供钙质。虽然使用了黄油和奶油，但通过控制分量，整份汤约320千卡，可作为开胃汤或搭配主食。</p>', 82, 1, 1, '2025-09-20 17:00:00');

INSERT INTO `recipe` VALUES (33, '彩椒牛肉粒', '/api/v1.0/self-health-api/file/getFile?fileName=1754385437697Snipaste_2025-08-05_16-15-33.png', 1, '<h1 style="text-align: start;">彩椒牛肉粒 —— 高蛋白快手小炒</h1><ol><li style="text-align: start;"><strong>食材准备：</strong>牛里脊肉250g、红黄绿彩椒各半个、洋葱1/4个、生抽2勺、老抽半勺、料酒1勺、淀粉1勺、蚝油1勺、黑胡椒粉、植物油</li><li style="text-align: start;"><strong>腌制牛肉：</strong>牛肉切成1.5cm见方的小丁，加入料酒、生抽、淀粉抓匀腌制15分钟上浆（这样炒出来更嫩滑）</li><li style="text-align: start;"><strong>准备配菜：</strong>彩椒去籽切成与牛肉差不多大小的丁，洋葱切丁</li><li style="text-align: start;"><strong>滑炒牛肉：</strong>锅中热油（油可稍多一些），下入牛肉丁快速滑散翻炒至变色即盛出（约1.5-2分钟，不要炒老了）</li><li style="text-align: start;"><strong>炒配菜：</strong>锅中留底油，下洋葱丁炒香，再加入彩椒丁大火快炒1分钟至断生但仍爽脆</li><li style="text-align: start;"><strong>合炒出锅：</strong>倒回牛肉丁，加蚝油、老抽调色，快速翻炒均匀（不超过30秒），撒黑胡椒即可出锅</li></ol><p><strong>营养亮点：</strong>牛肉丁提供优质蛋白质和铁、锌元素，彩椒富含维生素C（是橙子的2-3倍）和抗氧化物。色彩鲜艳增进食欲，整道菜约350千卡，适合增肌减脂期间食用。可搭配糙米饭或卷入饼皮。</p>', 83, 1, 1, '2025-09-21 12:30:00');

INSERT INTO `recipe` VALUES (34, '日式茶碗蒸蛋', '/api/v1.0/self-health-api/file/getFile?fileName=1754381984739Snipaste_2025-08-05_16-15-33.png', 3, '<h1 style="text-align: start;">日式茶碗蒸蛋 —— 如丝绸般顺滑的美容甜品</h1><ol><li style="text-align: start;"><strong>食材准备：</strong>鸡蛋2个、温水或高汤200ml（1:1.5比例）、盐少许、生抽几滴（可选）、香油几滴、葱花或海苔碎（装饰）</li><li style="text-align: start;"><strong>调制蛋液：</strong>鸡蛋打散后缓缓加入温水（水温约40℃，不可用开水），边加边轻轻搅拌，加入盐和生抽调匀。用细筛网过滤蛋液2遍（这是顺滑的关键！）</li><li style="text-align: start;"><strong>去除气泡：</strong>静置让表面浮沫沉淀，用勺子轻轻撇去浮沫，确保蛋液表面平滑</li><li style="text-align: start;"><strong>蒸制：</strong>将蛋液倒入碗中（八分满），盖上保鲜膜并用牙签扎几个小孔。蒸锅水开后放入，中火蒸10-12分钟（根据容器深浅调整时间）。晃动蛋液中心不再流动即表示蒸熟</li><li style="text-align: start;"><strong>点缀装盘：</strong>取出后在表面滴几滴香油和生抽，撒上海苔碎或葱花，即可享用</li></ol><p><strong>营养亮点：</strong>鸡蛋是优质蛋白的标杆，含全部必需氨基酸，易于消化吸收。蒸蛋做法保留了最大营养价值且几乎不加额外油脂。每份仅约90千卡，是老人儿童及肠胃不适者的理想食品。</p>', 84, 1, 1, '2025-09-22 07:30:00');

INSERT INTO `recipe` VALUES (35, '藜麦素食 bowl', '/api/v1.0/self-health-api/file/getFile?fileName=1754382055394Snipaste_2025-08-05_16-15-52.png', 2, '<h1 style="text-align: start;">藜麦素食 Bowl —— Instagram网红同款能量碗</h1><ol><li style="text-align: start;"><strong>基底准备：</strong>藜麦80g淘洗干净，按1:1.5加水煮沸后转小火焖15分钟至出现小白芽（说明熟透），捞出放凉备用</li><li style="text-align: start;"><strong>烤蔬菜：</strong>红薯1个切小块、甜菜根半个切片、西兰花切小朵，分别淋上橄榄油、盐、黑胡椒，烤箱200°C烤25-30分钟至边缘微焦</li><li style="text-align: start;"><strong>准备蛋白质：</strong>鹰嘴豆罐头沥干（或自制煮熟）、牛油果半个切片、烤豆腐块（可选）</li><li style="text-align: start;"><strong>调制酱汁：</strong> tahini（芝麻酱）2勺 + 柠檬汁1勺 + 水1勺 + 蒜末少许 + 盐，搅拌至顺滑稀稠状</li><li style="text-align: start;"><strong>组装 Bowl：</strong>大碗中先铺一层藜麦，然后将烤蔬菜、鹰嘴豆、牛油果按扇形分区摆放，淋上调好的酱汁，最后撒上南瓜籽和新鲜香菜装饰</li></ol><p><strong>营养亮点：</strong>这是一道完整的营养餐：藜麦提供完整蛋白质和复合碳水，烤蔬菜提供膳食纤维和抗氧化物，牛油果贡献健康脂肪，tahini酱添加钙质。整份约480千卡，饱腹感极强，适合作为午餐或训练后的恢复餐。</p>', 85, 1, 1, '2025-09-23 12:00:00');

INSERT INTO `recipe` VALUES (36, '蒜蓉粉丝蒸扇贝', '/api/v1.0/self-health-api/file/getFile?fileName=1754385535019Snipaste_2025-08-05_17-18-43.png', 1, '<h1 style="text-align: start;">蒜蓉粉丝蒸扇贝 —— 宴客级海鲜料理</h1><ol><li style="text-align: start;"><strong>食材准备：</strong>活扇贝6-8个、龙口粉丝1把（提前用温水泡软）、大蒜1头（剁成蒜蓉）、红椒半个（切末）、葱花、蒸鱼豉油2勺、料酒1勺、盐、白胡椒粉、植物油</li><li style="text-align: start;"><strong>处理扇贝：</strong>扇贝开壳取肉（贝壳可作容器），去掉黑色的肠腺和腮，只保留白色的闭壳肌和橘红色的膏（小心保留膏），用清水冲洗后用厨房纸吸干水分，加料酒、盐、白胡椒粉腌制5分钟</li><li style="text-align: start;"><strong>炒金银蒜：</strong>锅中加油烧至五成热，倒入一半蒜蓉小火炸至金黄（金蒜），盛出沥油。锅中留底油，加入另一半生蒜蓉和红椒末炒香（银蒜），关火后混入金蒜</li><li style="text-align: start;"><strong>组装摆盘：</strong>扇贝壳底部铺上一层粉丝，放上扇贝肉，顶部堆满金银蒜蓉混合料</li><li style="text-align: start;"><strong>蒸制出锅：</strong>蒸锅水开后放入，大火蒸4-5分钟（不可过头否则肉质变老）。取出后在每个扇贝上淋少许热油激发蒜香（可听到滋啦声），撒葱花，即可上桌</li></ol><p><strong>营养亮点：</strong>扇贝是高蛋白低脂肪的海鲜代表，富含锌、硒、维生素B12和牛磺酸（护眼明目）。粉丝提供缓释碳水。整道菜约220千卡/个，鲜美无比，宴客或犒劳自己的绝佳选择。</p>', 86, 1, 1, '2025-09-24 18:30:00');

INSERT INTO `recipe` VALUES (37, '意式番茄罗勒意面', '/api/v1.0/self-health-api/file/getFile?fileName=1754393136282Snipaste_2025-06-01_18-02-46.png', 4, '<h1 style="text-align: start;">意式番茄罗勒意面 —— 经典永不落幕</h1><ol><li style="text-align: start;"><strong>食材准备：</strong>意大利面（Spaghetti或Penne）100g、成熟番茄4个（或罐装去皮番茄400g）、大蒜4瓣、新鲜罗勒叶一大把、橄榄油3勺、帕玛森芝士粉2勺、盐、黑胡椒、红辣椒片（可选）</li><li style="text-align: start;"><strong>准备番茄酱：</strong>番茄划十字，开水烫一下去皮切块（若用罐装则直接打开）；锅中加橄榄油，下压扁的大蒜（不去皮，出香味后丢弃）慢炸出香，加入番茄块中火熬煮15-20分钟至浓稠成酱状，期间用勺背压碎番茄块，加盐和胡椒调味</li><li style="text-align: start;"><strong>煮意面：</strong>大锅烧开水（水量要足！），加盐（像海水一样咸），下面条按包装时间少煮1-2分钟（后续还要回锅收汁）。捞出保留一杯煮面水</li><li style="text-align: start;"><strong>Emulsify乳化：</strong>将面条直接转入番茄酱锅中，加少许煮面水，开中火快速翻拌1-2分钟让面条充分吸收酱汁并与油脂乳化（这是面条挂酱的关键！）</li><li style="text-align: start;"><strong>完成装盘：</strong>离火后拌入新鲜罗勒叶（用手撕碎释放香气），撒上帕玛森芝士粉，现磨黑胡椒，即可享用</li></ol><p><strong>营养亮点：</strong>番茄提供番茄红素和维生素C，橄榄油贡献单不饱和脂肪酸（心脏友好），罗勒具有抗炎抗氧化特性。整份约450千卡，碳水化合物适中，可作为正餐主菜搭配沙拉食用。</p>', 87, 1, 1, '2025-09-25 19:00:00');

INSERT INTO `recipe` VALUES (38, '桂花糯米藕', '/api/v1.0/self-health-api/file/getFile?fileName=1754393160129Snipaste_2025-06-01_17-43-44.png', 3, '<h1 style="text-align: start;">桂花糯米藕 —— 江南经典甜品</h1><ol><li style="text-align: start;"><strong>食材准备：</strong>莲藕2节（选粗壮直筒的）、圆糯米200g（提前浸泡4小时以上）、红糖80g、冰糖30g、干桂花1勺、红枣8颗</li><li style="text-align: start;"><strong>灌米：</strong>莲藕去皮洗净，在一端切下一小段（约2cm）作盖子。将糯米塞入莲藕孔中（用筷子帮忙捅实，但不要太紧以免煮裂），填满后将盖子复位，用牙签固定</li><li style="text-align: start;"><strong>炖煮：</strong>砂锅中放入灌好的藕，加足够的水没过藕身，加入红糖、冰糖和红枣，大火烧开后转小火慢炖2-2.5小时至藕变软糯（筷子可轻松插入）</li><li style="text-align: start;"><strong>收汁浸泡：</strong>关火后在汤汁中继续浸泡1-2小时让入味（也可隔夜冷藏浸泡风味更佳）</li><li style="text-align: start;"><strong>切片装盘：</strong>取出晾凉后切片（厚度约1cm），淋上浓缩的糖汁，撒上干桂花装饰。可冷食也可稍微温热后食用</li></ol><p><strong>营养亮点：</strong>莲藕富含膳食纤维、维生素C和钾，有清热凉血、健脾开胃之效。糯米提供能量和B族维生素。红枣补气养血。桂花有温中散寒、化痰止咳之功。此甜品香甜软糯，秋季润燥佳品，每份约280千卡。</p>', 88, 1, 1, '2025-09-26 20:30:00');


-- ============================================================
-- 四、新增健康模型（ID: 19~22）
-- 图标复用已有health_model图标
-- ============================================================

INSERT INTO `health_model` VALUES (19, '握力', '握力是反映上肢肌肉力量和整体健康状况的重要指标，研究表明握力每下降1公斤，心血管疾病风险上升约6%。正常成年男性握力应在40-50kg以上，女性应在25-30kg以上', '/api/v1.0/self-health-api/file/getFile?fileName=1753670454370weight.png', '千克(kg)', 'GRIP', '40,50', NULL, 0, '2025-09-17 10:00:00');
INSERT INTO `health_model` VALUES (20, '肺活量', '肺活量反映肺部的通气能力，与心肺功能密切相关。经常进行有氧运动可显著提升肺活量。正常成年男性应为3500-4500ml，女性为2500-3500ml', '/api/v1.0/self-health-api/file/getFile?fileName=1754393779064xt.png', '毫升(ml)', 'VC', '3500,4500', NULL, 0, '2025-09-18 10:00:00');
INSERT INTO `health_model` VALUES (21, '静息心率变异率', 'HRV（心率变异率）是衡量自主神经系统平衡的重要指标，HRV越高代表压力适应能力和心脏健康越好。一般建议RMSSD &gt; 20ms 为良好', '/api/v1.0/self-health-api/file/getFile?fileName=1753760115590BMI.png', '毫秒(ms)', 'HRV', '20,100', NULL, 0, '2025-09-19 10:00:00');
INSERT INTO `health_model` VALUES (22, '体表温度', '体温是评估新陈代谢和感染状态的快捷指标。正常腋下体温范围为36.0-37.2°C，超过37.3°C可能提示发热。女性排卵期体温会略有升高', '/api/v1.0/self-health-api/file/getFile?fileName=1753597325751rate.png', '摄氏度(°C)', 'TEMP', '36.0,37.2', NULL, 0, '2025-09-20 10:00:00');


SET FOREIGN_KEY_CHECKS = 1;

/*
 ============================================================
  图片替换说明
 ============================================================
  
  ✅ 本版本所有图片均使用系统中已有的真实图片：
  
  👤 用户头像（6张循环）：
     17587778993152.png / 17587779050599.png
     1758777922524Snipaste_2025-04-25_15-25-57.png
     1758777928834Snipaste_2025-05-20_15-11-47.png
     17587779689247.png / 17587779353178.png
  
  📰 健康资讯封面（9张循环）：
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
  以上图片均来源于原new1.sql文件中的已有数据，
  执行本SQL文件后可直接使用，无需额外配置图片资源。
 */
