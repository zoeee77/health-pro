package com.kmbeast.agent;

import org.springframework.stereotype.Component;

/**
 * 意图识别器
 * 通过关键词匹配识别用户消息的意图类型
 */
@Component
public class IntentRecognizer {

    // 饮食相关关键词
    private static final String[] DIET_KEYWORDS = {
            "饮食", "吃饭", "食物", "营养", "热量", "卡路里",
            "早餐", "午餐", "晚餐", "零食", "蔬菜", "水果",
            "减肥", "节食", "摄入", "消化", "胃口", "饱腹",
            "吃", "喝", "餐", "饭", "肉", "菜", "糖", "盐", "油",
            "饮食分析", "吃什么", "怎么吃", "食谱", "菜单"
    };

    // 运动相关关键词
    private static final String[] EXERCISE_KEYWORDS = {
            "运动", "锻炼", "健身", "跑步", "游泳", "瑜伽",
            "有氧", "无氧", "力量", "肌肉", "体能", "训练",
            "拉伸", "热身", "体育", "步数", "消耗", "减肥运动",
            "怎么运动", "运动建议", "运动量", "心率运动", "骑行",
            "爬山", "打球", "跳绳"
    };

    // 睡眠相关关键词
    private static final String[] SLEEP_KEYWORDS = {
            "睡眠", "睡觉", "失眠", "熬夜", "入睡", "午睡",
            "困", "疲倦", "做梦", "睡眠质量", "早睡", "晚睡",
            "作息", "生物钟", "睡不", "睡不着", "睡眠分析",
            "打鼾", "嗜睡", "清醒", "休息"
    };

    // 医疗提醒相关关键词
    private static final String[] MEDICAL_KEYWORDS = {
            "吃药", "服药", "用药", "打针", "输液", "手术",
            "复诊", "体检", "疫苗", "挂号", "看病", "医院",
            "提醒", "按时", "剂量", "处方", "药物", "过敏",
            "医生", "治疗", "症状", "疼痛", "发烧", "感冒",
            "咳嗽", "头晕", "恶心", "血压药", "降糖", "慢性病"
    };

    // 健康报告相关关键词
    private static final String[] REPORT_KEYWORDS = {
            "报告", "总结", "分析", "指标", "趋势", "健康状态",
            "健康评估", "数据", "统计", "健康报告", "身体报告",
            "查看健康", "我的健康", "身体情况", "身体状况",
            "最近怎么样", "健康状况", "体检报告", "周报告", "月报告"
    };

    /**
     * 识别用户消息的意图类型
     *
     * @param message 用户消息
     * @return 识别到的意图类型
     */
    public IntentType recognize(String message) {
        if (message == null || message.trim().isEmpty()) {
            return IntentType.GENERAL_CHAT;
        }

        String lowerMsg = message.toLowerCase();

        // 按优先级依次匹配（报告优先于通用分析）
        if (matchesAny(lowerMsg, REPORT_KEYWORDS)) {
            return IntentType.HEALTH_REPORT;
        }
        if (matchesAny(lowerMsg, DIET_KEYWORDS)) {
            return IntentType.DIET_ANALYSIS;
        }
        if (matchesAny(lowerMsg, EXERCISE_KEYWORDS)) {
            return IntentType.EXERCISE_ADVICE;
        }
        if (matchesAny(lowerMsg, SLEEP_KEYWORDS)) {
            return IntentType.SLEEP_ANALYSIS;
        }
        if (matchesAny(lowerMsg, MEDICAL_KEYWORDS)) {
            return IntentType.MEDICAL_REMINDER;
        }

        // 默认普通聊天
        return IntentType.GENERAL_CHAT;
    }

    /**
     * 检查消息是否包含关键词数组中的任意一个
     */
    private boolean matchesAny(String message, String[] keywords) {
        for (String keyword : keywords) {
            if (message.contains(keyword)) {
                return true;
            }
        }
        return false;
    }
}
