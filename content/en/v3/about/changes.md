---
title: Changes
linktitle: Changes
type: docs
description: The change log for Jenkins X 3.x
weight: 55
aliases: 
    - /v3/about/changes/
---

You may also find the [Roadmap](/community/roadmap/) and [Maturity Matrix](/v3/about/maturity-matrix/) documents useful:

       
## Changes 
            
* the new tekton version (0.20.x) now requires kubernetes 1.17 or later. If your cluster is older and you are using the cloud just ugprade your kubernetes version before upgrading your cluster. Otherwise you may want to explicitly override your `tekton-pipeline` version to pin it at `0.19.1` instead in your [helmfiles/tekton-pipelines/helmfile.yaml](https://github.com/jx3-gitops-repositories/jx3-kubernetes/blob/master/helmfiles/tekton-pipelines/helmfile.yaml#L12) file               
* you can now use [jx pipeline convert](https://github.com/jenkins-x/jx-pipeline/blob/master/docs/cmd/jx-pipeline_convert.md#jx-pipeline-convert) to [convert any old pipelines](/v3/develop/pipelines/upgrading/#converting-older-pipelines) across to the latest [concise syntax](/v3/develop/pipelines/catalog/)
* we have an awesome [new syntax to help share pipelines across git repositories](/v3/develop/pipelines/catalog/) that makes it easier to simplify the pipelines in each repository while keeping things vanilla Tekton YAML and letting you override and customise anything anywhere 
* the boot job now upgrades the `docs` folder to show what charts and versions are deployed in each namespace. You can view the `docs` folder in your own git repositories once you've [upgraded your cluster](/v3/admin/guides/upgrades/cluster/)
  * you can see the default reports for [kubernetes](https://github.com/jx3-gitops-repositories/jx3-kubernetes/tree/master/docs ), [aws](https://github.com/jx3-gitops-repositories/jx3-eks-vault/tree/master/docs), [azure](https://github.com/jx3-gitops-repositories/jx3-azure-akv) and [gke](https://github.com/jx3-gitops-repositories/jx3-gke-gsm/tree/master/docs )
* We now use multiple helmfiles per namespace so its easier to understand the organisation of your charts across namespaces
* The [3.0 beta is almost ready](/blog/2020/12/04/jx-v3-update/) so if you have been using the 3.0 alpha we now have a [migration guide](/v3/admin/guides/migrate/v3-alpha/) to smooth your transition to the beta

* You can now easily open the [Octant Console](/v3/develop/ui/octant/) or [Pipeline Dashboard](/v3/develop/ui/dashboard/) via 2 easy commands:

```bash 
jx ui
jx dash
```    

* We now have [Tekton Catalog integration](/v3/develop/pipelines/) so that you can:
  * easily [edit any pipeline in any git repository](/v3/develop/pipelines/#editing-pipelines) by just modifying the `PipelineRun` files in your `.ligthhouse/jenkins-x` folder
  * [reuse Tasks from the Tekton catalog](/v3/develop/pipelines/#adding-tasks-from-the-tekton-catalog) and optionally modify them locally in your repository
  * [add new pipelines to any git repository](/v3/develop/pipelines/#add-new-taskspipelines-by-hand) to reuse any `PipelineRun` files you find from places like the [tekton catalog](https://github.com/tektoncd/catalog) into your repositories

* We have migrated most of the [Jenkins X Plugins](https://github.com/jenkins-x/jx-cli#plugins) over to the new client-go 1.19.x version now which is a fairly major change due to the API changes in client-go. So we've moved many of the [libraries](https://github.com/jenkins-x/jx-cli#libraries) over to use `v3` instead such as using libraries like [jx-api](https://github.com/jenkins-x/jx-api) or [jx-helpers](https://github.com/jenkins-x/jx-helpers)
  * if you were planning on submitting a Pull Request on any plugin please make sure you rebase before submitting a Pull Request. Also upgrade to go `1.15.2` ASAP 
  
* New [Maturity Matrix](/v3/about/maturity-matrix/) published! You can now view at a glance the different capabilities across clouds and infrastructure. Many thanks [Nitin](https://github.com/borntorock) for all your hard work

* Preview environments how use [helmfile](https://github.com/roboll/helmfile) as a declarative way to describe all of the dependencies you need in your preview environment. 

  * This is all handled by the new [jx-preview](https://github.com/jenkins-x/jx-preview) plugin
  * This also opens up the possibility of using multiple namespaces per preview; or using canary releases on multiple previews into a shared environment.
  
* The new Jenkins X version 3 CLI [jx-cli](https://github.com/jenkins-x/jx-cli) is now plugins all the way down; so that all of the features are implemented by [separate binary plugins](https://github.com/jenkins-x/jx-cli#plugins) making the CLI more modular and easier to work on.