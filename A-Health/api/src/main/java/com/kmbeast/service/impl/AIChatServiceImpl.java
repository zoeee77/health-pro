package com.kmbeast.service.impl;

import com.kmbeast.agent.HealthAgent;
import com.kmbeast.context.LocalThreadHolder;
import com.kmbeast.pojo.api.ApiResult;
import com.kmbeast.pojo.api.Result;
import com.kmbeast.service.AIChatService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import jakarta.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * AI聊天助手服务实现类
 * 委托给 HealthAgent 处理聊天逻辑，消除重复的 API 调用代码
 */
@Service
@Slf4j
public class AIChatServiceImpl implements AIChatService {

    @Resource
    private HealthAgent healthAgent;

    @Resource
    private RestTemplate restTemplate;

    @Value("${deepseek.api.key}")
    private String deepseekApiKey;

    @Value("${deepseek.api.url}")
    private String deepseekApiUrl;

    @Value("${deepseek.api.enabled:true}")
    private boolean deepseekApiEnabled;

    /**
     * 发送消息到AI助手
     * 委托给 HealthAgent 处理
     *
     * @param message 用户消息
     * @return Result<String> AI回复
     */
    @Override
    public Result<String> sendMessage(String message) {
        try {
            Integer userId = LocalThreadHolder.getUserId();
            if (userId == null) {
                return ApiResult.error("用户未登录");
            }

            // 委托给 HealthAgent 处理
            String reply = healthAgent.chat(userId, message);
            return ApiResult.success(reply);
        } catch (Exception e) {
            log.error("AI聊天助手异常", e);
            return ApiResult.error("系统异常，请稍后重试");
        }
    }

    /**
     * 检测DeepSeek API可用性
     *
     * @return Result<Boolean> API是否可用
     */
    @Override
    public Result<Boolean> checkApiAvailability() {
        try {
            // 构建一个简单的请求来检测API是否响应
            Map<String, Object> requestBody = new HashMap<>();
            requestBody.put("model", "deepseek-chat");

            List<Map<String, Object>> messages = new ArrayList<>();
            Map<String, Object> systemMessage = new HashMap<>();
            systemMessage.put("role", "system");
            systemMessage.put("content", "你是一个健康助手，请简短回答'API测试成功'。");
            messages.add(systemMessage);

            Map<String, Object> userMessage = new HashMap<>();
            userMessage.put("role", "user");
            userMessage.put("content", "测试API连接");
            messages.add(userMessage);

            requestBody.put("messages", messages);
            requestBody.put("temperature", 0.7);
            requestBody.put("max_tokens", 10); // 限制响应长度，减少API调用成本

            // 构建请求头
            HttpHeaders headers = new HttpHeaders();
            headers.set("Content-Type", "application/json");
            headers.set("Authorization", "Bearer " + deepseekApiKey);

            // 构建请求实体
            HttpEntity<Map<String, Object>> requestEntity = new HttpEntity<>(requestBody, headers);

            log.info("检测DeepSeek API可用性");

            // 调用DeepSeek API
            Map<String, Object> response = restTemplate.postForObject(
                    deepseekApiUrl,
                    requestEntity,
                    Map.class
            );

            // 检查响应是否成功
            if (response != null && response.containsKey("choices")) {
                log.info("DeepSeek API可用");
                return ApiResult.success(true);
            } else {
                log.warn("DeepSeek API响应异常: {}", response);
                return ApiResult.error("API响应异常");
            }
        } catch (HttpClientErrorException e) {
            // 处理HTTP客户端错误
            HttpStatus statusCode = (HttpStatus) e.getStatusCode();
            log.error("DeepSeek API调用失败，状态码: {}, 响应体: {}", statusCode, e.getResponseBodyAsString());

            if (statusCode.isSameCodeAs(HttpStatus.PAYMENT_REQUIRED)) {
                // 402 错误：余额不足
                log.error("DeepSeek API账户余额不足，请充值或联系管理员");
                return ApiResult.error("AI助手服务余额不足，请联系管理员充值");
            } else if (statusCode == HttpStatus.UNAUTHORIZED) {
                // 401 错误：认证失败
                log.error("DeepSeek API密钥无效或已过期");
                return ApiResult.error("AI助手服务认证失败，请联系管理员");
            } else if (statusCode == HttpStatus.TOO_MANY_REQUESTS) {
                // 429 错误：请求过于频繁
                log.warn("DeepSeek API请求频率超限");
                return ApiResult.error("请求过于频繁，请稍后再试");
            } else {
                // 其他HTTP错误
                return ApiResult.error("AI服务调用失败: " + statusCode);
            }
        } catch (Exception e) {
            log.error("检测DeepSeek API可用性失败", e);
            return ApiResult.error("API不可用: " + e.getMessage());
        }
    }
}
