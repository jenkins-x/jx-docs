---
title: 配置
linktitle: 配置
description: 自定义你的 Jenkins X 安装
date: 2018-07-20
publishdate: 2018-07-20
lastmod: 2018-07-20
categories: [getting started]
keywords: [install,kubernetes]
menu:
  docs:
    parent: "getting-started"
    weight: 70
weight: 70
sections_weight: 70
draft: false
toc: true
---

Jenkins X 应该为你的云服务商提供默认可用的配置。例如：如果你使用 AWS 或 EKS，Jenkins X 自动地使用 ECR。

然而，你可以修改 Jenkins X 使用的 helm charts 的配置。

要做到这一点，你需要在运行命令 [jx create cluster](/commands/jx_create_cluster) 或 [jx install](/commands/jx_install) 的目录下创建一个文件 `myvalues.yaml` 。

然后，这个 YAML 文件可以覆盖 Jenkins X 中的任何 charts 中的 `values.yaml` 文件。

例如：如果你希望在安装过程中禁用 Nexus，而使用不同主机上的一个独立的 Nexus，那么，你可以使用 `myvalues.yaml` 中的服务链接来替代：

```yaml
nexus:
  enabled: false
nexusServiceLink:
  enabled: true
  externalName: "nexus.jx.svc.cluster.local"
```

要禁用并使用 chart museum 的服务链接的话添加：

```yaml
chartmuseum:
  enabled: false
chartmuseumServiceLink:
  enabled: true
  externalName: "jenkins-x-chartmuseum.jx.svc.cluster.local"
```

## Docker Registry

We try and use the best defaults for each platform for the Docker Registry; e.g. using ECR on AWS or KES. 

然而，你也可以在执行命令 [jx create cluster](/commands/jx_create_cluster) 或 [jx install](/commands/jx_install) 时，通过选项 `--docker-registry` 来指定。

例如：

``` 
jx create cluster gke --docker-registry eu.gcr.io
```   

但是，如果你使用了不同的 Docker Registry 的话，你可能需要[修改 secret 才能连接到 docker](/architecture/docker-registry/#update-the-config-json-secret)。