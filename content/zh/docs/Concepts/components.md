---
title: 组件
linktitle: 组件
description: 典型 Jenkins X 安装中的组件概览
---

Jenkins X 安装的包括：

* 每个团队一个开发环境，也就是 [kubernetes 命名空间](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/)
* 零或多个其它 [永久环境](/zh/about/concepts/features/#environments)
  * 为每个团队获取各自开箱即用的 `Staging` 和 `生产` 环境
  * 每个团队可以按照需要有很多环境，并依据习惯命名
* 可选的 [预览环境](/zh/about/concepts/features/#preview-environments)

通常，每个环境会关联对应不同的 [kubernetes 命名空间](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) ，以确保环境之间干净隔离。

尽管从技术上讲，两个团队可以共享同样的基础命名空间，比如 `Staging`，尽管我们建议分开以保持简单——不然的话，在同一个 git 库中配置相同的命名空间可能会发生冲突；例如：服务资源名称或者 DNS 会冲突。如果你希望两个团队共享基础微服务，使用 `服务链接` 在一个命名空间中连接另外一个会比较简单，这样它们可以通过本地 DNS 以本地服务的形式出现。

## 开发环境

在开发环境中，我们安装了很多必要的最小核心应用，才能启动基于 Kubernetes 的 CI/CD。

我们还支持 [addons](/zh/about/concepts/features/#applications) 扩展核心套件。

Jenkins X 的配置把这些服务连接起来，就可以直接工作了。这样就神奇地把 Kubernetes 的密码、环境遍历和配置文件全部配置好并可以工作了。

1. __Jenkins__  — 提供 CI 和 CD 自动化。这样对 Jenkins 的解耦变得更加云原生，并利用 Kubernetes 的概念，例如：CRDs（自定义资源定义）、存储和伸缩。
2. __Nexus__ — 作为 NodeJS 和 Java 程序的依赖缓存，可以减少构建时间。一个 SpringBoot 应用的初始化构建后，构建时间能从12分钟减少到4分钟。我们还没有实现，但是已经计划很快用 Artifactory 来替换。
3. __Docker registry__  — 一个集群中的 docker 注册表（registry），用于我们的流水线推送应用的镜像，我们将很快使用原生的云提供商，例如：Google Container Registry, Azure Container Registry 或 Amazon Elastic Container Registry (ECR)。
4. __ChartMuseum__ — 一个发布 Helm charts 的 registry
5. __Monocular__  — 一个用于发现和运行 Helm charts 的 UI

## 永久环境

这些[环境](/zh/about/concepts/features/#environments)，像 `Staging` 和 `Production` 使用 GitOps 来管理他们，因此，每个都有一个包含配置所有应用和服务以及要部署的位置信息的源码的 git 仓库。

通常，我们使用 git 仓库中的 Helm charts 来定义哪些 charts 要被安装，它们的版本，环境的具体配置，以及附加资源（例如：Secrets 或 像 Prometheus 可运行的应用等）

## 预览环境

[预览环境](/zh/about/concepts/features/#preview-environments) 和[永久环境](/zh/about/concepts/features/#environments) 类似，都在源码中使用 Helm charts 定义。

主要的不同之处，是预览环境配置在应用的源码的 `./chart/preview` 目录中。

而且，它们不是固定的，而是由一个应用的 git 仓库的 Pull Request 创建，而且后面会被删除（手动或者通过垃圾回收自动）。
