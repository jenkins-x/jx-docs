---
title: Getting jx 3.x alpha
linktitle: Getting jx 3.x alpha
type: docs
description: How to download the jx 3.x alpha
weight: 1
---

To try out the 3.x Alpha of Jenkins X you will need the 3.x `jx` binary.

You can download 3.x of `jx` from here: https://github.com/jenkins-x/jx-cli/releases

Its basically a drop in alternative to the usual `jx` that has all of the new Labs features enabled.

Notes:
* main development has been done using GitHub and Google Container Engine (GKE) but OSS contributions have been helping to validate and fix issues using other platforms.

## How jx 3.x is built

We are trying to take a microservices approach to creating improvements to Jenkins X with 3.x.

We are trying to keep 2.x of Jenkins X stable; but provide a place where we can rapidly innovate with new experiments, improvements and enhancements.

So the main `jx` CLI tool for 3.x is deifned at [jenkins-x/jx-cli](https://github.com/jenkins-x/jx-cli) which then depends on a number of separate [plugin binaries](https://github.com/jenkins-x/jx-cli#plugins) 
