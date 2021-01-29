---
title: Pipelines
linktitle: Pipelines
type: docs
description: Working with Tekton Pipelines in Jenkins X
weight: 200
aliases:
  - /v3/guides/pipeline-catalog/
  - /v3/develop/pipeline-catalog
---

As part of the [Tekton Catalog enhancement proposal](https://github.com/jenkins-x/enhancements/issues/37) we've improved support for Tekton in Jenkins X so that you can

  * easily [edit any pipeline in any git repository](/v3/develop/pipelines/#editing-pipelines) by just modifying the [Task](https://tekton.dev/docs/pipelines/tasks/#configuring-a-task), [Pipeline](https://tekton.dev/docs/pipelines/pipelines/#configuring-a-pipeline) or [PipelineRun](https://tekton.dev/docs/pipelines/pipelineruns/#configuring-a-pipelinerun) files in your `.ligthhouse/jenkins-x` folder
  * [add new pipelines to any git repository](#add-new-taskspipelines-by-hand) to reuse any [Task](https://tekton.dev/docs/pipelines/tasks/#configuring-a-task) files you find from places like the [tekton catalog](https://github.com/tektoncd/catalog) in your repositories

