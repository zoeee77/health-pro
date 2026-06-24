package com.kmbeast.agent.skills;

import com.kmbeast.agent.HealthProfile;
import org.springframework.stereotype.Component;

/**
 * 睡眠分析技能
 * 分析用户睡眠相关的健康指标并提供改善建议
 */
@Component
public class SleepAnalysisSkill implements HealthSkill {

    @Override
    public String analyze(HealthProfile profile) {
        StringBuilder sb = new StringBuilder();
        sb.append("【睡眠分析上下文】\n");

        if (profile == null) {
            sb.append("暂无用户档案数据。\n");
            return sb.toString();
        }

        // 基本信息
        if (profile.getAge() != null) {
            sb.append("年龄：").append(profile.getAge()).append("岁\n");
        }

        // 查找与睡眠相关的健康指标
        if (profile.getVitalSigns() != null && !profile.getVitalSigns().isEmpty()) {
            sb.append("相关健康指标：\n");
            boolean foundSleepRelated = false;
            for (HealthProfile.MetricTrend mt : profile.getVitalSigns()) {
                if (isSleepRelated(mt.getModelName())) {
                    foundSleepRelated = true;
                    sb.append(String.format("- %s: %.1f %s (趋势: %s, 评估: %s)\n",
                            mt.getModelName(), mt.getLatestValue(),
                            mt.getUnit(), mt.getTrend(), mt.getEvaluation()));

                    if ("abnormal".equals(mt.getEvaluation())) {
                        sb.append(String.format("  → %s指标异常，可能影响睡眠质量。\n", mt.getModelName()));
                    }
                }
            }
            if (!foundSleepRelated) {
                sb.append("暂无直接相关的睡眠指标记录。\n");
            }
        } else {
            sb.append("暂无健康指标记录。\n");
        }

        // 饮食对睡眠的影响
        if (profile.getRecentDietSummary() != null && !profile.getRecentDietSummary().isEmpty()) {
            sb.append("\n近期饮食情况（可能影响睡眠）：\n");
            sb.append("建议关注晚餐时间与内容，避免睡前摄入过多咖啡因和高糖食物。\n");
        }

        return sb.toString();
    }

    /**
     * 判断指标是否与睡眠相关
     */
    private boolean isSleepRelated(String modelName) {
        if (modelName == null) return false;
        String name = modelName.toLowerCase();
        return name.contains("心率") || name.contains("血压") || name.contains("血氧")
                || name.contains("呼吸") || name.contains("压力");
    }
}
