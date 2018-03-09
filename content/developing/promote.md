---
title: Promote
linktitle: Promote
description: Promote new versions of your application to environments 
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
menu:
  docs:
    parent: "developing"
    weight: 100
weight: 100
sections_weight: 100
draft: false
toc: true
---


The CD Pipelines of Jenkins X automate the [promotion](/about/features/#promotion) of version changes through each [Environment](/about/features/#environments) which is configured with a _promotion strategy_ property of `Auto`. By default the `Staging` environment uses automatic promotion and the `Production` environment uses `Manual` promotion. 

To manually Promote a version of your application to an environment use the [jx promote](/commands/jx_promote) command.

```shell 
jx promote myapp --version 1.2.3 --env production
```

The command waits for the promotion to complete, logging details of its progress. You can specify the timeout to wait for the promotion to complete via the `--timeout` argument.

e.g. to wait for 5 hours


```shell 
jx promote myapp --version 1.2.3 --env production --timeout 5h
```

You can use terms like `20m` or `10h30m` for the various duration expressions.






