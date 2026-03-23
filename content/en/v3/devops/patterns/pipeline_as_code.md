---
title: Pipelines As Code
linktitle: Pipelines As Code
description: Define your pipelines as code with your applications and environments
type: docs
weight: 120
---

Define your Continuous Integration and Continuous Delivery Pipelines as code and keep them in git with your application code.

In Jenkins X you can see the [Source Layout](/v3/develop/pipelines/editing/#source-layout) for more detail using standard [Tekton Pipelines](https://github.com/tektoncd/pipeline) YAML for defining pipelines in a cloud native self-contained way.

One downside with Pipelines As Code is that you can end up copy/pasting lots of YAML into lots of repositories which can become tricky to both maintain and to keep on recent images and configurations.

For details of the approach we use on Jenkins X check out [this blog post on GitOps your cloud native pipelines](/blog/2021/02/25/gitops-pipelines/) which lets us share versioned pipelines via git while also making it super easy to override pipeline steps as and when required keeping things super flexible while maximising reuse and making it easy to maintain and upgrade.



