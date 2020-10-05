---
title: Pipeline Catalogs
linktitle: Pipeline Catalogs
description: Pipeline Catalogs for better integration with Tekton
weight: 105
---

As part of the [Tekton Catalog enhancement proposal](https://github.com/jenkins-x/enhancements/issues/37) we've improved support for Tekton in Jenkins X so that you can

  * easily [edit any pipeline in any git repository](/docs/v3/guides/pipeline-catalog/#editing-pipelines) by just modifying the `PipelineRun` files in your `.ligthhouse/jenkins-x` folder
  * [add new pipelines to any git repository](/docs/v3/guides/pipeline-catalog/#add-new-pipelines) to reuse any `PipelineRun` files you find from places like the [tekton catalog](https://github.com/tektoncd/catalog) into your repositories

## Source changes

If you [upgrade your cluster to the latest version stream](docs/v3/guides/upgrade/#cluster) then you will find if you [create a new quickstart](/docs/v3/create-project/#create-a-new-project-from-a-quickstart) that:

* `.lighthouse/jenkins-x` directory contains the default CI/CD pipelines for Jenkins X with these files:
  * `triggers.yaml` to define the [lighthouse](https://github.com/jenkins-x/lighthouse) `presubmits` and `postsubmits` (i.e. Pull Request pipelines and releases).
  * `pullrequest.yaml` defines the Pull Request pipeline using a Tekton `PipelineRun`
  * `release.yaml` defines the Release pipeline using a Tekton `PipelineRun`
  
* `jenkins-x.yml` files are no longer used by default in new quickstarts instead we use the above. Note if you have projects using `jenkins-x.yml` files they are still supported if you [import them into v3](/docs/v3/create-project/#import-an-existing-project) 


## Editing pipelines

You can now easily modify any of the `PipelineRun` resources in any git repository. Just look in the `.lighthouse` folder, for each sub folder edit the YAML files.

e.g. for the default Jenkins X CI/CD pipelines edit either:

* `.lighthouse/jenkins-x`
  * `pullrequest.yaml` to edit the Pull Request pipeline
  * `release.yaml` to edit the Release pipeline 

You can test out changes to the Pull Request pipeline by submitting changes in a Pull Request. Changes to a release only take place after merging the change to the main branch.

## Add new pipelines

You can add new pipelines into a new folder inside `.lighthouse` at any time to reuse any tekton `PipelineRun` files you find from places like the [tekton catalog](https://github.com/tektoncd/catalog) or to add new `PipelineRun` resources you write by hand.

To setup a _trigger_ so that [lighthouse](https://github.com/jenkins-x/lighthouse) will start your pipeline on a `presubmit` (i.e. for Pull Requests) or for `postsubmits` (i.e. releases on main branches) you need to also add a `triggers.yaml` file which uses the lighthouse configuration file format.

You could look a the default `.lighthouse/jenkins-x` directory to see how all this works. The `triggers.yaml` file then refers to the tekton `PipelineRun` files via the `source:` attribute in a `presubmits:` or `postsubmits:` entry.
  
## Changing the triggers

You can modify the `.lighthouse/*/triggers.yaml` file to modify the  `presubmits:` and/or `postsubmits:` entries to do things like:

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
