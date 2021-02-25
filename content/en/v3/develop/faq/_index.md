---
title: FAQ
linktitle: FAQ
type: docs
description: Questions on using Jenkins X 3.x and helm 3
weight: 500
aliases:
  - /faq/
  - /v3/guides/faq/
  - /v3/develop/faq/
---


## Where do I raise issues?

One of the challenges with Jenkins X 3.x is the [source code is spread across a number of organisations and repositories](/v3/about/overview/source/) since its highly decoupled into many [plugins and microservices](/v3/about/overview/) so it can be confusing 

If you know the specific plugin causing an issue, say [jx-preview](https://github.com/jenkins-x/jx-preview) then just raise the issue there in the issue tracker.

Otherwise use the [issue tracker for Jenkins X 3.x](https://github.com/jenkins-x/issues) and we can triage as required.


## How do I list the apps that have been deployed?

You can see the helm charts that are installed along with their version, namespaces and any configuration values by looking at the `releases` section of your `helmfile.yaml` file in your cluster git repository.

You can browse all the kubernetes resources in each namespace using the canonical layout in the `config-root` folder. e.g. all charts are versioned in git as follows:
 
```bash 
config-root/
  namespaces/
    jx/
      lighthouse/
        lighthouse-webhooks-deploy.yaml    
```

You can see the above kubernetes resource, a `Deployment` with name `lighthouse-webhooks` in the namespace `jx` which comes from the `lighthouse` chart.

There could be some additional charts installed via Terraform for the [git operator](/v3/guides/operator/) and [health subsystem](/v3/guides/health/) which can be viewed via:
  
```bash 
helm list --all-namespaces
```                                                                                


## Why does Jenkins X use `helmfile template`?

If you look into the **versionStream/src/Makefile.mk** file in your cluster git repository to see how the boot proccess works you may notice its defined a simple makefile and uses the [jx gitops helmfile template](https://github.com/jenkins-x/jx-gitops/blob/master/docs/cmd/jx-gitops_helmfile_template.md) command to convert the [helmfile](https://github.com/roboll/helmfile) `helmfile.yaml` files referencing helm charts into YAML.

So why don't we use `helmfile sync` instead to apply the kubernetes resources from the charts directly into kubernetes?

The current approach has a [number of benefits](/v3/about/benefits/):

* we want to version all kubernetes resources (apart from `Secrets`) in git so that you can use git tooling to view the history of every kubernetes resource over time. 


  * by checking in all the kubernetes resources (apart from `Secrets`) its very easy to trace (and `git blame`) any change in any kubernetes resource in any chart and namespace to diagnose issues.
  * the upgrade of any tool such as [helm](https://helm.sh/), [helmfile](https://github.com/roboll/helmfile), [kustomize](https://kustomize.io/), [kpt](https://googlecontainertools.github.io/kpt/), [kubectl](https://kubernetes.io/docs/reference/kubectl/kubectl/) or [jx](/v3/guides/jx3/) could result in different YAML being generated changing the behaivour of your applications in Production.


* this approach makes it super easy to review all Pull Requests on all promotions and configuration changes and review what is actually going to change in kubernetes inside the git commit diff.

  * e.g. promoting from `1.2.3` to `1.3.0` of application `cheese` may look innocent enough, but did you notice those new `ClusterRole` and `PersistentVolume` resources that it now brings in?
  
* we can default to using [canonical secret management mechanism](/v3/guides/secrets/) based on [kubernetes external secrets](https://github.com/external-secrets/kubernetes-external-secrets) (see [how it works](/v3/about/how-it-works/#generate-step)) to ensure that:
 
  * no Secret value accidentally gets checked into git by mistake
  * all secrets can be managed, versioned, stored and rotated using vault or your cloud providers native secret storage mechanism
  * the combination of git and your secret store means your cluster becomes ephemeral and can be recreated if required (which often can happen if using tools like Terraform to manage infrastructure and you change significant infrastructure configuration values like node pools, version, location and so forth) 

* its easier for developers to understand what is going on as you can browse all the kubernetes resources in each namespace using the canonical layout in the `config-root` folder. e.g. all charts are versioned in git as follows:
                    
```bash 
config-root/
 namespaces/
   jx/
     lighthouse/
       lighthouse-webhooks-deploy.yaml    
```

   * you can see the above kubernetes resource, a `Deployment` with name `lighthouse-webhooks` in the namespace `jx` which comes from the `lighthouse` chart. 

* its easy to enrich the generated YAML with a combination of any additional tools [kustomize](https://kustomize.io/), [kpt](https://googlecontainertools.github.io/kpt/) or [jx](/v3/guides/jx3/). e.g.

  * its trivial to run [kustomize](https://kustomize.io/) or [kpt](https://googlecontainertools.github.io/kpt/) to modify any resource in any chart before it's applied to Production and to review the generated values first 

  * its easy to use [jx gitops hash](https://github.com/jenkins-x/jx-gitops/blob/master/docs/cmd/jx-gitops_hash.md) to add some hash annotations to cause rolling upgrade to `Deployments` when git changes (when the `Deployment` YAML does not)

  * use [jx gitops annotate](https://github.com/jenkins-x/jx-gitops/blob/master/docs/cmd/jx-gitops_annotate.md) to add add support for tools like [pusher wave](https://github.com/pusher/wave) so that rotating secrets in your underlying secret store can cause rolling upgrades in your `Deployments`

However since the steps to deploy a kubernetes cluster in Jenkins X is defined in a simple makefile stored in your cluster git repository its easy for developers to modify their cluster git repository to add any combination of tools to the makefile to use any permutation of  [helm 3](https://helm.sh/), [helmfile](https://github.com/roboll/helmfile), [kustomize](https://kustomize.io/), [kpt](https://googlecontainertools.github.io/kpt/)  and [kubectl](https://kubernetes.io/docs/reference/kubectl/kubectl/)

So if you really wanted to opt out of the canonical GitOps, resource and secret management model above you can add a `helm upgrade` or `helmfile sync` command to your makefile. The entire boot job is defined in git in **versionStream/git-operator/job.yaml** so you are free to go in whatever direction you prefer. 


## What is the directory layout?

To understand the directory layout see [this document](https://github.com/jenkins-x/jx-gitops/blob/master/docs/git_layout.md)
       

## Does Jenkins X support helmfile hooks?

Helmfile hooks allow programs to be executed during the lifecycle of the application of your helmfiles.

Since we default to using [helmfile template](/v3/develop/faq/#why-does-jenkins-x-use-helmfile-template) helmfile hooks are not supported for cluster git repositories (though you can use them in preview environments).

However its easy to add steps into the **versionStream/src/Makefile.mk** to simulate helmfile hooks.

           

## If I add a file to `config-root` it gets deleted, why?

The `config-root` directory is regenerated on every boot job - basically every time you promote an application or merge a change into the main branch of your git dev cluster git repository.  For background see the [dev git repository layout docs](https://github.com/jenkins-x/jx-gitops/blob/master/docs/git_layout.md))

To add a new chart add to the `helmfiles/mynamespace/helmfile.yaml` file follow the [add chart guide](/v3/develop/apps/#adding-charts).

To add a new kubernetes resource [follow the add resources guide](/v3/develop/apps/#adding-resources).
      
## How do I use testcontainers?

If you want to use a container, such as a database, inside your pipeline so that you can run tests against your database inside your pipeline then use a [sidecar container in Tekton](https://tekton.dev/vault/pipelines-v0.16.3/tasks/#specifying-sidecars).

Here is [another example of a sidecar in a pipeline](https://tekton.dev/vault/pipelines-v0.16.3/tasks/#using-a-sidecar-in-a-task)

If you want to use a separate container inside a preview environment then add [charts or resources](/v3/develop/apps/#adding-charts) to the `preview/helmfile.yaml`



## How do I uninstall Jenkins X?

We don't yet have a nice uninstall command. 

Though if you git clone your development git repository and cd into it you can run:

```bash 
kubectl delete -R -f config-root/namespaces
kubectl delete -R -f config-root/cluster
```


