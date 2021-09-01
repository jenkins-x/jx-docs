---
title: 常见问题解答
linktitle: Issues
description: Issues using Jenkins X 常见问题的解决方案。
---

我们已经试图把一些常见的问题整理到这里。如果你遇到的问题没有在这里列出来，请[让我们知道](https://github.com/jenkins-x/jx/issues/new)。

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

```sh
Temporary Error: Could not find an IP address for 46:0:41:86:41:6e
Temporary Error: Could not find an IP address for 46:0:41:86:41:6e
Temporary Error: Could not find an IP address for 46:0:41:86:41:6e
Temporary Error: Could not find an IP address for 46:0:41:86:41:6e
```

这里可能会给你提示，[minikube 和 hyperkit 相关问题](https://github.com/kubernetes/minikube/issues/1926#issuecomment-356378525)。

解决的办法是请尝试下面的操作：

```sh
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

```sh
jx open
```

你将会看到所有的 UR 格式 `http://$(minikube ip):somePortNumber`，不再通过 [nip.io](http://nip.io/)。这就意味着 URL 使用难记忆的数字格式而不是简单的主机名。

### 其他问题

请[让我们知道](https://github.com/jenkins-x/jx/issues/new) ，看我们是否可以提供帮助？祝你好运！
