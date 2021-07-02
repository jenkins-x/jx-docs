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

       
## Breaking Changes
        
* we have [noticed a regression](https://github.com/jenkins-x/jx/issues/7870) in the [auto upgrade jobs](/v3/admin/setup/upgrades/cluster/#automatic-upgrades) which causes them to fail with an error like this:
```bash 
updatebot WARNING: no $GIT_SECRET_MOUNT_PATH environment variable set                      
updatebot error: failed to setup git: failed to clone the cluster git URL: failed to clone cluster git repository https://github.com/myorg/myrepo.git: failed to clone cluster git repo https://github.com/
updatebot fatal: could not read Username for 'https://github.com': No such device or address
```

* you can fix this by following the [workarounds on this issue](https://github.com/jenkins-x/jx/issues/7870) which should get you past this and working [auto upgrade jobs](/v3/admin/setup/upgrades/cluster/#automatic-upgrades) again
  

* we now default to using `Ingress` `v1` which was introduced in kubernetes 1.19. The `v1beta1` version of `Ingress` has been deprecated since 1.14 and is removed in 1.22. If you are on 1.18 of kubernetes you could upgrade to 1.19 or later. Otherwise you can [configure your cluster to keep on v1beta1 if you want](/v3/develop/faq/config/ingress/#how-do-i-configure-to-use-v1beta1-ingress) until you can move forwards to 1.19 or later.
* the new tekton version (0.20.x) now requires kubernetes 1.17 or later. If your cluster is older and you are using the cloud just upgrade your kubernetes version before upgrading your cluster. Otherwise you may want to explicitly override your `tekton-pipeline` version to pin it at `0.19.1` instead in your [helmfiles/tekton-pipelines/helmfile.yaml](https://github.com/jx3-gitops-repositories/jx3-kubernetes/blob/master/helmfiles/tekton-pipelines/helmfile.yaml#L12) file
* if you are upgrading from an alpha cluster you may have vault installed in the `secret-infra` namespace. check out the [FAQ on vault in the wrong namespace](/v3/develop/faq/config/vault/#after-an-upgrade-the-boot-job-is-waiting-for-vault-in-jx-vault) for how to upgrade.

## Changes 
        
* we have a new [jx pipeline grid](/v3/develop/reference/jx/pipeline/grid/) command to easily view whats happening in your cluster on the CLI in a similar way to the [Octant Console](/v3/develop/ui/octant/) or [Dashboard](/v3/develop/ui/dashboard/)
* The [reference guide](/v3/develop/reference/) now has a full [Command Line Reference](/v3/develop/reference/jx/) for browsing the command line of the various [Jenkins X Plugins](https://github.com/jenkins-x-plugins)
* There is now support for [automatic upgrades](/v3/admin/setup/upgrades/cluster/#automatic-upgrades) where a Pull Request is automatically generated on your development cluster repository to upgrade the versions of charts in your installation. You can define the upgrade schedule and whether or not the Pull Request is auto merged or requires a manual approval/merge.
* A preview can fail to create for a multitude of reasons; bad helm charts, missing secrets/volumes, invalid configuration in `jx-requirements.yml`, bad image names, no capacity on the server to name but a few. Unfortunately `helmfile sync` does not give much information other than it succeeded of failed. 
  * to improve feedback on why some previews can fail we have added additional output in the [jx preview create](/v3/develop/reference/jx/preview/create) command to tail the kubernetes events in the preview namespace. This basically runs `kubectl exec get event -n $PREVIEW_NAMESPACE -w` and adds the output to the pipeline output (prefixed with `$PREVIEW_NAMESPACE:`      
  * this means the reason for why a preview fails should appear as a kubernetes event in the pipeline log
* we have a shiny new [Slack bot for Jenkins X](/v3/develop/ui/slack/) to help notify developers of failing pipelines
* its now much easier to [write system tests against Preview Environments](https://github.com/jenkins-x/jx-preview#system-tests-in-previews) so it's easier to test images and charts function as you expect inside a Pull Request before you are happy to merge the work for faster feedback
* check out the new [DevOps, GitOps and Cloud Native](https://jenkins-x.io/v3/devops/) documentation we're putting together based on the learnings of continuously deliverying Jenkins X with Jenkins X.
* new clusters created using Terraform that use Vault will be using the `jx-vault` namespace to setup Vault (so that its managed by Terraform)       
* you can now use [jx pipeline convert](/v3/develop/reference/jx/pipeline/convert) to [convert any old pipelines](/v3/develop/pipelines/upgrading/#converting-older-pipelines) across to the latest [concise syntax](/v3/develop/pipelines/catalog/)
* we have an awesome [new syntax to help share pipelines across git repositories](/v3/develop/pipelines/catalog/) that makes it easier to simplify the pipelines in each repository while keeping things vanilla Tekton YAML and letting you override and customise anything anywhere 
* the boot job now upgrades the `docs` folder to show what charts and versions are deployed in each namespace. You can view the `docs` folder in your own git repositories once you've [upgraded your cluster](/v3/admin/setup/upgrades/cluster/)
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

* We have migrated most of the [Jenkins X Plugins](https://github.com/jenkins-x/jx#plugins) over to the new client-go 1.19.x version now which is a fairly major change due to the API changes in client-go. So we've moved many of the [libraries](https://github.com/jenkins-x/jx#libraries) over to use `v3` instead such as using libraries like [jx-api](https://github.com/jenkins-x/jx-api) or [jx-helpers](https://github.com/jenkins-x/jx-helpers)
  * if you were planning on submitting a Pull Request on any plugin please make sure you rebase before submitting a Pull Request. Also upgrade to go `1.15.2` ASAP 
  
* New [Maturity Matrix](/v3/about/maturity-matrix/) published! You can now view at a glance the different capabilities across clouds and infrastructure. Many thanks [Nitin](https://github.com/borntorock) for all your hard work

* Preview environments how use [helmfile](https://github.com/roboll/helmfile) as a declarative way to describe all of the dependencies you need in your preview environment. 

  * This is all handled by the new [jx-preview](https://github.com/jenkins-x/jx-preview) plugin
  * This also opens up the possibility of using multiple namespaces per preview; or using canary releases on multiple previews into a shared environment.
  
* The new Jenkins X version 3 CLI [jx](https://github.com/jenkins-x/jx) is now plugins all the way down; so that all of the features are implemented by [separate binary plugins](https://github.com/jenkins-x/jx#plugins) making the CLI more modular and easier to work on.
