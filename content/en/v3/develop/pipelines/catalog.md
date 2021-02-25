---
title: Catalog
linktitle: Catalogs
type: docs
description: Integration with pipeline catalogs
weight: 400
---

As we create more and more software we tend to get an explosion in the number of git repositories and microservices. Each repository needs automated CI and CD; but how do we manage the hundreds of pipelines we need - while also making it easy to share pipelines across repositories and allowing each repository to customize when required?

Jenkins X solves this as follows:

* the pipelines, tasks and steps are defined via [Tekton YAML](https://tekton.dev/docs/pipelines/tasks/#configuring-a-task) letting you use any tekton tooling such as [IDE completion and validation](/v3/develop/pipelines/#ide-support)
* we support an `image: uses:sourceURI` notation that lets you inherit steps from a git repository without having to copy/paste the source code aross repositories.

For example if you create a new [quickstart](/v3/develop/create-project/) pipeline may look like this (slightly condensed)...

```yaml 
tasks:
- name: from-build-pack
  taskSpec:
    stepTemplate:
      image: uses:jenkins-x/jx3-pipeline-catalog/tasks/javascript/release.yaml@versionStream
    steps:
    - image: uses:jenkins-x/jx3-pipeline-catalog/tasks/git-clone/git-clone.yaml@versionStream
    - name: next-version
    - name: jx-variables
    - name: build-npm-install
    - name: build-npm-test
    - name: build-container-build
    - name: promote-changelog
    - name: promote-helm-release
    - name: promote-jx-promote
```

You may wonder what those `uses:` strings mean.

### Referencing a Task or Step

Rather than copy pasting [task and step YAML](https://tekton.dev/docs/pipelines/tasks/#configuring-a-task) between repositories we can refer to a `Task` or a `Step` in a Task as follows:

* refer to all the steps in a task by using

```yaml
taskSpec:
  steps:
  - image: uses:sourceURI
```

* refer to a single _named_ step from a task

```yaml
  taskSpec:
    stepTemplate:
      image: uses:sourceURI
    steps:
    - name: mystep
```

### SourceURI notation

The source URI notation is enabled by a special `image` prefix of **uses:** on step or if an image on a step is blank and the `stepTemplate:` has an `image` prefix of **uses:**

We borrowed this idea from [ko](https://github.com/google/ko) and [mink](https://github.com/mattmoor/mink); the idea of using a custom prefix on image URIs.

You can refer to the [detailed documentation](https://github.com/jenkins-x/lighthouse/blob/master/docs/pipelines.md) on how the step inheritence and overriding works.

For a [github.com](https://github.com) source URI we use the syntax:

```yaml
- image: uses:owner/repository/pathToFile@version
```

This references the https://github.com repository for `owner/repository` and **@version** can be a git tag, branch or SHA.

If you are not using [github.com](https://github.com) to host your git repositories you can access a pipeline task or step from your custom git serve use the **uses:lighthouse:** prefix before `owner`:

```yaml
- image: uses:lighthouse:owner/repository/pathToFile@version
```

We [recommend you version everything with GitOps](/v3/devops/gitops/#recommendations) so you know exactly what versions are being used from git. 

However you can use **@HEAD** to reference the latest version.

To use a locked down version based on the _version stream_ of your cluster, you can use **@versionStream** which means use the git SHA for the repository which is configured in the version stream.

The nice thing about **@versionStream** is that the pipeline catalog you inherit tasks and steps from is locked down to an exact SHA in the version stream; but it avoids you having to go through every one of your git repositories whenever you upgrade a pipeline catalog.


#### file and URL syntax

If you want to reuse a Task or Step thats not easily accessible from the above git source URI syntax you can always use a http:// or https:// URL instead:

```yaml
- image: uses:https://myserver.com/cheese.yaml
```

If there's no @version on a uses string its interpreted as a local file:

```yaml
- image: uses:some-file.yaml
```

## How it looks

So here is an [example release pipeline](https://github.com/jenkins-x/jx3-pipeline-catalog/blob/master/packs/javascript/.lighthouse/jenkins-x/release.yaml) generated via the [Jenkins X Pipeline catalog](https://github.com/jenkins-x/jx3-pipeline-catalog/tree/master/tasks) if you create a [JavaScript quickstart](/v3/develop/pipelines/catalog)

```yaml 
apiVersion: tekton.dev/v1beta1
kind: PipelineRun
metadata:
  name: release
spec:
  pipelineSpec:
    tasks:
    - name: from-build-pack
      taskSpec:
        stepTemplate:
          env:
          - name: NPM_CONFIG_USERCONFIG
            value: /tekton/home/npm/.npmrc
          image: uses:jenkins-x/jx3-pipeline-catalog/tasks/javascript/release.yaml@versionStream
          name: ""
          resources:
            requests:
              cpu: 400m
              memory: 512Mi
          volumeMounts:
          - mountPath: /tekton/home/npm
            name: npmrc
          workingDir: /workspace/source
        steps:
        - image: uses:jenkins-x/jx3-pipeline-catalog/tasks/git-clone/git-clone.yaml@versionStream
          name: ""
        - name: next-version
        - name: jx-variables
        - name: build-npm-install
        - name: build-npm-test
        - name: check-registry
        - name: build-container-build
        - name: promote-changelog
        - name: promote-helm-release
        - name: promote-jx-promote
        volumes:
        - name: npmrc
          secret:
            optional: true
            secretName: npmrc
  serviceAccountName: tekton-bot
  timeout: 240h0m0s
```

You can see it mounts an npm secret for using npm package management and specifies CPU and memory requirements. It then is using the **uses:** notation to inherit a bunch of steps from the [jenkins-x/jx3-pipeline-catalog/tasks/javascript/release.yaml](https://github.com/jenkins-x/jx3-pipeline-catalog/blob/master/tasks/javascript/release.yaml) as well as sharing the [jenkins-x/jx3-pipeline-catalog/tasks/git-clone/git-clone.yaml](https://github.com/jenkins-x/jx3-pipeline-catalog/blob/master/tasks/git-clone/git-clone.yaml) task

Also notice we don't have to copy and paste the exact details of the images, commands, arguments, environment variables and volume mounts required for each step; we can just reference them via Git. Also each pipeline in each repository can reference different versions if required.

### Adding your own steps

You can easily add your own steps in between the `uses:` steps in your pipeline by adding a regular step which has a custom image.

e.g. see `my-prefix-step` which has an explicit `image:` value so isn't inherited from the `stepTemplate.image`

```yaml 
apiVersion: tekton.dev/v1beta1
kind: PipelineRun
spec:
  pipelineSpec:
    tasks:
    - name: from-build-pack
      taskSpec:
        stepTemplate:
          image: uses:jenkins-x/jx3-pipeline-catalog/tasks/javascript/release.yaml@versionStream
        steps:
        - name: jx-variables
        
        # lets add a custom step in between shared steps...
        - image: node:12-slim
          name: my-prefix-step
          script: |
            #!/bin/sh
            npm something        
        - name: jx-variables 
          ...
```

### Customizing an inherited step

You can edit the step in your [IDE](/v3/develop/pipelines/#ide-support) and add any custom properties such as `command`, `args`, `env`, `script` or `volumeMount` - those values then override the inherited step.

e.g. you can then change any command line, add an environment variable or add a new volume mount without copy pasting the whole step. e.g. we change the `script` value of the `jx-variables` step below:
     

```yaml 
apiVersion: tekton.dev/v1beta1
kind: PipelineRun
spec:
  pipelineSpec:
    tasks:
    - taskSpec:
        stepTemplate:
          image: uses:jenkins-x/jx3-pipeline-catalog/tasks/javascript/release.yaml@versionStream
        steps:
        - name: jx-variables
          script: |
            #!/usr/bin/env sh
            echo my replacement command script goes here
```

Any extra properties in the steps are used to override the underlying uses step.


## Command line tools

To help understand the inheriance and overriding of steps we have a few command line tools to help:

### Viewing the effective pipeline

To see the actual Tekton pipeline that would be executed from your local source directory you can run the [jx pipeline effective](https://github.com/jenkins-x/jx-pipeline/blob/master/docs/cmd/jx-pipeline_effective.md#jx-pipeline-effective) command:

```bash
jx pipeline effective
```

If you want to open the effective pipeline in your editor, such as [VS Code](https://code.visualstudio.com/) you can do:

```bash
jx pipeline effective -e code
```
                   
If you use [Intellij](https://www.jetbrains.com/idea/) or any of [JetBrains other IDEs](https://www.jetbrains.com/products/#type=ide) you can do the following if you have [enabled](https://www.youtube.com/watch?v=SVANj3gAWt8) the `idea` [command line tool](https://www.youtube.com/watch?v=SVANj3gAWt8):

```bash
jx pipeline effective -e idea
```

If you want to always view an effective pipeline in your editor then define the `JX_EDITOR` environment variable...

```bash
export JX_EDITOR="code"

# now we will always open effective pipelines inside VS Code
jx pipeline effective
```

### Overriding a pipeline step locally

If you want to edit a step that is inherited from a pipeline catalog just run the [jx pipeline override](https://github.com/jenkins-x/jx-pipeline/blob/master/docs/cmd/jx-pipeline_override.md#jx-pipeline-override) command from a clone of your repository.

```bash
jx pipeline override
```

This will then prompt you to pick which pipeline and step that's inherited via the `image: uses:sourceURI` notation. When chosen the step will be inlined into your local file so you can [edit any of the properties](#customizing-an-inherited-step).

You can use the git compare to see the changes and remove any properties you don't wish to override.


## Tekton Catalog
                        
The [Tekton Catalog](https://github.com/tektoncd/catalog) git repository defines a ton of Tekton pipelines you can reuse in your pipelines

## Referencing Tasks or Steps from a Catalog

You can `image: uses:sourceURI` notation inside any pipeline file in your `.lighthouse/jenkins-x/mypipeline.yaml` file like this:

```yaml 
steps:
  - image: uses:tektoncd/catalog/task/git-clone/0.2/git-clone.yaml@HEAD
```

This will then include the steps from the [git-clone.yaml](https://github.com/tektoncd/catalog/blob/master/task/git-clone/0.2/git-clone.yaml) file 

It's not just the [Tekton Catalog](https://github.com/tektoncd/catalog) - you can use this same approach to reuse Tasks or steps from any git repository of your choosing; such as the [Jenkins X Pipeline catalog](https://github.com/jenkins-x/jx3-pipeline-catalog/tree/master/tasks)


## Custom Pipeline Catalog

See [this section](https://jenkins-x.io/v3/about/extending/#pipeline-catalog) to configure your custom pipeline catalog.
