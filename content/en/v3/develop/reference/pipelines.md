---
title: Pipelines
linktitle: Pipelines
type: docs
description: Reference for all things Pipelines
weight: 100
aliases:
- /v3/develop/pipelines/reference
---

The following are the links to the various configuration file formats:

[Tekton](https://tekton.dev/) resources:

* [Task](https://tekton.dev/docs/pipelines/tasks/#configuring-a-task)
* [TaskRun](https://tekton.dev/docs/pipelines/taskruns/#configuring-a-taskrun)
* [Pipeline](https://tekton.dev/docs/pipelines/pipelines/#configuring-a-pipeline)
* [PipelineRun](https://tekton.dev/docs/pipelines/pipelineruns/#configuring-a-pipelinerun)

A `Task` is made up of `Steps` which each support all of the properties you can modify on a [kubernetes Container](https://kubernetes.io/docs/reference/kubernetes-api/workloads-resources/container/)

### Lighthouse

[Lighthouse](https://github.com/jenkins-x/lighthouse) [TriggerConfig](https://github.com/jenkins-x/lighthouse/blob/master/docs/trigger/github-com-jenkins-x-lighthouse-pkg-triggerconfig.md#Config):

* [presubmits](https://github.com/jenkins-x/lighthouse/blob/master/docs/trigger/github-com-jenkins-x-lighthouse-pkg-config-job.md#Presubmit) for triggering pipelines on Pull Request
* [postsubmits](https://github.com/jenkins-x/lighthouse/blob/master/docs/trigger/github-com-jenkins-x-lighthouse-pkg-config-job.md#Postsubmit) for triggering pipelines on a push to a branch (e.g. releasing)

Also check out the [lighthouse pipeline configuration docs](https://github.com/jenkins-x/lighthouse/blob/master/docs/pipelines.md)
