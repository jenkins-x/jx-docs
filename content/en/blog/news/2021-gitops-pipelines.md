---
title: "GitOps your cloud native pipelines"
date: 2021-02-25
draft: false
description: overview of how to use GitOps to manage your cloud native pipelines
categories: [blog]
keywords: [Community, 2021]
slug: "gitops-pipelines"
aliases: []
author: James Strachan
---

[Tekton pipelines](https://tekton.dev/) are cloud native and are designed from the ground up for kubernetes and the cloud:

* there's no single point of failure and the pipelines are elastically scalable
* each pipeline is completely declarative and self defined
* each pipeline executes independently of any others
* pipelines are orchestrated via the sophisticated kubernetes scheduler:
  * can use pipeline specific metadata for resource limits and node selectors: memory, CPU, machine type (GPU, windows/macOS/linux etc)
* its easy to associate pipelines with [Cloud IAM roles](/v3/devops/cloud-native/#map-iam-roles-to-kubernetes-service-accounts) to avoid you having to upload cluster admin secrets to your public CI service which really helps security and helps reduce accidental bitcoin mining on your cloud account

In a previous blog we talked about how you can [accelerate your use of tekton with Jenkins X](/blog/2020/11/11/accelerate-tekton/).

## The problem

We are moving towards a microservice kind of world with many teams writing many bits of software in many repositories. So there are lots and lots of pipelines. These pipelines keep getting more sophisticated over time; doing much more (all kinds of building, analysis, reporting, testing, ChatOps etc) and the software/images/approaches they use change.

So how can we manage, configure and maintain them all so that there are many pipelines for many repositories; where each repository can customise anything it needs but we can easily maintain everything continuously and its easy to understand and tool around?

### Previous solutions

We've tried to tackle this problem in a number of ways over the years; each has pros and cons.

One option is to put all your pipelines in a shared library. You can then reference the pipelines by name in each of your repositories.

But what if you want to change a bit of a pipeline for a specific repository? If you change it globally for everyone you can break things. You may just want local customisation for your repository only.

You can add parameters into your pipelines. They are [quite verbose on Pipelines and PipelineRuns](https://github.com/tektoncd/pipeline/issues/1484); but it's hard to think up front of every parameterisation that may be required by downstream repositories. e.g. changing any image; changing any command line argument in any step, adding/changing any environment variables or volumes? How about adding extra steps before/after a particular step? It can soon get very complex and results in very complex pipelines that are hard to understand and use.

Another option is if you need to change a pipeline file you just copy the entire file or create a fork. But then you end up with 100s of copies or forks of pipelines that are hard to synchronise and manage. You end using ancient image versions or older approaches in some repositories which leads to maintenance nightmare. How do you roll out security updates to images in all those repositories, copies and forks?

Another approach we tried is using a tool like [kpt](https://googlecontainertools.github.io/kpt/) to share YAML files across git repositories and then upgrade them via git. This does work quite well; though the downside is whenever you upgrade a new version (e.g. we roll out a new pipeline catalog or a new image change to a tool for security reasons) you need to generate a pull request on every git repository to upgrade them and usually you end up with merge conflicts as the tekton YAML is not trivial; even fairly minor local customisations lead to merge conflict hell.

So how can you apply the benefits of [GitOps](/v3/devops/gitops/) to your cloud native pipelines while also avoiding copy-paste of lots of YAML into all of your repositories, keeping things easy to understand and flexible so any repository can customize things when required but at the same time make it painless to move reliably forward as the pipeline catalogs and images change?

## GitOps your pipelines

Now our recommendation on the [Jenkins X](https://jenkins-x.io/) project is to use [GitOps](/v3/devops/gitops/) for your pipelines as well as for your source code and deployment configuration:

* store your pipelines as declarative YAML files inside each of your git repositories.
* use the standard [Tekton YAML syntax](/v3/develop/reference/pipelines/) so that you get [IDE support](/v3/develop/pipelines/editing/#ide-support) and [easy linting](/v3/develop/pipelines/editing/#linting)

This lets each git repository configure what pipelines are triggered by what events with what pipeline steps.

If you need to [edit your pipelines in any repository](/v3/develop/pipelines/editing/) they are right there in git; it is then easy for each repository to use its own version and configuration if required. This lets pipelines and repositories change over time independently to help you accelerate.

## Sharing Tasks and Steps across repositories

Rather than copy pasting [task and step YAML](https://tekton.dev/docs/pipelines/tasks/#configuring-a-task) between repositories we can refer to a `Task` or a `Step` in a Task as follows:

* refer to all the steps in a shared task by using

```yaml
taskSpec:
  steps:
  - image: uses:sourceURI
```

* refer to a single _named_ step from a shared task

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

This references the <https://github.com> repository for `owner/repository` and **@version** can be a git tag, branch or SHA.

If you are not using [github.com](https://github.com) to host your git repositories you can access a pipeline task or step from your custom git serve use the **uses:lighthouse:** prefix before `owner`:

```yaml
- image: uses:lighthouse:owner/repository/pathToFile@version
```

We [recommend you version everything with GitOps](/v3/devops/gitops/#recommendations) so you know exactly what versions are being used from git.

However you can use **@HEAD** to reference the latest version.

To use a locked down version based on the _version stream_ of your cluster, you can use **@versionStream** which means use the git SHA for the repository which is configured in the version stream.

The nice thing about **@versionStream** is that the pipeline catalog you inherit tasks and steps from is locked down to an exact SHA in the version stream; but it avoids you having to go through every one of your git repositories whenever you upgrade a pipeline catalog.

## Reusing Tasks and Steps from Tekton Catalog

The [Tekton Catalog](https://github.com/tektoncd/catalog) git repository defines a ton of Tekton pipelines you can reuse in your pipelines

You can `image: uses:sourceURI` notation inside any pipeline file in your `.lighthouse/jenkins-x/mypipeline.yaml` file like this:

```yaml
steps:
  - image: uses:tektoncd/catalog/task/git-clone/0.2/git-clone.yaml@HEAD
```

This will then include the steps from the [git-clone.yaml](https://github.com/tektoncd/catalog/blob/master/task/git-clone/0.2/git-clone.yaml) file

It's not just the [Tekton Catalog](https://github.com/tektoncd/catalog)  - you can use this same approach to reuse Tasks or steps from any git repository of your choosing; such as the [Jenkins X Pipeline catalog](https://github.com/jenkins-x/jx3-pipeline-catalog/tree/master/tasks)

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

### Inlining a pipeline step locally

If you want to edit a step that is inherited from a pipeline catalog just run the [jx pipeline override](https://github.com/jenkins-x/jx-pipeline/blob/master/docs/cmd/jx-pipeline_override.md#jx-pipeline-override) command from a clone of your repository.

```bash
jx pipeline override
```

This will then prompt you to pick which pipeline and step that's inherited via the `image: uses:sourceURI` notation. When chosen the step will be inlined into your local file so you can [edit any of the properties](#customizing-an-inherited-step).

You can use the git compare to see the changes and remove any properties you don't wish to override.

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

## Summary

We've been on our own digital transformation journey in the world of pipelines and used many different approaches over the years to manage many pipelines across many repositories.

A few months ago we moved to the above GitOps approach for our cloud native pipelines and we are absolutely loving it!

Its super easy to:

* share pipelines across all of your git repositories without copy/paste
* easily customise pipelines in any project and be able to easily understand what the local changes are and roll them back if required  
* upgrade pipelines across your repositories in a consistent way as you [upgrade your images, applications and cluster via GitOps](/v3/admin/setup/upgrades/cluster/) so that new versions of pipeline catalogs are upgraded once they pass the system tests.

If you are thinking about using cloud native pipelines with [Tekton](https://tekton.dev/) please try it out and see what you think. We'd love to hear your [feedback](/community/)
