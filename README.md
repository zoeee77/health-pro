# SelfHealth - 个人健康管理系统

基于 Spring Boot 3 + Vue 3 的个人健康管理系统，集成 AI 健康助手（DeepSeek），支持健康数据记录、饮食管理、健康资讯、食谱推荐等功能。

## 技术栈

### 后端
- **Spring Boot 3.2.5** - Java 17+
- **MyBatis-Plus 3.5.7** - 持久层框架
- **MySQL** - 关系型数据库
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

## 开源说明

本项目所有敏感配置（数据库密码、API Key 等）均使用环境变量管理，不会被提交到仓库。使用者需要根据 `.env.example` 模板自行配置。

## License

MIT
