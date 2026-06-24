package com.kmbeast.agent;

import com.kmbeast.context.LocalThreadHolder;
import com.kmbeast.mapper.DietHistoryMapper;
import com.kmbeast.mapper.HealthModelMapper;
import com.kmbeast.mapper.HealthRecordMapper;
import com.kmbeast.mapper.UserMapper;
import com.kmbeast.pojo.entity.DietHistory;
import com.kmbeast.pojo.entity.HealthModel;
import com.kmbeast.pojo.entity.HealthRecord;
import com.kmbeast.pojo.entity.User;
import com.kmbeast.utils.AESUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.time.Period;
import java.util.*;
import java.util.stream.Collectors;

/**
 * Assembles a comprehensive HealthProfile for a user by aggregating
 * data from user table, diet_history, health_record, and health_model.
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class HealthProfileBuilder {

    private final UserMapper userMapper;
    private final DietHistoryMapper dietHistoryMapper;
    private final HealthRecordMapper healthRecordMapper;
    private final HealthModelMapper healthModelMapper;
    private final AESUtil aesUtil;

    public HealthProfile buildForCurrentUser() {
        Integer userId = LocalThreadHolder.getUserId();
        if (userId == null) return null;
        return build(userId);
    }

    public HealthProfile build(Integer userId) {
        HealthProfile profile = new HealthProfile();
        profile.setUserId(userId);

        // 1. Basic user info
        User user = userMapper.getUserById(userId);
        if (user == null) return profile;

        profile.setUsername(user.getUsername());
        profile.setGender(user.getGender());
        if (user.getBirthday() != null) {
            profile.setAge(Period.between(user.getBirthday(), LocalDate.now()).getYears());
        }

        // 2. Diet history (last 20 entries)
        List<DietHistory> diets = dietHistoryMapper.getByUserId(userId);
        if (diets != null && !diets.isEmpty()) {
            diets.sort((a, b) -> b.getCreateTime().compareTo(a.getCreateTime()));
            List<DietHistory> recent = diets.size() > 20 ? diets.subList(0, 20) : diets;
            StringBuilder sb = new StringBuilder();
            for (DietHistory d : recent) {
                double value = d.getValue() != null ? d.getValue() : 0;
                // 加密后数值会显著增大，通过阈值判断是否需要解密
                if (Math.abs(value) > 10000) {
                    value = aesUtil.decryptValue(value);
                }
                sb.append(String.format("[%s] %s — %.0fg%n",
                        d.getCreateTime() != null ? d.getCreateTime().toLocalDate() : "",
                        d.getDetail() != null ? d.getDetail() : "未知食物",
                        value));
            }
            profile.setRecentDietSummary(sb.toString());
        }

        // 3. Health metrics with trends
        List<HealthRecord> records = healthRecordMapper.getByUserId(userId);
        if (records != null && !records.isEmpty()) {
            Map<Integer, List<HealthRecord>> grouped = records.stream()
                    .collect(Collectors.groupingBy(HealthRecord::getHealthModelId));

            List<HealthProfile.MetricTrend> trends = new ArrayList<>();
            // Fetch all health models for names
            List<HealthModel> models = healthModelMapper.selectList(null);
            Map<Integer, HealthModel> modelMap = models.stream()
                    .collect(Collectors.toMap(HealthModel::getId, m -> m));

            for (Map.Entry<Integer, List<HealthRecord>> entry : grouped.entrySet()) {
                Integer modelId = entry.getKey();
                List<HealthRecord> rs = entry.getValue();
                rs.sort((a, b) -> b.getCreateTime().compareTo(a.getCreateTime()));

                if (rs.isEmpty()) continue;

                HealthProfile.MetricTrend mt = new HealthProfile.MetricTrend();
                HealthModel model = modelMap.get(modelId);
                mt.setModelName(model != null ? model.getName() : "指标" + modelId);
                mt.setUnit(model != null && model.getUnit() != null ? model.getUnit() : "");

                // Decrypt values if needed
                double latestVal = rs.get(0).getValue();
                if (Math.abs(latestVal) > 10000) {
                    latestVal = aesUtil.decryptValue(latestVal);
                }
                mt.setLatestValue(latestVal);

                if (rs.size() >= 2) {
                    double prevVal = rs.get(1).getValue();
                    if (Math.abs(prevVal) > 10000) {
                        prevVal = aesUtil.decryptValue(prevVal);
                    }
                    mt.setPreviousValue(prevVal);
                    double diff = mt.getLatestValue() - mt.getPreviousValue();
                    mt.setTrend(Math.abs(diff) < 0.01 ? "stable" : diff > 0 ? "up" : "down");
                } else {
                    mt.setTrend("stable");
                }

                // Simple normal-range evaluation based on common thresholds
                mt.setEvaluation(evaluateMetric(model != null ? model.getName() : "", mt.getLatestValue()));
                trends.add(mt);
            }
            profile.setVitalSigns(trends);
        }

        return profile;
    }

    private String evaluateMetric(String modelName, Double value) {
        if (value == null) return "unknown";
        String name = modelName.toLowerCase();
        if (name.contains("血压") || name.contains("blood pressure")) {
            if (name.contains("舒张") || name.contains("diastolic")) {
                return value >= 60 && value <= 90 ? "normal" : "abnormal";
            }
            return value >= 90 && value <= 140 ? "normal" : "abnormal";
        }
        if (name.contains("血糖") || name.contains("blood sugar") || name.contains("glucose")) {
            return value >= 3.9 && value <= 6.1 ? "normal" : "abnormal";
        }
        if (name.contains("心率") || name.contains("heart rate")) {
            return value >= 60 && value <= 100 ? "normal" : "abnormal";
        }
        if (name.contains("bmi")) {
            return value >= 18.5 && value <= 24.9 ? "normal" : "abnormal";
        }
        return "unknown";
    }
}
