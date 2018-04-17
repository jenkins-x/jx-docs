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


Jenkins X defaults to using [GitHub](https://github.com/), the free public git hosting solution for open source projects.
 
However when working in the enterprise you may wish to use different git servers.

You can list the git servers configured via [jx get git](/commands/jx_get_git):

```
jx get git
```

## Adding a new git provider

If you already have a git server somewhere you can add it into Jenkins X via [jx create git server](/commands/jx_create_git_server):
                                    
``` 
jx create git server gitKind someURL
```

Where the `gitKind` is one of the supported git provider kinds like `github, gitea, gitlab, bitbucket`

## GitHub Enterprise

To add a GitHub Enterprise server try:

``` 
jx create git server github https://github.foo.com -n GHE
```

Where `-n` is the name for the git service.

## BitBucket

To add BitBucket try:

```
jx create git server bitbucket -n BitBucket https://bitbucket.org
```

### Adding user tokens

To use a git server you need to add a user name and API token via [jx create git token](/commands/jx_create_git_token):

``` 
jx create git token -n myProviderName myUserName
```

You will then be prompted for the API token 

### Kubernetes hosted git providers

You can install git providers inside the kubernetes cluster running Jenkins X. 

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

