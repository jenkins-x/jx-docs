---
title: "Kubernetes 1.22 - Breaking change!"
date: 2022-04-22
draft: false
description: >
  Jenkins X goes to Kubernetes 1.22 
categories: [blog]
keywords: [Community, 2022]
slug: "kubernetes-1.22-tekton"
aliases: []
author: Jenkins X maintainers
---

To allow Jenkins X to support Kubernetes 1.22, we had to update our version of Tekton. This updated version of Tekton contains breaking changes that has consequences if you made your own custom Jenkins X pipelines.

To make sure that your custom pipelines continue to work after this upgrade, you must edit the resource settings in your pipelines. Otherwise your pipelines will most likely not be able to start at all, or if they do, consume a lot of resources.


#### Changes in Tekton version 28
Tekton made changes in how to calculate the resources needed to run a pipeline, in order to support the concept of [LimitRange](https://kubernetes.io/docs/concepts/policy/limit-range/) in Kubernetes (introduced in Kubernetes version 1.10). Previously, Tekton simply used the maximum requested cpu and memory of any single step, and set that as limits for the all steps in the pipeline. 

[Tekton documentation on how resources are calculated with LimitRange](https://tekton.dev/vault/pipelines-main/limitrange/)


#### How to prepare for upgrade

The Jenkins X pipeline catalog has already been upgraded to handle the changes. You can study [this PR](https://github.com/jenkins-x/jx3-pipeline-catalog/pull/984/files) to see how the new resource settings are handled there.

In the pipeline files, the StepTemplate is changed to not specify resource requests, but only setting an empty resource limit:

```yaml
stepTemplate:
  image: uses:jenkins-x/jx3-pipeline-catalog/tasks/go/release.yaml@a5ab19ebc5a074e0402c5016b11bc11b32cc5c83
  name: ""
  resources:
    # override limits for all containers here
    limits: {}
```


The resource requests are only set on one step:
```yaml
steps:
  - image: uses:Mentor-Medier/jx3-pipeline-catalog/tasks/git-clone/git-clone-pr.yaml@versionStream
    name: ""
    resources: {}
  - name: jx-variables
    resources:
      requests:
        cpu: 400m
        memory: 512Mi
```

Typically, the Jenkins X pipeline in the previous version had resources set on the stepTemplate. Running the old pipelines in the new version will lead to resource requirements being multiplied by the number of steps. 

So, please prepare for upgrade now! We want people to have a safe upgrade experience. If you have questions, you can find us on [Slack](https://kubernetes.slack.com/messages/C9MBGQJRH).

