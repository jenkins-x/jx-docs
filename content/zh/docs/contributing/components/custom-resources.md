---
title: 自定义资源
linktitle: 自定义资源
description: 由 Jenkins X 自定的资源
---

Kubernetes 提供了一个叫做[自定义资源](https://kubernetes.io/docs/concepts/api-extension/custom-resources/)的扩展机制，它允许微服务扩展 Kubernetes 平台来解决更高级的问题。

因此，在 Jenkins X 中定义了若干个自定义资源来扩展 Kubernetes 支持 CI/CD：

### 环境

Jenkins X 原生地支持[环境](/zh/docs/concepts/features/#environments)，允许为你们团队定义环境，并通过 [jx get environments](/commands/jx_get_environments/) 查询：

```sh
jx get environments
```

以下的命令都使用 Kubernetes 自定义资源`环境`。

因此，你还可以通过 [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) 查询环境：

```sh
kubectl get environments
```

或者你想要通过 `YAML` 直接编辑它们的话：

```sh
kubectl edit env staging
```

尽管，你使用命令 [jx edit environment](/commands/jx_edit_environment/) 会更容易。

### 发版

Jenkins X 流水线生成了一个自定义资源 `发版`，我们可以用来跟踪：

* 版本、git 标签、git 地址映射到 Kubernetes/Helm 中的发版
* Jenkins 流水线地址和执行日志用于执行发布
* 提交日志、问题和 Pull Requests 是每次发版的一部分，因此我们可以实现[在 Staging/生产环境中修复的问题反馈](/zh/docs/concepts/features/#feedback)


### 流水线活动

该资源保存了基于 Jenkins 流水线阶段以及 [升级活动](/docs/concepts/features/#promotion) 的流水线状态

该资源还会被命令 [jx get activities](/commands/jx_get_activities/) 用到
