---
title: 加速
linktitle: 加速
description: Jenkins X 用到了哪些在《Accelerate》一书中提及的能力
date: 2018-07-01
publishdate: 2018-07-01
lastmod: 2018-07-01
menu:
  docs:
    parent: "about"
    weight: 10
weight: 10
sections_weight: 0
draft: false
categories: [fundamentals]
toc: true
---

<img src="/images/accelerate.jpg" class="img-thumbnail">

Jenkins X 重新构思了云原生时代下的 CI/CD 实现，这些想法受到了 DevOps 状态报告和近来大热的[《Accelerate》](https://www.amazon.co.uk/Accelerate-Software-Performing-Technology-Organizations/dp/1942788339)一书的深刻影响，这本书的三位合著者分别是：[Nicole Forsgren](https://twitter.com/nicolefv)、[Jez Humble](https://twitter.com/jezhumble)以及[Gene Kim](https://twitter.com/RealGeneKim?)。 

经年累月基于真实世界中的团队和组织收集上来的数据被 DevOps 领域的思想领袖和数据科学家们进行了深入的分析。《Accelerate》一书总结了一组有助于实施 DevOps 的能力，这些能力被 Jenkins X 实现以帮助用户以开箱即用的方式获取到科学证明过的收益。我们会从已经实现的能力项入手，并不断整合更多的能力进来。

<img src="/images/capabilities_zh.png" class="img-thumbnail">

# 对所有构件进行版本控制

来自 Weaveworks 的天才们创造了 GitOps 的概念，这一点我们非常认同。对环境的任何变更，无论是一个新的应用，版本升级，资源约束变更，还是简单的应用配置，都应该在 Git 上提交一个 Pull Request ，并且采用类似环境的持续集成对这些变更进行验证，并且经过团队的审核，这个团队负责所有相关环境的变更控制。于是针对一个环境的任何变更都可以被追溯并且达到受控状态。

_关联的加速能力项：对所有生产构件进行版本控制_

# 自动化部署过程

## 环境

Jenkins X 在安装过程中会自动创建基于 Git 的环境，并且使用`jx create environment`命令来轻松地创建新的环境。此外，当通过quickstart(`jx create quickstart`)创建一个新的基于 Java 中 SpringBoot (`jx create spring`) 应用，或者导入已有应用(`jx import`)时，Jenkins X 都会自动帮你添加 CI/CD 流水线，并配置相关任务、git 代码仓库、webhook 来启用自动化部署流程。

Jenkins X 开箱即用地创建了永久的预发布和生产环境（这个是可配置的）以及一个 Pull Request 阶段临时使用的应用预览环境。

### 预览环境

在一个变更被合入主干之前，我们希望尽可能的进行测试、安全、验证和试验工作。使用临时动态创建的预览环境，任何 Pull Request 都会生成有一个预览版本被构建和部署，包括引用了公共库的下游应用。这就意味着我们可以同任何关联团队进行代码评审，测试和更好的协作，来确认这次变更可以部署到生产环境。

Jenkins X 的终极目标是提供一种方式，帮助开发人员、测试人员、设计人员和产品经理来验证将要合入主干的变更完全符合预期。我们希望确信这次变更没有对任何服务或特性带来负面影响，并且按照预想的那样来交付价值。

让预览环境变得真正有趣的是，当我们能够在不同阶段和成熟度的情况下进行 PR，也就是我们可以导入一定比例的真实生产环境流量，比如 beta 用户。那么我们可以分析此次变更的价值，并且使用假设驱动开发的方式运行多种自动化试验。这会帮助我们更好的理解当变更推送给所有用户时的效果。

_关联的加速能力项：培养和支持团队试验_

使用预览环境是导入自动化测试的绝佳方式。虽然 Jenkins X 支持这种方式，但是我们尚没有针对预览环境进行自动化测试的例子。一个最简测试集合应该可以确保应用正常启动，并且通过一段时间的 Kubernetes 的有效性（liveness）检查。相关内容包括：

_关联的加速能力项：实施自动化测试_

_关联的加速能力项：自动化部署过程_

### 永久环境

在软件开发中，我们习惯于在变更部署到生产环境之前在多套环境中验证。尽管这看起来没什么问题，但是如果在真正合并到主干之前，某些流程证明它并不合适，这就有可能导致其他变更的严重延迟。后续提交都会阻塞，并且紧急生产环境变更也同样会被推迟。

Jenkins X 希望所有变更和试验在合并主干之前都经过验证。变更在预发布环境中经过一段时间的验证后在推送到生产环境，理想情况下使用自动化的方式。

Jenkins X 的默认流水线提供了环境间自动化部署的能力。它可以被定制以适配你自己的 CI/CD 流水线要求。

Jenkins X 认为预发布环境应该尽可能的模拟生产环境，理想情况下使用服务网格技术导入真实生产数据来验证真实行为。着同样有助于预览环境的变更部署，我们可以将其链接到预发布中的非生产服务。

_关联的加速能力项：自动化部署过程_

# 使用主干开发分支策略

《Accelerate》一书的研究发现那些使用短分支生命周期并基于主干开发的团队拥有更好的效能。这对于 Jenkins X 核心团队成员而言再熟悉不过，所以 Jenkins X 通过配置 Git 仓库和 CI/CD 任务即可轻松实现这个能力。

# 实施持续集成

Jenkins X 将 CI 视为一个变更经过 Pull Request 合入主干前的验证活动。自动化配置代码仓库，Jenkins 和 Kubernetes 来提供开箱即用的持续集成功能。

# 实施持续交付

Jenkins X 将 CD 视为一个变更合入主干后到线上环境运行的活动。Jenkins X 将发布流水线中的大部分环境自动化：

Jenkins X 建议使用语义化版本号。采用 git 标签来计算下一次发布版本意味着无需在主干分支中保存最新的版本号。当发布系统将最新的和下一次版本保存在 git 仓库中，这会让 CD 变得困难，因为发布流水线中的变更会触发一次新的发布，这会导致递归的发布触发器。使用 git 标签可以避免这种情况来实现 Jenkins X 的完整自动化流程。

Jenkins X 会基于每一次针对主干的变更自动创建一个发布版本，这个版本就是潜在部署到生产环境的版本。

# 使用松耦合的架构

Jenkins X 面向 Kubernetes 用户，这让它可以受益于多种云的特性来设计和开发松耦合的解决方案。服务发现、容错性、扩展性、健康检查、滚动升级、容器编排和调度等仅仅是 Kubernetes 所带来的部分能力。

# 赋能团队的架构

Jenkins X 旨在帮助多语言的应用开发者。目前 Jenkins X 具备自动语言检测能力的 quickstart 和自动化 CI/CD 配置，比如 Golang, Java, NodeJS, .Net, React, Angular, Rust, Swift 以及更多语言支持。这样做也提供了一个持续性的工作方式来让开发者更加专注于开发活动。

Jenkins X 同样提供了很多插件，比如自动化度量数据收集和可视化工具：Grafana 和 Prometheus。集中化的度量可以帮助我们查看构建和部署在 Kubernetes 上的应用指标。

[DevPods](https://jenkins-x.io/developing/devpods/) 是一个全新的特性，可以帮助开发人员在本地 IDE 中编辑代码，并自动化同步到云环境上进行构建和重新部署。

Jenkins X 相信自动化可以帮助开发者在云环境下进行试验，使用不同的技术，并通过反馈让他们更快的做出最佳决策。
