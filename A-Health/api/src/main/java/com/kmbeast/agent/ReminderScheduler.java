package com.kmbeast.agent;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kmbeast.mapper.HealthAlertMapper;
import com.kmbeast.mapper.HealthReminderMapper;
import com.kmbeast.mapper.HealthRecordMapper;
import com.kmbeast.mapper.UserMapper;
import com.kmbeast.pojo.entity.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 健康提醒调度器
 * 负责生成健康提醒和异常预警
 */
@Slf4j
@Component
@EnableScheduling
@RequiredArgsConstructor
public class ReminderScheduler {

    private final HealthAgent healthAgent;
    private final UserMapper userMapper;
    private final HealthReminderMapper healthReminderMapper;
    private final HealthAlertMapper healthAlertMapper;
    private final HealthRecordMapper healthRecordMapper;

    // 健康指标正常范围配置
    private static final Map<String, double[]> NORMAL_RANGES = new HashMap<>();

    static {
        NORMAL_RANGES.put("血压", new double[]{90, 140});
        NORMAL_RANGES.put("血糖", new double[]{3.9, 6.1});
        NORMAL_RANGES.put("心率", new double[]{60, 100});
        NORMAL_RANGES.put("体温", new double[]{36.1, 37.2});
        NORMAL_RANGES.put("BMI", new double[]{18.5, 24.9});
        NORMAL_RANGES.put("血氧", new double[]{95, 100});
    }

    /**
     * 每天 8:00 执行日常健康提醒
     * 将提醒存储到数据库
     */
    @Scheduled(cron = "0 0 8 * * ?")
    public void dailyHealthReminder() {
        log.info("开始生成每日健康提醒...");
        List<User> users = userMapper.selectList(null);
        int count = 0;
        LocalDateTime now = LocalDateTime.now();

        for (User user : users) {
            try {
                String reminder = healthAgent.generateReminder(user.getId());
                if (reminder != null && !"null".equals(reminder.trim())) {
                    // 将提醒存储到数据库
                    HealthReminder healthReminder = HealthReminder.builder()
                            .userId(user.getId())
                            .reminderType("DAILY")
                            .content(reminder)
                            .status(0) // 0-未读
                            .scheduledTime(now)
                            .createTime(now)
                            .build();
                    healthReminderMapper.insertReminder(healthReminder);
                    log.info("已为用户 {} 生成每日健康提醒", user.getId());
                    count++;
                }
            } catch (Exception e) {
                log.warn("为用户 {} 生成提醒失败: {}", user.getId(), e.getMessage());
            }
        }
        log.info("每日健康提醒生成完成，共生成 {} 条提醒", count);
    }

    /**
     * 每小时检查一次异常指标，生成健康预警
     */
    @Scheduled(cron = "0 0 * * * ?")
    public void hourlyAlertCheck() {
        log.info("开始每小时异常指标检查...");
        List<User> users = userMapper.selectList(null);
        int alertCount = 0;

        for (User user : users) {
            try {
                alertCount += generateAlerts(user.getId());
            } catch (Exception e) {
                log.warn("为用户 {} 生成预警失败: {}", user.getId(), e.getMessage());
            }
        }
        log.info("异常指标检查完成，共生成 {} 条预警", alertCount);
    }

    /**
     * 遍历用户健康数据，生成异常预警并存储到 health_alert 表
     * @param userId 用户ID
     * @return 生成的预警数量
     */
    public int generateAlerts(Integer userId) {
        int alertCount = 0;
        try {
            // 获取用户最新的健康记录
            List<HealthRecord> records = healthRecordMapper.selectList(
                    new QueryWrapper<HealthRecord>()
                            .eq("user_id", userId)
                            .orderByDesc("create_time")
                            .last("LIMIT 20")
            );

            if (records.isEmpty()) {
                return 0;
            }

            // 按指标分组，取最新值检查
            Map<Integer, HealthRecord> latestByModel = new HashMap<>();
            for (HealthRecord record : records) {
                latestByModel.putIfAbsent(record.getHealthModelId(), record);
            }

            LocalDateTime now = LocalDateTime.now();

            for (HealthRecord record : latestByModel.values()) {
                double value = record.getValue();
                // 跳过加密值（绝对值大于10000的可能是加密数据）
                if (Math.abs(value) > 10000) {
                    continue;
                }

                String modelName = getHealthModelName(record.getHealthModelId());
                double[] range = NORMAL_RANGES.get(modelName);

                if (range != null) {
                    String alertLevel = null;
                    String alertContent = null;

                    if (value < range[0]) {
                        // 低于正常范围
                        double deviation = (range[0] - value) / (range[1] - range[0]);
                        if (deviation > 0.3) {
                            alertLevel = "高";
                            alertContent = String.format("%s 值 %.1f 严重低于正常范围 (%.1f-%.1f)，请尽快就医",
                                    modelName, value, range[0], range[1]);
                        } else {
                            alertLevel = "中";
                            alertContent = String.format("%s 值 %.1f 低于正常范围 (%.1f-%.1f)，请注意调整",
                                    modelName, value, range[0], range[1]);
                        }
                    } else if (value > range[1]) {
                        // 高于正常范围
                        double deviation = (value - range[1]) / (range[1] - range[0]);
                        if (deviation > 0.3) {
                            alertLevel = "高";
                            alertContent = String.format("%s 值 %.1f 严重超出正常范围 (%.1f-%.1f)，请尽快就医",
                                    modelName, value, range[0], range[1]);
                        } else {
                            alertLevel = "中";
                            alertContent = String.format("%s 值 %.1f 超出正常范围 (%.1f-%.1f)，请注意调整",
                                    modelName, value, range[0], range[1]);
                        }
                    }

                    if (alertLevel != null) {
                        HealthAlert alert = HealthAlert.builder()
                                .userId(userId)
                                .alertLevel(alertLevel)
                                .modelName(modelName)
                                .currentValue(String.valueOf(value))
                                .content(alertContent)
                                .status(0) // 0-未处理
                                .createTime(now)
                                .build();
                        healthAlertMapper.insertAlert(alert);
                        log.warn("为用户 {} 生成 {} 级别预警: {}", userId, alertLevel, alertContent);
                        alertCount++;
                    }
                }
            }
        } catch (Exception e) {
            log.error("生成用户 {} 的预警时发生异常: {}", userId, e.getMessage());
        }
        return alertCount;
    }

    /**
     * 根据指标ID获取指标名称
     */
    private String getHealthModelName(Integer healthModelId) {
        // 简化映射，实际项目中可从数据库查询
        switch (healthModelId) {
            case 1: return "血压";
            case 2: return "血糖";
            case 3: return "心率";
            case 4: return "体温";
            case 5: return "BMI";
            case 6: return "血氧";
            default: return "未知指标-" + healthModelId;
        }
    }
}
