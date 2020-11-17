---
title: CLI
linktitle: CLI
type: docs
description: Jenkins X Command Line Interface
weight: 10
aliases:
  - /docs/v3/develop/ui/cli
---

For those who like command lines you can view and watch most things via the [jx](/docs/v3/guides/jx3/) command line.

You can download 3.x of jx from here: https://github.com/jenkins-x/jx-cli/releases

Browse the [command line commands](https://github.com/jenkins-x/jx-cli/blob/master/docs/cmd/jx.md) along with the [plugin commands](https://github.com/jenkins-x/jx-cli#plugins) 

Many things in Jenkins X are exposed as [custom resources](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) so that you can also use [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) to interact with the Jenkins X.

* to view environments

```bash
kubectl get env
```

* to view preview environments

```bash
kubectl get preview
```

* to view build logs try:

``` bash
jx pipeline log
```
