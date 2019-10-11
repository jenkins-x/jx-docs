---
title: 分类问题
linktitle: 分类问题
description: 如何对 Jenkins X 项目中的问题进行分类
---

Jenkins X 项目主要的问题跟踪系统是 https://github.com/jenkins-x/jx/issues。这旨在捕捉问题、想法和开发工作。如有疑问请提交一个问题，一名 Jenkins X 团队成员将考虑尽快给它分类。

由于 Jenkins X 使用来自 Kubernetes 生态的 [prow](/https://www.cloudbees.com/blog/serverless-jenkins-jenkins-x)，我们认为，我们应该带领他们参与处理分类大量问题，以帮助和鼓励贡献者。我们正在重用标签的样式，包括颜色，以尝试在跨开源项目时创建熟悉度，并减少贡献的障碍。

# 分类问题

所有可用标签列表请参考：https://github.com/jenkins-x/jx/labels

当对问题进行分类时，来自 Jenkins X 团队的某个成员将分配标签用来描述问题的 __area__ 和 __kind__ 。有可能，他们还将增加一个 priority ，但是，在进一步分析或更广泛的可见性之后，这些 priority 可能会发生变化。

标签通过 prow [label](https://prow.k8s.io/plugins) 插件使用 GitHub 评论被添加。例如：
```text
/kind bug
/area prow
/priority important-soon
```
![Triage](/images/contribute/triage.png)

# 分配问题

当进行分类时我们尝试将问题分配给某个人。这可能会随着调查或人员的可用性而改变。

# 调查问题

当任何人在处理一个问题时，我们的目的是通过添加注释来捕获任何分析。这有助于人们学习如何调查类似问题的技巧，帮助人们理解思考过程，并通过 pull request 为任何链接修复提供上下文。

# 新建标签

如果你想要请求创建一个新的标签，那么请提交一个问题并附带尽可能多的内容。

# 陈旧的问题

当我们鼓励广泛的问题类型，如一般的想法和想法，问题跟踪器可能增长得相当高。我们将启用 prow [lifecycle](https://prow.k8s.io/plugins) 插件来帮助管理陈旧的问题。这并不意味着具有侵入性，而是允许我们不断地重新思考问题，并保持跨问题的势头。