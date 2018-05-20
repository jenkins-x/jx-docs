---
title: 常见问题解答
linktitle: FAQ
description: Jenkins X 常见问题的解决方案。
date: 2018-05-20
categories: [troubleshooting]
menu:
  docs:
    parent: "troubleshooting"
keywords: [faqs]
weight: 2
toc: true
aliases: [/faq/]
---

我们已经试图把一些常见的问题整理到这里。如果你遇到的问题没有在这里列出来，请[让我们知道](https://github.com/jenkins-x/jx/issues/new)。


### Jenkins X 是开源的吗？

是的！Jenkins X 的所有源码和成品都是开源的；Apache 或 MIT 能保证这一点！

### Jenkins X 是 Jenkins 的分支吗？

不！Jenkins X 总是复用 Jenkins 核心，并尽可能把它配置作为 Kubenetes 的本地资源。

起初，Jenkins X 是 Jenkins 核心带着 Kubernetes 配置以及一些附加的插件，打包为一个 Helm 的 Chart。

随着时间的推移，我们希望 Jenkins X 项目可以推动 Jenkins 核心发生一些改变，以帮助 Jenkins 更加原生地支持云。例如：使用数据库或者 Kubernetes 资源来存储任务、运行和凭据，使得更加容易地支持像多 master 或单个 master。虽然，这些变化首先会在 Jenkins 核心中出现，但会被 Jenkins X 复用。

### 为什么要创建一个子项目？

我们是 <a href="https://kubernetes.io/">Kubernetes</a> 和云的超级粉丝，并认为是软件运行的未来趋势。

然而，很多分支仍然想要通过：<code>java -jar jenkins.war</code >以常规的方式来运行 Jenkins。

因此，Jenkins X 子项目的想法，是为了100%关注在 Kubernetes 和云原生使用场景，并让 Jenkins 核心项目关注经典的 Java 方式。

Jenkins 最强大的是它的灵活性和巨大的插件生态。分离 Jenkins X 子项目帮助社区并行地迭代并快速改进云原生和 Jenkins 经典的发行。

### 无法创建 minikube 集群

如果你使用的是 Mac，那么， `hyperkit` 是最好的虚拟机驱动——但首先需要你安装最新的[Docker for Mac](https://docs.docker.com/docker-for-mac/install/)。之后，尝试 `jx create cluster minikube`。

如果，你的 minikube 启动失败，那么你可以尝试：

    minikube delete
    rm -rf ~/.minikube

如果运行 `rm` 失败，你可能需要：

    sudo rm -rf ~/.minikube

现在，再试一次 `jx create cluster minikube` ，这样有帮助吗？有时候，从安装的旧版本中一些过时的证书或者文件会导致 minikube 失败。

有时候，当虚拟机出错时，重启可能会有帮助。

另外，你还可以尝试下面的 minikube 指令

* [安装 minikube](https://github.com/kubernetes/minikube#installation)
* [运行 minikube start](https://github.com/kubernetes/minikube#quickstart)

### Minkube 和 hyperkit: 无法找到 IP 地址

如果你在 Mac 上通过 hyperkit 使用 minikube，并发现 minikube 启动失败的日志如下：

```
Temporary Error: Could not find an IP address for 46:0:41:86:41:6e
Temporary Error: Could not find an IP address for 46:0:41:86:41:6e
Temporary Error: Could not find an IP address for 46:0:41:86:41:6e
Temporary Error: Could not find an IP address for 46:0:41:86:41:6e
```

这里可能会给你提示，[minikube 和 hyperkit 相关问题](https://github.com/kubernetes/minikube/issues/1926#issuecomment-356378525)。

解决的办法是请尝试下面的操作：

```
rm ~/.minikube/machines/minikube/hyperkit.pid
```

然后，再试一次。希望这次能够成功！

### 无法访问 minikube 上的服务

当运行 minikube，本地 `jx` 默认使用 [nip.io](http://nip.io/) 作为服务的域名解析，并解决了大多数笔记本无法使用通配的 DNS。然而，有时候，[nip.io](http://nip.io/) 会出问题而无法工作。

为了避免使用 [nip.io](http://nip.io/) 你可以进行以下操作：

编辑文件 `~/.jx/cloud-environments/env-minikube/myvalues.yaml`，并添加下面的内容：

```yaml
expose:
  Args:
    - --exposer
    - NodePort
    - --http
    - "true"
```

然后，再次运行 `jx install` ，这将会把把服务暴露在 `node ports`，不再使用 ingress 和 DNS。

因此，如果你输入：

```
jx open
```

你将会看到所有的 UR 格式 `http://$(minikube ip):somePortNumber`，不再通过 [nip.io](http://nip.io/)。这就意味着 URL 使用难记忆的数字格式而不是简单的主机名。

### 其他问题

请[让我们知道](https://github.com/jenkins-x/jx/issues/new) ，看我们是否可以提供帮助？祝你好运！
