---
title: Jenkins X Pipelines
linktitle: Jenkins X Pipelines
description: cloud native serverless pipelines
date: 2019-03-04
publishdate: 2019-03-04
keywords: [tekton]
menu:
  docs:
    parent: "architecture"
    weight: 66
weight: 66
sections_weight: 66
draft: false
toc: true
---

We [recently announced](/news/jenkins-x-next-gen-pipeline-engine) that we are introducing **Jenkins X Pipelines**, a new serverless pipeline execution engine based on the [Tekton Pipelines](https://tekton.dev/) open source project. 

Tekton has been designed to be a modern cloud native solution for running pipelines.

The work here is still experimental but we'd love feedback and help from the community to drive it forward.  

## Trying Jenkins X Pipelines

Right now to enable a Tekton based install you can create a new cluster using `jx` along with these flags:

```
jx create cluster gke --tekton --no-tiller
```

Or if you want to go all in on the next generation of Jenkins X with built-in GitOps for your development environment, using Tekton and using Vault for storage of Secrets then use the following (only works on GCP and AWS right now):

```
jx create cluster gke --ng
```

The general developer experience, CLI and IDE plugins should work as before - but using [Tekton Pipelines](https://tekton.dev/) Custom Resources under the covers instead of creating a Jenkins Server per team!

## Using a quickstart
 
Once your cluster is started you can create a new quickstart, we've been using the nodejs one reliably.

```
jx create quickstart
```

A `prowjob` is created, a new prow pipeline controller watches for these jobs and when it receives an event it will check if it has a `pipelinerun` spec present, if not it will post the `prowjob` to a new `pipelinerunner` service from Jenkins X which in turn clones the repo and revision then translates its `jenkins-x.yml` into vanilla Tekton Pipeline resources.  Once they are created the `tekton-pipeline-controller` executes the builds.

## Differences to Jenkins Pipelines

Jenkins X Pipelines use a new `jenkins-x.yml` file which is YAML instead of the Groovy `Jenkinsfile` used by Jenkins.

However it's still reusing the same reusable and composable build packs under the covers. (The Jenkins X [build packs](/architecture/build-packs/) are actually written in Jenkins X Pipelines YAML).

One thing you will notice is that with Jenkins X Pipelines we don't need to copy/paste a large `Jenkisnfile` into each application's git repository; usually the generated `jenkins-x.yml` file is small, like this:

```yaml 
buildPack: maven
```

That's it! What that basically means is at runtime the Jenkins X Pipeline will use the [build packs](/architecture/build-packs/) to generate the actual Tekton Pipeline.
 
## Customising the Pipelines

Having automated [build packs](/architecture/build-packs/) to do all of your CI+CD is pretty awesome - as most of the time your microservices will all be compiled, tested, packaged, released and promoted in the same way. CI+CD is often undifferentiated heavy lifting we should just automate!

However there are times you want to customise a [particular pipeline](/architecture/build-packs/#pipelines) (release, pull request, feature etc) and a particular [lifecycle](/architecture/build-packs/#lifecycles) to change the actual steps invoked.

You can read more about the [extension model](/architecture/build-packs/#pipeline-extension-model) to find out all you can do. Basically you can add steps before/after any lifecycle or completely replace a set of lifecycles or even opt out of the build pack completely and inline your pipelines inside your `jenkins-x.yml`

For a quick way to add a new step into a pipeline lifecycle you can use the [jx create step](/commands/jx_create_step/) command:

<figure>
<img src="/images/architecture/create-step.gif" />
<figcaption>
<h5>Create a new Jenkins X Pipeline Step via the CLI</h5>
</figcaption>
</figure>

You can also add or override an environment variable in your pipeline via the [jx create variable](/commands/jx_create_variable/) command

## Editing in VS Code

If you are using [VS Code](https://code.visualstudio.com/) you may want to install the [YAML Language Extension](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml) from Red Hat. 

This extension lets you add JSON Schemas to validate YAML files.

If you open your `Settings` in the `settings.json` page and add the following to the top of your file:

```json
{
    "yaml.schemas": {
        "https://jenkins-x.io/schemas/jx-schema.json": "jenkins-x*.yml"
    },
    ...
```

This will then register the [Jenkins X Json Schema file](https://jenkins-x.io/schemas/jx-schema.json) so that any file you open called `jenkins-x.yml` will get smart completion in the IDE as you can see in [this video](/images/architecture/yaml-edit.mp4):

<figure>
<embed src="/images/architecture/yaml-edit.mp4" autostart="false" height="400" width="600" />
<figcaption>
<h5>Edit Jenkins X Pipeline in VS Code</h5>
</figcaption>
</figure>

We'd love to improve this UX if you fancy [helping out](/contribute/).

## Default environment variables

The following environment variables are available for use in a step in Jenkins X Pipelines:

| Name | Description |
| --- | --- |
| DOCKER_REGISTRY | the docker registry host (e.g. `docker.io` or `gcr.io`) |
| BUILD_NUMBER | the build number (1, 2, 3) starts at `1` for each repo and branch |
| PIPELINE_KIND | the kind of pipeline such as `release` or `pullrequest` |
| PIPELINE_CONTEXT | the pipeline context if there are multiple pipelines per PR (for different tests/governance/lint etc) |
| REPO_OWNER | the git repository owner |
| REPO_NAME | the git repository name |
| JOB_NAME | the job name which tyically looks like `$REPO_OWNER/$REPO_NAME/$BRANCH_NAME` |
| APP_NAME | the name of the app which typically is the `$REPO_NAME`
| BRANCH_NAME | the name of the branch such as `master` or `PR-123` |
| JX_BATCH_MODE | indicates to jx to use batch mode if `true` |
| VERSION | contains the version number being released or the PR's preview version |
| BUILD_ID | same as `$BUILD_NUMBER`
| JOB_TYPE | the prow job type such as `presubmit` for PR or `postsubmit` for release |
| PULL_BASE_REF | the branch/ref of git |
| PULL_BASE_SHA | the git sha being built |
| PULL_NUMBER | for PRs this will be the number without the `PR-` prefix
| PULL_REFS | for batch merging all the git refs |
 
