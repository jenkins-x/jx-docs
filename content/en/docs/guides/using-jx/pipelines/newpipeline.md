---
title: "Creating Jenkins X Pipelines from scratch"
linkTitle: "Create from scratch"
weight: 1
description: >
  How to create a new Jenkins X Pipeline from scratch
---

If you’re starting out with a blank canvas, it’s still a good idea to have a look at the [quickstart templates](https://github.com/jenkins-x-quickstarts) to get inspiration for creating a pipeline with proper syntax and structure.

You can copy the basic structure over from an existing file, or copy from here, but at the very minimum you need to define two pipelines, pullRequest and Release, which will encompass the more detailed stages and steps:

```yaml
buildPack: none
pipelineConfig:
 pipelines:
   pullRequest:
   release:
```

For the `pullRequest` pipeline you define the stages and steps that Jenkins X will execute for each pull request, and `Release` is the same, just for what should happen to create the final product (whether a k8s app, docker image, static website, etc.)

You can also specify a `feature` pipeline, for processing merges to a feature branch. However, note that the [Accelerate book](/about/overview/accelerate/) recommends against long term feature branches. Instead, consider using trunk based development which is a practice of high performing teams.

Each pipeline will have an `agent` defined (usually Kaniko for building docker images) and at least one `stage`:

```yaml
    release:
      pipeline:
        agent:
          image: gcr.io/kaniko-project/executor:9912ccbf8d22bbafbf971124600fbb0b13b9cbd6
        stages:
        - name: release
          steps:
```

Within each stage you’ll define the steps, which can generally be anything you can call on a command line or execute via a docker container. [Configuration for steps](/docs/reference/pipeline-syntax-reference/#configuration-for-steps) lists the various parameters you can use in a step.
