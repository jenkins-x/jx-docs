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
* fork or clone the git repository for the [install requirements and configuration](https://github.com/jenkins-x/jenkins-x-boot-config):
``` 
  git clone https://github.com/jenkins-x/jenkins-x-boot-config.git my-jx-config
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

### About 'jx boot'

The [jx boot](/commands/jx_boot) interprets the boot pipeline using your local `jx` binary. The underlying pipeline for booting Jenkins X can later on be ran inside kubernetes via Tekton. If ever something goes wrong with tekton you can always `jx boot` again to get things back up and running (e.g. if someone accidentally deletes your cluster).


#### Pre and Post Validation
 
Before ny installation is attempted it runs the [jx step verify preinstall](/commands/jx_step_verify_preinstall/) command to check everything looks OK. If you are using Terraform (so that your 'jx-requirements.yml' file has `terraform: true`) it will fail if Terraform has not created the required cloud resources. Otherwise they are lazily created for you if they don't exist.

Once the installation has completed the [jx step verify install](/commands/jx_step_verify_install/) command is run to verify your installation is valid.

## Changing your installation

At any time you can re-run [jx boot](/commands/jx_boot) to re-apply any changes in your configuration.

So just edit anything in the configuration you like and re-run [jx boot](/commands/jx_boot) - whether thats to add or remove Apps, to change parameters or configuration or upgrade or downgrade versions of dependencies. 

## Source Repositories

Boot automatically sets up any source repositories which exist in the [repositories/templates](https://github.com/jenkins-x/jenkins-x-boot-config/tree/master/repositories/templates) folder as [SourceRepository](http://localhost:1313/architecture/custom-resources/#sourcerepository)  custom resources and uses any associated [Scheduler](http://localhost:1313/architecture/custom-resources/#scheduler) custom resources to regenerate the Prow configuration.

Boot also automatically creates or updates any required webhooks on the git provider for your [SourceRepository](http://localhost:1313/architecture/custom-resources/#sourcerepository) resources.

If you are using GitOps we hope to automate the population of the [repositories/templates](https://github.com/jenkins-x/jenkins-x-boot-config/tree/master/repositories/templates) folder as you import/create projects. Until then you can manually create a Pull Request on your boot git repository via [jx step create pullrequest repositories](/commands/jx_step_create_pullrequest_repositories/)

## Requirements

There is a file called [jx-requirements.yml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/jx-requirements.yml) which is used to specify the logical requirements of your installation; such as:

* what kubernetes provider to use
* whether to store secrets in the local file system or vault
* if you are using Terraform to manage your cloud resources
* if you wish to use kaniko for container image builds

You may want to review the  [jx-requirements.yml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/jx-requirements.yml) file and make any changes you need.

## Storage

the [jx-requirements.yml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/jx-requirements.yml) file can configure whether you want to use long term storage for logs + reports and what cloud storage buckets to use to store the data.

e.g. the following `jx-requirements.yml` file enables long term storage:

```yaml 
cluster:
  provider: gke
environments:
- key: dev
- key: staging
- key: production
kaniko: true
storage:
  logs:
    enabled: false
  reports:
    enabled: false
  repository:
    enabled: false
```

You can also specify the URLs of the storage buckets in the `storage` section. The following URL syntax is supported 

* `gs://anotherBucket/mydir/something.txt` : using a GCS bucket on GCP
* `s3://nameOfBucket/mydir/something.txt` : using S3 bucket on AWS
* `azblob://thatBucket/mydir/something.txt` : using an Azure bucket
* `http://foo/bar` : file stored in git not using HTTPS
* `https://foo/bar` : file stored in a git repo using HTTPS

e.g.

```yaml 
cluster:
  provider: gke
environments:
- key: dev
- key: staging
- key: production
kaniko: true
storage:
  logs:
    enabled: false
    url: gs://my-logs
  reports:
    enabled: false
    url: gs://my-logs
  repository:
    enabled: false
    url: gs://my-repo
```

For more details see the [Storage Guide](/architecture/storage).

## Ingress

If you don't specify anything in your [jx-requirements.yml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/jx-requirements.yml) file then boot will default to using HTTP (rathter than HTTPS) and using [nip.io](https://nip.io/) as the DNS mechanism. 

After running boot your `jx-requirements.yml` may look like:

```yaml 
cluster:
  provider: gke
  clusterName: my-cluster-name
  environmentGitOwner: my-git-org
  project: my-gke-project
  zone: europe-west1-d
environments:
- key: dev
- key: staging
- key: production
ingress:
  domain: 1.2.3.4.nip.io
  externalDNS: false
  tls:
    email: ""
    enabled: false
    production: false
kaniko: true
secretStorage: local
storage:
  logs:
    enabled: false
  reports:
    enabled: false
  repository:
    enabled: false
webhook: prow
```

If you wish tot enable external DNS (to automatically register DNS names for all of your exported services) a DNS domain name or TLS then modify the `ingress` section of your  `jx-requirements.yml` file and re-run `jx boot`

## Pipeline

The install/upgrade process is defined in a [Jenkins X Pipeline](/architecture/jenkins-x-pipelines/) in a file called [jenkins-x.yml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/jenkins-x.yml).

Typically you won't need to edit this file; though if you do see the [editing guide](http://localhost:1313/architecture/jenkins-x-pipelines/#customising-the-pipelines).




## Configuration

The boot process is configured using helm style configuration in `values.yaml` files. Though we support a few [extensions to helm](https://github.com/jenkins-x/jx/issues/4328).


### Parameters file

We define a [env/parameters.yaml](https://github.com/jstrachan/environment-simple-tekton/blob/master/env/parameters.yaml) file which defines all the parameters either checked in or loaded from Vault or a local file system secrets location.

#### Injecting secrets into the parameters

If you look at the current [env/parameters.yaml](https://github.com/jstrachan/environment-simple-tekton/blob/master/env/parameters.yaml) file you will see some values inlined and others use URIs of the form `local:my-cluster-folder/nameofSecret/key`. This currently supports 2 schemes:

* `vault:` to load from a path + key from Vault
* `local:` to load from a key in a YAML file at `~/.jx/localSecrets/$path.yml`

This means we can populate all the Parameters we need on startup then refer to them from `values.tmpl.yaml` to populate the tree of values to then inject those into Vault.


### Populating the `parameters.yaml` file 

We can then use the new step to populate the `parameters.yaml` file in the Pipeline via this command in the `env` folder:

``` 
jx step create values --name parameters
```

This uses the [parameters.schema.json](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/env/parameters.schema.json) file which powers the UI.

### Improvements to values.yaml

#### Support a tree of values.yaml files

Rather than a huge huge deeply nested values.yaml file we can have a tree of files for each App only include the App specific configuration in each folder. e.g.

``` 
env/
  values.yaml   # top level configuration
  prow/
    values.yaml # prow specific config
  tekton/
    values.yaml  # tekton specific config 
```
  
  
#### values.tmpl.yaml templates

When using `jx step helm apply` we now allow `values.tmpl.yaml` files to use go/helm templates just like `templates/foo.yaml` files support inside helm charts so that we can generate value/secret strings which can use templating to compose things from smaller secret values. e.g. creating a maven `settings.xml` file or docker `config.json` which includes many user/passwords for different registries.

We can then check in the `values.tmpl.yaml` file which does all of this composition and reference the actual secret values via URLs (or template functions) to access vault or local vault files

To do this we use expressions like: `{{ .Parameter.pipelineUser.token }}` somewhere in the `values.tmpl.yaml` values file. So this is like injecting values into the helm templates; but it happens up front to help generate the `values.yaml` files.
