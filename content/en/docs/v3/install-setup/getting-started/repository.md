---
title: Create Git Repository
linktitle: Create Git Repository
description: Create a Git repository for your installation
weight: 20
---


Once you are connected to a Kubernetes cluster you need to create a git repository for your development environment.

If you already have a git repository for your environment then run the [jx admin operator](operator) command.

## Creating a fresh install

{{< pageinfo >}}
**NOTE** Jenkins X creates repositories per default as private. This can cause issues when evaluating Jenkins X with GitHub, using a free GitHub _organisation_ to hold the various created (environment) repositories as free organization accounts do not have access to private repos. Using a personal Github account is not an issue though, as free private accounts have unlimited private repos.

For evaluation purposes you could use a private GitHub account as the owner of the repositories, and switch to a paid organizational account once you're ready to go all in. Alternatively, you can use a free GitHub organisation and enable public environment repositories by setting `environmentGitPublic` to true in your jx boot configuration in the next section or use `--git-public` flags below.
{{< /pageinfo >}}

To create a fresh install run the `jx admin create` command.  Note this by default creates three git repositories, one for each environments dev, staging and production.

In a new directory run:

```bash
jx admin create
```

or for public git repositories as per the note above

```bash
jx admin create --env-git-public  --git-public
```

This will create the git repository and then setup the [git operator](https://github.com/jenkins-x/jx-git-operator) to manage installing + upgrading of the kubernetes resources.

You do not need to run the [jx admin operator](operator) command directly.

<nav>
  <ul class="pagination">
    <li class="page-item"><a class="page-link" href="../cloud">Previous</a></li>
    <li class="page-item"><a class="page-link" href="../secrets">Next</a></li>
  </ul>
</nav>


### Extra arguments

You can pass in a whole number of different arguments to default values in your installation. You can see all the available arguments via:

```bash 
jx admin create --help
``` 

e.g. if you want to specify the kubernetes provider to `gke` you can use:

```bash 
jx admin create --provider=gke
``` 

### Shrinking the footprint

If you are using a free tier or small kubernetes cluster you can shrink the footprint a little via the following:
 
```bash 
 jx admin create --repository=bucketrepo
 ``` 

This will avoid `nexus` and `chartmuseum` and deploy the small [bucketrepo](https://github.com/jenkins-x/bucketrepo) instead. More on the [configuration page](/docs/v3/install-setup/getting-started/config/#bucketrepo)



### Using Multi Cluster

If you wish to use [multi cluster](/docs/v3/install-setup/multi-cluster/) where your `staging` and `production` environments are in separate repositories then please add the `--env-remote` flag then follow the [multi cluster documentation](/docs/v3/install-setup/multi-cluster/) after you have booted your development environment.

```bash 
jx admin create --env-remote
```

This will create the git repositories for your environments.

The command will output instructions on how to setup the [secrets](/docs/v3/install-setup/getting-started/secrets/) and then [run the boot job](/docs/v3/install-setup/getting-started/run/).

## Other options

You can enable TLS + cert manager and externaldns via:

```bash 
jx admin create --tls --externaldns
```                                 

Incidentally you can also specify the [TLS secret](/docs/v3/install-setup/faq/#how-do-i-configure-the-ingress-tls-certificate-in-dev-staging-or-production)


## Upgrading an existing cluster
 
 
 f you have already installed Jenkins X somehow; e.g. via the deprecated `jx install` command of via `jx boot` with or without using GitOps using helm 2.x to manage the development environment then we have a way to upgrade your cluster to helm 3 and helmfile.
  
To do this connect to your current Kubernetes cluster so that `kubectl` can see the development namespace.

You can test this by running:

```bash 
kubectl get environments 
```

Which should list the `Environment` resources in your installation which usually has `dev`, `staging` and `production`.

You can use the `jx admin upgrade` command to help upgrade your existing Jenkins X cluster to helm 3 and helmfile.

Connect to the cluster you wish to migrate and run:

```bash 
jx admin upgrade
```

and follow the instructions.

If your cluster is using GitOps the command will clone the development git repository to a temporary directory, modify it and submit a pull request.

If your cluster is not using GitOps then a new git repository will be created along with instructions on how to setup the [secrets](/docs/v3/install-setup/getting-started/secrets/) and then [run the boot job](/docs/v3/install-setup/getting-started/run/).
