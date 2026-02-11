---
title: 导入
linktitle: 导入
description: 如何把已经存在的项目导入 Jenkins X
---


如果你已经有一些源码，希望导入 Jenkins X，你可以使用 [jx import](/commands/jx_import/) 命令。

```sh
cd my-cool-app
jx import
```

导入将会执行下面的动作（提示你按照这个方法来）：

* 如果你的源码还不在 git 库中，添加进去
* 在给定的 git 服务上创建一个远程库，例如 [GitHub](https://github.com)
* 把你的代码推送到远程 git 服务
* 添加任何需要的文件到你的工程中，如果不存在的话：
  * `Dockerfile` 把你的应用作为 docker 镜像进行构建
  * `Jenkinsfile` 实现持续集成、持续构建流水线
  * helm chart 让你的应用在 Kubernetes 中运行
* 为你们团队的 Jenkins 注册一个 webhook 到远程 git 仓库
* 为你们团队的 Jenkins 添加这个 git 仓库
* 首次触发流水线

### 避免 docker + helm

如果你正在导入的仓库而不需要创建 docker 镜像，你可以使用命令参数 `--no-draft` ，就不会使用 Draft 默认的 Dockerfile 和 helm chart。

### 通过 URL 导入

如果你希望导入的工程已经在 git 远程库中，那么，你可以使用参数 `--url`：

```sh
jx import --url https://github.com/jenkins-x/spring-boot-web-example.git
```

### 导入 GitHub 项目

如果你希望从 GitHub 组织中导入，可以使用：

```sh
jx import --github --org myname
```

将会提示你需要导入的库。使用光标和空格键来选择（取消）要导入的库。

如果你希望默认导入所有的库（那么反选你不想要的）添加 `--all`：

```sh
jx import --github --org myname --all
```

为了过滤列表，你可以添加参数 `--filter`

```sh
jx import --github --org myname --all --filter foo
```

