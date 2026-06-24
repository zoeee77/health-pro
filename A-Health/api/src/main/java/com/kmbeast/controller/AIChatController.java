package com.kmbeast.controller;

import com.kmbeast.agent.HealthAgent;
import com.kmbeast.context.LocalThreadHolder;
import com.kmbeast.pojo.api.ApiResult;
import com.kmbeast.pojo.api.Result;
import com.kmbeast.pojo.vo.ChatMessageVO;
import com.kmbeast.pojo.vo.ChatSessionVO;
import com.kmbeast.service.ChatSessionService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/ai-chat")
public class AIChatController {

    @Resource
    private HealthAgent healthAgent;

    @Resource
    private ChatSessionService chatSessionService;

    @PostMapping("/send")
    public Result<String> sendMessage(@RequestBody Map<String, String> requestMap) {
        String message = requestMap.get("message");
        if (message == null || message.trim().isEmpty()) {
            return ApiResult.error("消息不能为空");
        }

        Integer userId = LocalThreadHolder.getUserId();
        if (userId == null) {
            return ApiResult.error("用户未登录");
        }

        // 支持可选的 sessionId
        String sessionIdStr = requestMap.get("sessionId");
        Integer sessionId = null;
        if (sessionIdStr != null && !sessionIdStr.isEmpty()) {
            try {
                sessionId = Integer.parseInt(sessionIdStr);
            } catch (NumberFormatException e) {
                return ApiResult.error("会话ID格式错误");
            }
        }

        String reply = healthAgent.chat(userId, sessionId, message.trim());
        return ApiResult.success(reply);
    }

    @GetMapping("/daily-summary")
    public Result<String> dailySummary() {
        Integer userId = LocalThreadHolder.getUserId();
        if (userId == null) return ApiResult.error("用户未登录");

        String summary = healthAgent.generateDailySummary(userId);
        return summary != null ? ApiResult.success(summary) : ApiResult.error("生成日报失败");
    }

    @GetMapping("/reminder")
    public Result<String> reminder() {
        Integer userId = LocalThreadHolder.getUserId();
        if (userId == null) return ApiResult.error("用户未登录");

        String reminder = healthAgent.generateReminder(userId);
        return reminder != null ? ApiResult.success(reminder) : ApiResult.success("暂无特殊提醒");
    }

    /**
     * 检查AI服务是否可用
     */
    @GetMapping("/check-availability")
    public Result<Boolean> checkAvailability() {
        return ApiResult.success(healthAgent.isApiEnabled());
    }

    /**
     * 创建新会话
     * POST /ai-chat/session/create
     */
    @PostMapping("/session/create")
    public Result<Integer> createSession(@RequestBody(required = false) Map<String, String> request) {
        Integer userId = LocalThreadHolder.getUserId();
        if (userId == null) {
            return ApiResult.error("用户未登录");
        }
        String title = request != null ? request.get("title") : null;
        Integer sessionId = chatSessionService.createSession(userId, title);
        return ApiResult.success(sessionId);
    }

    /**
     * 获取用户会话列表
     * GET /ai-chat/session/list
     */
    @GetMapping("/session/list")
    public Result<List<ChatSessionVO>> listSessions() {
        Integer userId = LocalThreadHolder.getUserId();
        if (userId == null) {
            return ApiResult.error("用户未登录");
        }
        List<ChatSessionVO> sessions = chatSessionService.listSessions(userId);
        return ApiResult.success(sessions);
    }

    /**
     * 获取指定会话的聊天记录
     * GET /ai-chat/session/messages/{sessionId}
     */
    @GetMapping("/session/messages/{sessionId}")
    public Result<List<ChatMessageVO>> getSessionMessages(@PathVariable Integer sessionId) {
        Integer userId = LocalThreadHolder.getUserId();
        if (userId == null) {
            return ApiResult.error("用户未登录");
        }
        List<ChatMessageVO> messages = chatSessionService.getSessionMessages(sessionId);
        return ApiResult.success(messages);
    }

    /**
     * 关闭指定会话
     * POST /ai-chat/session/close/{sessionId}
     */
    @PostMapping("/session/close/{sessionId}")
    public Result<Boolean> closeSession(@PathVariable Integer sessionId) {
        Integer userId = LocalThreadHolder.getUserId();
        if (userId == null) {
            return ApiResult.error("用户未登录");
        }
        chatSessionService.closeSession(sessionId);
        return ApiResult.success(true);
    }

    /**
     * 删除指定会话及其消息
     * DELETE /ai-chat/session/delete/{sessionId}
     */
    @DeleteMapping("/session/delete/{sessionId}")
    public Result<Boolean> deleteSession(@PathVariable Integer sessionId) {
        Integer userId = LocalThreadHolder.getUserId();
        if (userId == null) {
            return ApiResult.error("用户未登录");
        }
        chatSessionService.deleteSession(sessionId);
        return ApiResult.success(true);
    }
}
