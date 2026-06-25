# SelfHealth - 个人健康管理系统

基于 Spring Boot 3 + Vue 3 的个人健康管理系统，集成 AI 健康助手（DeepSeek），支持健康数据记录、饮食管理、健康资讯、食谱推荐等功能。

## 技术栈

### 后端
- **Spring Boot 3.2.5** - Java 17+
- **MyBatis-Plus 3.5.7** - 持久层框架
- **MySQL** - 关系型数据库
- **Redis** - 缓存（对话记忆、敏感词词典）
- **Spring AI 1.0.0** - AI 集成（兼容 DeepSeek OpenAI 协议）
- **JWT** - 用户认证
- **Lombok** - 简化开发

### 前端
- **Vue 3** - 前端框架
- **Vite 5** - 构建工具
- **Element Plus** - UI 组件库
- **Vue Router 4** - 路由管理
- **ECharts 5** - 数据可视化
- **WangEditor / TUI Editor** - 富文本编辑器
- **Sass** - CSS 预处理器

## 功能模块

| 模块 | 说明 |
|------|------|
| 用户管理 | 注册、登录、权限管理（管理员/普通用户） |
| 健康记录 | 血压、体重、BMI 等健康指标记录与可视化 |
| 饮食管理 | 饮食记录与营养分析 |
| 健康模型 | 健康指标模型管理 |
| 健康资讯 | 健康资讯发布、浏览与收藏 |
| 食谱管理 | 食谱浏览、收藏与推荐 |
| 健康指数 | 流量指数与健康评分 |
| AI 健康助手 | 基于 DeepSeek 的智能健康问答与建议 |
| 数据看板 | 管理员数据统计与可视化 |
| 评论管理 | 资讯与食谱评论互动 |

## 项目结构

```
health-pro/
├── A-Health/
│   ├── api/                      # 后端项目
│   │   ├── src/main/java/        # Java 源码
│   │   ├── src/main/resources/   # 配置文件与 Mapper
│   │   ├── .env.example          # 环境变量模板
│   │   └── pom.xml               # Maven 依赖
│   ├── view/                     # 前端项目
│   │   ├── src/                  # Vue 源码
│   │   ├── public/               # 静态资源
│   │   ├── package.json          # 依赖配置
│   │   └── vite.config.js        # Vite 配置
│   └── mock-server.js            # 模拟后端服务（可选）
└── .gitignore
```

## 快速开始

### 环境要求
- Java 17+
- Maven 3.6+
- MySQL 5.7+ / 8.0+
- Redis 6.0+
- Node.js 18+

### 1. 数据库初始化

创建数据库并导入你的 SQL 文件：

```sql
CREATE DATABASE selfhealth DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
-- 导入你的 SQL 脚本
```

### 2. 后端启动

```bash
cd A-Health/api

# 配置环境变量
cp .env.example .env
# 编辑 .env 文件，填入你的实际配置

# Maven 构建
mvn clean package -DskipTests

# 运行
java -jar target/self-health-api-2.0-SNAPSHOT.jar
# 或开发模式运行
mvn spring-boot:run
```

后端默认运行在 `http://localhost:21090`

### 3. 前端启动

```bash
cd A-Health/view

# 安装依赖
npm install

# 开发模式
npm run dev

# 生产构建
npm run build
```

前端默认运行在 `http://localhost:21091`

### 4. 环境变量配置

在 `A-Health/api` 目录下创建 `.env` 文件（基于 `.env.example`）：

```env
# 数据库配置
DB_HOST=localhost
DB_PORT=3306
DB_NAME=selfhealth
DB_USERNAME=root
DB_PASSWORD=your_database_password

# Redis 配置
REDIS_HOST=localhost
REDIS_PORT=6379
REDIS_PASSWORD=
REDIS_DATABASE=0

# AI API 配置（DeepSeek）
AI_API_KEY=your_deepseek_api_key
AI_BASE_URL=https://api.deepseek.com
AI_MODEL=deepseek-chat
AI_TEMPERATURE=0.7

# AES 加密密钥
AES_SECRET_KEY=your_aes_secret_key

# JWT 签名密钥
JWT_PRIVATE_KEY=your_jwt_private_key

# DeepSeek API 是否启用
DEEPSEEK_API_ENABLED=true
```

> **注意：** `.env` 文件已加入 `.gitignore`，不会被提交到仓库。

### 5. 使用 Mock 服务（可选）

如果不想启动完整后端，可以使用模拟服务：

```bash
cd A-Health
node mock-server.js
```

Mock 服务运行在 `http://localhost:21090`，提供基础 API 响应。

## 默认账号

| 角色 | 账号 | 密码 |
|------|------|------|
| 管理员 | admin | 123456 |
| 普通用户 | user | 123456 |

## API 文档

后端 API 基础路径：`/api/v1.0/self-health-api`

| 接口前缀 | 说明 |
|----------|------|
| `/user/*` | 用户相关接口 |
| `/health-record/*` | 健康记录 |
| `/diet-history/*` | 饮食记录 |
| `/health-news/*` | 健康资讯 |
| `/recipe/*` | 食谱管理 |
| `/health-model/*` | 健康模型 |
| `/evaluations/*` | 评论管理 |
| `/flow-index/*` | 流量指数 |
| `/dashboard/*` | 数据看板 |
| `/ai-chat/*` | AI 聊天 |
| `/file/*` | 文件上传 |

## AI 架构设计

### 混合意图识别架构

AI 健康助手采用 **6 意图混合识别架构**，结合规则关键词匹配与 LLM 二次判定：

- **高置信度（≥0.6）**：关键词匹配得分达标时，直接路由到对应 Skill
- **低置信度（<0.6）**：走 Function Calling 流程，由 LLM 自动选择最合适的 Tool
- **意图类型**：饮食分析、运动建议、睡眠分析、异常预警、健康咨询、数据查询

#### 意图识别流程

```
用户输入 → HybridIntentRecognizer
    ├─ 规则关键词匹配 → 得分 ≥ 0.6 → 直接路由 Skill
    └─ 得分 < 0.6 → Function Calling → LLM 选择 Tool → 执行
```

### HealthSkill 技能体系

抽象 `HealthSkill` 接口，通过 `@Tool` 注解暴露给 LLM 调用，实现 4 个核心技能模块：

| Skill 模块 | 功能 | 对应工具 |
|-----------|------|---------|
| `DietAnalysisSkill` | 饮食分析 | 营养摄入分析、饮食建议 |
| `ExerciseAdviceSkill` | 运动建议 | 运动计划制定、运动量评估 |
| `SleepAnalysisSkill` | 睡眠分析 | 睡眠质量评估、改善建议 |
| `AlertSkill` | 异常预警 | 健康指标异常检测与预警 |

### 用户画像构建 (HealthProfileBuilder)

`HealthProfileBuilder` 聚合多表数据构建用户健康画像，并动态注入 SystemPrompt：

- 聚合用户基础信息、健康记录、饮食记录、运动数据等 **4 张核心表**
- 动态构建用户健康画像 `HealthProfile`
- 将画像数据注入 LLM 的 SystemPrompt，实现个性化健康建议

### 对话记忆管理 (ConversationMemory)

`ConversationMemory` 实现三层缓存架构的对话上下文管理：

- **Redis 缓存层**：优先从 Redis Hash 加载历史对话，避免重复查询数据库
- **持久层**：数据库增量持久化，防止内存丢失
- **内存窗口层**：`ConcurrentHashMap` 存储活跃会话，每会话维持 **20 轮** 对话上下文
- **清理策略**：超过窗口大小的旧对话自动清理，保持上下文精简
- **Redis Key 结构**：`agent:conversation:{sessionId}` Hash 存储

### 推荐算法 (User-CF 协同过滤)

食谱与健康资讯推荐采用 **User-CF 协同过滤算法**：

- **相似度计算**：余弦相似度衡量用户间相似性
- **近邻筛选**：Top-20 相似用户作为推荐依据
- **数据源**：5 类用户行为数据（收藏、浏览、点赞、评论、记录）
- **应用场景**：食谱推荐、健康资讯推荐

## 工程化特性

### AES 双模式加密

敏感健康数据采用 AES 双模式加密存储：

- 支持 AES-128 / AES-256 两种密钥长度
- 加密配置通过 `AES_SECRET_KEY` 环境变量管理

### ThreadLocal 用户身份传递

`LocalThreadHolder` 使用 `ThreadLocal` 实现请求级用户身份传递：

- JWT 拦截器解析 Token 后存入 ThreadLocal
- 业务层随时获取当前用户信息，无需参数传递
- 请求结束后自动清理，防止内存泄漏

### @Pager 分页注解

AOP 实现自定义 `@Pager` 分页注解：

- 拦截标注 `@Pager` 的方法，自动处理分页逻辑
- 统一分页参数解析与结果封装
- 减少 Controller 层重复代码

### 全局异常处理与统一响应

`GlobalExceptionHandler` + `BusinessException` + `AssertUtils` 构建完整的异常处理体系：

- **@RestControllerAdvice**：全局拦截 Controller 层异常，统一返回 JSON 格式
- **BusinessException**：自定义业务异常，支持携带状态码和错误信息
- **AssertUtils**：业务断言工具，提供 `notNull`、`notEmpty` 等常用校验方法
- **Result<T>**：统一响应体结构（`code` / `message` / `data`），所有接口遵循同一返回格式
- **ResultCode**：响应码枚举，集中管理 200/400/401/500 等状态码及描述

异常处理流程：
```
Controller → Service → AssertUtils.notNull() 校验失败
    → 抛出 BusinessException → @RestControllerAdvice 拦截
    → 封装为 Result<T> 返回前端
```

### AC 自动机敏感词过滤

`AhoCorasickFilter` 实现高效的 AC 自动机敏感词过滤：

- 多模式匹配算法，一次遍历完成所有敏感词检测
- 支持动态添加/移除敏感词
- 应用于用户输入、评论等内容的合规性检查
- **缓存策略**：敏感词词典通过 Redis Hash 缓存（24 小时过期），降级到数据库加载，最终降级到内置默认词

### Redis 缓存策略

项目使用 Redis 实现多维度缓存加速：

| 缓存场景 | Redis 数据结构 | Key 模式 | 过期策略 |
|---------|---------------|----------|---------|
| 对话记忆 | Hash | `agent:conversation:{sessionId}` | 24 小时 |
| 敏感词词典 | Hash | `filter:sensitive_words` | 24 小时 |
| 热点数据缓存 | String/Hash | 自定义 | 可配置 |

缓存架构设计：
- **三级降级策略**：Redis 缓存 → 数据库 → 内置默认值
- **增量更新**：对话记忆增量写入 Redis，减少全量同步开销
- **防穿透**：缓存未命中时写入空值，防止恶意请求打到数据库

## 性能优化

### SQL 索引优化

项目包含完整的索引优化方案（详见 `A-Health/sql/optimize_indexes.sql`）：

- **联合索引**：覆盖高频查询场景，避免回表
- **覆盖索引**：查询所需字段全部在索引中，减少磁盘 I/O
- **复合索引**：多条件组合查询优化
- **执行计划优化**：从全表扫描（`type: ALL`）优化为索引范围扫描（`type: ref`）

### 关键优化点

| 优化场景 | 优化前 | 优化后 | 性能提升 |
|---------|--------|--------|---------|
| flow_index 聚合查询 | 全表扫描数千行 | 索引范围扫描数十行 | 100x+ |
| health_news 统计查询 | 4 个子查询 N+1 问题 | LEFT JOIN + GROUP BY | 4x+ |
| 敏感词过滤 | 每次从数据库加载 | Redis 缓存 + AC 自动机 | 内存级 O(n) |
| 对话上下文加载 | 每次都查数据库 | Redis → DB 三级降级 | 缓存命中时 O(1) |

## 开源说明

本项目所有敏感配置（数据库密码、API Key 等）均使用环境变量管理，不会被提交到仓库。使用者需要根据 `.env.example` 模板自行配置。

## License

MIT
