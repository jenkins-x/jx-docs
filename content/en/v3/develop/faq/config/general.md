---
title: General
linktitle: General
type: docs
description: General questions on configuration
weight: 100
---

## What is the directory layout?

To understand the directory layout see [this document](https://github.com/jenkins-x/jx-gitops/blob/master/docs/git_layout.md) and the [file reference](/v3/develop/reference/files/)
       

## How do I add an Environment

With v3 everything is done via GitOps - so if in doubt the answer is to modify git. 

You can create new environments by adding to the `environments:` section of [jx-requirements.yml](https://github.com/jx3-gitops-repositories/jx3-kubernetes/blob/master/jx-requirements.yml#L18)
 
## How do I change promotion for my app?

Usually when you [import a repository or create a quickstart](/v3/develop/create-project/) they inherit the default environments for [promotion](/v3/develop/environments/promotion/). It is common to share the same environments across all of your microservices.

If you want to change that on a per repository/microservice basis you can [configure custom environments for a repository](/v3/develop/environments/config/#custom-environments-per-repository)

## How do I specify DOCKER_REGISTRY_ORG?

If you need to you can override in a specific repository (via a `.jx/settings.yaml` in your repository) but usually its common to all repos and is inherited from your `jx-requirements.yml` in your development environment repository

See the [file reference](/v3/develop/reference/files/)

## If I add a file to `config-root` it gets deleted, why?

The `config-root` directory is regenerated on every boot job - basically every time you promote an application or merge a change into the main branch of your git dev cluster git repository.  For background see the [dev git repository layout docs](https://github.com/jenkins-x/jx-gitops/blob/master/docs/git_layout.md))

To add a new chart add to the `helmfiles/mynamespace/helmfile.yaml` file follow the [add chart guide](/v3/develop/apps/#adding-charts).

To add a new kubernetes resource [follow the add resources guide](/v3/develop/apps/#adding-resources).

## How do I add a user to my Jenkins X installation?
          
There are a number of different levels of access you may wish to grant:

### git

When developers are [developing software that has its CI/CD automated by Jenkins X](/v3/develop/developing/) then usually letting the developer access git is enough.

### dashboard

Though being able to see the logs of pipelines is useful so you probably want to either share the basic auth user/password for the [Dashboard](/v3/develop/ui/dashboard/) or to configure full Auth0/OAuth single sign on access to the [Dashboard](/v3/develop/ui/dashboard/). Then developers will be able to browse the [Dashboard](/v3/develop/ui/dashboard/) or click on Pull Request and Release links on your git website. 

### kubernetes 

If you want to give full access to Jenkins X so that developers can access kubernetes resources via `kubectl`, can use the [jx cli](/v3/develop/reference/jx/) or can use the [Octant console](/v3/develop/ui/octant/) then you need to grant Cloud IAM roles to the developer using your cloud infrastructure.

If the developer does not have access to the kubernetes cluster we need to setup their `~/.kube/config` file so that they can access it.

If you are using Google's GKE then you can browse the [GKE Console](https://console.cloud.google.com) to view all the clusters and click on the `Connect` button next to your development cluster and then that lets you copy/paste the command to connect to the cluster.

For other types of clusters please review the Kubernetes documentation for how to grant access to your cluster via your cloud providers CLI / web console.


#### testing kubernetes access

Once your user has access to the kubernetes cluster:

* [install the jx binary](/v3/admin/setup/jx3/)

If Jenkins X was installed in the namespace `jx` then the following should [switch your context](/docs/resources/guides/using-jx/developing/kube-context/) to the `jx` namespace:

```bash 
jx ns jx
```

To view the environments try:

```bash 
kubectl get environments
```
      
To view the SourceRepositories:

```bash 
kubectl get sr
```

To use the [jx cli](/v3/develop/ui/cli/) try:

```bash 
jx pipeline grid
```

(and hit Ctrl-c or `q` to quit)