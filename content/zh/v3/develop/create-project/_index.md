---
title: "创建项目"
date: 2017-01-05
weight: 30
type: docs
description: >
  现在，已经安装好了平台，开始创建你的第一个项目。
---

想要创建或者导入项目的话，你需要下载 [jx 3.x 二进制文件](/v3/guides/jx3/)，并移动到你的环境变量 `$PATH` 下。


## 基于快速入门创建一个新项目

通过命令 [jx project quickstart](https://github.com/jenkins-x/jx-project/blob/master/docs/cmd/project_quickstart.md) 来根据快速入门的模板创建一个新的项目:

```bash 
jx project quickstart
``` 

注意，旧版本 Jenkins X 2.x 的别名 `jx quickstart` 仍然可以使用，但最终会被弃用。

查看[快速入门文档](/docs/create-project/creating/)获取更多信息

## 导入已存在的项目

通过命令 [jx project import](https://github.com/jenkins-x/jx-project/blob/master/docs/cmd/project_import.md) 可以导入已有项目：

```bash
jx project import
```

查看[导入文档](/docs/create-project/creating/import/)获取更多信息

注意，旧版本的 Jenkins X 2.x 别名 `jx import` 仍然支持，但最终会被弃用。

### 通过 Jenkinfiles 导入项目

注意，如果你尝试将 Jenkins 和 Tekton 集成在 Jenkins X 中，Jenkins X 3.x 包含[最新对导入 Jenkinsfiles 的支持](jenkinsfile)。

这意味着我们可以创建快速入门，并可以使用相同的界面导入项目，复用已有的 `Jenkinsfile`（甚至在同一个项目中将二者结合）

## 顶层向导
               
如果你只是运行 [jx project](https://github.com/jenkins-x/jx-project/blob/master/docs/cmd/project.md) 你会得到一个顶层的向导，会提示你选择哪种方式（例如：quickstart、 import 等）

## v3 带来的改进

我们已经在 2.x 版本的[jx import](https://jenkins-x.io/commands/jx_import/)基础上做了很多改进：

* 当导入 Jenkins X 时，会提示你想要使用哪个 pipeline catalog 然后[可以简单地配置](/v3/about/extending/#pipeline-catalog)
* 这个向导会根据语言的检测提示你。通常，检测是可用的，例如：检测到 `maven` 但是你可能想要选择特定版本（例如：`maven-java11`）
* 当你导入的项目中包含了 `Jenkinfiles` 时，可以有如下的选择：
  * 忽略 `Jenkinsfile` 并让 Jenkins X 通过 Tekton 自动化 CI/CD 
  * 使用 Jenkins X 已经配置好的一个 Jenkins 服务来实现 CI
  * 在 Jenkins X 中增加一个由 GitOps 管理的新的 Jenkins 服务
  * 通过 Tekton 使用 Jenkinfile Runner
  

### 2.x 的变更：

对于已经知道 [Jenkins X](https://jenkins-x.io/) 并且之前使用过 [jx import](https://jenkins-x.io/commands/jx_import/)，那么创建项目的向导有一些不同：

* 以下命令会有些不同：

  * `jx create import` 变为 `jx project import`
  * `jx create quickstart` 变为 `jx project quickstart`
  * `jx create project` 变为 `jx project`
  * `jx create spring` 变为 `jx project spring`
