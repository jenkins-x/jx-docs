---
title: 源码
linktitle: 源码
description: 多个源码仓库的位置
---

Jenkins X 建立在巨人的肩膀上，并且拥有许多不同的源码仓库，从 CLI 工具、Docker 镜像、Helm 图表到[插件应用](/docs/contributing/addons/)来做各种各样的事情。

这个页面列出了主要的组织和仓库。

## 组织

* [jenkins-x](https://github.com/jenkins-x) 源码的主要组织
* [jenkins-x-apps](https://github.com/jenkins-x-apps) 包括 Jenkins X 的标准[插件应用](/docs/contributing/addons/)
* [jenkins-x-buildpacks](https://github.com/jenkins-x-buildpacks) 包括可用的[构建打包](/docs/resources/guides/managing-jx/common-tasks/build-packs/)
* [jenkins-x-charts](https://github.com/jenkins-x-charts) 我们分发的主要 helm 图表
* [jenkins-x-images](https://github.com/jenkins-x-images) 包括一些自定义的 docker 镜像构建
* [jenkins-x-quickstarts](https://github.com/jenkins-x-quickstarts) 通过[创建快速开始](/docs/getting-started/first-project/create-quickstart/)使用的快速开始项目
* [jenkins-x-test-projects](https://github.com/jenkins-x-test-projects) 我们在测试用例中使用的项目

## 仓库

在这里我们列出上面组织的一些主要仓库

* [jenkins-x/jx](https://github.com/jenkins-x/jx) 创建 `jx` CLI 和可重用的流水线步骤的主要仓库
* [jenkins-x/jx-docs](https://github.com/jenkins-x/jx-docs) 基于 Hugo 的文档，用来生成网站
* [jenkins-x/bdd-jx](https://github.com/jenkins-x/bdd-jx)  我们用来验证平台变更以及用来验证 [jenkins-x/jx](https://github.com/jenkins-x/jx) 上 PR 的 BDD 测试
* [jenkins-x/jenkins-x-platform](https://github.com/jenkins-x/jenkins-x-platform) Jenkins X 平台主要合成物的 helm 图表
* [jenkins-x/jenkins-x-versions](https://github.com/jenkins-x/jenkins-x-versions) 包括[版本流](/about/concepts/version-stream/) - 所有 _图表_ 和 CLI _包_ 的稳定版本
* [jenkins-x/cloud-environments](https://github.com/jenkins-x/cloud-environments) 不同 cloud providers 的 helm 配置
 
### 构建 pods 和 镜像

* [jenkins-x/jenkins-x-builders](https://github.com/jenkins-x/jenkins-x-builders) 生成静态 jenkins 服务的构建 pod 和 docker 镜像
* [jenkins-x/jenkins-x-image](https://github.com/jenkins-x/jenkins-x-image) 为我们默认使用的静态 jenkins 服务器生成 docker 镜像
* [jenkins-x/jenkins-x-serverless](https://github.com/jenkins-x/jenkins-x-serverless) 当使用 [prow](/architecture/prow/) 时生成 [serverless jenkins](/news/serverless-jenkins/) docker 镜像

### 工具

* [jenkins-x/exposecontroller](https://github.com/jenkins-x/exposecontroller) 用来生成或更新 `Ingress` 资源（或 OpenShift 中的 `Route` ）的 `Deployment` 或 `Job`。如果你修改了你的 DNS 域或开启了 TLS ，它可以通过 `ConfigMap` 注入用来注入外部 URLs 到你的应用中。
* [jenkins-x/updatebot](https://github.com/jenkins-x/updatebot) 一个我们用来为库、可执行文件、图表和镜像执行持续交付的命令行机器人。例如：当一个新的上游发布完成后，我们在下游依赖的 git 仓库中生成 Pull Requests。
