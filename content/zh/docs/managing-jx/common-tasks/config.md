---
title: 配置
linktitle: 配置
description: 自定义你的 Jenkins X 安装
date: 2018-07-20
publishdate: 2018-07-20
lastmod: 2018-07-20
categories: [getting started]
keywords: [install,kubernetes]
---

Jenkins X 应该为你的云服务商提供默认可用的配置。例如：如果你使用 AWS 或 EKS，Jenkins X 自动地使用 ECR。

然而，你可以修改 Jenkins X 使用的 helm charts 的配置。

要做到这一点，你需要在运行命令 [jx create cluster](/commands/jx_create_cluster/) 或 [jx install](/commands/jx_install/) 的目录下创建一个文件 `myvalues.yaml` 。

然后，这个 YAML 文件可以覆盖 Jenkins X 中的任何 charts 中的 `values.yaml` 文件。

## Nexus

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

## Jenkins 镜像

Jenkins X 中我们提供了一个默认的 Jenkins docker 镜像 [jenkinsxio/jenkinsx](https://hub.docker.com/r/jenkinsxio/jenkinsx/)，把我们所需要的所有插件包含在里面。

如果你想添加自己的插件，你可以使用我们的基础镜像创建一个你自己的 Dockerfile 和镜像，如下所示：

```dockerfile
# Dockerfile for adding plugins to Jenkins X
FROM jenkinsxio/jenkinsx:latest

COPY plugins.txt /usr/share/jenkins/ref/openshift-plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/openshift-plugins.txt
```
然后以下面的形式将你所有自定义插件放到 `plugins.txt`：

```text
myplugin:1.2.3
anotherplugin:4.5.6
```

一旦你通过 CI/CD 构建和发布了你的镜像，你就可以在安装 Jenkins X 时使用它：

为了用你自定义的镜像配置 Jenkins X ，你可以在 `myvalues.yaml` 文件中指定你的 Jenkins 镜像：

```yaml
jenkins:
  Master:
    Image: "acme/my-jenkinsx"
    ImageTag: "1.2.3"
```

这里有一个开源项目的例子 [jenkins-x/jenkins-x-openshift-image](https://github.com/jenkins-x/jenkins-x-openshift-image)，你可以以它为模板创建一个新的 Jenkins 镜像用来在 OpenShift 上使用 Jenkins X 时增加 OpenShift 特定的插件和配置。

## Docker Registry

We try and use the best defaults for each platform for the Docker Registry; e.g. using ECR on AWS.

然而，你也可以在执行命令 [jx create cluster](/commands/jx_create_cluster/) 或 [jx install](/commands/jx_install/) 时，通过选项 `--docker-registry` 来指定。

例如：

```sh
jx create cluster gke --docker-registry eu.gcr.io
```

但是，如果你使用了不同的 Docker Registry 的话，你可能需要[修改 secret 才能连接到 docker](/docs/reference/components/docker-registry/#update-the-config-json-secret)。