---
title: 快速开始
linktitle: 快速开始
description: 如何创建快速开始应用并导入 Jenkins X
---

你可以由预制的应用开始一个项目，而不是从头开始。

你可以通过命令 [jx create quickstart](/commands/jx_create_quickstart/) ，从我们预制的快速应用列表中创建一个新的应用。

```sh
jx create quickstart
```

然后，根据列表选择一个。

如果你清楚列表中你所需要的语言，可以进行如下过滤：

```sh
jx create quickstart  -l go
```

或者使用文本过滤器对项目名称做过滤：

```sh
jx create quickstart  -f http
```

### 当你选择快速开始时的细节

一旦你选择项目并命名后，下面的步骤会自动完成：

* 在子目录中创建应用
* 把你的代码添加到 git 库中
* 在 git 服务上添加远程库，例如： [GitHub](https://github.com)
* 推送代码到远程库
* 添加默认文件：
  * `Dockerfile` to build your application as a docker image
  * `Dockerfile` 把你的应用构建为 docker 镜像
  * `Jenkinsfile` to implement the CI / CD pipeline
  * `Jenkinsfile` 实现 CI / CD 流水线
  * 在 Kubernetes 中通过 helm chart 运行你的应用
* 为你的 Jenkins 在 git 远程库上注册 webhook
* 为你的 Jenkins 添加 git 库
* 首次触发流水线

### 快速开始的原理？

快速开始的源码托管在 [the jenkins-quickstarts GitHub organisation](https://github.com/jenkins-x-quickstarts)。

当你创建完成后，我们根据工程源码的语言，使用 [Jenkins X build packs](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes) 来匹配最合适的构建。

当你使用 [jx create](/zh/docs/getting-started/setup/create-cluster/)， [jx install](/docs/resources/guides/managing-jx/common-tasks/install-on-cluster/) 或者 [jx init](/commands/deprecation/) 时，[Jenkins X build packs](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes) 会克隆到目录 `~/.jx/draft/packs` 中。

例如：你可以通过下面命令查看支持的所有语言：

```sh
ls -al ~/.jx/draft/packs/github.com/jenkins-x/draft-packs/packs
```

你可以使用 [jx create spring](/zh/docs/resources/guides/using-jx/common-tasks/create-spring/) 或 [jx import](developing/import/) 来快速创建，这时 [Jenkins X build packs](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes) 会进行下面的步骤：

* 找到对应的语言包。当前包括 [list of language packs](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes/tree/master/packs)。
* 当文件不存在时，语言包会实现默认的：
  * `Dockerfile` 将程序打包为 docker 镜像
  * `Jenkinsfile` 使用申明式流水线（pipeline）实现持续构建、持续部署
  * Helm Charts 在 Kubernetes 上部署程序，并且实现 [预发环境](/about/concepts/features/#preview-environments)

## 添加你自己的快速开始

如果你想要提交一个新的快速开始给 Jenkins X，请把你 GitHub中的链接[提交问题](https://github.com/jenkins-x/jx/issues/new?labels=quickstart&title=Add%20quickstart&body=Please%20add%20this%20github%20quickstart:) 到[快速开始组织](https://github.com/jenkins-x-quickstarts)，然后它就会出现在菜单 `jx create quickstart` 中。

或者，你是开源项目的一份子，希望管理一套你们项目的快速开始；你可以[提交问题](https://github.com/jenkins-x/jx/issues/new?labels=quickstart&title=Add%20quickstart&body=Please%20add%20this%20github%20quickstart:)，把你们的GitHub组织详细信息给我们，然后我们会它作为默认的组织添加到命令 [jx create quickstart](/commands/jx_create_quickstart/) 中。如果你把快速开始作为一个单独的 GitHub 组织来维护的话，对于 [jx create quickstart](/commands/jx_create_quickstart/) 会更容易些。

在我们完成这些事情之前，你还是可以在命令 `jx create quickstart` 中通过参数 `-g` or `--organisations` 来实现。

```sh
jx create quickstart  -l go --organisations my-github-org
```

在 `my-github-org`中可以找到所有 Jenkins X 需要的快速开始。
