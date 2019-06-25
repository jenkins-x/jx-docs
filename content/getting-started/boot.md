---
title: Jenkins X Boot
linktitle: Jenkins X Boot
description: A new consistent way to install, configure or upgrade Jenkins X via GitOps and a Jenkins X Pipeline
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
categories: [getting started]
keywords: [install]
menu:
  docs:
    parent: "getting-started"
    weight: 90
weight: 90
sections_weight: 90
draft: false
aliases: [/overview/usage/,/extras/livereload/,/doc/usage/,/usage/]
toc: true
---

## NOTE: Experimental!

Jenkins X Boot is currently experimental but we hope will become the long term strategic way to install, configure and upgrade Jenkins X

Currently [unsupported features](https://github.com/jenkins-x/jx/issues/4326):

* vault
* external dns
* environment git repositories are hard coded in the [values.yaml](https://github.com/jstrachan/environment-simple-tekton/blob/master/env/values.yaml#L11-L16) and the webhooks don't get automatically registered
* we don't automate setting up your own dev, staging, production git repositories easily
* we don't yet support adding the changes from the [cloud-environments](https://github.com/jenkins-x/cloud-environments) repository for the different kinds of kubernetes provider

## Background

We've learnt over the last 1-2 years that there are many different kinds of Kubernetes cluster and ways of setting up things like Ingress, DNS, domains, certificates which leads to complexity in the current [jx create cluster](/commands/jx_create_cluster) and [jx install](/commands/jx_install/) commands.

Plus its now recommended to use tools like Terraform to manage all of your cloud resources: creating/updating Kubernetes clusters, cloud storage buckets, service accounts, KMS etc.

We found we had lots of different bits of install logic spread across all kinds of different ways of installing (e.g. [jx create cluster](/commands/jx_create_cluster), [jx install](/commands/jx_install/), the use of the [--gitops flag](http://localhost:1313/getting-started/manage-via-gitops/) together with the different ways of managing production secrets - that were hard to test and keep solid.

We also hit issues that the [jx create cluster](/commands/jx_create_cluster) and [jx install](/commands/jx_install/) commands would install things like ingress controller and not give users the chance to configure/override their installation.

Users often struggled with understanding how to easily configure and override things; or upgrade values after things have been installed. 

So we wanted to come up with a new cleaner approach which worked for every kind of installation and provided a standard way to extend and customise the configuration via [Jenkins X Pipelines](/architecture/jenkins-x-pipelines/) and helm style configuration.


## Overview

The new _Jenkins X Boot_ mechanism uses the following approach:

* create your kubernetes cluster however you want:
  * use Terraform to create your kubernetes clusters + the associated cloud resources
  * use your cloud providers web console to create a new kubernetes cluster
  * use `jx create cluster --skip-installation` e.g.
``` 
jx create cluster gke --skip-installation
```
  
  * use some custom tool of your choice or maybe its provided to you by your operations team

* you may want to verify you can communicate correctly with your kubernetes cluster via:
``` 
kubectl get ns
```
* fork or clone the git repository for the [install requirements and configuration](https://github.com/jstrachan/environment-simple-tekton):
``` 
  git clone https://github.com/jstrachan/environment-simple-tekton.git my-jx-config
  cd my-jx-config
```  
* if you want to reset the existing parameters in the git repository just remove the parameters file:
``` 
rm env/parameters.yaml
```
* review the configuration to see if there's anything you want to change in the `values.yaml` files - you can always skip this step and come back later.
* run the [jx boot](/commands/jx_boot) command:
``` 
jx boot
```

You will now be prompted for any missing parameters required to install such as your admin user/password, the Pipeline git user and token etc.


Then Jenkins X should be installed and setup on your kubernetes cluster.


## Changing your installation

At any time you can re-run [jx boot](/commands/jx_boot) to re-apply any changes in your configuration.

So just edit anything in the configuration you like and re-run [jx boot](/commands/jx_boot) - whether thats to add or remove Apps, to change parameters or configuration or upgrade or downgrade versions of dependencies. 

## Requirements

There is a file called [jx-requirements.yaml](https://github.com/jstrachan/environment-simple-tekton/blob/master/jx-requirements.yml)) which is used to specify the logical requirements of your installation; such as:

* what kubernetes provider to use
* whether to store secrets in the local file system or vault
* if you are using Terraform to manage your cloud resources
* if you wish to use kaniko for container image builds

You may want to review the  [jx-requirements.yaml](https://github.com/jstrachan/environment-simple-tekton/blob/master/jx-requirements.yml) file and make any changes you need.


## Pipeline

The install/upgrade process is defined in a [Jenkins X Pipeline](/architecture/jenkins-x-pipelines/) in a file called [jenkins-x.yml](https://github.com/jstrachan/environment-simple-tekton/blob/master/jenkins-x.yml).

Typically you won't need to edit this file; though if you do see the [editing guide](http://localhost:1313/architecture/jenkins-x-pipelines/#customising-the-pipelines).


## Configuration

The boot process is configured using helm style configuration in `values.yaml` files. Though we support a few [extensions to helm](https://github.com/jenkins-x/jx/issues/4328).


### Parameters file

We define a [env/parameters.yaml](https://github.com/jstrachan/environment-simple-tekton/blob/master/env/parameters.yaml) file which defines all the parameters either checked in or loaded from Vault or a local file system secrets location.

#### Injecting secrets into the parameters

If you look at the current [env/parameters.yaml](https://github.com/jstrachan/environment-simple-tekton/blob/master/env/parameters.yaml) file you will see some values inlined and others use URIs of the form `local:my-cluster-folder/nameofSecret/key`. This currently supports 2 schemes:

* `vault:` to load from a path + key from Vault
* `local:` to load from a key in a YAML file at `~/.jx/localSecrets/$path.yml`

This means we can populate all the Parameters we need on startup then refer to them from `values.yaml` to populate the tree of values to then inject those into Vault.


### Populating the `parameters.yaml` file 

We can then use the new step to populate the `parameters.yaml` file in the Pipeline via this command in the `env` folder:

``` 
jx step create values --name parameters
```

This uses the [parameters.schema.json](https://github.com/jstrachan/environment-simple-tekton/blob/master/env/parameters.schema.json) file which powers the UI.

### Improvements to values.yaml

#### Support a tree of values.yaml files

Rather than a huge huge deeply nested values.yaml file we can have a tree of files for each App only include the App specific configuration in each folder. e.g.

``` 
env/
  values.yaml   # top level configuration
  prow/
    values.yaml # prow specific config
  tekton/
    vales.yaml  # tekton specific config 
```
  
  
#### values.yaml templates

When using `jx step helm apply` we now allow `values.yaml` files to use go/helm templates just like `templates/foo.yaml` files support inside helm charts so that we can generate value/secret strings which can use templating to compose things from smaller secret values. e.g. creating a maven `settings.xml` file or docker `config.json` which includes many user/passwords for different registries.

We can then check in the `values.yaml` file which does all of this composition and reference the actual secret values via URLs (or template functions) to access vault or local vault files

To do this we use expressions like: `{{ .Parameter.pipelineUser.token }}` somewhere in the `values.yaml` values file. So this is like injecting values into the helm templates; but it happens up front to help generate the `values.yaml` files.
