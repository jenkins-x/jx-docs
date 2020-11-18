---
title: Extending
linktitle: Extending
type: docs
description: How to extend Jenkins X 3.x 
weight: 500
aliases: 
    - /docs/v3/about/extending/
---

Jenkins X has a number of extension points you can use to extend the CI/CD platform to suit your needs:

## Charts

[Helm](https://helm.sh/) [charts](https://helm.sh/docs/topics/charts/) are the standard way to package applications for kubernetes.

It's easy to use GitOps to [add charts](/docs/v3/develop/apps/#adding-charts) to any of your clusters and [customize them](/docs/v3/develop/apps/#customising-charts) however you need.


You can also easily [add one or more kubernetes resources to a cluster via a source layout chart](/docs/v3/develop/apps/#adding-resources)
    

## Plugins

The `jx` command line in version 3 is build on [plugins](https://github.com/jenkins-x/jx-cli#plugins).

It turns out anyone can create a new plugin to wrap up some functionality that is either ran on a developer laptop or is used via a container image inside a pipeline step.

Plugins usually written in [Go](https://golang.org/) as it has awesome Kubernetes support and generates easy to use statically compiled binaries - though you are free to create plugins in any programming language.

If you wish to create a new plugin try browse the [jenkins-x-plugins organisation](https://github.com/jenkins-x-plugins) for inspiration or check out the [standard plugins used in the jx-cli](https://github.com/jenkins-x/jx-cli#plugins)

## Triggers

With version 3.x we default to using [Pipeline Catalogs](/docs/v3/develop/pipeline-catalog/) containing Tekton resources to define CI/CD pipelines.

e.g. the default CI/CD pipelines from the [default Jenkins X Pipeline Catalog](https://github.com/jenkins-x/jx3-pipeline-catalog/tree/master/packs) define tekton pipelines in the `.lighthouse/jenkins-x` folder.

Inside each repository there is now a trigger file called `triggers.yaml` defined at`.lighthouse/jenkins-x/triggers.yaml` to define the [lighthouse](https://github.com/jenkins-x/lighthouse) `presubmits` and `postsubmits` (i.e. Pull Request pipelines and release pipelines).

You can add any number of folders with the `.lighthouse` folder to add any number of `presubmits` and `postsubmits` (i.e. Pull Request pipelines and releases).

If you define a pipeline you want to share with other repositories you can then use [kpt pkg get](https://googlecontainertools.github.io/kpt/reference/pkg/get/) to copy the folder into other repositories. Later on you can then use [kpt pkg update](https://googlecontainertools.github.io/kpt/reference/pkg/update/) to replicate upstream changes to other repositories. Or use the [jx gitops upgrade](/docs/v3/guides/upgrade/#cluster) command which uses `kpt pkg update` under the covers.

## Pipeline Catalog

The `pipeline catalog` contains default triggers, tekton pipelines and associated files (e.g. `Dockerfile` and helm charts) for different languages and runtimes.

The pipeline catalog is used to default the triggers, pipelines and other files for [new projects](/docs/v3/develop/create-project/) when you import or create new quickstarts.

You can browse the [default Jenkins X Pipeline Catalog here](https://github.com/jenkins-x/jx3-pipeline-catalog/tree/master/packs).

If you want you can fork the [jenkins-x/jx3-pipeline-catalog](https://github.com/jenkins-x/jx3-pipeline-catalog) repository and make your modifications to add/remove folders for different languages or modify the pipelines and associated files.

We'd prefer if any improvements or enhancements could be submitted back to the project via a Pull Request then we all get to share your improvements; but its totally fine to have some local modifications for your specific business requirements. 

To use your custom fork modify the `jx-requirements.yml` file in your cluster git repository to link to your fork instead of the  [jenkins-x/jx3-pipeline-catalog](https://github.com/jenkins-x/jx3-pipeline-catalog) repository:

```yaml 
...
buildPacks:
  buildPackLibrary:
    gitRef: master
    gitURL: https://github.com/myorg/jx3-pipeline-catalog.git
```  


## QuickStarts

Quickstarts are sample projects which are used `jx project quickstart` when you [create new projects](/docs/v3/develop/create-project/)

The default quickstart projects are in the [jenkins-x-quickstarts](https://github.com/jenkins-x-quickstarts/) github organisation.

The quickstarts are versioned in the version stream in your cluster git repository at `versionStream/quickstarts.yml`.

So you can add your own quickstarts by just modifying that file to add any quickstart you like. 

## Octant

Our preferred UI for Kubernetes, Tekton and Jenkins X is [octant](/docs/v3/develop/ui/octant) as its easy to install/run and has fined grained RBAC and security without the hassle of setting up TLS, DNS and SSO on every cluster.

One of the awesome features of [Octant](https://octant.dev/) is it supports plugins so that anyone can build a plugin to extend the UI. We've created the [octant-jx](https://github.com/jenkins-x/octant-jx) plugin to extend [Octant](https://octant.dev/) with the Jenkins X capabilities of environments, pipelines, source repositories and so forth. 

If you wish to extend [Octant](https://octant.dev/) further either contribute to the [octant-jx](https://github.com/jenkins-x/octant-jx) plugin or create your own!
