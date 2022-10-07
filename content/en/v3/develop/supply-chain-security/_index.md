---
title: Supply Chain Security
linktitle: Supply Chain Security
type: docs
description: Securing Your Supply Chain in Jenkins X
weight: 200
---

For a CI/CD system like Jenkins X to be an all-in-one solution, it's an essential part to secure supply chain of our users.
We've improved support for generating [SBOMs](https://jenkins-x.io/blog/2022/07/24/intro-to-sbom/) and signing generated artifacts so that you can

* easily generate sboms for released artifacts [in the same approach Jenkins X does](https://jenkins-x.io/community/maintainer_guide/supply-chain-security/) by just modifying the files in your `.lighthouse/jenkins-x` folder
* [sign tekton artifacts using chains](chains/) to sign any [TaskRun](https://tekton.dev/docs/pipelines/taskruns/) in your pipelines.
