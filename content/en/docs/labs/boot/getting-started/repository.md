---
title: Create Repository
linktitle: Create Repository
description: Create a Git repository for your installation
weight: 20
---

Once you are connected to a Kubernetes cluster you need to create a git repository for your development environment.

## Creating a fresh install

To create a fresh install run the `jxl boot create` command:

``` 
jxl boot create
```

This will create the git repositories for your environments.

The command will output instructions on how to setup the [secrets](/docs/labs/boot/getting-started/secrets/) and then [run the boot job](/docs/labs/boot/getting-started/run/).


### Extra arguments

You can pass in a whole number of different arguments to default values in your installation. You can see all the available arguments via:

```bash 
jxl boot create --help
``` 

e.g. if you want to specify the kubernetes provider to `gke` and enable public repositories for environments and apps you can use:

```bash 
jxl boot create --provider=gke --env-git-public  --git-public
``` 

### Shrinking the footprint

If you are using a free tier or small kubernetes cluster you can shrink the footprint a little via the following:
 
```bash 
 jxl boot create --repository=bucketrepo
 ``` 

This will avoid `nexus` and `chartmuseum` and deploy the small [bucketrepo](https://github.com/jenkins-x/bucketrepo) instead. More on the [configuration page](/docs/labs/boot/getting-started/config/#bucketrepo)



### Using Multi Cluster

If you wish to use [multi cluster](/docs/labs/boot/multi-cluster/) where your `staging` and `production` environments are in separate repositories then please add the `--env-remote` flag then follow the [multi cluster documentation](/docs/labs/boot/multi-cluster/) after you have booted your development environment.

```bash 
jxl boot create --env-remote
```

This will create the git repositories for your environments.

The command will output instructions on how to setup the [secrets](/docs/labs/boot/getting-started/secrets/) and then [run the boot job](/docs/labs/boot/getting-started/run/).

## Other options

You can switch to use `istio` instead of `nginx` for ingress support via adding:

```bash 
jxl boot create --ingress-kind=istio
```                                 

which then switches to adding `istio` instead and using `Gateway` and `VirtualService` resources from istio instead of the classic `Ingress` resources.

You can enable TLS + cert manager and externaldns via:

```bash 
jxl boot create --tls --externaldns
```                                 

Though please note we are still working on [cert manager + externaldns integration](https://github.com/jenkins-x-labs/issues/issues/13) in `jxl boot` so please be gentle.

Incidentally you can also specify the [TLS secret](/docs/labs/boot/faq/#how-do-i-configure-the-ingress-tls-certificate-in-dev-staging-or-production)


## Upgrading an existing cluster
 
 
 f you have already installed Jenkins X somehow; e.g. via the deprecated `jx install` command of via `jx boot` with or without using GitOps using helm 2.x to manage the development environment then we have a way to upgrade your cluster to helm 3 and helmfile.
  
To do this connect to your current Kubernetes cluster so that `kubectl` can see the development namespace.

You can test this by running:

```
kubectl get environments 
```

Which should list the `Environment` resources in your installation which usually has `dev`, `staging` and `production`.

You can use the `jxl boot upgrade` command to help upgrade your existing Jenkins X cluster to helm 3 and helmfile.

Connect to the cluster you wish to migrate and run:

``` 
jxl boot upgrade
```

and follow the instructions.

If your cluster is using GitOps the command will clone the development git repository to a temporary directory, modify it and submit a pull request.

If your cluster is not using GitOps then a new git repository will be created along with instructions on how to setup the [secrets](/docs/labs/boot/getting-started/secrets/) and then [run the boot job](/docs/labs/boot/getting-started/run/).
