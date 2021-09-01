---
title: Editing
linktitle: Editing
type: docs
description: Editing pipelines in Jenkins X
weight: 200
---

## Source layout

If you [upgrade your cluster to the latest version stream](/v3/guides/upgrade/#cluster) then you will find if you [create a new quickstart](/v3/develop/create-project/#create-a-new-project-from-a-quickstart) that:

* `.lighthouse/jenkins-x` directory contains the default CI/CD pipelines for Jenkins X with these files:
  * `triggers.yaml` to define the [lighthouse](https://github.com/jenkins-x/lighthouse) [TriggerConfig](https://github.com/jenkins-x/lighthouse/blob/master/docs/trigger/github-com-jenkins-x-lighthouse-pkg-triggerconfig.md#Config) which defines the [ChatOps](/docs/resources/faq/using/chatops/#what-is-chatops) and triggering configuration via a [spec field](https://github.com/jenkins-x/lighthouse/blob/master/docs/trigger/github-com-jenkins-x-lighthouse-pkg-triggerconfig.md#ConfigSpec) which defines [presubmits](https://github.com/jenkins-x/lighthouse/blob/master/docs/trigger/github-com-jenkins-x-lighthouse-pkg-config-job.md#Presubmit) and [postsubmits](https://github.com/jenkins-x/lighthouse/blob/master/docs/trigger/github-com-jenkins-x-lighthouse-pkg-config-job.md#Postsubmit) (i.e. Pull Request and Release triggers).
  * `pullrequest.yaml` defines the Pull Request pipeline using a Tekton [Task](https://tekton.dev/docs/pipelines/tasks/#configuring-a-task), [Pipeline](https://tekton.dev/docs/pipelines/pipelines/#configuring-a-pipeline) or [PipelineRun](https://tekton.dev/docs/pipelines/pipelineruns/#configuring-a-pipelinerun)
  * `release.yaml` defines the Release pipeline using a Tekton Tekton [Task](https://tekton.dev/docs/pipelines/tasks/#configuring-a-task), [Pipeline](https://tekton.dev/docs/pipelines/pipelines/#configuring-a-pipeline) or [PipelineRun](https://tekton.dev/docs/pipelines/pipelineruns/#configuring-a-pipelinerun)
  
* `jenkins-x.yml` files are no longer used by default in new quickstarts instead we use the above. Note if you have projects using `jenkins-x.yml` files they are still supported if you [import them into v3](/v3/develop/create-project/#import-an-existing-project) or you can [use this tool to migrate them to tekton pipelines](https://github.com/jenkins-x-plugins/jx-v2-tekton-converter/blob/main/README.md)

## Editing pipelines

You can now easily modify any of the [Task](https://tekton.dev/docs/pipelines/tasks/#configuring-a-task), [Pipeline](https://tekton.dev/docs/pipelines/pipelines/#configuring-a-pipeline) or [PipelineRun](https://tekton.dev/docs/pipelines/pipelineruns/#configuring-a-pipelinerun) resources in any git repository - just look in each folder inside `.lighthouse` for the YAML files to edit.

e.g. for the default Jenkins X CI/CD pipelines edit either:

* `.lighthouse/jenkins-x`
  * `pullrequest.yaml` to edit the Pull Request [Task](https://tekton.dev/docs/pipelines/tasks/#configuring-a-task), [Pipeline](https://tekton.dev/docs/pipelines/pipelines/#configuring-a-pipeline) or [PipelineRun](https://tekton.dev/docs/pipelines/pipelineruns/#configuring-a-pipelinerun)
  * `release.yaml` to edit the Release [Task](https://tekton.dev/docs/pipelines/tasks/#configuring-a-task), [Pipeline](https://tekton.dev/docs/pipelines/pipelines/#configuring-a-pipeline) or [PipelineRun](https://tekton.dev/docs/pipelines/pipelineruns/#configuring-a-pipelinerun)

You can test out changes to the Pull Request pipeline by submitting changes in a Pull Request. Changes to a release only take place after merging the change to the main branch.

### Overriding steps

The default pipelines use the default [Jenkins X Catalog](/v3/develop/pipelines/catalog/) and so the details of the steps such as the container image and commands used are often inherited.

You can override steps locally by:

* [Overriding a pipeilne step locally](/v3/develop/pipelines/catalog/#overriding-a-pipeline-step-locally) so that you inline the step details into your local YAML file and then edit accordingly.
* [Override a specific step property locally such as the script property](/v3/develop/pipelines/catalog/#overriding-specific-properties-of-a-step-locally) which lets you just inline, say, the `script` commands to modify the commands run

### Tools

* [viewing the effective pipeline](/v3/develop/pipelines/catalog/#viewing-the-effective-pipeline)
* [overriding a pipeline step locally](/v3/develop/pipelines/catalog/#overriding-a-pipeline-step-locally)

### Linting

You can run the [jx pipeline lint](/v3/develop/reference/jx/pipeline/lint) command from a clone of your repository.

```bash
jx pipeline lint
```

which will verify that have not made any typos.

You can also [view the effective pipeline](/v3/develop/pipelines/catalog/#viewing-the-effective-pipeline)

## IDE support
  
If you use [IntelliJ IDEA](https://www.jetbrains.com/idea/) or [Goland](https://www.jetbrains.com/go/) you might find the [RedHat's intellij-tekton plugin](https://plugins.jetbrains.com/plugin/14096-tekton-pipelines-by-red-hat) useful for editing pipelines with schema validation and completion.

If you use [VS Code](https://code.visualstudio.com/) you may want to try [Red Hat's Tekton Pipelines Extension tekton](https://github.com/redhat-developer/vscode-tekton#tekton-pipelines-extension--)

## Add new tasks/pipelines by hand

You can add new pipelines by hand into a new folder inside `.lighthouse` at any time.

To setup a _trigger_ so that [lighthouse](https://github.com/jenkins-x/lighthouse) will start your pipeline on a [presubmits](https://github.com/jenkins-x/lighthouse/blob/master/docs/trigger/github-com-jenkins-x-lighthouse-pkg-config-job.md#Presubmit) (i.e. for Pull Requests) or for [postsubmits](https://github.com/jenkins-x/lighthouse/blob/master/docs/trigger/github-com-jenkins-x-lighthouse-pkg-config-job.md#Postsubmit) (i.e. releases on main branches) you need to also add a `triggers.yaml` file which uses the lighthouse [trigger config file file format](https://github.com/jenkins-x/lighthouse/blob/master/docs/trigger/github-com-jenkins-x-lighthouse-pkg-triggerconfig.md#Config) with [this spec field](https://github.com/jenkins-x/lighthouse/blob/master/docs/trigger/github-com-jenkins-x-lighthouse-pkg-triggerconfig.md#ConfigSpec).

You could look at the default `.lighthouse/jenkins-x` directory to see how all this works. The `triggers.yaml` file then refers to the tekton [Task](https://tekton.dev/docs/pipelines/tasks/#configuring-a-task), [Pipeline](https://tekton.dev/docs/pipelines/pipelines/#configuring-a-pipeline) or [PipelineRun](https://tekton.dev/docs/pipelines/pipelineruns/#configuring-a-pipelinerun) files via the `source:` attribute in a [presubmits](https://github.com/jenkins-x/lighthouse/blob/master/docs/trigger/github-com-jenkins-x-lighthouse-pkg-config-job.md#Presubmit) or [postsubmits](https://github.com/jenkins-x/lighthouse/blob/master/docs/trigger/github-com-jenkins-x-lighthouse-pkg-config-job.md#Postsubmit) entry.
  
## Changing the triggers

You can modify the `.lighthouse/*/triggers.yaml` file to modify the  [presubmits](https://github.com/jenkins-x/lighthouse/blob/master/docs/trigger/github-com-jenkins-x-lighthouse-pkg-config-job.md#Presubmit) and/or [postsubmits](https://github.com/jenkins-x/lighthouse/blob/master/docs/trigger/github-com-jenkins-x-lighthouse-pkg-config-job.md#Postsubmit) entries to do things like:

* customise the `rerun_command` or `trigger` ChatOps comments for `presubmits`
* configure the `branches` patterns for `postsubmit` triggers
* add new entries for new pipelines; or pipelines with different `pipeline_run_params` entries to parameterise existing `PipelineRun` files differently

## Diagnosing problems

If you edit pipelines or lighthouse trigger files and things don't work there's a couple of places the errors may show up.

We will hopefully add much better linting/error messages on Pull Requests soon to give you better and faster feedback.

Until then you could look in:

* the `lighthouse-webhooks-*` pod(s) which take the webhooks from your git provider and convert them into `lighthousejob` resources
* the `lighthouse-tekton-controller-*` pod(s) which watch for `lighthousejob` resources and create the Tekton [PipelineRun](https://tekton.dev/docs/pipelines/pipelineruns/#configuring-a-pipelinerun) resources
* the `tekton-controller-*`  pod(s) watches for Tekton [PipelineRun](https://tekton.dev/docs/pipelines/pipelineruns/#configuring-a-pipelinerun) resources and conver them into Kubernetes `Pod` resources

Any errors will usually be recorded in the `status` field of the resource that has issues (`lighthousejob` or `pipelinerun`).
