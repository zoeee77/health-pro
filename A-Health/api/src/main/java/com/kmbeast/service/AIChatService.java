package com.kmbeast.service;

import com.kmbeast.pojo.api.Result;

public interface AIChatService {

    /**
     * 发送消息到AI助手
     *
     * @param message 用户消息
     * @return Result<String> AI回复
     */
    Result<String> sendMessage(String message);

    /**
     * 检测DeepSeek API可用性
     *
     * @return Result<Boolean> API是否可用
     */
    Result<Boolean> checkApiAvailability();
}
