---
title: Kubernetes 上下文
linktitle: Kubernetes 上下文
description: 处理 Kubernetes 上下文
---


Kubernetes 命令行工具 [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) 通过本地文件 `~/.kube/config`（会在 `$KUBECONFIG` 的文件） 记录你使用的 Kubernetes 集群和命名空间。

如果你想要改变命名空间，你可以使用 kubectl 命令行：

```sh
kubectl config set-context`kubectl config current-context` --namespace=foo
```

然而 [jx](/commands/jx/) 还提供了很多有用的命令，用来改变集群、命名空间或环境：

### 切换环境

使用 [jx environment](/commands/jx_environment/) 来切换 [环境](/zh/docs/concepts/features/#environments)

```sh
jx environment
```

你将会看到当前团队的环境列表。使用方向键和回车来选择你想要切换的环境。或者按下 `Ctrl+C` 终止，不切换环境。

或者，如果你知道想要切换的环境，可以直接把它作为参数：

```sh
jx env staging
```

### 切换命名空间

使用 [jx namespace](/commands/jx_namespace/) 在 Kubernetes 不同的命名空间之间进行切换。


```sh
jx namespace
```

你会看到 Kubernetes 集群中所有命名空间的列表。使用方向键和回车选择你想要切换的。或者，按下 `Ctrl+C` 中断，不切换命名空间。

或者，如果你知道想要切换的 Kubernetes 命名空间，可以直接把它作为参数：

```sh
jx ns jx-production
```

### 切换集群

使用 [jx context](/commands/jx_context/) 在不同的 Kubernetes 集群（或者上下文）之间切换。

```sh
jx context
```

你会得到当前机器上所有上下文的列表。使用方向键或者回车选择你想要切换的。或者，按下 `Ctrl+C` 中断，不切换集群。

或者，如果你知道想要切换的 Kubernetes 集群，可以直接把它作为参数：

```sh
jx ctx gke_jenkinsx-dev_europe-west2-a_myuserid-foo
jx ctx minikube
```

### 本地变化

当前你通过 [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) 切换 Kubernetes 的命名空间或上下文，或上面提到的命令，那么 Kubernetes 会把 **你所有的终端** 都进行切换，因为它更新的是共享文件 (`~/.kube/config` 或 `$KUBECONFIG`)。

这样很方便——但有时候会有危险。例如：如果你想要在生产集群上做一些事情；但是，忘记了，然后在另外一个终端上执行命令要删除你的开发命名空间上所有的 pod——但是你忘记来刚刚切换到来生产命名空间上！

因此，如果通过一个 shell 命令来切换 Kubernetes 上下文或命名空间，有时候是很有帮助的。例如：如果你总是想要看一下集群中的生产环境，就只在那个 shell 中使用那个集群，这样可以减少事故。

你可以使用命令 [jx shell](/commands/jx_shell/) 提示你选择不同的 Kubernetes 上下文，例如：[jx context](/commands/jx_context/) 命令。然而，这样切换命名空间或集群就只能在当前 shell 中有效！

还有 [jx shell](/commands/jx_shell/) 通过 [jx prompt](/commands/jx_prompt/) 自动更新你的命令提示符，这样使得你的 shell 很清楚上下文或命名空间的修改。

### 定制你的 shell

你可以使用 [jx prompt](/commands/jx_prompt/) 把当前 Kubernetes 集群和命名空间添加到你的终端提示符中。

要为 [jx 命令](/commands/jx/) 添加命令自动补充，尝试 [jx 自动补充](/commands/jx_completion/) 。



