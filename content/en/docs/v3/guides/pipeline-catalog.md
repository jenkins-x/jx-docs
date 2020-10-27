---
title: Pipeline Catalogs
linktitle: Pipeline Catalogs
description: Pipeline Catalogs for better integration with Tekton
weight: 105
---

As part of the [Tekton Catalog enhancement proposal](https://github.com/jenkins-x/enhancements/issues/37) we've improved support for Tekton in Jenkins X so that you can

  * easily [edit any pipeline in any git repository](/docs/v3/guides/pipeline-catalog/#editing-pipelines) by just modifying the [Task](https://tekton.dev/docs/pipelines/tasks/#configuring-a-task), [Pipeline](https://tekton.dev/docs/pipelines/pipelines/#configuring-a-pipeline) or [PipelineRun](https://tekton.dev/docs/pipelines/pipelineruns/#configuring-a-pipelinerun) files in your `.ligthhouse/jenkins-x` folder
  * [add new pipelines to any git repository](#add-new-taskspipelines-by-hand) to reuse any [Task](https://tekton.dev/docs/pipelines/tasks/#configuring-a-task) files you find from places like the [tekton catalog](https://github.com/tektoncd/catalog) in your repositories

## Source changes

If you [upgrade your cluster to the latest version stream](/docs/v3/guides/upgrade/#cluster) then you will find if you [create a new quickstart](/docs/v3/create-project/#create-a-new-project-from-a-quickstart) that:

* `.lighthouse/jenkins-x` directory contains the default CI/CD pipelines for Jenkins X with these files:
  * `triggers.yaml` to define the [lighthouse](https://github.com/jenkins-x/lighthouse) [TriggerConfig](https://github.com/jenkins-x/lighthouse/blob/master/docs/trigger/github-com-jenkins-x-lighthouse-pkg-triggerconfig.md#Config) which has a [spec field](https://github.com/jenkins-x/lighthouse/blob/master/docs/trigger/github-com-jenkins-x-lighthouse-pkg-triggerconfig.md#ConfigSpec) which defines [presubmits](https://github.com/jenkins-x/lighthouse/blob/master/docs/trigger/github-com-jenkins-x-lighthouse-pkg-config-job.md#Presubmit) and [postsubmits](https://github.com/jenkins-x/lighthouse/blob/master/docs/trigger/github-com-jenkins-x-lighthouse-pkg-config-job.md#Postsubmit) (i.e. Pull Request pipelines and releases).
  * `pullrequest.yaml` defines the Pull Request pipeline using a Tekton [Task](https://tekton.dev/docs/pipelines/tasks/#configuring-a-task), [Pipeline](https://tekton.dev/docs/pipelines/pipelines/#configuring-a-pipeline) or [PipelineRun](https://tekton.dev/docs/pipelines/pipelineruns/#configuring-a-pipelinerun)
  * `release.yaml` defines the Release pipeline using a Tekton Tekton [Task](https://tekton.dev/docs/pipelines/tasks/#configuring-a-task), [Pipeline](https://tekton.dev/docs/pipelines/pipelines/#configuring-a-pipeline) or [PipelineRun](https://tekton.dev/docs/pipelines/pipelineruns/#configuring-a-pipelinerun)
  
* `jenkins-x.yml` files are no longer used by default in new quickstarts instead we use the above. Note if you have projects using `jenkins-x.yml` files they are still supported if you [import them into v3](/docs/v3/create-project/#import-an-existing-project) or you can [use this tool to migrate them to tekton pipelines](https://github.com/jenkins-x-plugins/jx-v2-tekton-converter/blob/main/README.md)


## Editing pipelines

You can now easily modify any of the [Task](https://tekton.dev/docs/pipelines/tasks/#configuring-a-task), [Pipeline](https://tekton.dev/docs/pipelines/pipelines/#configuring-a-pipeline) or [PipelineRun](https://tekton.dev/docs/pipelines/pipelineruns/#configuring-a-pipelinerun) resources in any git repository - just look in each folder inside `.lighthouse` for the YAML files to edit.

e.g. for the default Jenkins X CI/CD pipelines edit either:

* `.lighthouse/jenkins-x`
  * `pullrequest.yaml` to edit the Pull Request [Task](https://tekton.dev/docs/pipelines/tasks/#configuring-a-task), [Pipeline](https://tekton.dev/docs/pipelines/pipelines/#configuring-a-pipeline) or [PipelineRun](https://tekton.dev/docs/pipelines/pipelineruns/#configuring-a-pipelinerun)
  * `release.yaml` to edit the Release [Task](https://tekton.dev/docs/pipelines/tasks/#configuring-a-task), [Pipeline](https://tekton.dev/docs/pipelines/pipelines/#configuring-a-pipeline) or [PipelineRun](https://tekton.dev/docs/pipelines/pipelineruns/#configuring-a-pipelinerun) 

You can test out changes to the Pull Request pipeline by submitting changes in a Pull Request. Changes to a release only take place after merging the change to the main branch.

## IDE support
  
If you use [IntelliJ IDEA](https://www.jetbrains.com/idea/) or [Goland](https://www.jetbrains.com/go/) you might find the [RedHat's intellij-tekton plugin](https://plugins.jetbrains.com/plugin/14096-tekton-pipelines-by-red-hat) useful for editing pipelines.

Though until [this issue is fixed](https://github.com/redhat-developer/intellij-tekton/issues/263) you can't use it at the same time as the excellent [intellij-kubernetes plugin](https://plugins.jetbrains.com/plugin/10485-kubernetes) 

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

