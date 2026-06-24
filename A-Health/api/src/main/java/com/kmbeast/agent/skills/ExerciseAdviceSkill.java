package com.kmbeast.agent.skills;

import com.kmbeast.agent.HealthProfile;
import org.springframework.stereotype.Component;

/**
 * 运动建议技能
 * 根据用户健康档案提供个性化的运动建议
 */
@Component
public class ExerciseAdviceSkill implements HealthSkill {

    @Override
    public String analyze(HealthProfile profile) {
        StringBuilder sb = new StringBuilder();
        sb.append("【运动建议上下文】\n");

        if (profile == null) {
            sb.append("暂无用户档案数据。\n");
            return sb.toString();
        }

        // 基本信息
        if (profile.getAge() != null) {
            sb.append("年龄：").append(profile.getAge()).append("岁\n");
        }
        if (profile.getGender() != null) {
            sb.append("性别：").append(profile.getGender() == 1 ? "女" : "男").append("\n");
        }

        // 基于健康指标的运动建议提示
        if (profile.getVitalSigns() != null && !profile.getVitalSigns().isEmpty()) {
            sb.append("当前健康指标：\n");
            for (HealthProfile.MetricTrend mt : profile.getVitalSigns()) {
                sb.append(String.format("- %s: %.1f %s (趋势: %s, 评估: %s)\n",
                        mt.getModelName(), mt.getLatestValue(),
                        mt.getUnit(), mt.getTrend(), mt.getEvaluation()));

                // 根据指标类型给出运动提示
                String advice = getExerciseHint(mt.getModelName(), mt.getEvaluation());
                if (advice != null) {
                    sb.append("  → ").append(advice).append("\n");
                }
            }
        } else {
            sb.append("暂无健康指标记录。\n");
        }

        return sb.toString();
    }

    /**
     * 根据指标名称和评估结果获取运动建议提示
     */
    private String getExerciseHint(String modelName, String evaluation) {
        if (modelName == null) return null;
        String name = modelName.toLowerCase();
        boolean abnormal = "abnormal".equals(evaluation);

        if (name.contains("血压")) {
            return abnormal ? "血压异常，建议进行低强度有氧运动如散步，避免剧烈运动。"
                    : "血压正常，可进行中强度有氧运动，如快走、慢跑。";
        }
        if (name.contains("心率")) {
            return abnormal ? "心率异常，建议先休息观察，必要时就医。" : "心率正常，适合进行有氧训练。";
        }
        if (name.contains("bmi") || name.contains("体重")) {
            return abnormal ? "体重超标，建议增加有氧运动量并结合饮食控制。" : "体重正常，保持当前运动习惯即可。";
        }
        if (name.contains("血糖")) {
            return abnormal ? "血糖异常，建议饭后30分钟进行适度运动帮助降糖。" : "血糖正常，规律运动有助于维持血糖稳定。";
        }
        return null;
    }
}
