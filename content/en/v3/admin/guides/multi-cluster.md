---
title: Multi-Cluster
linktitle: Multi-Cluster
type: docs
description: How to use multiple clusters with helm 3 and helmfile
weight: 100
aliases:
  - /docs/v3/guides/multi-cluster
---


We recommend using separate clusters for your `Preprod` and `Production` environments. This lets you completely isolate your environments which improves security.


## Setting up multi cluster

Follow new [getting started approach](/docs/v3/getting-started/) to setup a new cluster. For `Preprod` and `Production` you typically won't need lots of the development tools like lighthouse and tekton; you will just want your actual applications and any additional services you need to run them (e.g. maybe nginx-ingress or cert-manager etc).

Then when you have a git repository URL for your `Preprod` or `Production`  cluster, [import the git repository](/docs/v3/develop/create-project/#import-an-existing-project) like you would any other git repository into your development cluster using the [jx project import](https://github.com/jenkins-x/jx-project/blob/master/docs/cmd/project_import.md) command:

```bash 
jx project import --url https://github.com/myowner/my-prod-repo.git
```        

This will create a Pull Request on your development cluster git repository to link to the `Preprod` or `Production` git repository on promotions of apps.


