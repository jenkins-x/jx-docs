---
title: Jenkins X Pipelines
linktitle: Jenkins X Pipelines
description: Jenkins X Pipelines
date: 2019-03-04
publishdate: 2019-03-04
categories: [tekton]
keywords: [tekton]
menu:
  docs:
    parent: "tekton"
    weight: 90
weight: 90
sections_weight: 90
draft: false
aliases: [/tekton/]
toc: true
---

Jenkins X [recently announced](/news/jenkins-x-next-gen-pipeline-engine) that it was working with the Jenkins X Pipeline initiative which offers a new pipeline execution engine in the form of Tekton Pipelines project.  Tekton has been designed as a cloud native solution.

The work here is still experimental but we'd love feedback and help from the community to drive it forward.  Right now to enable a Tekton based install you can create a new cluster using `jx` along with these flags:

```
jx create cluster gke --tekton --no-tiller
```

Once your cluster is started you can create a new quickstart, we've been using the nodejs one reliably.

```
jx create quickstart
```

A `prowjob` is created, a new prow pipeline controller watches for these jobs and when it receives and event will check if it has a `pipelinerun` spec present, if not it will post the `prowjob` to a new `pipelinerunner` service from Jenkins X which in turn clones the repo and revision then translates it's `jenkins-x.yml` into vanilla Tekton Pipeline resources.  Once they are created the `tekton-pipeline-controller` executes the builds.
