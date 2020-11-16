---
title: Pipeline Catalogs
linktitle: Pipeline Catalogs
type: docs
description: Integration with Tekton Pipelines and Tekton Catalog
weight: 200
aliases:
  - /docs/v3/guides/pipeline-catalog/
  - /docs/v3/develop/pipeline-catalog
---

As part of the [Tekton Catalog enhancement proposal](https://github.com/jenkins-x/enhancements/issues/37) we've improved support for Tekton in Jenkins X so that you can

  * easily [edit any pipeline in any git repository](/docs/v3/develop/pipeline-catalog/#editing-pipelines) by just modifying the [Task](https://tekton.dev/docs/pipelines/tasks/#configuring-a-task), [Pipeline](https://tekton.dev/docs/pipelines/pipelines/#configuring-a-pipeline) or [PipelineRun](https://tekton.dev/docs/pipelines/pipelineruns/#configuring-a-pipelinerun) files in your `.ligthhouse/jenkins-x` folder
  * [add new pipelines to any git repository](#add-new-taskspipelines-by-hand) to reuse any [Task](https://tekton.dev/docs/pipelines/tasks/#configuring-a-task) files you find from places like the [tekton catalog](https://github.com/tektoncd/catalog) in your repositories

## Source changes

If you [upgrade your cluster to the latest version stream](/docs/v3/guides/upgrade/#cluster) then you will find if you [create a new quickstart](/docs/v3/develop/create-project/#create-a-new-project-from-a-quickstart) that:

* `.lighthouse/jenkins-x` directory contains the default CI/CD pipelines for Jenkins X with these files:
  * `triggers.yaml` to define the [lighthouse](https://github.com/jenkins-x/lighthouse) [TriggerConfig](https://github.com/jenkins-x/lighthouse/blob/master/docs/trigger/github-com-jenkins-x-lighthouse-pkg-triggerconfig.md#Config) which defines the [ChatOps](/docs/resources/faq/using/chatops/#what-is-chatops) and triggering configuration via a [spec field](https://github.com/jenkins-x/lighthouse/blob/master/docs/trigger/github-com-jenkins-x-lighthouse-pkg-triggerconfig.md#ConfigSpec) which defines [presubmits](https://github.com/jenkins-x/lighthouse/blob/master/docs/trigger/github-com-jenkins-x-lighthouse-pkg-config-job.md#Presubmit) and [postsubmits](https://github.com/jenkins-x/lighthouse/blob/master/docs/trigger/github-com-jenkins-x-lighthouse-pkg-config-job.md#Postsubmit) (i.e. Pull Request and Release triggers).
  * `pullrequest.yaml` defines the Pull Request pipeline using a Tekton [Task](https://tekton.dev/docs/pipelines/tasks/#configuring-a-task), [Pipeline](https://tekton.dev/docs/pipelines/pipelines/#configuring-a-pipeline) or [PipelineRun](https://tekton.dev/docs/pipelines/pipelineruns/#configuring-a-pipelinerun)
  * `release.yaml` defines the Release pipeline using a Tekton Tekton [Task](https://tekton.dev/docs/pipelines/tasks/#configuring-a-task), [Pipeline](https://tekton.dev/docs/pipelines/pipelines/#configuring-a-pipeline) or [PipelineRun](https://tekton.dev/docs/pipelines/pipelineruns/#configuring-a-pipelinerun)
  
* `jenkins-x.yml` files are no longer used by default in new quickstarts instead we use the above. Note if you have projects using `jenkins-x.yml` files they are still supported if you [import them into v3](/docs/v3/develop/create-project/#import-an-existing-project) or you can [use this tool to migrate them to tekton pipelines](https://github.com/jenkins-x-plugins/jx-v2-tekton-converter/blob/main/README.md)


## Editing pipelines

You can now easily modify any of the [Task](https://tekton.dev/docs/pipelines/tasks/#configuring-a-task), [Pipeline](https://tekton.dev/docs/pipelines/pipelines/#configuring-a-pipeline) or [PipelineRun](https://tekton.dev/docs/pipelines/pipelineruns/#configuring-a-pipelinerun) resources in any git repository - just look in each folder inside `.lighthouse` for the YAML files to edit.

e.g. for the default Jenkins X CI/CD pipelines edit either:

* `.lighthouse/jenkins-x`
  * `pullrequest.yaml` to edit the Pull Request [Task](https://tekton.dev/docs/pipelines/tasks/#configuring-a-task), [Pipeline](https://tekton.dev/docs/pipelines/pipelines/#configuring-a-pipeline) or [PipelineRun](https://tekton.dev/docs/pipelines/pipelineruns/#configuring-a-pipelinerun)
  * `release.yaml` to edit the Release [Task](https://tekton.dev/docs/pipelines/tasks/#configuring-a-task), [Pipeline](https://tekton.dev/docs/pipelines/pipelines/#configuring-a-pipeline) or [PipelineRun](https://tekton.dev/docs/pipelines/pipelineruns/#configuring-a-pipelinerun) 

You can test out changes to the Pull Request pipeline by submitting changes in a Pull Request. Changes to a release only take place after merging the change to the main branch.

## IDE support
  
If you use [IntelliJ IDEA](https://www.jetbrains.com/idea/) or [Goland](https://www.jetbrains.com/go/) you might find the [RedHat's intellij-tekton plugin](https://plugins.jetbrains.com/plugin/14096-tekton-pipelines-by-red-hat) useful for editing pipelines with schema validation and completion.

If you use [VS Code](https://code.visualstudio.com/) you may want to try [Red Hat's Tekton Pipelines Extension tekton](https://github.com/redhat-developer/vscode-tekton#tekton-pipelines-extension--)

## Adding Tasks from the Tekton Catalog

The new [jx pipeline import](https://github.com/jenkins-x/jx-pipeline/blob/master/docs/cmd/jx-pipeline_import.md) command can be used to import `Task` resources from the [Tekton Catalog](https://github.com/tektoncd/catalog) and using them inside your project. 

Here's a [demo of this in action](https://asciinema.org/a/368282):

<script src="https://asciinema.org/a/368282.js" id="asciicast-368282" async></script>

The tekton Task resources are copied into your `.lighthouse` directory in a folder using `kpt` so that you can modify things locally if you need to and can [upgrade your local copy with upstream changes](#upgrading-pipelines-and-helm-charts) via the `jx gitops upgrade` command described below.


## Add new tasks/pipelines by hand

You can add new pipelines by hand into a new folder inside `.lighthouse` at any time. 

To setup a _trigger_ so that [lighthouse](https://github.com/jenkins-x/lighthouse) will start your pipeline on a [presubmits](https://github.com/jenkins-x/lighthouse/blob/master/docs/trigger/github-com-jenkins-x-lighthouse-pkg-config-job.md#Presubmit) (i.e. for Pull Requests) or for [postsubmits](https://github.com/jenkins-x/lighthouse/blob/master/docs/trigger/github-com-jenkins-x-lighthouse-pkg-config-job.md#Postsubmit) (i.e. releases on main branches) you need to also add a `triggers.yaml` file which uses the lighthouse [trigger config file file format](https://github.com/jenkins-x/lighthouse/blob/master/docs/trigger/github-com-jenkins-x-lighthouse-pkg-triggerconfig.md#Config) with [this spec field](https://github.com/jenkins-x/lighthouse/blob/master/docs/trigger/github-com-jenkins-x-lighthouse-pkg-triggerconfig.md#ConfigSpec).

You could look at the default `.lighthouse/jenkins-x` directory to see how all this works. The `triggers.yaml` file then refers to the tekton [Task](https://tekton.dev/docs/pipelines/tasks/#configuring-a-task), [Pipeline](https://tekton.dev/docs/pipelines/pipelines/#configuring-a-pipeline) or [PipelineRun](https://tekton.dev/docs/pipelines/pipelineruns/#configuring-a-pipelinerun) files via the `source:` attribute in a [presubmits](https://github.com/jenkins-x/lighthouse/blob/master/docs/trigger/github-com-jenkins-x-lighthouse-pkg-config-job.md#Presubmit) or [postsubmits](https://github.com/jenkins-x/lighthouse/blob/master/docs/trigger/github-com-jenkins-x-lighthouse-pkg-config-job.md#Postsubmit) entry.
  
## Changing the triggers

You can modify the `.lighthouse/*/triggers.yaml` file to modify the  [presubmits](https://github.com/jenkins-x/lighthouse/blob/master/docs/trigger/github-com-jenkins-x-lighthouse-pkg-config-job.md#Presubmit) and/or [postsubmits](https://github.com/jenkins-x/lighthouse/blob/master/docs/trigger/github-com-jenkins-x-lighthouse-pkg-config-job.md#Postsubmit) entries to do things like:

* customise the `rerun_command` or `trigger` ChatOps comments for `presubmits`
* configure the `branches` patterns for `postsubmit` triggers
* add new entries for new pipelines; or pipelines with different `pipeline_run_params` entries to parameterise existing `PipelineRun` files differently

## Upgrading pipelines and helm charts

You can upgrade any git repository in the same way you upgrade your [clusters git repository](/docs/v3/guides/upgrade/#cluster) by running the [jx gitops upgrade](https://github.com/jenkins-x/jx-gitops/blob/master/docs/cmd/jx-gitops_update.md) command inside a git checkout of your repository:

```bash
cd my-quickstart-thingy
jx gitops upgrade
```              

This will then upgrade any helm charts or pipeline catalogs you are using in your git repository with the latest versions.

After running this command you will usually have some changes in `git` you can review. If you are happy with the changes commit them and create a Pull Request so that they can get applied on your cluster.

```bash
git add *
git commit -a -m "fix: upgrade pipeline catalog"
git push
```               

It is possible that you can have merge conflicts.  

You can follow the inline git helper messages to resolve conflicts - or use your IDE to help figure out the merge issues more easily. 

## Diagnosing problems

If you edit pipelines or lighthouse trigger files and things don't work there's a couple of places the errors may show up.

We will hopefully add much better linting/error messages on Pull Requests soon to give you better and faster feedback.

Until then you could look in:

* the `lighthouse-webhooks-*` pod(s) which take the webhooks from your git provider and convert them into `lighthousejob` resources
* the `lighthouse-tekton-controller-*` pod(s) which watch for `lighthousejob` resources and create the Tekton [PipelineRun](https://tekton.dev/docs/pipelines/pipelineruns/#configuring-a-pipelinerun) resources
* the `tekton-controller-*`  pod(s) watches for Tekton [PipelineRun](https://tekton.dev/docs/pipelines/pipelineruns/#configuring-a-pipelinerun) resources and conver them into Kubernetes `Pod` resources

Any errors will usually be recorded in the `status` field of the resource that has issues (`lighthousejob` or `pipelinerun`).


## Reference Guide

The following are the links to the various configuration file formats:

[Tekton](https://tekton.dev/) resources:

* [Task](https://tekton.dev/docs/pipelines/tasks/#configuring-a-task)
* [TaskRun](https://tekton.dev/docs/pipelines/taskruns/#configuring-a-taskrun)
* [Pipeline](https://tekton.dev/docs/pipelines/pipelines/#configuring-a-pipeline) 
* [PipelineRun](https://tekton.dev/docs/pipelines/pipelineruns/#configuring-a-pipelinerun)

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