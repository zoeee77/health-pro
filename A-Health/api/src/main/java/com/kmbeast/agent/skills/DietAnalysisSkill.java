package com.kmbeast.agent.skills;

import com.kmbeast.agent.HealthProfile;
import org.springframework.stereotype.Component;

/**
 * 饮食分析技能
 * 根据用户的饮食记录和健康指标进行饮食方面的分析
 */
@Component
public class DietAnalysisSkill implements HealthSkill {

    @Override
    public String analyze(HealthProfile profile) {
        StringBuilder sb = new StringBuilder();
        sb.append("【饮食分析上下文】\n");

        if (profile == null) {
            sb.append("暂无用户档案数据。\n");
            return sb.toString();
        }

        // 分析饮食记录
        if (profile.getRecentDietSummary() != null && !profile.getRecentDietSummary().isEmpty()) {
            sb.append("近期饮食记录：\n").append(profile.getRecentDietSummary()).append("\n");
        } else {
            sb.append("近期无饮食记录，建议用户坚持记录饮食。\n");
        }

        // 结合健康指标给出饮食相关提示
        if (profile.getVitalSigns() != null && !profile.getVitalSigns().isEmpty()) {
            sb.append("相关健康指标：\n");
            for (HealthProfile.MetricTrend mt : profile.getVitalSigns()) {
                if (isDietRelated(mt.getModelName())) {
                    sb.append(String.format("- %s: %.1f %s (趋势: %s, 评估: %s)\n",
                            mt.getModelName(), mt.getLatestValue(),
                            mt.getUnit(), mt.getTrend(), mt.getEvaluation()));
                    if ("abnormal".equals(mt.getEvaluation())) {
                        sb.append(String.format("  → %s指标异常，需要注意饮食调整。\n", mt.getModelName()));
                    }
                }
            }
        }

        return sb.toString();
    }

    /**
     * 判断指标是否与饮食相关
     */
    private boolean isDietRelated(String modelName) {
        if (modelName == null) return false;
        String name = modelName.toLowerCase();
        return name.contains("血糖") || name.contains("血脂") || name.contains("胆固醇")
                || name.contains("尿酸") || name.contains("bmi") || name.contains("体重")
                || name.contains("血压") || name.contains("甘油");
    }
}
