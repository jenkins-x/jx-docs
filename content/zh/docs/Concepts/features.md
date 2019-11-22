---
title: 特色
linktitle: 特色
description: Jenkins X 如何帮助你做持续交付
date: 2018-04-21
publishdate: 2018-04-21
lastmod: 2018-04-30
---

## 命令行

Jenkins X 带来了一个方便使用的命令行工具 [jx](/commands/jx/) ：

* [安装 Jenkins X](/zh/docs/getting-started/setup/install/) 到你已经存在的 Kubernetes 集群
* [创建一个新的 kubernetes 集群](/zh/docs/getting-started/setup/create-cluster/) 并把 Jenkins X 安装进去
* [导入项目](/zh/developing/import) 到 Jenkins X 中以及他们的持续部署流水线设置
* [创建新的 Spring Boot 应用](/zh/developing/create-spring) 并导入 Jenkins X 中，以及他们的持续部署流水线设置

## 流水线

不必深入了解 Jenkins 流水线的内部，Jenkins X 会默认给你的项目提供一些很好的流水线——基于[DevOps 最佳实践](/zh/about/concepts)实现了所有的持续集成和持续部署

## 环境

环境指的是应用部署的地方。开发人员通常使用缩写来描述环境，例如：“测试中（Testing）、Staging/UAT或者生产（Production）”。

在 Jenkins X 中每个团队都有一套自己的环境。默认情况下，Jenkins X 会给每个团队创建一个 `Staging` 和 `生产` 环境，但你可以通过命令 [jx create environment](/commands/jx_create_environment/)创建一个新的环境。

我们使用 GitOps 来管理要部署到每个环境中的 Kubernetes 资源的配置和版本。因此，每个环境都有自己的 git 仓库，应用在这个环境中运行需要的 Helm Charts、版本以及配置都在库中。

在 Kubernetes 集群中一个环境对应一个命名空间。当 Pull Requests 被合并到环境所在的 git 库后，该环境的流水线就会把 git 库中的 Helm Charts 应用到环境命名空间中。

这意味着开发和运维都可以在同一个 git 库中，管理应用和资源在某个环境中的所有配置和版本，并且对环境的所有改变都可以在 git 中获取到。因此，这样很容易看到是谁作出的改变，而且，更重要的是当发生问题后很容易回滚改变。

## 部署升级

部署升级是通过 GitOps 在环境关联的 git 库上发起一个 Pull Requests 来实现的，这样所有的改变都通过 git 来审查、批准，因此所有的改变的都很容易回滚。

当环境所关联的 git 库上有新的变化合并到 master 后，环境的流水线就会触发，helm 就会把任何改变应用到资源上。

Jenkins X 的持续部署流水线把改变了的版本自动做部署升级，这是需要把配置中的”部署升级策略“设置为”自动“。默认情况下，”Staging“环境使用自动部署升级，而”生产“环境使用”手动“部署升级。

要手动把某个版本的应用部署升级到一个环境中的话，你可以使用[jx promote](/developing/promote/)命令。

<img src="/images/overview.png" class="img-thumbnail">

## 预发环境

Jenkins X 允许你给 Pull Requests 设置一个预发环境，这样就可以在变更后并到 master 之前得到更多的反馈。这使你的变更在被合并以及发布之前更快得到反馈，并允许你避免在你的发版流水线中有人为的批准，加速变更在合并后的部署。

当预发环境启动并运行后，Jenkins X 将会在你的 Pull Requests 中添加一个带链接的评论，这样你们团队的成员就可以点击来尝试它！

<img src="/images/pr-comment.png" class="img-thumbnail">

## 反馈

正如在上面看到的，当你使用预发环境时，Jenkins X 会在你的 Pull Requests 上自动添加评论。

如果你在提交日志中引用了 issues（例如：通过文本`fixes #123`），那么，Jenkins X 流水线将会生成发版记录，例如： [the jx releases](https://github.com/jenkins-x/jx/releases)。

同样地，在升级到`Staging`或者`生产`环境时，这些版本上也会在已修复的问题上自动添加对应环境可用的评论。例如：

<img src="/images/issue-comment.png" class="img-thumbnail">


## 应用

一些最好的软件工具已经被打包为 helm charts，部分预先集成在了 Jenkins X 中，例如：Nexus、ChartMuseum、Monocular、Prometheus、Grafana等等。

### 插件

部分应用是内置的；例如：Nexus、ChartMuseum、Monocular。其他的则是作为“插件”提供的。

要安装插件的话，使用命令[jx create addon](/commands/jx_create_addon/)。例如：

```sh
jx create addon grafana
```
