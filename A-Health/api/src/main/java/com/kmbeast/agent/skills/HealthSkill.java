package com.kmbeast.agent.skills;

import com.kmbeast.agent.HealthProfile;

/**
 * 健康技能接口
 * 每个技能负责对用户健康数据进行分析并返回结果
 */
public interface HealthSkill {

    /**
     * 分析用户健康档案，返回分析结果
     *
     * @param profile 用户健康档案
     * @return 分析结果字符串
     */
    String analyze(HealthProfile profile);
}
