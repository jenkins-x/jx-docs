---
title: Getting Started 
linktitle: Getting Started
description: Getting started with Jenkins X, helm 3 and kustomize
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2020-02-21
weight: 10
---

Jenkins X 3.x alpha includes a new install approach which uses tools like helm 3, kpt, kustomize and includes a number of [improvements](/docs/v3/about/benefits/) over Jenkins X 2.

- Download the new `jx` CLI and install it in your executable path by running the snippet appropriate for your OS given here: https://github.com/jenkins-x/jx-cli/releases/latest

The new `jx` CLI uses a plugin system to add sub commands when working with Jenkins X.

- Once you have the new `jx` CLI, download the base set of sub commands used for admistrating and working with Jenkins X:

```bash
jx upgrade plugins
```

## Pick your initial git repository

We have a [number of quickstart git repositories](https://github.com/jx3-gitops-repositories) to start from when installing Jenkins X 3.x.
