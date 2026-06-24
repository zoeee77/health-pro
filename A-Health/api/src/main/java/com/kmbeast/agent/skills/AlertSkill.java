package com.kmbeast.agent.skills;

import com.kmbeast.agent.HealthProfile;
import org.springframework.stereotype.Component;

/**
 * 异常预警技能
 * 检测用户健康指标中的异常值并发出预警
 */
@Component
public class AlertSkill implements HealthSkill {

    @Override
    public String analyze(HealthProfile profile) {
        StringBuilder sb = new StringBuilder();
        sb.append("【异常预警上下文】\n");

        if (profile == null) {
            sb.append("暂无用户档案数据。\n");
            return sb.toString();
        }

        boolean hasAlert = false;

        // 检查所有健康指标的异常状态
        if (profile.getVitalSigns() != null && !profile.getVitalSigns().isEmpty()) {
            for (HealthProfile.MetricTrend mt : profile.getVitalSigns()) {
                if ("abnormal".equals(mt.getEvaluation())) {
                    hasAlert = true;
                    sb.append(String.format("⚠ 预警: %s 指标异常\n", mt.getModelName()));
                    sb.append(String.format("  当前值: %.1f %s\n", mt.getLatestValue(), mt.getUnit()));
                    sb.append(String.format("  趋势: %s\n", mt.getTrend()));

                    // 根据指标类型给出预警级别
                    String level = getAlertLevel(mt.getModelName(), mt.getLatestValue());
                    sb.append(String.format("  预警级别: %s\n", level));
                }
            }
        }

        if (!hasAlert) {
            sb.append("当前所有指标均在正常范围内，无异常预警。\n");
        }

        return sb.toString();
    }

    /**
     * 根据指标名称和值判断预警级别
     */
    private String getAlertLevel(String modelName, Double value) {
        if (modelName == null || value == null) return "未知";
        String name = modelName.toLowerCase();

        if (name.contains("血压")) {
            if (value > 180 || value < 60) return "高";
            if (value > 140 || value < 80) return "中";
            return "低";
        }
        if (name.contains("血糖") || name.contains("blood sugar") || name.contains("glucose")) {
            if (value > 16.7 || value < 2.8) return "高";
            if (value > 7.0 || value < 3.9) return "中";
            return "低";
        }
        if (name.contains("心率")) {
            if (value > 120 || value < 50) return "高";
            if (value > 100 || value < 60) return "中";
            return "低";
        }

        return "低";
    }
}
