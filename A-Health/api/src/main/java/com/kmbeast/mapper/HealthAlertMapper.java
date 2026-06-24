package com.kmbeast.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kmbeast.pojo.entity.HealthAlert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 健康预警持久化接口
 */
@Mapper
public interface HealthAlertMapper extends BaseMapper<HealthAlert> {

    /**
     * 插入预警记录
     */
    void insertAlert(HealthAlert alert);

    /**
     * 获取用户未处理预警
     */
    List<HealthAlert> getUnprocessedByUserId(@Param("userId") Integer userId);

    /**
     * 标记预警为已处理
     */
    void markAsProcessed(@Param("id") Integer id);

    /**
     * 获取用户指定级别预警
     */
    List<HealthAlert> getAlertsByLevel(@Param("userId") Integer userId, @Param("alertLevel") String alertLevel);

    /**
     * 清理旧预警
     */
    void cleanOldAlerts(@Param("daysAgo") Integer daysAgo);
}
