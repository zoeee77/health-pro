package com.kmbeast.agent;

import lombok.Data;

import java.util.List;

/**
 * Structured health profile assembled from all user data sources.
 * Used as the system context for the AI agent.
 */
@Data
public class HealthProfile {
    private Integer userId;
    private String username;
    private Integer age;
    private Integer gender;           // 1-female, 2-male
    private String recentDietSummary; // last 20 diet records summarised
    private List<MetricTrend> vitalSigns;

    @Data
    public static class MetricTrend {
        private String modelName;      // e.g. "血压", "血糖"
        private String unit;
        private Double latestValue;
        private Double previousValue;
        private String trend;          // "up", "down", "stable"
        private String evaluation;     // "normal", "abnormal"
    }
}
