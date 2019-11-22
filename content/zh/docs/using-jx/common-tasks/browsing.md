---
title: 浏览
linktitle: 浏览
description: 浏览 Jenkins X 中的资源
---


如果你之前用过 Kubernetes，你可能使用过 [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) 命令查看 Kubernetes 资源：

```sh
kubectl get pods
```

Jenkins X 的命令行工具，[jx](/commands/jx/)，和 [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) 看起来相似，并且可以让你看到所有的 Jenkins X 资源。

### 查看 Jenkins 控制台

如果你熟悉 Jenkins 控制台，那么你可以使用 [jx console](/commands/jx_console/) ：

```sh
jx console
```

就会打开一个浏览器。

### 流水线

要查看当前流水线使用 [jx get pipelines](/commands/jx_get_pipelines/):

```sh
jx get pipelines
```

### 流水线构建日志

通过 [jx get build logs](/commands/jx_get_build_log/) 查看当前流水线构建日志：

```sh
jx get build logs
```

你当前看到的是所有能看到的流水线。

你可以通过下面快速过滤

```sh
jx get build logs -f myapp
```

或者，你希望指定

```sh
jx get build logs myorg/myapp/master
```

### 流水线活动

为了查看当前流水线的活动 [jx get activities](/commands/jx_get_activities/)：

```sh
jx get activities
```

如果你想要观察你的应用 `myapp`，你可以使用：

```sh
jx get activities -f myapp -w
```

这样将会观察流水线的活动，并无论任何重要的改变发生（例如：发版完成，一个 PR 被创建开始[升级](/zh/developing/promote) 等等）都会更新屏幕。

### 应用程序

为了查看你的团队所有环境的所有应用的URL和 pod 数量，使用 [jx get applications](/commands/jx_get_applications/)：


```sh
jx get applications
```

如果你想要隐藏 URL 或者 pod 数量，你可以使用 `u` 或 `-p`。例如：为了隐藏 URL：

```sh
jx get applications -u
```

或者隐藏 pod 数量：

```sh
jx get applications -p
```

你还可以根据环境来过滤应用：

```sh
jx get applications -e staging
```



### 环境

为了查看你们团队中的 [环境](/zh/docs/concepts/features/#environments)，使用 [jx get environments](/commands/jx_get_environments/)：

```sh
jx get environments
```

你还可以

* 通过 [jx create environment](/commands/jx_create_environment/) 创建一个新的环境
* 通过 [jx edit environment](/commands/jx_edit_environment/) 编辑环境
* 通过 [jx delete environment](/commands/jx_delete_environment/) 删除环境
