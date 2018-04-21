---
title: 在 Kubernetes 上安装
linktitle: 在 Kubernetes 上安装
description: 如何在已有的 Kubernetes 集群上安装 Jenkins X
date: 2018－04-21
publishdate: 2018－04-21
lastmod: 2018－04-21
categories: [getting started]
keywords: [install,kubernetes]
menu:
  docs:
    parent: "getting-started"
    weight: 30
weight: 30
sections_weight: 30
draft: false
toc: true
---

Jenkins X 可以在 Kubernetes 1.8 以及更高版本上安装。需要的依赖有：

* RBAC 是可用的
* 启用 docker 私有仓库。这样的话，流水线可以在 Kubernetes 集群中使用 docker 仓库（通常不是公共的因此不支持 https）。后续，你可以修改你的流水线来使用其他仓库。

### 通过 kops 启用私有仓库

注意，如果你是在 AWS 环境中，你可能会想使用 [jx create aws](/zh/getting-started/create-cluster/) 命令来帮你自动化完成所有步骤！

如果你是通过 [kops](https://github.com/kubernetes/kops) 创建的 kubernetes 集群，那么你可以这么做：

```
kops edit cluster 
```

然后，确保在 YAML 文件的章节 `spec` 中有 `docker` 配置：

```yaml 
...
spec:
  docker:
    insecureRegistry: 100.64.0.0/10
    logDriver: ""
``` 

上面的 IP 范围 `100.64.0.0/10` 是 AWS 上的，但你需要修改为其他 Kubernetes 集群的；它依赖于 Kubernetes 服务的 IP 范围。
 
保存后，你可以参考下面的命令进行验证：

```
kops get cluster -oyaml
```

然后查找 `insecureRegistry` 章节。

现在，确保这些修改在你的集群类型上是激活的：

```
kops update cluster --yes
kops rolling-update cluster --yes
```

你现在可以继续了！

### 安装 Jenkins X

为了在已有的 kubernetes 集群上安装 Jenkins X 你可以使用命令 [jx install](/zh/commands/jx_install) ：

    jx install

如果你知道提供商的话，可以通过命令行来指定。例如：

    jx install --provider=aws
    
