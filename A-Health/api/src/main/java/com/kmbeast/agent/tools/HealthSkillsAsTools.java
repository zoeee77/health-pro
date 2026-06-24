package com.kmbeast.agent.tools;

import com.kmbeast.agent.HealthProfile;
import com.kmbeast.agent.HealthProfileBuilder;
import com.kmbeast.agent.skills.AlertSkill;
import com.kmbeast.agent.skills.DietAnalysisSkill;
import com.kmbeast.agent.skills.ExerciseAdviceSkill;
import com.kmbeast.agent.skills.SleepAnalysisSkill;
import lombok.RequiredArgsConstructor;
import org.springframework.ai.tool.annotation.Tool;
import org.springframework.ai.tool.annotation.ToolParam;
import org.springframework.stereotype.Component;

/**
 * 将现有 HealthSkill 实现包装为 Spring AI @Tool
 * Phase 3: Function Calling 集成
 *
 * LLM 可以在对话中自动调用这些工具来分析用户健康数据
 */
@Component
@RequiredArgsConstructor
public class HealthSkillsAsTools {

    private final HealthProfileBuilder profileBuilder;
    private final DietAnalysisSkill dietAnalysisSkill;
    private final ExerciseAdviceSkill exerciseAdviceSkill;
    private final SleepAnalysisSkill sleepAnalysisSkill;
    private final AlertSkill alertSkill;

    /**
     * 分析用户近期饮食记录并给出评价
     */
    @Tool(description = "分析用户近期的饮食记录，评估营养摄入情况并给出饮食建议。适用于用户询问饮食、营养、热量、减肥餐等问题。")
    public String analyzeDiet(@ToolParam(description = "用户ID") Integer userId) {
        HealthProfile profile = profileBuilder.build(userId);
        return dietAnalysisSkill.analyze(profile);
    }

    /**
     * 分析用户运动习惯并给出建议
     */
    @Tool(description = "分析用户的运动习惯和健康记录，提供个性化的运动建议。适用于用户询问运动、锻炼、健身、减肥运动等问题。")
    public String analyzeExercise(@ToolParam(description = "用户ID") Integer userId) {
        HealthProfile profile = profileBuilder.build(userId);
        return exerciseAdviceSkill.analyze(profile);
    }

    /**
     * 分析用户睡眠质量
     */
    @Tool(description = "分析用户的睡眠质量、作息规律，并提供改善建议。适用于用户询问睡眠、失眠、熬夜、作息、疲倦等问题。")
    public String analyzeSleep(@ToolParam(description = "用户ID") Integer userId) {
        HealthProfile profile = profileBuilder.build(userId);
        return sleepAnalysisSkill.analyze(profile);
    }

    /**
     * 生成健康预警和提醒
     */
    @Tool(description = "检查用户的健康指标异常，生成健康预警和医疗提醒。适用于用户询问吃药提醒、指标异常、慢性病管理等问题。")
    public String generateHealthAlert(@ToolParam(description = "用户ID") Integer userId) {
        HealthProfile profile = profileBuilder.build(userId);
        return alertSkill.analyze(profile);
    }

    /**
     * 综合健康报告（组合所有技能）
     */
    @Tool(description = "综合分析用户的所有健康数据，生成完整的健康报告，包括饮食、运动、睡眠和预警信息。适用于用户请求健康报告、身体分析、数据总结等场景。")
    public String generateHealthReport(@ToolParam(description = "用户ID") Integer userId) {
        HealthProfile profile = profileBuilder.build(userId);
        StringBuilder sb = new StringBuilder();
        sb.append("【饮食分析】\n").append(dietAnalysisSkill.analyze(profile)).append("\n\n");
        sb.append("【运动建议】\n").append(exerciseAdviceSkill.analyze(profile)).append("\n\n");
        sb.append("【睡眠分析】\n").append(sleepAnalysisSkill.analyze(profile)).append("\n\n");
        sb.append("【健康预警】\n").append(alertSkill.analyze(profile)).append("\n");
        return sb.toString();
    }
}
