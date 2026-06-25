package com.kmbeast.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 敏感词 Mapper
 * 用于从数据库加载敏感词词典，配合 Redis 缓存使用
 */
@Mapper
public interface SensitiveWordMapper {

    /**
     * 查询所有敏感词
     * @return 敏感词列表
     */
    @Select("SELECT word FROM sensitive_word WHERE status = 1 ORDER BY create_time DESC")
    List<String> selectSensitiveWords();
}
