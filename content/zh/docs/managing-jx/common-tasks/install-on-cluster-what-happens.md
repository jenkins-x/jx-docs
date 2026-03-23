---
title: 安装过程中发生了什么
linktitle: 安装过程中发生了什么
description: 安装 Jenkins X 时究竟做了什么
date: 2018-07-10
publishdate: 2018-07-10
lastmod: 2018-07-10
categories: [getting started]
keywords: [install,kubernetes]
---

Jenkins X 命令行在安装 Jenkins X 平台时会做如下事情：

## 安装二进制客户端来管理你的集群

{{< alert >}}
如果您运行在 Mac OS X 上，Jenkins X 会使用 `Homebrew` 来安装不同的命令行。不存在就会安装。
{{< /alert >}}

### 安装 kubectl

[kubectl](https://kubernetes.io/docs/reference/kubectl/kubectl/) 是 Kubernetes 的命令行。它允许您和您的 Kubernetes 集群通过 API server 交互。

### 安装 Helm

Jenkins X 将会安装 [helm](https://github.com/kubernetes/helm) 客户端 - (可能是  helm *2.x* 或 helm *3*)，如果它不在您的环境变量里的话。Helm 是用于打包 Kubernetes 中的应用或资源（也叫做 charts），并迅速地成为标准。

### 安装云提供商的命令行

如果您在使用公有云，会有相关的命令行来与之交互。当通过 [jx create cluster](/docs/getting-started/setup/create-cluster/) 命令来安装时，您的云提供商相关的二进制如果不在环境变量里的话，也会被安装。

- AKS 集群（Azure）的 `az`
- GKE 集群 (Google Cloud) 的 `gcloud` for GKE cluster (Google Cloud)
- AWS 集群 (Amazon Web Services) 的 `kops`
- [AWS EKS](https://aws.amazon.com/eks/) 集群的 `eksctl`
- OKS 集群 (Oracle Cloud) 的 `oci`

如果您想要在本地通过 minikube 或 minishift 运行 Jenkins X 的话，下面的二进制会被添加：

- 本地 minishift (OpenShift) 集群 的 `oc` (OpenShift CLI) 和 `minishift`
- 本地 minikube 集群的 `minikube`

最后，Jenkins X 将会根据需要安装 VM 驱动，通常 Mac OS X 上是 `xhyve` 或 Windows 上是 `hyperv` 。其他驱动则需要手动安装。

## 创建 Kubernetes 集群

之后，集群会通过云提供商的命令来创建（例如：Azure 的 `az aks create` 命令）。

## 设置 Jenkins X 平台

### 创建 Jenkins X 命名空间

然后，会为 Jenkins X 平台创建一个命名空间，用于存放 Jenkins X 基础组件。默认为：*jx*。

### 安装 Tiller（可选，只有 Helm 2 需要）

Tiller，也就是 Helm 的服务器端，会部署到命名空间 *kube-system* 中。[Helm](https://www.helm.sh/) 是 Kubernetes 的包管理器，也用于部署 Jenkins X 的其他组件。

### 设置 Ingress 控制器

在 Kubernetes 集群中，Service 和 Pod 的 IP 只能在集群网络中访问。为了能够访问集群，必须要创建一个 Ingress。Ingress 是路由到集群内的 Service 的规则集。Ingress 规则是由 Kubernetes API 配置在 Ingress 资源中，而 Ingress Controller 是必要的。所有的这些 Jenkins X 都会替您做——为下面的 Service 设置一个 Ingress Controller 和相关联的后端 Ingress 规则（一旦部署完后）：

- chartmuseum
- docker-registry
- jenkins
- monocular
- nexus

{{< alert >}}
默认，Jenkins X 将会通过域名 *nip.io* 暴露 Ingress，并生成自签名的证书。当按照完后，您可以通过命令 `jx upgrade ingress --cluster` 轻松地修改为您自己的域名和签名。
{{< /alert >}}

### 配置 git 仓库

Jenkins X 需要一个 Git 仓库提供商，以便能够插件环境仓库。如果您没有提供参数 *git-provider-url* 的划，默认使用 GitHub。您需要提供用户名和 Token 来和 Git 交互，尤其是 Jenkins。

## 创建管理员凭据

Jenkins X 为 Monocular/Nexus/Jenkins 生成管理员密码并保存到 Secret 中。当在 helm 安装的时候就会取出来使用（因此，密码可以用在流水线中）。

### 检出云环境仓库

[云环境仓库](https://github.com/jenkins-x/cloud-environments)保存所有特定的配置以及加密的 Secret，这些将会应用在您的 Kubernetes 集群中的 Jenkins 平台。这些 Secret 将会由 Helm 包管理器来加解密。

## 安装 Jenkins X 平台

[Jenkins X 平台](https://github.com/jenkins-x/jenkins-x-platform)保存安装了的组件的 Helm Chart，用于提供 Jenins X 真正的 CD 解决方案。这包括：

- [Jenkins](https://github.com/jenkinsci/jenkins) 一个 CI/CD 流水线方案
- [Nexus](https://www.sonatype.com/nexus-repository-oss) 一个制品仓库
- [ChartMuseum](https://github.com/kubernetes-helm/chartmuseum) 一个 Helm Chart 仓库
- [Monocular](https://github.com/kubernetes-helm/monocular) 提供了一个 Web UI 用于搜索和发现通过 Jenkins X 部署到您的集群中的 Chart。
