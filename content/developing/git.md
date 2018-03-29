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

### Adding a new git provider

If you already have a git server somewhere you can add it into Jenkins X via [jx create git server](/commands/jx_create_git_server):
                                    
``` 
jx create git server gitKind someURL
```

Where the `gitKind` is one of the supported git provider kinds like `github, gitea, gitlab, bitbucket`

### Adding user tokens

To use a git server you need to add a user name and API token via [jx create git token](/commands/jx_create_git_token):

``` 
jx create git token myUserName
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





