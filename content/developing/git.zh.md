---
title: Git 服务器
linktitle: Git 服务器
description: 使用不同的 Git 服务器 
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
menu:
  docs:
    parent: "developing"
    weight: 210
weight: 210
sections_weight: 210
draft: false
toc: true
---


Jenkins X 默认使用 [GitHub](https://github.com/)，用于开源项目的免费公共 git 托管方案。
 
然而，在企业中工作时，你可能希望使用不同的 git 服务器。

你可以通过 [jx get git](/commands/jx_get_git) 列出配置好的 git 服务器。

```
jx get git
```

## 添加一个新的 git 服务商

如果你在某个地方已经有了一个 git 服务，你可以通过 [jx create git server](/commands/jx_create_git_server) 把它添加到 Jenkins X中：
                                    
``` 
jx create git server gitKind someURL
```

这里 `gitKind` 是某个 git 服务商，像 `github, gitea, gitlab, bitbucket`

## 企业 GitHub

要添加一个企业 Github 服务，尝试：

``` 
jx create git server github https://github.foo.com -n GHE
```

这里 `-n` 是 git 服务的名称。

## BitBucket

要添加 BitBucket ，尝试：

```
jx create git server bitbucket -n BitBucket https://bitbucket.org
```

### 添加用户 tokens

为了添加一个 git 服务，你需要通过 [jx create git token](/commands/jx_create_git_token) 添加一个用户名和 API token：

``` 
jx create git token -n myProviderName myUserName
```

然后，就会提示你输入 API token

### Kubernetes 托管的 git 服务

你可以安装 git 服务到运行 Jenkins X 的 Kubernetes 集群中。

e.g. there is an addon for [gitea](https://gitea.io/en-us/) that lets you install gitea as part of your Jenkins X installation.

To use [gitea](https://gitea.io/en-us/) with Jenkins X then you need to enable the `gitea` addon before installing Jenkins X:

``` 
jx edit addon gitea -e true
``` 

You can view the enabled addons via [jx get addons](/commands/jx_get_addons):

``` 
jx get addons
``` 

Now when you [install Jenkins X](/getting-started/) it will also install the `gitea` addon. 

Then whenever Jenkins X needs to create a git repository for an Environment or for a new Project the gitea server will appear in the pick list.


#### Known gitea limitations

At the time of writing the [gitea plugin for Jenkins](https://issues.jenkins-ci.org/browse/JENKINS-50459) does not correctly update Pull Request and git commit build statuses which breaks the GitOps promption pipelines. Promotion can work through manual approval; but the pipeline reports a failure. 

Another issue is new projects created by `jx` inside `gitea` do not get the [merge buttons enabled on Pull Requests](https://github.com/go-gitea/go-sdk/issues/100). The work around is after a project is created on github you go to the `Settings` page for the repository inside the `gitea` web console and enable the merge buttons there. 

