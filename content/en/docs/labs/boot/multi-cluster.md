---
title: Multi-Cluster
linktitle: Multi-Cluster
description: How to use multiple clusters with helm 3 and helmfile
weight: 6
---

We recommend using separate clusters for your `Staging` and `Production` environments. This lets you completely isolate your environments which improves security.


## Setting up multi cluster

To enable multi cluster you need to specify `remoteCluster: true` on your `Staging` and/or `Production` environments in your `jx-requirements.yml`.

The easiest way to do that is passing in `--env-report`  when you [created your environment git repositories](/docs/labs/boot/getting-started/repository/):

``` 
jxl boot create --env-remote
```

Or if you've already [created your environment git repositories](/docs/labs/boot/getting-started/repository/) you can modify your `jx-requirements.yml` to something like this:

```yaml 
bootConfigURL: https://github.com/jenkins-x/jenkins-x-boot-helmfile-config
cluster:
  gitKind: github
  gitName: github
  gitServer: https://github.com
  namespace: jx
environments:
- key: dev
- key: staging
  remoteCluster: true
- key: production
  remoteCluster: true
gitops: true
helmfile: true
kaniko: true
repository: nexus
secretStorage: local
versionStream:
  ref: v1.0.330
  url: https://github.com/jenkins-x/jenkins-x-versions.git
webhook: lighthouse
```    

### Setup the development cluster as normal

Follow the [getting started guide for helm 3 boot](/docs/labs/boot/getting-started/) to setup the secrets and boot up the development cluster.

### Configure the Staging/Production git repository

First make sure you do:

```bash 
export NAMESPACE=jx-staging
```

Then you will need to follow the instructions to [setup the cloud resources for the Staging/Production cluster](/docs/labs/boot/getting-started/cloud/)

When you are connected to the Staging/Production cluster you will need to run:

``` 
jxl boot verify --git-url=https://github.com/myorg/environment-mycluster-staging.git
```
 
This will ensure that your `jx-requirements.yml` file in your `staging` / `production` git repository is setup to point at the correct cloud resources.

Then follow the [secrets setup](/docs/labs/boot/getting-started/secrets/) and  [run the boot job](/docs/labs/boot/getting-started/run/) for the `staging` / `production` environment


## How it works

Once you run `jx boot` on your development cluster you will get a helm 3 based installation of Jenkins X as usual but with a few differences:
 
* the `Environment` resources for `Staging` and `Production` marked as `remote`
* the `SourceRepository` resources for `Staging` and `Production` will reference the `pr-only` `Scheduler` which means only the Pull Request pipelines will run on the development cluster; the release pipelines will run in the remote cluster.
* the git repository for the `Staging` and `Production` environments will use the helmfile + helm 3 layout structure (using an `apps` folder instead of `env`)

### Setting up the remote Staging/Production cluster

First make a note of the git repository locations of your `Staging` and `Production` environments via the [jx get env](https://jenkins-x.io/commands/jx_get_environments/) command:

``` 
jx get env
```

Now follow the [usual steps to create your kubernetes cluster](https://jenkins-x.io/docs/getting-started/setup/create-cluster/) and connect to the cluster so that `kubectl get node` runs against the `Staging` or `Production` cluster you want to setup.

Then git clone the git repository for the `Staging` / `Production` environment and `cd` into the directory.

Now run `jx boot` in the usual way...

``` 
jx boot
```

And your remote `Staging` or `Production` cluster should boot up.

If you want to add any more apps to your cluster, use the [jx add app](/docs/labs/boot/apps/#adding-apps-or-charts) command.