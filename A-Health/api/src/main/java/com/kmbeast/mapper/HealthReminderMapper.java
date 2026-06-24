package com.kmbeast.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kmbeast.pojo.entity.HealthReminder;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 健康提醒持久化接口
 */
@Mapper
public interface HealthReminderMapper extends BaseMapper<HealthReminder> {

    /**
     * 插入提醒记录
     */
    void insertReminder(HealthReminder reminder);

    /**
     * 获取用户未读提醒
     */
    List<HealthReminder> getUnreadByUserId(@Param("userId") Integer userId);

    /**
     * 标记提醒为已读
     */
    void markAsRead(@Param("id") Integer id);

    /**
     * 获取指定时间前的提醒
     */
    List<HealthReminder> getDueReminders(@Param("now") LocalDateTime now);

    /**
     * 清理旧提醒
     */
    void cleanOldReminders(@Param("daysAgo") Integer daysAgo);
}
