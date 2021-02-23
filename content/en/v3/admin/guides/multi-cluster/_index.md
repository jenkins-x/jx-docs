---
title: Multi-Cluster
linktitle: Multi-Cluster
type: docs
description: How to use multiple clusters with helm 3 and helmfile
weight: 100
aliases:
  - /v3/guides/multi-cluster
---


We recommend using separate clusters for your `Preprod` and `Production` environments. This lets you completely isolate your environments which improves security.

## Setting up multi cluster

1. Follow the [administration documentation](/v3/admin/platform/) to setup a new Development Cluster (or skip this step if already in place). 

2. Follow the mentioned approach at the previous point in order to setup new and additional clusters for the desired remote environments:
    * For remote environments (e.g. `Preprod` and `Production`) you typically won't need lots of the development tools such as:
      * Lighthouse
      * Tekton
      * Webhooks
      * Nexus / Bucketrepo
    * And install only services to run and expose your applications, e.g.:
      * Nginx-ingress
      * Cert-manager
      * [kubernetes external secrets](https://github.com/external-secrets/kubernetes-external-secrets) for [populating Secrets from your secret store](/v3/admin/guides/secrets/) (vault or cloud provider secret manager)
      * [push-wave](https://github.com/jenkins-x-charts/pusher-wave#wave) for automatically performing rolling upgrades when secrets are rotated in your secret store

3. Then when you have a git repository URL for your `Preprod` or `Production` cluster, [import the git repository](/v3/develop/create-project/#import-an-existing-project) like you would any other git repository into your Development cluster using the [jx project import](https://github.com/jenkins-x/jx-project/blob/master/docs/cmd/project_import.md) command (command should be run in the `jx` namespace):
    
    ```bash 
    jx project import --url https://github.com/myowner/my-prod-repo.git
    ```
    
    This will create a Pull Request on your development cluster git repository to link to the `Preprod` or `Production` git repository on promotions of apps.
     
    **NOTE**: Jenkins X will [push additional configuration files](/v3/about/how-it-works/#importing--creating-quickstarts) to the created Pull Request, so it is recommended to wait until the Pull Request is auto-merged and avoid manual intervention.

### Changes to `jx-requirements.yml`

The above [jx project import](https://github.com/jenkins-x/jx-project/blob/master/docs/cmd/project_import.md) should modify your `jx-requirements.yml` file in your development cluster to reference the remote production/pre-production cluster.

So your `jx-requirements.yml` should have started something like:

```yaml 
environments:
- key: dev
  repository: my-dev-environment
- key: staging                                                   
```                                                              

after importing the remote environment via [jx project import](https://github.com/jenkins-x/jx-project/blob/master/docs/cmd/project_import.md) and the pull request merging it should look like: 

```yaml 
environments:
- key: dev
  repository: my-dev-environment
- key: staging
- key: my-prod-repo
  owner: myowner
  repository: my-prod-repo
  remoteCluster: true
``` 


Once everything is correctly setup, it will be possible to deploy applications to the newly created remote environment/s. 




## How it works

The multi cluster setup of Jenkins X is designed around the following goals:

* you have full control over production and pre-production clusters, choosing exactly what software is installed there
  * there are no development tools installed: no tekton, lighthouse, container registries and no images are built in production
* immutable infrastructure configured via GitOps with maximum traceability and feedback
  * easy to review changes on production via git and not requiring access to production
  
  
### Development Cluster

The development cluster:

* runs all pipelines on your applications to handle pull requests and performs releases
  * releases of applications create pull requests on remote cluster repositories
* handles all webhooks for pull requests on remove environments and runs pipelines to validate changes to remote environments
  * reports back to GitHub the status of pull request pipelines 
  * visualises the pipelines in the [usual Jenkins X UIs](/v3/develop/ui/)
  * supports auto-merge via ChatOps when approved

### Remote Cluster

* runs the [git operator](/v3/admin/guides/operator/) which polls the main branch in the remote cluster for changes
* when a change is found a `Job` is run to perform the `kubectl apply` or `helmfile sync` or whatever 


## Remote Cluster Recommendations

We do recommend using the Jenkins X GitOps pipeline approach in [production and preproduction for these reasons](/v3/develop/faq/#why-does-jenkins-x-use-helmfile-template) then all changes to git result in the [kubernetes resources being checked into git](/v3/about/how-it-works/#boot-job) so they can be easily reviewed without reviewers needing access to production.

You may want to reuse existing built in charts such as:

* [kubernetes external secrets](https://github.com/external-secrets/kubernetes-external-secrets) for [populating Secrets from your secret store](/v3/admin/guides/secrets/) (vault or cloud provider secret manager)
* [push-wave](https://github.com/jenkins-x-charts/pusher-wave#wave) for automatically performing rolling upgrades when secrets are rotated in your secret store


### using `helmfile sync`

If you want to just use something like `helmfile sync` to deploy charts in production you could use the following `Makefile` in your production/pre-production repository:

```make 
apply:
    helmfile sync
    
pr:
    helmfile lint
```

though you will lose [these benefits](/v3/develop/faq/#why-does-jenkins-x-use-helmfile-template). You will also need to:

* add your own [pusher-wave integration](https://github.com/jenkins-x-charts/pusher-wave#quick-start) for each chart you want to perform a rolling upgrade if the underlying secrets are rotated.
* manually populate all secrets in each remote environments via the underlying secret store as you will not be using the [jx-secret](https://github.com/jenkins-x/jx-secret) mechanism built into the default Jenkins X GitOps pipelines for doing this. 
