---
title: Reference
linktitle: Reference
type: docs
description: Reference for all things Pipelines
weight: 900
---

## Reference Guide

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

### Parameters and Environment Variables

The following tekton parameters and environment variables are available inside the pipeline catalog. They are populated by [lighthouse](https://github.com/jenkins-x/lighthouse)

* `BUILD_ID` a unique long number for this build
* `JOB_NAME` the name of the build which matches the name in the `presubmit` or `postsubmit` in your [lighthouse](https://github.com/jenkins-x/lighthouse) `triggers.yaml`
* `JOB_SPEC` is of the form `type:presumit` or `type:postsubmit` so you know what kind of job you are inside
* `PULL_BASE_REF` the base branch name. e.g. `master` or `main`
* `PULL_BASE_SHA` the base git SHA being built
* `REPO_NAME` the name of the git repository
* `REPO_OWNER` the owner of the git repository (a user or organisation)
* `REPO_URL` the git URL to clone the repository being built

Pull Requests `presubmit` also have the following values:

* `PULL_NUMBER` the number of the pull request
* `PULL_PULL_REF` the git reference of the pull request; something like `refs/pull/123/head`
* `PULL_PULL_SHA`  the git SHA of the pull request

#### Additional environment variables

If your pipeline runs the [jx gitops variables](https://github.com/jenkins-x/jx-gitops/blob/master/docs/cmd/jx-gitops_variables.md) command it will lazily create the `.jx/variables.sh` script which will default a bunch more environment variables if they are not already populated in your git repository.

**NOTE** that these variables are dynamically created during the execution of the pipeline pod; so to access them you must `source .jx/variables.sh` inside your step.

So that your step looks something like this...

```yaml
- image: gcr.io/jenkinsxio/jx-cli:latest
  name: my-step
  script: |
    #!/usr/bin/env bash
    source /workspace/source/.jx/variables.sh
    echo "now we can use variables like this: ${VERSION}"
```

Available variables:

* `APP_NAME` the name of the application which defaults to the `$REPO_NAME`
* `BRANCH_NAME` is really the pull request name so something like `PR-123`
* `BUILD_NUMBER` the human readable short build number relative to the repository and branch. So builds start at 1 and go up incrementally
* `DOCKERFILE_PATH`  the location of the `Dockerfile` if it exists
* `DOCKER_REGISTRY` the host name of the registry being used for image builds
* `DOCKER_REGISTRY_ORG` the owner in the container registry (user name or organisation) to push images
* `JX_CHART_REPOSITORY` the URL of the helm chart repository to use
* `PIPELINE_KIND` the kind of pipeline being run `pullrequest` or `release`
* `VERSION` the version number used for releases (and used to tag images and git etc) or the preview version for pull requests

If you want to define dynamic environment variables in one step for use in later steps you can append new variables to `.jx/variables.sh` and then add the `source .jx/variables.sh` later in your pipeline
