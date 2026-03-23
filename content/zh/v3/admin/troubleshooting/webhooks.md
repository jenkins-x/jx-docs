---
title: Webhooks
linktitle: Webhooks
type: docs
description: 如何对 webhooks 问题进行诊断以及修复
weight: 200
---

当你做如下操作时，Webhooks 可以触发 [lighthouse](https://github.com/jenkins-x/lighthouse)：

* 合并提交记录到你的默认分支
* 创建 Pull Request
* 推送代码到 Pull Request 对应的分支
* 在 Pull Request 上添加评论来触发 ChatOps

如果你的集群中的 webhooks 无效时，ChatOps 或者流水线将不会被触发。

### 前置条件

`Ingress` 中 `hook` 关于 [lighthouse](https://github.com/jenkins-x/lighthouse) 配置正确是 webhooks 有效的前提。

Ingress 默认会采用文件 `jx-requirements.yml` 中 `ingress.domain` 指定的域名。

### 问题诊断
        
你可以根据[健康性指南](/v3/admin/setup/health/)来检查你系统以及 webhooks 是否健康。

首先，请确保 ingress 正常

```bash 
kubectl get ing
```

你会看到 `hook` 的合法域名地址。然后，使用 curl 命令做一下测试：

```bash
curl -v http://hook-jx.1.2.3.4.nip.io/hook
```

检查你的机器是否可以访问那个地址。另外，检查是否有一个运行中的 Pod `lighthouse-webhook-*`？

```bash
kubectl get pod -l app=lighthouse-webhooks
```

你也可以通过 `jx ui` 查看他们的状态、事件、日志等。

如果看起来都正常的话，然后打开你集群的 git 仓库

```bash
kubectl get environments
```

然后，点击链接 `GIT URL`。

打开你的 git 提供商的 **Webbooks** 页面， 查看发送到 hook 地址的请求是否成功。对于 GitHub，你可以在 **Settings** ->  **Webhooks** 这里找到。

如果你的 git 无法访问 ingress 地址的话，你可以设置一个转发通道。请查看[借助 ngrok 使用 webhooks](/v3/admin/platforms/on-premises/#enable-webhooks) 

### AWS 相关的问题

如果你在使用 AWS，你可以查看 [AWS 关于使用 ELB](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/routing-to-elb-load-balancer.html) 的文档。