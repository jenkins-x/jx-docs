---
title: 常见问题解答
linktitle: FAQ
description: Jenkins X 常见问题的解决方案。
---

我们已经试图把一些常见的问题整理到这里。如果你遇到的问题没有在这里列出来，请[让我们知道](https://github.com/jenkins-x/jx/issues/new)。


## Jenkins X 是开源的吗？

是的！Jenkins X 的所有源码和成品都是开源的；Apache 或 MIT 能保证这一点！

## Jenkins X 和 Jenkins 相比如何呢？

Jenkins X 通过[跨环境的 GitOps 部署升级](/zh/about/concepts/features/#部署升级)和[ Pull Requests 预发环境](/zh/about/concepts/features/#预发环境)为 Kubernetes 中的应用提供了[自动化 CI + CD ](/zh/about/concepts/features/#automated-pipelines)。
更多信息请参考[特性](/zh/about/concepts/features/)。

Jenkins是一个通用的 CI/CD 服务器，可以通过添加插件、更改配置和编写自己的流水线来配置它来做你喜欢的任何事情。

对于 Jenkins X 仅仅[安装 Jenkins X ](/zh/dosc/getting-started/)，它将自动配置所有各种不同的工具（ helm，docker registry，nexus 等等），然后[创建](/zh/docs/resources/guides/using-jx/common-tasks/create-spring/)/导入(/zh/docs/resources/guides/using-jx/common-tasks/import/)，你将获得全面的自动化 CI/CD 和预发环境。这使得当你委托 Jenkins X 管理您的 CI + CD 时，开发人员可以集中精力构建应用程序。

Jenkins X 支持不同的执行引擎；因此它可以通过在 Docker 容器中重用 Jenkins 来为每个团队编排 Jenkins 服务器。然而当使用[无服务 Jenkins X 流水线](/zh/about/concepts/jenkins-x-pipelines/)时，我们使用 [Tekton](https://tekton.dev/) 而不是 Jenkins 作为底层的 CI/CD 引擎来提供一个新式的、高可用的云原生架构。


## Jenkins X 是 Jenkins 的分支吗？

不！ Jenkins X 可以通过在容器中重用 Jenkins 来编排 Jenkins ，并尽可能地用 kubernetes 原生方式配置它。

然而当使用[无服务 Jenkins X 流水线](/zh/about/concepts/jenkins-x-pipelines/)时，我们使用 [Tekton](https://tekton.dev/) 而不是 Jenkins 作为底层的 CI/CD 引擎来提供一个新式的、高可用的云原生架构。

## 为什么要创建一个子项目？

我们是 <a href="https://kubernetes.io/">Kubernetes</a> 和云的超级粉丝，并认为是软件运行的未来趋势。

然而，很多分支仍然想要通过：<code>java -jar jenkins.war</code >以常规的方式来运行 Jenkins。

因此，Jenkins X 子项目的想法，是为了100%关注在 Kubernetes 和云原生使用场景，并让 Jenkins 核心项目关注经典的 Java 方式。

Jenkins 最强大的是它的灵活性和巨大的插件生态。分离 Jenkins X 子项目帮助社区并行地迭代并快速改进云原生和 Jenkins 经典的发行。
