---
title: 创建 Spring Boot
linktitle: 创建 Spring Boot
description: 如何创建Spring Boot应用并导入Jenkins X
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
menu:
  docs:
    parent: "developing"
    weight: 40
weight: 40
sections_weight: 40
categories: [fundamentals]
draft: false
toc: true
---

                
如果你在开发基于Java的微服务，那么，你可能正在用流行的[Spring Boot](https://projects.spring.io/spring-boot/)。

你可以利用[Spring Boot Initializr](http://start.spring.io/)创建Spring Boot应用，然后通过执行命令 [jx import](/commands/jx_import) 来[导入Jenkins X](/developing/import)。
 
然而，另外一个快速自动化的方式，是通过执行 [jx create spring](/commands/jx_create_spring) 命令实现：

```shell
$ jx create spring -d web -d actuator
```

参数 `-d` 允许你指定希望添加到 Spring Boot 应用中的依赖。

我们强烈建议你总是包括依赖 **actuator** 到你的 Spring Boot 应用中，它可以为 [Liveness and Readiness probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/) 提供健康检查。

命令 [jx create spring](/commands/jx_create_spring) 的步骤如下：

* 在子目录中创建一个新的 Spring Boot 应用
* 把你的源码加入到git库中
* 在 git 服务，例如 [GitHub](https://github.com),添加 git 远程库
* 推送代码到 git 远程库
* 添加默认的文件：
  * `Dockerfile` 把你的应用构建为 docker 镜像
  * `Jenkinsfile` 实现 CI / CD 流水线
  * 在 Kubernetes 中通过 helm chart 运行你的应用
* 为你的 Jenkins 在 git 远程库上注册 webhook
* 为你的 Jenkins 添加 git 库
* 首次触发流水线 

