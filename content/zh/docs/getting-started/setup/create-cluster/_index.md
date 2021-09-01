---
title: 创建新集群
linktitle: 创建新集群
description: 如何通过 Jenkins X 创建新的 Kubernetes 集群
date: 2018-04-21
publishdate: 2018-04-21
categories: [getting started]
keywords: [install]
weight: 1
---

Jenkins X 可以通过jx的命令行界面CLI安装到Kubernetes集群里。

创建Kubernetes集群的方法有很多种。

我们推荐的方法是使用Terraform设置所有云基础架构（kubernetes集群，服务帐户，存储桶，日志记录等），并使用云提供商来创建和管理kubernetes集群。

---

或者您可以使用kubernetes提供程序特定的方法：

通过已经安装的 Jenkins X 创建一个新的集群，使用命令  [jx create cluster](/commands/jx_create_cluster/) 。

如下所示，支持很多不同的公有云提供商。

__为了最好的入门体验，我们目前推荐使用 Google Container Engine (GKE)__。如果你没有谷歌云账号的话，谷歌云平台提供三百美元的额度。查看 <https://console.cloud.google.com/freetrial>

这有一个小的演示，同时展示 GKE、AKS 和 Minikube。在不同的设备（云）上启动需要花点时间，请耐心等待！

<iframe width="640" height="360" src="https://www.youtube.com/embed/ELA4tytdFeA" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

### 使用谷歌云 (GKE)

使用命令 [jx create cluster gke](/commands/jx_create_cluster_gke/) ：

    jx create cluster gke

该命令假设你有一个谷歌账户，并且已经设置了一个默认项目，可以再里面创建 Kubernetes 集群。

现在 **[使用 Jenkins X 更快速地开发应用](/zh/docs/getting-started/)**。

### 使用亚马逊 (AWS)

使用命令 [jx create cluster aws](/commands/x_create_cluster_aws) ：

```sh
jx create cluster aws
```

这会通过你的亚马逊账户，使用命令 [kops](https://github.com/kubernetes/kops) 创建一个新的 Kubernetes 集群并安装 Jenkins X。

来试试这个，我们建议你参照 [AWS Workshop for Kubernetes](https://github.com/aws-samples/aws-workshop-for-kubernetes/tree/master/01-path-basics/101-start-here#create-aws-cloud9-environment)  设置 AWS Cloud9 IDE。

然后，在 Cloud9 中打开一个新的终端，试试这些命令：

```sh
curl -L https://github.com/jenkins-x/jx/releases/download/v{{.Site.Params.release}}/jx-linux-amd64.tar.gz | tar xzv
sudo mv jx /usr/local/bin
jx create cluster aws
```

现在 **[使用 Jenkins X 更快速地开发应用](/zh/docs/getting-started/)**。

### 使用 Azure (AKS)

使用命令 [jx create cluster aks](/commands/jx_create_cluster_aks/) ：

```sh
jx create cluster aks
```

现在 **[使用 Jenkins X 更快速地开发应用](/zh/docs/getting-started/)**。

### 使用 Minikube (local)

有些人在开始使用 minikube 时遇到问题，可能有几个原因：

* minikube 需要更新你的机器以及虚拟化软件
* 你可能已经安装了旧版本的 Docker 或者 minikube、kubectl、helm等。

因此，我们**强烈**建议使用上面的公有云来尝试 Jenkins X。他们都有免费体验，所以应该不会花费你的任何现金，而且还给了你体验云的机会。

如果你还是想尝试 minikube，那么，我们建议从头开始，并让 jx 帮你创建

```sh
jx create cluster minikube
```

现在 **[使用 Jenkins X 更快速地开发应用](/zh/docs/getting-started/)**。

### 故障排除

如果你在安装 Jenkins X 时遇到任何问题，请检查我们的 [故障排除](/zh/troubleshooting/faq/) 或者 [让我们知道](/zh/community/)，我们会尽力给予帮助。
