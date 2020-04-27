---
title: Jenkins X Pipelines
linktitle: Jenkins X Pipelines
description: cloud native serverless pipelines
date: 2019-03-04
publishdate: 2019-03-04
keywords: [tekton]
aliases:
  - /architecture/jenkins-x-pipelines
  - /getting-started/next-gen-pipeline
weight: 40
---

<!-- We [recently announced](/news/jenkins-x-next-gen-pipeline-engine/) that we are introducing -->

 **Jenkins X Pipelines** are cloud native pipelines that use [Tekton](https://tekton.dev/) as the pipeline execution engine.

## Trying Jenkins X Pipelines

Create a new cluster installed with Jenkins X Pipelines using `jx` and the following flags:

```sh
jx create cluster gke --tekton
```

Or if you want to go all in on the next generation of Jenkins X with built-in GitOps for your development environment, using Tekton and using Vault for storage of secrets then use the following (only works on GCP and AWS right now):

```sh
jx create cluster gke --ng
```

The general developer experience, CLI and IDE plugins should work as before - but using [Tekton Pipelines](https://tekton.dev/) Custom Resources under the covers instead of creating a Jenkins Server per team!

## Using a quickstart

Once your cluster is started you can create a new quickstart.

```sh
jx create quickstart
```

A `prowjob` is created, a new prow pipeline controller watches for these jobs and when it receives an event it will check if it has a `pipelinerun` spec present, if not it will post the `prowjob` to a new `pipelinerunner` service from Jenkins X which in turn clones the repo and revision then translates its `jenkins-x.yml` into vanilla Tekton Pipeline resources.  Once they are created the `tekton-pipeline-controller` executes the builds.

## Differences to Jenkins Pipelines

Jenkins X Pipelines use a new `jenkins-x.yml` file which is YAML instead of the Groovy `Jenkinsfile` used by Jenkins.

However it's still reusing the same reusable and composable build packs under the covers. (The Jenkins X [build packs](/docs/reference/components/build-packs//) are actually written in Jenkins X Pipelines YAML).

One thing you will notice is that with Jenkins X Pipelines we don't need to copy/paste a large `Jenkinsfile` into each application's git repository; usually the generated `jenkins-x.yml` file is small, like this:

```yaml
buildPack: maven
```

That's it! What that basically means is at runtime the Jenkins X Pipeline will use the [build packs](/docs/reference/components/build-packs//) to generate the actual Tekton Pipeline.

## Customizing the Pipelines

Having automated [build packs](/docs/reference/components/build-packs//) to do all of your CI+CD is pretty awesome - as most of the time your microservices will all be compiled, tested, packaged, released and promoted in the same way. CI+CD is often undifferentiated heavy lifting we should just automate!

However there are times you want to customize a [particular pipeline](/docs/reference/components/build-packs//#pipelines) (release, pull request, feature etc) and a particular [life cycle](/docs/reference/components/build-packs/#life-cycles) to change the actual steps invoked.

You can read more about the [extension model](/docs/reference/components/build-packs//#pipeline-extension-model) to find out all you can do. Basically you can add steps before/after any life cycle or completely replace a set of life cycles or even opt out of the build pack completely and inline your pipelines inside your `jenkins-x.yml`

For a quick way to add a new step into a pipeline life cycle you can use the [jx create step](/commands/deprecation/) command:

<figure>
<img src="/images/architecture/create-step.gif" />
<figcaption>
<h5>Create a new Jenkins X Pipeline Step via the CLI</h5>
</figcaption>
</figure>

You can also add or override an environment variable in your pipeline via the [jx create variable](/commands/jx_create_variable/) command

## Editing in VS Code

If you are using [VS Code](https://code.visualstudio.com/) we recommend you install the [YAML Language Extension](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml) from Red Hat.

This extension lets you edit YAML files with optional JSON Schema validation.

Jenkins X's JSON Schema is already registered with [schemastore.org](http://schemastore.org/json/) so editing your `jenkins-x.yml` file in VS Code will include smart completion and validation!

<figure>
<embed src="/images/architecture/yaml-edit.mp4" autostart="false" height="400" width="600" />
<figcaption>
<h5>Edit Jenkins X Pipeline in VS Code</h5>
</figcaption>
</figure>

We'd love to improve this UX if you fancy [helping out](/docs/contributing).

## Editing in IDEA

This should already be included out of the box due to the Jenkins X JSON Schema being registered with [schemastore.org](http://schemastore.org/json/) so editing your `jenkins-x.yml` file in IDEA will include smart completion and validation!

We'd love to improve this UX if you fancy [helping out](/docs/contributing/).
