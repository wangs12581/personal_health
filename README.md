# PersonalHealth（个人健康管理平台）
基于 Spring Boot + Vue 的前后端分离个人健康管理平台，支持用户注册/登录、记录与管理个人健康数据（体重、血压、血糖、运动、睡眠等）、查看历史趋势图表、浏览健康资讯并与其他用户讨论交流。该仓库包含后端工程、前端工程与数据库脚本。

## 目录
+ [演示截图](#演示截图)
+ [功能](#功能)
+ [技术栈](#技术栈)
+ [仓库结构](#仓库结构)
+ [快速开始](#快速开始)
    - [前置条件](#前置条件)
    - [数据库初始化](#数据库初始化)
    - [运行后端（开发）](#运行后端开发)
    - [运行前端（开发）](#运行前端开发)
+ [配置说明](#配置说明)
+ [联系方式](#联系方式)

## 演示截图
+ 登录页面

![](https://cdn.nlark.com/yuque/0/2025/png/53406322/1760779373138-cedb3305-198a-4bd3-b05d-654022fa9225.png)

+ 注册页面

![](https://cdn.nlark.com/yuque/0/2025/png/53406322/1760779543180-de8a2bb8-6d6b-40a7-b171-719e2b527276.png)

### 用户界面
+ 健康资讯

![](https://cdn.nlark.com/yuque/0/2025/png/53406322/1760779629904-7a49eb5c-310f-4e50-809f-8d5ebea647f5.png)

+ 资讯收藏

![](https://cdn.nlark.com/yuque/0/2025/png/53406322/1760779656038-b52f0e8a-6987-4e42-ba80-81621c67cec1.png)

+ 健康数据

![](https://cdn.nlark.com/yuque/0/2025/png/53406322/1760779673594-a4bab652-2899-4027-a8a3-ad95561d0bf3.png)

![](https://cdn.nlark.com/yuque/0/2025/png/53406322/1760779679141-0041b41a-5d2e-4900-8152-1e0df85594d2.png)

+ 健康记录

![](https://cdn.nlark.com/yuque/0/2025/png/53406322/1760779698760-55ce259e-32a0-42c5-abd3-faddcb89955a.png)

+ 消息

![](https://cdn.nlark.com/yuque/0/2025/png/53406322/1760779719380-700ebd07-1148-4bc7-b0ae-3251cef905a8.png)

### 管理员界面
+ 监控台

![](https://cdn.nlark.com/yuque/0/2025/png/53406322/1760779770960-d191d398-4753-4e6c-b38d-a986597d5f03.png)

+ 用户管理

![](https://cdn.nlark.com/yuque/0/2025/png/53406322/1760779791475-1a5b6960-4476-44e7-b94c-9bc97b3aaa04.png)

+ 资讯分类

![](https://cdn.nlark.com/yuque/0/2025/png/53406322/1760779815780-adc016a4-defa-4e90-bb11-eb3f6543e0a1.png)

+ 资讯管理

![](https://cdn.nlark.com/yuque/0/2025/png/53406322/1760779856297-561eab08-6e19-4aa6-88ce-6a29b5b93cce.png)

+ 项目管理

![](https://cdn.nlark.com/yuque/0/2025/png/53406322/1760779883979-4db4ba90-d8a8-4db7-8def-0c204147bf3b.png)

+ 健康记录

![](https://cdn.nlark.com/yuque/0/2025/png/53406322/1760779916451-36e6db28-9312-430f-ad52-d101a3d92b82.png)

+ 消息管理

![](https://cdn.nlark.com/yuque/0/2025/png/53406322/1760779932206-98ba1053-1281-439f-8b09-ede05d5ddeed.png)

+ 评论管理

![](https://cdn.nlark.com/yuque/0/2025/png/53406322/1760779954432-e0585d4a-6e51-45ae-b9dc-66f38ea1532f.png)

## 功能
+ 用户注册 / 登录 / 个人信息管理
+ 健康数据记录：体重、血压、血糖、运动、睡眠等多类型指标
+ 健康资讯浏览，可在评论区与其他用户交流讨论
+ 历史记录列表、筛选与分页
+ 指标趋势可视化（折线图）
+ 管理后台（用户与数据管理）

## 技术栈
+ 后端：Spring Boot，SpringMVC、MyBatis
+ 前端：Vue.js、Axios、Router
+ 数据库：MySQL
+ 可视化：ECharts

## 仓库结构
+ personal-health-api/ — 后端 Spring Boot 项目（Maven，Java 1.8 编译目标）
+ personal-heath-view/ — 前端 Vue 应用（npm/yarn 管理依赖）
+ sql/ — 数据库建表与初始化脚本
+ README.md — 项目说明（当前文件）

## 快速开始
### 前置条件
+ JDK 8（项目 pom.xml 指定编译目标 1.8）
+ Maven（用于后端构建）
+ Node.js + npm 或 yarn（用于前端）
+ MySQL 数据库

### 数据库初始化
1. 在 MySQL 中创建数据库（示例名 personal_health）：

```bash
mysql -u root -p
CREATE DATABASE personal_health DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_general_ci;
```

2. 导入仓库中 `sql/` 目录提供的脚本（示例）：

```bash
mysql -u root -p personal_health < sql/your_init_script.sql
```

（将命令中的脚本名替换为 `sql/` 下实际文件名）

### 运行后端（开发）
进入后端目录并运行：

```bash
cd personal-health-api
# 修改配置（src/main/resources/application.yml 或 environment variables）
mvn spring-boot:run
```

或打包后运行 jar：

```bash
mvn clean package
java -jar target/personal-health-api-1.0-SNAPSHOT.jar
```

后端基于 Maven，Java 编译目标为 1.8；核心依赖包括 MyBatis、JWT、EasyExcel、POI 和 fastjson2（详见 `personal-health-api/pom.xml`）。

### 运行前端（开发）
进入前端目录：

```bash
cd personal-heath-view
npm install        # 或 yarn install
npm run dev        # 启动本地开发服务器
# 生产打包
npm run build
```

前端通过 HTTP 请求对接后端 API，请确保 `VUE_APP_API_BASE_URL` 或前端配置指向后端地址。

## 配置说明
后端（application.yml / environment variables）常见配置项举例：

```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/personal_health?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC
    username: your_db_user
    password: your_db_password
server:
  port: 8080
jwt:
  secret: your_jwt_secret
```

前端常见配置示例（.env）：

```plain
VUE_APP_API_BASE_URL=http://localhost:8080/api
```

请根据实际代码中使用的配置项调整。

## 联系方式
作者：wangs12581  
GitHub: [https://github.com/wangs12581](https://github.com/wangs12581)

