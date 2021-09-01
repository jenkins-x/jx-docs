---
title: okteto
linktitle: okteto
type: docs
description: Using okteto with Jenkins X
weight: 100
---

If you [install okteto](https://okteto.com/docs/getting-started/installation/index.html) it has a command you can use to spin up a development container inside a deployment so you can iteratively rebuild an application.

Then if your application is deployed to your staging environment you can `cd` into a git clone of your application and run...

```bash
# switch to the staging namespace
jx ns jx-staging

okteto up
```

You will now have a [development container setup](https://okteto.com/docs/getting-started#step-4-activate-your-development-container) you can perform incremental builds
