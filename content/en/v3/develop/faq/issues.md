---
title: Troublehshooting
linktitle: Troublehshooting
type: docs
description: Questions on common issues folks hit using the cloud, kubernetes and Jenkins X
weight: 400
---

## Why did my quickstart / import not work?

If you are not able to create quickstarts or import projects its most probably webhooks not being setup correctly.

When the `jx project import` or `jx project quickstart` runs it creates a Pull Request on your dev cluster repository. This should [trigger a webhook](/v3/about/how-it-works/#importing--creating-quickstarts) on your git provider which should then trigger a Pipeline (via [lighthouse webhooks](/v3/about/overview/#lighthouse)). The pipeline should then  [create a second commit on the pull request](/v3/about/how-it-works/#importing--creating-quickstarts) to configure your repository which then should get labelled and auto-merge.

If this does not happen its usually your webhooks are not working. You can check on the health of your system and webhooks via the [Health guide](/v3/admin/setup/health/)

Check out the [webhooks troubleshooting guide](/v3/admin/troubleshooting/webhooks/) 

If you manually merge the Pull Request by hand then you'll miss out the [create a second commit on the pull request](/v3/about/how-it-works/#importing--creating-quickstarts) which means your project won't properly import. To work around that you can do a dummy commit on your dev cluster repository which will trigger a regeneration.

If the `jx project import` or `jx project quickstart` times out before the pipeline triggers the [second commit on the pull request](/v3/about/how-it-works/#importing--creating-quickstarts) and it auto merges and triggers a boot job to setup webhooks for the new repository - you will have pipeline catalog files locally on your laptop which are not pushed to git. e.g. the `.lighthouse/*` files and maybe other files like `charts/*` and `Dockerfile`. You can always try add those files to git locally and push once you have got your webhooks working.

Also make sure that the boot Job that is triggered by the pull request merging has the necessary scopes on the git personal access token to be able to registry the webhooks on the new repository. You will see if the webhook registration has been successful in the boot log:

```bash 
jx admin log 
```


## Why does my pipeline not start?

It could be your [YAML configuration](/v3/develop/reference/pipelines/) is invalid.

Try [linting your YAML configuration](/v3/develop/pipelines/editing/#linting) to verify things are setup correctly.

Also make sure you are in the git repository collaborators group and are in the `OWNERS` file in the main branch.

       
## Why is my pipeline pending?

If your pipeline shows pending in the [CLI](/v3/develop/ui/cli/), [Console](/v3/develop/ui/octant/) or [Dashboard](/v3/develop/ui/dashboard/) there could be various causes such as invalid images, pipeline configuration, missing secrets or insufficient cluster capacity to name but a few.
                                                         
To diagnose why a pipeline pod can't run the simplest thing is to use the [Console](/v3/develop/ui/octant/)

```bash 
jx ui
```

* on the **Pipelines** page pick the pipeline that is having trouble (see the links you can click on the **Build** column)
* on the **Pipeline** page there is then a **Pod** link in the navigation bar which takes you to the **Pod** view in [octant](https://octant.dev/) that lets you view the detail of the pod. From there you should be able to see any events/issues with the pod such as bad images, missing secrets or whatever.
        
To do this via the command line try

```bash
jx get build pod
```

if you know the repository name:


```bash
jx get build pod -r myrepo
```
                          
Then you should be able to see the pod name for the pipeline in question. You can then use `kubectl` to destribe the issue:

```bash
kubectl describe pod the-actual-pod-name-for-your-pipeline```
```

## Why does Jenkins X fail to download plugins?

When I run a `jx` command I get an error like...

``` Get https://github.com/jenkins-x/jx-..../releases/download/v..../jx-.....tar.gz: dial tcp: i/o timeout```

This sounds like a network problem; the code in `jx` is trying to download from `github.com` and your laptop is having trouble resolving the `github.com` domain.

* do you have a firewall / VPN / HTTP proxy blocking things?
* is your `/etc/resolv.conf` causing issues? e.g. if you have multiple entries for your company VPN?

               
