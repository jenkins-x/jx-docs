---
title: Custom Resources
linktitle: Custom Resources
description: Custom Resources defined by Jenkins X 
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
menu:
  docs:
    parent: "architecture"
    weight: 50
weight: 50
sections_weight: 50
draft: false
toc: true
---

Kubernetes provides an extension mechanism called [Custom Resources](https://kubernetes.io/docs/concepts/api-extension/custom-resources/) which allows microservices to extend the Kubernetes platform to solve higher order problems.

So in Jenkins X we have added a number of Custom Resources to help extend Kubernetes to support CI/CD:
                
### Environments

Jenkins X natively supports [environments](/about/features/#environments) allowing them to be defined for your team and then queried via [jx get environments](/commands/jx_get_environments):

```shell
jx get environments
```

Under the covers that command uses the custom Kubernetes resource `Environments`. 

So you can also query the environments via [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) as well:

  
```shell
kubectl get environments
```

Or edit them via `YAML` directly if you want:

```shell
kubectl edit env staging
```

though you may prefer the easier to use [jx edit environment](/commands/jx_edit_environment) command

### Release

The Jenkins X pipelines generate a custom `Release` resource which we can use to keep track of:

* what version and git tag and git URL map to a release in Kubernetes/Helm
* what Jenkins pipeline URL and log was used to perform the release
* which commits, issues and Pull Requests were part of each release so that we can implement [feedback as issues are fixed in Staging/Production](/about/features/#feedback)


### PipelineActivity

This resource stores the pipeline status in terms of Jenkins Pipeline stages plus the [promotion activity](http://localhost:1313/about/features/#promotion)

This resource is also used by the [jx get activities](/commands/jx_get_activities) command
  