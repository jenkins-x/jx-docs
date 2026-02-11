---
title: 给 Jenkins X 项目做贡献
linktitle: 给 Jenkins X 项目做贡献
description: 给 Jenkins X 项目做研发和文档贡献。
weight: 10
---

Jenkins X 在很大程度上依赖于开源社区的热情参与。我们需要你，所以请加入我们！这里有很多方式提供帮助：

* [给我们反馈](community/)。 我们还可以改进什么？你不喜欢什么或者你认为缺少什么？
* 帮助 [改进文档](documentation/)，以便更清楚地了解如何开始使用Jenkins X。
* [添加您自己的快速入门](/zh/docs/getting-started/first-project/create-quickstart/#adding-your-own-quickstarts) 以便 Jenkins X 社区可以使用您的快速入门轻松引导新项目。如果你在为一个开源项目工作，那么这个项目是否可以作为一个好的快速入门项目添加到 Jenkins X 当中。
* 创建一个 [插件](/zh/about/concepts/features/#应用)。要添加自己的插件，只需创建一个 Helm Chart ，以获得扩展 Jenkins X，然后提交一个 Pull Request 在 [the pkg/kube/constants.go file](https://github.com/jenkins-x/jx/blob/master/pkg/kube/constants.go#L32-L50) 来添加你的 chart 的名称匹配到`AddonCharts`。
* 如果你想要 [贡献代码](development/) 那么尝试浏览 [当前问题](https://github.com/jenkins-x/jx/issues).
  * 我们已经标记了问题 [需要帮助](https://github.com/jenkins-x/jx/issues?q=is%3Aopen+is%3Aissue+label%3A%22help+wanted%22) 或者 [好的首个问题](https://github.com/jenkins-x/jx/issues?q=is%3Aopen+is%3Aissue+label%3A%22good+first+issue%22) 为你节省寻找问题的时间。
  * 我们特别乐意帮助您 [在 Windows 上运行 Jenkins X](https://github.com/jenkins-x/jx/issues?q=is%3Aopen+is%3Aissue+label%3Awindows) 或者 [和云服务，git 提供程序以及问题跟踪器集成](https://github.com/jenkins-x/jx/issues?q=is%3Aissue+is%3Aopen+label%3Aintegrations)。
 * 为了更长远的目标，我们制定了 [长期路线图](roadmap)。
 * 我们总是接收更多的测试用例并提高测试覆盖率。
