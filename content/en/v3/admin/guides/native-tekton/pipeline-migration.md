---
title: Pipeline Migration
linktitle: Pipeline Migration
type: docs
description: How to migrate existing pipelines to native Tekton
weight: 100
aliases:
  - /v3/guides/native-tekton
---

Migrating to native Tekton brings a number of changes to the way that Jenkins X pipelines are configured and run.
The main changes are:
- The lighthouse PipelineRun resolver (responsible for handling the `uses:sourceURI` syntax) has been replaced with 
[Tekton's git resolver](https://tekton.dev/docs/pipelines/git-resolver/).
- Pipelines are no longer confined to a single pod running multiple containers (1 task, many steps). Instead, each step
now runs as its own pod (many tasks, many steps).
- As each pipeline now contains many tasks, [Tekton's workspaces](https://tekton.dev/docs/pipelines/workspaces/) are used to share files between tasks.

This guide will walk you through the steps required to migrate your existing pipelines to native Tekton.

## Prerequisites
You're cluster git repository will need to be at `versionStream>=[insert version here]` before proceeding with the 
pipeline upgrade. This can be done by running the following command on your cluster git repository.
```bash
jx gitops upgrade
```
The upgrade will bring in the relevant pipeline changes for your cluster repository so the `verify` & `bootjob` pipelines
will continue to work during your migration.

## Upgrading pipelines in your repositories
You can upgrade the pipelines in all the repositories you've imported or created via quickstarts by running:
```bash
jx updatebot pipeline
```
This uses the default [kpt](https://kpt.dev/) strategy of `resource-merge` to merge any local changes with the those in the 
[pipeline-catalog](https://github.com/jenkins-x/jx3-pipeline-catalog). The strategy used can be changed using the `--strategy` flag. 
For more information see`jx updatebot pipeline --help`.

**Warning:** This is substantial change to the pipeline configuration and will likely result in merge conflicts. 
If so, you will need to resolve these manually or by using the pipeline conversion tool seen in [converting pipelines](#converting-pipelines).

## Converting pipelines
Both in-repository pipelines and personal catalogs can be converted by using the following command in the root of the 
repository:
```bash
jx pipeline convert remotetasks
```

The command identifies whether the PipelineRun is child or parent (in-repository or catalog) by checking for the presence 
of a `uses:sourceURI` image in the stepTemplate. 

Child PipelineRuns have they're steps converted to either taskRefs or embeddedTasks depending on whether the original step was inherited. 

Parent PipelineRuns have their steps converted into standalone tasks as native Tekton does not support PipelineRuns 
inheriting tasks from other PipelineRuns.

Standalone Tasks have the Lighthouse's default params and environment variables added to them. These can be found 
 [here](https://jenkins-x.io/v3/develop/reference/variables/#environment-variables).

By default, the workspace size of the converted pipeline is calculated from the size of the repository plus 300Mi - to account
for any additional files that may be added during the pipeline run. This can be overridden using the `--workspace-size` flag.
For catalogs the calculation can be disabled by setting `--calculate-workspace-volume=false` in which case the workspace size
will default to 1Gi.

For more information on this command, see `jx pipeline convert remotetasks --help`.
