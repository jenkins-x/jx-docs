---
title: Getting jx 3.x alpha
linktitle: Getting jx 3.x alpha
type: docs
description: How to download the jx 3.x alpha
weight: 1
aliases:
  - /docs/v3/guides/jx3
---

To try out the 3.x Alpha of Jenkins X you will need the 3.x version of the `jx` binary.

You can download 3.x of `jx` from here: https://github.com/jenkins-x/jx-cli/releases

It's basically a drop in alternative to the usual 2.x version of `jx`.

Notes:
* main development has been done using GitHub and Google Container Engine (GKE) but OSS contributions have been helping to validate and fix issues using other platforms.

## How jx 3.x is built

We are trying to take a microservices approach to creating improvements to Jenkins X with 3.x.

We are trying to keep 2.x of Jenkins X stable; but provide a place where we can rapidly innovate on 3.x.

So the main `jx` CLI tool for 3.x is defined at [jenkins-x/jx-cli](https://github.com/jenkins-x/jx-cli) which is a small core using lots of separate [plugin binaries](https://github.com/jenkins-x/jx-cli#plugins), [components](https://github.com/jenkins-x/jx-cli#components) and [libraries](https://github.com/jenkins-x/jx-cli#libraries) which allows us to go faster improving 3.x, refactoring code, improving quality and code coverage while removing technical debt - without needing to touch 2.x.
