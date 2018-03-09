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
jx preview TODO
```



