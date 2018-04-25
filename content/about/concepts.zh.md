---
title: 概念
linktitle: 概念
description: Jenkins X 中的概念
date: 2018-04-21
publishdate: 2018-04-21
lastmod: 2018-04-21
menu:
  docs:
    parent: "about"
    weight: 20
weight: 20
sections_weight: 20
draft: false
aliases: [/about/concepts]
categories: [fundamentals]
toc: true
---

Jenkins X 旨在使得 DevOps 原则和最佳实践对于研发人员来说简单。

## 原则
---
*"DevOps 是一套旨在缩短从提交变更到生产发布的时间的实践，同时保证高质量"*

DevOps项目的目标：

* 市场需求
* 提高部署频率
* 缩短修复时间
* 更低的市场错误率
* 更快的平均恢复时间

相对于行业平均水平——每周一次和每月一次来说，高效的团队应该有能力每天部署多次。

代码从已提交到上生产应该少于一个小时，变更失败率也应该小于15%，而平均值在31-45%之间。

从失败中的平均恢复时间应该少于一个小时。

Jenkins X 设计了第一原则，允许团队采用 DevOps 的最佳实践，来达到行业的最高目标。

## 实践
---
下列最佳实践被认为是DevOps成功的关键：

* 架构松耦合
* 自服务配置
* 自动化管理
* 持续构建 / 集成和部署
* 自动发布管理
* 增量测试
* 配置即代码

Jenkins X 把大量常见的方法论和组件集成为复杂度最小的方法。

## 架构

Jenkins X 基于松耦合架构的 DevOps 模型，被设计用来支持在多个团队之间，部署大量可重复、可管理的分布式微服务。

### 概念模型

<img src="/images/model.png" class="img-thumbnail">

## 构成

Jenkins X 基于以下的核心组件：  
  
### Kubernetes 和 Docker
---
Kubernetes 是系统的核心，它已经成为了 DevOps 事实上的虚拟基础设施平台。每个主要的云服务商现在都已经提供了 Kubernetes 基础设施，并且可能已经在很多私有基础设施中也被安装了。测试环境可能也在使用 Minikube 安装器创建本地开发环境。

从功能上，该Kubernetes 平台扩展了 Docker 提供的基本容器化原则，用于跨多个物理节点。

简单来说，Kubernetes 提供了同构的虚拟基础设施，可以通过动态添加或者移除节点实现伸缩。每个节点都在一个大型专用虚拟网络空间里。

Kubernetes 中的部署单元是 Pod，它包含一个或多个 Docker 容器以及一些元数据。Pod 中所有的容器分享同样的虚拟 IP 地址和端口范围。Deployments在 Kubernetes 中是申明式的，因此，用户指定特定版本的 Pod 中部署的实例数量，Kubernetes 据此来计算跨节点中的 Pod 是应该删除或部署。根据标签匹配来决定资源的实例数量。一旦被部署，Kubernetes 就会通过定期的健康检查来保证 Pod 的数量，终止或则替换没响应的 Pod。

为了增加某些结构，Kubernetes 允许创建虚拟命名空间用于对 Pod 做逻辑分离，隐含地把一组 Pod 和特定资源关联起来。例如：在同一个命名空间里的资源共用安全策略。同一个命名空间里的资源名称必须是唯一的，但在不同的命名空间里不受该约束。

在 Jenkins X 模型中，一个 Pod 相当于部署好的一个微服务（大多数情况下）。当微服务需要横向扩容时，Kubernetes 允许在一个 Pod 中有多个相同的实例被部署，
每个实例都有自己的虚拟 IP 地址。它们可以聚合为一个虚拟终端，也就是服务，它有唯一的静态 IP 地址，并且本地的 DNS 纪录会匹配服务的名称。对服务的调用
会动态地随机映射到健康的 POD 实例上。服务还可以重新映射端口。在 Kubernetes 虚拟网络中，服务可以根据域名全称来饮用的，格式为`<service-name>.<namespace-name>.svc.cluster.local`，它也可以缩短为`<service-name>.<namespace-name>`，或者服务的命名空间都一样的话可以是`<service-name>`。因此，如果一个 RESTful 服务'payments'部署在命名空间'finance'中时，就可以通过`http://payments.finance.svc.cluster.local`或者`http://payments.finance`或只是`http://payments`来引用，这要取决于代码的调用位置。

为了在本地网络以外的地方访问服务，Kubernetes 需要给每个服务创建一个入口。最常见的形式是利用一个或者多个负载均衡绑定静态 IP 地址，在 Kubernetes 外面的虚拟基础设施和路由网络请求映射到内部服务。给负载均衡的静态 IP 地址创建一个通配符的外部 DNS 纪录，就剋一把服务映射到外部的全称域名上。例如：如果我们的负载均衡映射到 `*.jenkins-x.io` ，那么我们负载的服务就可能暴露为 `http://payments.finance.jenkins-x.io` 。

Kubernetes 为强大的不断提高的平台在部署服务上提供巨大的伸缩能力，但它同时也是复杂不容易理解的，而且要正确进行配置也有一定的困难。Jenkins X 给 Kubernetes引入了一系列默认约定遗迹简单的工具，为了优化 DevOps 并管理松耦合的服务。

命令行工具 `jx` 提供了执行基于 Kubernetes 实例的简单方法，例如：查看日志、连接容器实例。另外，Jenkins X 扩展了 Kubernetes 的命名空间约定来创建环境，这样就把发布流水线串联起来了。

一个 Jenkins X 环境代表一个虚拟基础设施环境，例如：Dev、Staging、Production等等。两个环境之间的流转规则是可以定义的，因此可以通过流水线实现自动或者人工发版。每个环境的管理都遵循 GitOps 的方法——环境状态的维护依赖于 Git 仓库，提交或者回滚都会关联 Kubernetes 中的环境状态的改变。

Kubernetes 集群可以直接通过命令 `jx create cluster` 来创建，这使得当发生错误时可以很容易地复制一个集群。相同地，Jenkins X 平台通过 `jx upgrade platform` 来升级已有的集群。Jenkins X 通过 `jx context` 支持多 Kubernetes 集群，在一个集群中可以通过 `jx environment` 来切换环境。

研发人员应该知道 Kubernetes 提供的分布式配置数据以及夸集群的安全身份。ConfigMaps 可以用来创建一系列键值对形式的非敏感配置元素句，Secrets 与之类似，但保存的是加密的身份信息。Kubernetes 还提供为 Pod 指定资源配额的机制，这在优化跨节点之间的部署上是有必要的。这一点，我们先简短地讨论下。

默认情况下， Pod 的状态是临时的。当 Pod 被删除后，该 Pod 下载本地文件系统中的任何数据都会丢失。研发人员应该明白，Kubernetes 为了节点的负载均衡，可能随时会删除或者重建 Pod，因此本地数据可能会在任何时间丢失。当用到有状态的数据时，应该申明持久化的卷（Volumes），并挂载到指定 Pod 的文件系统中。

### Helm 和 Draft
---
要直接和 kubernetes 交互的话可以使用命令行  `kubectl` ，或者传递各种格式的 YAML 数据给 API。这一点会比较困难，而且错误信息的可读性差。为了沿用 DevOps ”配置即代码” 的原则，Jenkins X 借助 Helm 和 Draft 来创建应用的原子配置。

Helm 通过 Chart 的概念简化了 Kubernetes 的配置，它把一套需要部署到 Kubernetes 中的应用或者服务的原数据文件组织起来。Helm 不是维护一套基于 Kubernetes API 的样板化 YAML 文件，而是使用模板语言来通过需要的值来创建 YAML 文件。这使得在部署期间可以重用 Kubernetes 应用的配置文件。


