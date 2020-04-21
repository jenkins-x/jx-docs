---
title: Pipelines Questions
linktitle: Pipelines Questions
description: Questions on how to use Serverless Jenkins X Pipelines
weight: 10
---

For more background see the guide on [Serverless Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) using [Tekton](https://tekton.dev/). There is also the [Jenkins X Pipelines Syntax Reference](/docs/reference/pipeline-syntax-reference/)

## How do I add a custom step?

To add a new custom step to your `jenkins-x.yml` file see [how to use the jx create step](/about/concepts/jenkins-x-pipelines/#customizing-the-pipelines)

## How do I override a step?

If there is a named step in the pipeline you wish to override you can add some YAML to your `jenkins-x.yml` file as 
 follows:

In this case were are going to replace the step called `helm-release` in the `release` pipeline

``` 
pipelineConfig:
  pipelines:
    overrides:
      - pipeline: release
        name: helm-release
        step: 
          image: busybox
          sh: echo "this command is replaced"
```   

You can see the effect of this change locally before you commit it to git via the [jx step syntax effective](/commands/jx_step_syntax_effective/) command:

``` 
jx step syntax effective -s
```

You can override whole Stages or replace a specific step with a single step or a sequence of steps. You can also add steps before/after another step.

For more detail check out [how to override steps](/docs/reference/pipeline-syntax-reference/#specifying-and-overriding-release-pull-request-and-feature-pipelines)

## How can I override the default container image?

As you can see above you can override any step in any build pack; but you can also override the container image used by default in all the steps by adding this YAML to your `jenkins-x.yml`:

``` 
pipelineConfig:
  agent:
    label: jenkins-go
    container: somerepo/my-container-image:1.2.3
```

You can see the effect of this change locally before you commit it to git via the [jx step syntax effective](/commands/jx_step_syntax_effective/) command:

``` 
jx step syntax effective -s
```         

For more detail check out [how to override steps](/docs/reference/pipeline-syntax-reference/#specifying-and-overriding-release-pull-request-and-feature-pipelines)

## How do Jenkins X Pipelines compare to Jenkins pipelines?

See [the differences between Jenkins X and Jenkins Pipelines](/about/concepts/jenkins-x-pipelines/#differences-to-jenkins-pipelines)

## How do I get IDE completion editing `jenkins-x.yml`

See the IDE guide for [IDEA](/about/concepts/jenkins-x-pipelines/#editing-in-vs-code) and [VS Code](/about/concepts/jenkins-x-pipelines/#editing-in-vs-code)

## What environment variables are available by default inside a pipeline?

See the [default environment variables created for pipeline steps](/docs/guides/using-jx/pipelines/envvars/#default-environment-variables)

## Is there a reference for the syntax?

See the [Jenkins X Pipelines Syntax Reference](/docs/reference/pipeline-syntax-reference/)

## How do I mount a Secret or ConfigMap?

Each step in a Jenkins X Pipeline in the `jenkins-x.yml` file is basically a [Container](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.15/#container-v1-core) from kubernetes so you can specify the image, resource limits, environment variables and mount them from a `ConfigMap` or `Secret`

You can see [an example of mounting a Secret to an environment variable here](/docs/reference/pipeline-syntax-reference/#full-pipeline-definition-in-jenkins-xyml)

If you are inside a shell script you can also use the [jx step credential](/commands/deprecation/)

## Can I mount a Persistent Volume in my pipeline?

Tekton already mounts a separate Persistent Volume for each build pod at `/workspace` so the build results are kept around for a while until they are garbage collected.

On most kubernetes clusters you cannot easily share a single Persistent Volume across multiple pods; so having a shared PV across builds isn't generally easy or compatible. You can however add a step to populate your PV on startup from a cloud bucket and at the end of a pipeline copy data into a bucket to speed up caching.

You can also do things like use Nexus as a network cache for fetching maven dependencies (which happens OOTB with Maven builds in Jenkins X) or add the Athens proxy for Go.

Hopefully the Tekton community will figure out some even better caching solutions to speed up builds.


## How do I define an environment variable inside a step for other steps to use?

Files are the easiest approach as the `/workspace` directory is shared with all steps. So write in one step and use the value from other steps etc.

The other option is mounting a `ConfigMap` as environment variables into each step and modifying that on one step; but files are easier really.



