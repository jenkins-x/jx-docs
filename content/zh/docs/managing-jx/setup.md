---
title: 安装问题
linktitle: 安装问题
description: Jenkins X 的安装和配置问题
---

## 如何在 Jenkins X 的安装当中添加用户？

Jenkins X 假设每个用户都可以访问运行 Jenkins X 的 kubernetes 开发集群。

如果您的用户无权访问 kubernetes 集群，我们需要设置他们的 `~/.kube/config` 文件，以便他们可以访问它。

如果您正在使用 Google 的 GKE ，那么您可以浏览 [GKE Console](https://console.cloud.google.com) 以查看所有集群，然后单击开发集群旁边的 `Connect` 按钮，然后可以运行复制/粘贴命令以连接到集群。

对于其他集群，我们计划编写一些 [CLI 命令来导出和导入kube配置](https://github.com/jenkins-x/jx/issues/1406)。

### 当用户拥有了 kubernetes 集群的访问权限

当用户拥有了 kubernetes 集群的访问权限：

* [安装 jx 二进制文件](/zh/getting-started/setup/install/)

如果 Jenkins X 安装在命名空间 `jx` 中，那么应该 [切换你的上下文](/zh/docs/resources/guides/using-jx/common-tasks/kube-context/) 到命名空间 `jx` 当中：

    jx ns jx

测试安装成功可以输入下列命令：

    jx get env
    jx open

查看环境和任何开发工具，如 Jenkins 或 Nexus 控制台。

