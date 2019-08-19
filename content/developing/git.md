---
title: Git Servers
linktitle: Git Servers
description: Working with different Git servers 
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

## Using a different git provider for environments

When you install Jenkins X it will create git repositories for `Staging` and `Production` using GitHub.

If you wish to use a different git provider for your environments then when you install Jenkins X add the `--no-default-environments` argument on [jx create cluster](/commands/jx_create_cluster/) or [jx install](/commands/jx_install/)


{{% note %}}
NOTE: All of the Git Providers mentioned here are supported if you are using Jenkins Static Masters.  However, if you are using Jenkins X Serverless with Tekton, only GitHub is supported.  This means that all other Git Providers including GitHub Enterprise are not currently supported due to how Prow communicates with the APIs.

{{% /note %}}


e.g. to [create a new cluster](/getting-started/create-cluster/)
 
``` 
jx create cluster gke --no-default-environments
```

or to [install in an existing cluster](/getting-started/install-on-cluster/)

``` 
jx install --no-default-environments
```


Then once Jenkins X is installed you can then [add a new git provider](#adding-a-new-git-provider).

Then when the git provider is setup you can verify it is available and has the right `gitKind` via:

``` 
jx get git server
```


Now create the `Staging` and `Production` environments using whatever git provider you wish via:

``` 
jx create env staging --git-provider-url=https://gitproviderhostname.com
jx create env production --git-provider-url=https://gitproviderhostname.com
```


## Adding a new git provider

If you already have a git server somewhere you can add it into Jenkins X via [jx create git server](/commands/jx_create_git_server):
                                    
``` 
jx create git server gitKind someURL
```

Where the `gitKind` is one of the supported git provider kinds like `github, gitea, gitlab, bitbucketcloud, bitbucketserver`

You can verify what server URLs and `gitKind` values are setup via

``` 
jx get git server
```

**NOTE** please make sure you set the right `gitKind` for your git provider otherwise the wrong underlying REST API provider will be invoked! 

## GitHub Enterprise

To add a GitHub Enterprise server try:

``` 
jx create git server github https://github.foo.com -n GHE
jx create git token -n GHE myusername

```

Where `-n` is the name for the git service.

## BitBucket Cloud

To add BitBucket Cloud try:

```
jx create git server bitbucketcloud -n BitBucket https://bitbucket.org
jx create git token -n BitBucket myusername
```

Please make sure that the `gitKind` is properly set to `bitbucketcloud` via the following command

``` 
jx get git server
```

and look in the `Kind` column.

## BitBucket Server

To add BitBucket Standalone Server try:

```
jx create git server bitbucketserver -n BitBucket https://your_server_address
jx create git token -n BitBucket myusername
```

## Gitlab

To add a git server for Gitlab and a token try:

```
jx create git server gitlab https://gitlab.com/ -n gitlab
jx create git token -n gitlab myusername
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

At the time of writing the [gitea plugin for Jenkins](https://issues.jenkins-ci.org/browse/JENKINS-50459) does not correctly update Pull Request and git commit build statuses which breaks the GitOps promotion pipelines. Promotion can work through manual approval, but the pipeline reports a failure.

Another issue is new projects created by `jx` inside `gitea` do not get the [merge buttons enabled on Pull Requests](https://github.com/go-gitea/go-sdk/issues/100). The work around is after a project is created on github you go to the `Settings` page for the repository inside the `gitea` web console and enable the merge buttons there. 

