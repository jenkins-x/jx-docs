---
title: 通过 GitOps 管理
linktitle: 通过 GitOps 管理
description: 使用 GitOps 配置和升级你的 Jenkins X 设施
date: 2016-11-01
publishdate: 2016-11-01
lastmod: 2018-04-04
categories: [getting started]
keywords: [install,kubernetes]
---

我们推荐你使用 GitOps 管理你的 Jenkins X 设施，升级它、配置它、以及添加或移除扩展[应用](/docs/contributing/addons/)，这样容易审计谁在你的设施上做了什么变更并且容易恢复坏的变更。

当前这仅在 AWS 和 Google 云可用，因为它要求我们的 vault 操作员（需要云存储和 KMS ）存储凭据，而所有其他配置都存储在开发环境 git 仓库中。

## 使用 GitOps 管理 Jenkins X

如果你正在创建一个集群或者在已经存在的集群安装，这里有一种快速简便的方法来使用 GitOps 来管理 Jenkins X 本身。它是 `—ng` ，为下一代 Jenkins X 而来。在我们今年晚些时候发布 Jenkins X 2.x 时，我们会将此功能标记设为默认选项。


`—ng` 标记是这些标记的一个别名：`—gitops —vault —no-tiller —tekton` 。所以它还附带了对 [Jenkins X 流水线](/about/concepts/jenkins-x-pipelines/) - 基于 Tekton 的新式云原生流水线引擎的支持。

如果你仍然想要使用Jenkins服务器作为 Jenkins X 中自动化 CI/CD 流水线的执行引擎，那么你可以使用 `—gitops —vault` 代替。仍要注意是的即使使用了 `—ng` 以及使用了由 Tekton 驱动的 [Jenkins X 流水线](/about/concepts/jenkins-x-pipelines/),你仍然需要创建你自己的[自定义 Jenkins 服务器](/docs/resources/guides/managing-jx/common-tasks/custom-jenkins/)来运行传统的 Jenkins 任务和流水线。

一旦你使用 GitOps 安装了 Jenkins X 来管理开发环境，那么表明安装了 Jenkins X 和它的附加应用程序，你将为 Dev，Staging，Production 环境获得一个额外的 git 仓库。它也意味着如果你用一个更新命令如 [jx upgrade platform](/commands/deprecation/) 或通过 [jx add app](http://localhost:1313/commands/jx_add_app/) 添加、更新、删除应用，那么那些命令将在开发环境的 git 存储库生成 Pull Request ，就像当你发布新版本的微服务时， promotion 是如何工作的。


## 如果出现问题

一般来说，当使用 Tekton 时，Jenkins X 可以很容易地自我升级。但是，如果升级让 Jenkins X 无法实施 CI/CD ，那么使用 GitOps 回退更改将不起作用；）

如果你在升级 Jenkins X 过程中遇到任何问题，这里有一种手动方法可以应用开发环境的 git 存储库的内容：

```sh
git clone $MY_DEV_GIT_CLONE_URL jenkins-x-dev-env
cd jenkins-x-dev-env/env
jx step env apply
```
