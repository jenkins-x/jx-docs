---
title: 预览
linktitle: 预览
description: 在变更合并到 master 之前预览 Pull Requests
---


我们强烈建议使用 [预览环境](/zh/about/concepts/features/#preview-environments) ，使得在变更合并到 master 之前尽快地得到反馈。

通常，预览环境是由 Jenkins X 的流水线中自动创建的。

然而，你可以使用 [jx](/commands/jx/) 通过命令 [jx preview](/commands/jx_preview/) 手动创建一个[预览环境](/zh/about/concepts/features/#preview-environments)。

```sh
jx preview
```

### 创建预览环境时都做了什么

* 一个新的 [环境](/zh/about/concepts/features/#environments) ，例如 `预览` 被创建时，一个 [kubernetes 命名空间](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) 会在 [jx get environments](/commands/jx_get_environments/) 出现， 使用 [jx 环境和 jx 命名空间命令](/zh/developing/kube-context) 你可以看到那个预览环境是活跃的，并可以进入查看。
* Pull Request 会作为预览 Docker 镜像和 chart 构建，并被部署到预览环境中
* 添加一条注释到 Pull Request 中，让你们团队知道该预览应用已经准备好可以测试了，并带有打开应用的链接。因此，只要点击一下就可以让你们团队成员体验预览环境！

<img src="/images/pr-comment.png" class="img-thumbnail">



