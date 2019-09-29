---
title: Pipelines Questions
linktitle: Pipelines Questions
description: Questions on how to use Serverless Jenkins X Pipelines
weight: 10
---

For more background see the guide on [Serverless Jenkins X Pipelines](/docs/concepts/jenkins-x-pipelines/) using [Tekton](https://tekton.dev/). There is also the [Jenkins X Pipelines Syntax Reference](/docs/reference/pipeline-syntax-reference/)

## How do I add a custom step?

To add a new custom step to your `jenkins-x.yml` file see [how to use the jx create step](/docs/concepts/jenkins-x-pipelines/#customizing-the-pipelines)

## How do Jenkins X Pipelines compare to Jenkins pipelines?

See [the differences between Jenkins X and Jenkins Pipelines](/docs/concepts/jenkins-x-pipelines/#differences-to-jenkins-pipelines)

## How do I get IDE completion editing `jenkins-x.yml`

See the IDE guide for [IDEA](/docs/concepts/jenkins-x-pipelines/#editing-in-vs-code) and [VS Code](/docs/concepts/jenkins-x-pipelines/#editing-in-vs-code)

## What environment variables are available by default inside a pipeline?

See the [default environment variables created for pipeline steps](/docs/concepts/jenkins-x-pipelines/#default-environment-variables)

## Is there a reference for the syntax?

See the [Jenkins X Pipelines Syntax Reference](/docs/reference/pipeline-syntax-reference/)

## How do I mount a Secret or ConfigMap?

Each step in a Jenkins X Pipeline in the `jenkins-x.yml` file is basically a [Container](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.15/#container-v1-core) from kubernetes so you can specify the image, resource limitts, environment variables and mount them from a `ConfigMap` or `Secret`

You can see [an example of mounting a Secrett to an environment variable here](/docs/reference/pipeline-syntax-reference/#full-pipeline-definition-in-jenkins-x-yml)

If you are inside a shell script you can also use the [jx step credential](/commands/jx_step_credential/)

## Can I mount a Persistent Volume in my pipeline?

Tekton already mounts a separate Persistent Volume for each build pod at `/workspace` so the build results are kept around for a while until they are garbage collected.

On most kubernetes clusters you cannot easily share a single Persistent Volume across multiple pods; so having a shared PV across builds isn't generally easy or compatible. You can however add a step to populate your PV on startup from a cloud bucket and at the end of a pipeline copy data into a bucket to speed up caching.

You can also do things like use Nexus as a network cache for fetching maven dependencies (which happens OOTB with Maven builds in Jenkins X) or add the Athens proxy for Go.

Hopefully the Tekton community will figure out some even better caching solutions to speed up builds.
