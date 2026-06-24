# Phase 4: RAG + Memory 升级设计文档

> **状态**: 设计阶段（本阶段仅做设计，不实施）
> **创建日期**: 2026-06-10
> **前置条件**: Phase 1 + Phase 2 + Phase 3 已完成并验证通过

---

## 1. 概述

Phase 4 旨在为 HealthAgent 引入两项 Spring AI 核心能力：

1. **RAG（检索增强生成）** — 基于向量知识库检索健康知识，增强 LLM 回复的专业性和准确性
2. **ChatMemory 升级** — 使用 Spring AI 内置的 `ChatMemory` 抽象替代手写 `ConversationMemory`，同时保留 MySQL 持久化

---

## 2. RAG 架构设计

### 2.1 整体流程

```
用户提问 → Embedding 向量化 → 向量数据库检索 Top-K → 检索结果注入 Prompt → LLM 生成回复
```

### 2.2 知识库内容规划

| 知识类别 | 示例内容 | 数据来源 |
|---------|---------|---------|
| 饮食指南 | 中国居民膳食指南、营养搭配原则 | 公开文献 |
| 运动建议 | 不同人群的推荐运动量、运动禁忌 | 公开文献 |
| 医学科普 | 高血压/糖尿病/高血脂管理知识 | 公开文献 |
| 用药指南 | 常见药物使用说明、禁忌 | 公开文献 |

### 2.3 技术选型

| 组件 | 推荐方案 | 备选方案 |
|------|---------|---------|
| 向量数据库 | Chroma（轻量，适合学习） | Milvus / pgvector |
| Embedding 模型 | DashScope text-embedding-v3 | Ollama bge-m3 |
| Spring AI 模块 | `spring-ai-chroma-store` | `spring-ai-milvus-store` |

### 2.4 实现步骤

```
Step 1: 添加向量存储依赖
Step 2: 构建知识库文档（PDF/Markdown → Document 对象）
Step 3: 文档分块（TokenTextSplitter）
Step 4: 向量化并入库（Document → Embedding → VectorStore）
Step 5: HealthAgent 中使用 @VectorStore 注入检索能力
Step 6: Prompt 中注入检索到的知识片段
```

### 2.5 核心代码示例（供后续实施参考）

```java
@Service
public class HealthAgent {
    
    @Autowired
    private VectorStore vectorStore;
    
    private String retrieveKnowledge(String query) {
        List<Document> docs = vectorStore.similaritySearch(
            SimilaritySearchQuery.builder()
                .query(query)
                .topK(3)
                .build()
        );
        return docs.stream()
            .map(Document::getContent)
            .collect(Collectors.joining("\n\n"));
    }
}
```

---

## 3. ChatMemory 升级设计

### 3.1 现状

当前 `ConversationMemory` 实现了：
- 内存中维护最近 N 轮对话（maxTurns=20）
- 定期批量保存到 MySQL（每 5 条保存一次）
- 从 MySQL 加载历史对话

### 3.2 Spring AI 方案

Spring AI 提供了 `ChatMemory` 抽象：

| 实现 | 特点 |
|------|------|
| `InMemoryChatMemory` | 内存存储，进程重启丢失 |
| `JdbcChatMemoryRepository` | JDBC 存储，天然持久化 |
| 自定义 `ChatMemoryRepository` | 可复用现有 `AgentConversationMapper` |

### 3.3 推荐方案：自定义 ChatMemoryRepository

复用现有的 `AgentConversationMapper` 和 `agent_conversation` 表，通过实现 `ChatMemoryRepository` 接口让 Spring AI 管理对话记忆：

```java
@Component
@RequiredArgsConstructor
public class MybatisChatMemoryRepository implements ChatMemoryRepository {
    
    private final AgentConversationMapper mapper;
    
    @Override
    public List<Message> findMessages(String conversationId) {
        Integer userId = Integer.parseInt(conversationId);
        List<AgentConversation> records = mapper.getRecentByUserId(userId, 20);
        return records.stream()
            .map(r -> Message.builder()
                .role(r.getRole().equals("user") ? Role.USER : Role.ASSISTANT)
                .content(r.getContent())
                .build())
            .toList();
    }
    
    @Override
    public void saveMessages(String conversationId, List<Message> messages) {
        Integer userId = Integer.parseInt(conversationId);
        for (Message msg : messages) {
            mapper.insertConversation(AgentConversation.builder()
                .userId(userId)
                .role(msg.getRole().name().toLowerCase())
                .content(msg.getContent())
                .createTime(LocalDateTime.now())
                .build());
        }
    }
}
```

### 3.4 ChatClient 集成

```java
// 配置 ChatMemory
@Bean
public ChatMemory chatMemory(ChatMemoryRepository repository) {
    return MessageWindowChatMemory.builder()
        .chatMemoryRepository(repository)
        .maxMessages(20)
        .build();
}

// ChatClient 使用
chatClient.prompt()
    .system(systemPrompt)
    .user(userMessage)
    .advisors(a -> a.param(ChatMemory.CONVERSATION_ID, userId.toString()))
    .tools(...)
    .call()
    .content();
```

### 3.5 迁移注意事项

| 风险点 | 处理方式 |
|--------|---------|
| 现有 `ConversationMemory` 的内存缓存 | 保留内存缓存层，减少数据库查询 |
| `lastSavedIndexStore` 逻辑 | 由 Spring AI 内部管理，可删除 |
| 批量保存优化 | 可在 `saveMessages` 中实现批量插入 |

---

## 4. 实施优先级建议

```
Phase 4a（中等优先级）: ChatMemory 升级
  - 复用现有数据库表
  - 改动范围小
  - 收益：减少样板代码，统一记忆管理
  
Phase 4b（低优先级）: RAG 知识库
  - 需要额外基础设施（向量数据库）
  - 需要准备知识文档
  - 收益：提升回复专业性和准确性
```

---

## 5. 依赖变更

```xml
<!-- Phase 4a: ChatMemory -->
<!-- 无需额外依赖，Spring AI 已内置 -->

<!-- Phase 4b: RAG -->
<dependency>
    <groupId>org.springframework.ai</groupId>
    <artifactId>spring-ai-chroma-store-spring-boot-starter</artifactId>
</dependency>
```

---

## 6. 预期收益

| 能力 | 当前状态 | Phase 4 后 |
|------|---------|-----------|
| 对话记忆管理 | 手写 ConversationMemory | Spring AI ChatMemory 统一管理 |
| 知识检索 | 无 | 向量检索 + 知识库注入 |
| 回复准确性 | 依赖 LLM 训练数据 | LLM + 专业知识库双重保障 |
| 代码维护性 | 中等（混合了业务和记忆管理） | 高（关注点分离） |
