---
title: Preview
linktitle: Preview
description: Preview pull requests before changes merge to master
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
menu:
  docs:
    parent: "developing"
    weight: 110
weight: 110
sections_weight: 110
draft: false
toc: true
---


We highly recommend the use of [Preview Environments](/about/features/#preview-environments) to get early feedback on changes to applications before the changes are merged into master.
  
Typically the creation of preview environments is automated inside the Pipelines created by Jenkins X.

However you can manually create a [Preview Environment](/about/features/#preview-environments) using [jx](/commands/jx) via the [jx preview](/commands/jx_preview) command.

```shell 
jx preview
```

### What happens when a Preview environment is created

* a new [Environment](/about/features/#environments) of kind `Preview` is created along with a [kubernetes namespace](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) which shows up in the [jx get environments](/commands/jx_get_environments/) command along with the [jx environment and jx namespace commands](/developing/kube-context) so you can see which preview environments are active and switch into them to look around
* the Pull Request is built as a preview docker image and chart and deployed into the preview environment
* a comment is added to the Pull Request to let your team know the preview application is ready for testing with a link to open the application. So in one click your team members can try out the preview!
 
<img src="/images/pr-comment.png" class="img-thumbnail">



