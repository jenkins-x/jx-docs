---
title: 快速入门
linktitle: 快速入门
description: 如何创建快速入门应用并导入 Jenkins X
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
menu:
  docs:
    parent: "developing"
    weight: 45
weight: 45
sections_weight: 45
categories: [fundamentals]
draft: false
toc: true
---

你可以由预制的应用开始一个项目，而不是从头开始。 
                
你可以通过命令 [jx create quickstart](/commands/jx_create_quickstart) ，从我们预制的快速应用列表中创建一个新的应用。

```shell
$ jx create quickstart
```

然后，根据列表选择一个。

如果你清楚列表中你所需要的语言，可以进行如下过滤：

```shell
$ jx create quickstart  -l go
```

或者使用文本过滤器对项目名称做过滤：

```shell
$ jx create quickstart  -f http
```

### 当你选择快速入门时的细节

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

### 快速入门的原理？

快速入门的源码托管在 [the jenkins-quickstarts Github organisation](https://github.com/jenkins-x-quickstarts)。

When you create a quickstart we use the [Jenkins X build packs](https://github.com/jenkins-x/draft-packs) to match the right pack for the project using the source code language kinds to pick the most suitable match.
当你创建完成后，我们根据工程源码的语言，使用 [Jenkins X build packs](https://github.com/jenkins-x/draft-packs) 来匹配最合适的构建。

When you use [jx create](/getting-started/create-cluster/), [jx install](http://localhost:1313/getting-started/install-on-cluster/) or [jx init](/commands/jx_init/) the [Jenkins X build packs](https://github.com/jenkins-x/draft-packs) are cloned into your `~/.jx/draft/packs` folder.
当你使用 [jx create](/getting-started/create-cluster/)， [jx install](http://localhost:1313/getting-started/install-on-cluster/) 或者 [jx init](/commands/jx_init/) 时，[Jenkins X build packs](https://github.com/jenkins-x/draft-packs) 会克隆到目录 `~/.jx/draft/packs` 中。

e.g. you can view all the languages supported via build packs on your machine via:
例如：你可以通过下面命令查看支持的所有语言：

```shell
ls -al ~/.jx/draft/packs/github.com/jenkins-x/draft-packs/packs
```

Then when you create a quickstart, use [jx create spring](/developing/create-spring/) or [jx import](developing/import/) then the [Jenkins X build packs](https://github.com/jenkins-x/draft-packs) are used to:

* find the right language pack. e.g. here are the current [list of language packs](https://github.com/jenkins-x/draft-packs/tree/master/packs).
* the language pack is then used to default these files if they don't already exist:
  * `Dockerfile` to package the application as a docker image
  * `Jenkinsfile` to implement the CI / CD pipelines using declarative pipeline as code
  * Helm Charts to deploy the application on Kubernetes and to implement [Preview Environments](/about/features/#preview-environments)
   
## 增加你自己的快速入门

If you would like to submit a new Quickstart to Jenkins X please just [raise an issue](https://github.com/jenkins-x/jx/issues/new?labels=quickstart&title=Add%20quickstart&body=Please%20add%20this%20github%20quickstart:) with the URL in GitHub of your quickstart and we can fork it it into the [quickstart organisation](https://github.com/jenkins-x-quickstarts) so it appears in the `jx create quickstart` menu.

Or if you are part of an open source project and wish to curate your own set of quickstarts for your project; you can [raise an issue](https://github.com/jenkins-x/jx/issues/new?labels=quickstart&title=Add%20quickstart&body=Please%20add%20this%20github%20quickstart:) giving us details of the github organisation where the quickstarts live and we'll add that in as a default organisation to include in the [jx create quickstart](/commands/jx_create_quickstart) command. Its easier for the [jx create quickstart](/commands/jx_create_quickstart) if you maintain the quickstarts in a separate quickstart organisation on github.

Until we do that you can still use your own Quickstarts in the `jx create quickstart` command via the `-g` or `--organisations` command line argument. e.g.

```shell
$ jx create quickstart  -l go --organisations my-github-org
```

Then all quickstarts found in `my-github-org` will be listed in addition to the Jenkins X quickstarts.
