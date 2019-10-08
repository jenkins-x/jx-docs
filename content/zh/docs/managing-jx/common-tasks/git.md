---
title: Git 服务器
linktitle: Git 服务器
description: 使用不同的 Git 服务器
---


Jenkins X 默认使用 [GitHub](https://github.com/)，用于开源项目的免费公共 git 托管方案。

然而，在企业中工作时，你可能希望使用不同的 git 服务器。

你可以通过 [jx get git](/commands/jx_get_git) 列出配置好的 git 服务器。

```sh
jx get git
```

## 添加一个新的 git 服务商

如果你在某个地方已经有了一个 git 服务，你可以通过 [jx create git server](/commands/jx_create_git_server) 把它添加到 Jenkins X中：

```sh
jx create git server gitKind someURL
```

这里 `gitKind` 是某个 git 服务商，像 `github, gitea, gitlab, bitbucket`

## 企业 GitHub

要添加一个企业 GitHub 服务，尝试：

```sh
jx create git server github https://github.foo.com -n GHE
```

这里 `-n` 是 git 服务的名称。

## BitBucket

要添加 BitBucket ，尝试：

```sh
jx create git server bitbucket -n BitBucket https://bitbucket.org
```

### 添加用户 tokens

为了添加一个 git 服务，你需要通过 [jx create git token](/commands/jx_create_git_token) 添加一个用户名和 API token：

```sh
jx create git token -n myProviderName myUserName
```

然后，就会提示你输入 API token

### Kubernetes 托管的 git 服务

你可以安装 git 服务到运行 Jenkins X 的 Kubernetes 集群中。

例如：有一个 [gitea](https://gitea.io/en-us/) 的插件，可以让你把 gitea 作为 Jenkins X 安装的一部分。

要在 Jenkins X 中使用 [gitea](https://gitea.io/en-us/)，你需要在安装 Jenkins X 之前启用 `gitea` 插件：

```sh
jx edit addon gitea -e true
```

你可以通过 [jx get addons](/commands/jx_get_addons) 查看启用的插件：

```sh
jx get addons
```

现在，当你 [安装 Jenkins X](/zh/docs/getting-started/) 时，也会安装 `gitea` 插件。

无论什么时候，Jenkins X 需要为一个环境或者新项目创建一个 git 库时，gitea 服务都会出现在选择列表中。

#### gitea 已知的限制

在写本文时，[gitea plugin for Jenkins](https://issues.jenkins-ci.org/browse/JENKINS-50459)不能够正确地更新 Pull Request 和 git 提交构建状态，这会打断 GitOps 升级流水线。可以手工审核来升级；但是，流水线会报告失败。

另一个问题是，由 `jx` 在 `gitea` 创建的新项目，无法使得 [在 Pull Requests 中合并按钮可用](https://github.com/go-gitea/go-sdk/issues/100)。要使得可用的话，当一个项目在 GitHub 中创建后，你到仓库的 `Settings` 页面，在 `gitea` 的 web 控制台中，启用合并按钮。

