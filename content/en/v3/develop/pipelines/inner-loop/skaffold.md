---
title: skaffold
linktitle: skaffold
type: docs
description: Using skaffold with Jenkins X
weight: 300
---
          
See the [skaffold site](https://skaffold.dev/) on how to use `skaffold`  to perform localy builds of a project.

Essentially you do the following:

* [install skaffold](https://skaffold.dev/docs/install/)
* `cd` into a git clone of your application
* run

```bash 
skaffold init
```

* then to run your application

```bash 
skaffold run --tail
```