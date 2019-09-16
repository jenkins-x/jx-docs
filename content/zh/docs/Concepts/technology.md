---
title: 技术性问题
linktitle: 技术
description: Kubernetes 以及关联的开源项目的技术问题
---

## 什么是 Helm?

[helm](https://www.helm.sh/) 是 Kubernetes 的开源包管理器。

它和其他的包管理工具（brew, yum, npm等）类似，有一个或者更多的包仓库可以安装（在 helm 中叫做 `charts` 和 kubernetes 的主题保持一致），可以搜索、安装和升级。

一个 [helm chart 基本上是带版本的 kubernetes yaml 压缩包](https://docs.helm.sh/developing_charts/#charts) ，可以轻松地安装在任何 kubnernetes 集群上。

Helm 通过文件 `requirements.yaml` 支持组合（一个 chart 可以包含其他 charts）。

## 什么是 Skaffold?

[skaffold](https://github.com/GoogleContainerTools/skaffold) 是一个开源的工具，用于在 Kubernetes 集群中构建 docker 镜像，并通过 `kubectl` 或 `helm` 部署、升级。

在 kubernetes 集群中构建 docker 镜像的挑战有几种方法来实现：

* 使用本地 docker daemon 和 kubernetes 集群的 socket
* 使用一个云服务，例如：Google Cloud Builder
* 使用无 docker-daemon，例如：[kaniko](https://github.com/GoogleContainerTools/kaniko) 不需要访问权限

Skaffold 的好处是把你的代码或 CLI 从细节中抽象出来；你可以在文件 `skaffold.yaml` 中配置构建 docker 镜像的策略，切换 docker daemon、GCB 或 kaniko等。

Skaffold 在 [DevPods](/docs/reference/devpods/) 中也很有用，当你改变代码后可以执行快速增量构建。

## Helm 和 Skaffold 比较？

`helm` 允许你安装、升级叫做 charts 的包，使用一个或者多个在一些 docker registry 中的 docker 镜像以及一些 kubernetes YAML 文件来安装、升级 kubernetes 集群中的应用。

`skaffold` 是一个用于执行 docker 构建的工具，也可以通过 `kubectl` 或 `helm` 重启部署应用——或者在一个 CI/CD 流水线中以及本地开发中使用。

Jenkins X 使用在它的 CI/CD 流水线中使用 `skaffold` 创建 docker 镜像。我们在每次合并到 master 时发布版本化的 docker 镜像和 helm charts。然后，我们通过 `helm` 升级环境。

## 什么是 exposecontroller?

事实证明，在 Kubernetes 集群中暴露服务比较复杂。例如：

* 使用什么域名？
* 你是否应该使用 TLS 和生成的证书，并把它们关联到域名上？
* 你是否在使用 OpenShift，如果是的话，可能使用 `Route` 会比 `Ingress` 更好？

因此，我们在 Jenkins X 中通过把微服务代理到一个叫做 [exposecontroller](https://github.com/jenkins-x/exposecontroller) 的服务上实现简化，它的职责就是处理上面的事情——把所有带有表明希望暴露到当前集群的 `Service` 资源暴露，类似域名的命名空间的暴露规则，是否使用 TLS 以及 `Route` 或 `Ingress`等。

如果你看一下你的环境 git 仓库，可能会注意到两个 `exposecontroller` [默认是 charts](https://github.com/jenkins-x/default-environment-charts/blob/master/env/requirements.yaml)

默认有两个任务用来自动化生成或者清理 `Ingress` 资源，以实现暴露标记了你希望从集群外部访问的 `Services` 资源。例如：web 应用或者 rest 接口。

你也可以不使用 exposecontroller —— 只要不在你的服务中使用 exposecontroller 标签即可。你也可以从环境中移除 exposecontroller 任务 —— 这么做的话，我们所有的快速开始（QuickStarts）都无法从集群外部访问！
