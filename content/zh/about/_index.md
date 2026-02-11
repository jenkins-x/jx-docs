---
title: 关于 Jenkins X
linktitle: 概览
description: Jenkins X 的概念，特点，实践和架构。
type: docs
menu:
  main:
    weight: 10
---

Jenkins X 是基于 Kubernetes 的持续集成、持续部署平台。 该项目是 <a href="https://jenkins.io/">Jenkins</a> 的子项目。

## 概念
---
Jenkins X旨在使程序员在研发过程中能够轻松遵循DevOps原理和最佳实践。推荐的方法是来自于[* Accelerate：构建和扩展高性能技术组织*]（https://goo.gl/vZ8BFN）之前对业界进行的全面研究调查。您可以继续阅读为什么Jenkins X会重点使用[Accelerate]（../ accelerate）。

## 原则
---
*"DevOps是旨在缩短将源代码发布到生产环境时间的一组实践。这里不仅仅减少从源代码更改到最后生产环境发布的时间差，同时还要确保系统的高质量，"*

DevOps项目的目标是：

*更快的上市时间
*提高部署频率
*更短的修复时间
*降低发布失败率
*更快的平均恢复时间

高效团队应该每天能够部署多次，远高于每周一次到每月一次的行业平均水平。

从“提交的代码”状态到“生产中的代码”状态的时间应少于一小时，更改失败率应少于15％，而业界平均比例高达31-45％。

从故障中恢复的平均时间也应少于一小时。

Jenkins X从最初的设计就是基于这些原则，允许团队应用DevOps最佳实践来达到行业顶峰的绩效目标。

## Practices
---
以下最佳实践被认为是成功运行DevOps方法的关键：

*松耦合架构
*自助服务配置
*自动部署和管理资源
*持续构建/集成和交付
*自动发布管理
*增量测试
*基础结构配置为代码
*全面的配置管理
*基于主干的开发和功能标志

Jenkins X将许多业界熟悉的方法和组件整合到一个系统中，从而最大程度地减少了复杂性。

## 架构

Jenkins X建立在松耦合架构的DevOps模型的基础上，用以支持多个团队中可重复的方式部署大量分布式微服务。

<img src="/images/jx-arch.png" class="img-thumbnail">

### 概念模型

<img src="/images/model.png" class="img-thumbnail">

## 构建

Jenkins X建立在以下核心组件之上： 

### Kubernetes & Docker

该系统的核心是Kubernetes，它已成为DevOps的事实上的虚拟基础架构平台。现在，每个主要的云提供商都提供Kubernetes基础架构服务。如果需要，Kubernetes也可以内部安装在私有云基础架构上。还可以使用Minikube安装程序在本地开发硬件上创建测试环境。

在功能上，Kubernetes平台扩展了以跨越多个物理节点的Docker容器。

简而言之，Kubernetes提供了一个同类的虚拟基础架构，可以通过添加或删除节点来动态扩容。每个节点都可参与单个大型专用虚拟网络空间。

Kubernetes中的部署单位是Pod，pod可以包含一个或多个Docker容器和一些元数据。 Pod中的所有容器共享相同的虚拟IP地址和端口空间。 Kubernetes内的部署是声明式的。当用户指定要部署Pod的版本和数量后，Kubernetes通过跨节点部署或删除Pod来决定从当前状态到所需状态所需的操作。关于如何配置Pod的具体特性则被系统可用资源，所需资源和标签匹配的影响。部署后，Kubernetes会定期进行健康状况检查，通过终止和替换无响应的Pod来确保每种类型的Pod所需保持数量。

为了确定某种结构，Kubernetes允许创建虚拟命名空间Namespace，该命名空间可用于逻辑上分隔Pod，并将Pod组与特定资源相关联。例如，命名空间中的资源可以共享一个安全策略。资源名称在命名空间内必须唯一，但可以在不同命名空间中重用。

在Jenkins X模型中，一个Pod相当于一个已部署的微服务实例（在大多数情况下）。在需要水平扩展微服务的情况下，Kubernetes允许部署多个相同运行实例的Pods，而每个实例都有其自己的虚拟IP地址。它们可以聚合到一个称为服务Service的虚拟节点中，该节点有唯一的静态IP地址和与该服务名称匹配的本地DNS条目。对该服务的调用会动态随机映射到某个健康Pod实例的IP。服务还可以用于重新映射端口。在Kubernetes虚拟网络中，可以使用以下格式的使用完全域名来调用服务：“<service-name>.<namespace-name>.svc.cluster.local”，可以将其缩写为 “<service-name>.<namespace-name>” 或在属于相同名称空间Namespace的情况下仅为“<service-name>”。比方说，在“finance” 的名称空间下调用RESTful服务“payment”，就可以在代码中根据调用代码的位置来决定是“http://payments.finance.svc.cluster.local”，“http://payments.finance”或只是“http://payments”。

要从外部网络访问本地服务，Kubernetes要求为每个服务创建一个Ingress。 最常见的形式是使用一个或多个带有静态IP地址的负载均衡器，该负载均衡器位于Kubernetes虚拟基础架构之外，并将网络请求路由到映射的内部服务。 通过为负载均衡器的静态IP地址创建外部DNS条目，可以将服务映射到外部完全限定域名。 例如，如果我们的负载均衡器映射到“* .jenkins-x.io”，那么我们的付款服务可能会显示为“http://payments.finance.jenkins-x.io”。

Kubernetes代表了一个强大且不断更新的可用于大规模部署服务的平台。但是一般研发人员也很难理解和操作Kubernetes的负责配置。 Jenkins X为Kubernetes带来了一组默认配置和一些简化的工具，这些工具目的就是优化DevOps和简化松耦合服务的管理。

“jx”命令行工具提供了对Kubernetes实例进行一些常见操作的简单方法，例如查看日志和连接到容器实例。 此外，Jenkins X通过扩展Kubernetes命名空来创建Environments，这些Environments可以流水线的方式链接在一起形成不断升级的发布管道。

Jenkins X Environment可以给研发团队的一个给定虚拟基础架构环境，例如Dev，Staging，Production等。 通过定义环境之间的升级规则，构建完的代码可以在流水线里的各个环境上进行自动或手动发布。 每个环境均按照GitOps方法进行管理-环境的状态在Git存储库里来维护，向Git存储库提交或回滚变更会触发Kubernetes中给定环境状态的相应改变。 

在Jenkins X的系统里，我们可以使用`jx create cluster`命令直接创建Kubernetes集群，从而在发生故障时轻松地复制集群。同样，我们可以使用“jx upgrade platform” 在现有集群上升级Jenkins X平台。 Jenkins X支持通过`jx context`处理多个Kubernetes集群，并支持`jx environment`切换在同一个集群中的不同环境。

开发人员应了解Kubernetes提供在整个群集中分发配置和安全凭证的功能。 ConfigMap可用于为非机密配置元数据创建名称/值对name/value pairs的集合，同时Secrets则对安全凭证和令牌执行加密保护的机制。 Kubernetes还提供了一种为Pod指定资源配额的机制，这对于优化跨节点的部署是必要的，我们将在稍后讨论。

默认情况下，Pod状态为瞬态。删除该Pod时，写入Pod本地文件系统的所有数据都会丢失。开发人员应注意，作为Node常规负载平衡过程的一部分，Kubernetes可能会在任何时候单方面决定删除Pods实例并重新创建它们，因此本地数据可能随时丢失。如果需要保存状态数据，则需要声明持久保留的储存空间，并将其安装在特定Pod的文件系统中。

### Helm and Draft
用户如果直接与Kubernetes交互，可以使用`kubectl`命令行进行手动配置，或将各种类型的YAML数据传递给Kubernetes API Server。 这个操作过程可能很复杂，并且容易出现人为错误。根据DevOps的“将代码配置为代码”原则，Jenkins X利用Helm和Draft两个开源软件来为用户的应用程序创建原子配置单元。

Helm通过Chart的方式简化了Kubernetes的配置。Chart是一组文件，这些文件共同指定了将给定应用程序或服务部署到Kubernetes中所需的元数据。 Helm并没有使用基于Kubernetes API的一系列样板YAML文件，而是使用模板语言从单个共享值集来创建所需的YAML规范文件。 这使得在可重用的Kubernetes应用程序进行部署时，可以选择性地重新定义配置。



