---
title: Jenkins X Boot
linktitle: Jenkins X Boot
description: Install, configure or upgrade Jenkins X via GitOps and a Jenkins X Pipeline
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
categories: [getting started]
keywords: [install]
weight: 10
aliases:
  - /getting-started/boot
  - /docs/reference/boot
---



## Overview

_Jenkins X Boot_ uses the following approach:

* create your kubernetes cluster however you want:
  * use Terraform to create your kubernetes clusters + the associated cloud resources
  * use your cloud providers web console to create a new kubernetes cluster
  * use `jx create cluster --skip-installation` e.g.
``` sh
jx create cluster gke --skip-installation
```

  * use some custom tool of your choice or maybe its provided to you by your operations team

* you may want to verify you can communicate correctly with your kubernetes cluster via:
``` sh
kubectl get ns
```

* run the [jx boot](/commands/jx_boot) command:
```sh
jx boot
```

You will now be prompted for any missing parameters required to install such as your admin user/password, the Pipeline git user and token etc.


Then Jenkins X should be installed and setup on your kubernetes cluster.

### About 'jx boot'

The [jx boot](/commands/jx_boot) interprets the boot pipeline using your local `jx` binary. The underlying pipeline for booting Jenkins X can later on be ran inside kubernetes via Tekton. If ever something goes wrong with tekton you can always `jx boot` again to get things back up and running (e.g. if someone accidentally deletes your cluster).


#### Pre and Post Validation

Before any installation is attempted it runs the [jx step verify preinstall](/commands/jx_step_verify_preinstall/) command to check everything looks OK. If you are using Terraform (so that your 'jx-requirements.yml' file has `terraform: true`) it will fail if Terraform has not created the required cloud resources. Otherwise they are lazily created for you if they don't exist.

Once the installation has completed the [jx step verify install](/commands/jx_step_verify_install/) command is run to verify your installation is valid.

## Changing your installation

At any time you can re-run [jx boot](/commands/jx_boot) to re-apply any changes in your configuration.

So just edit anything in the configuration you like and re-run [jx boot](/commands/jx_boot) - whether thats to add or remove Apps, to change parameters or configuration or upgrade or downgrade versions of dependencies.

## Requirements

There is a file called [jx-requirements.yml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/jx-requirements.yml) which is used to specify the logical requirements of your installation; such as:

* what kubernetes provider to use
* whether to store secrets in the local file system or vault
* if you are using Terraform to manage your cloud resources
* if you wish to use kaniko for container image builds

This is the main configuration file for `jx boot` and where you make most of your changes. You may want to review the  [jx-requirements.yml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/jx-requirements.yml) file and make any changes you need.

## Secrets

Boot currently supports the following options for managing secrets:

### Local Storage

This is the default or can be explicitly configured via `secretStorage: local`:

```yaml
cluster:
  provider: gke
environments:
- key: dev
- key: staging
- key: production
kaniko: true
secretStorage: local
webhook: prow
```

If enabled secrets are loaded/saved into the folder `~/.jx/localSecrets/$clusterName`. You can use `$JX_HOME` to change the location of `~/.jx`.

### Vault

This is the recommended approach when using GKE or EKS providers. It can be explicitly configured via `secretStorage: vault`:

```yaml
cluster:
  provider: gke
environments:
- key: dev
- key: staging
- key: production
kaniko: true
secretStorage: vault
webhook: prow
```

This configuration will cause `jx boot`'s pipeline to install a Vault using KMS and a cloud storage bucket to load/save secrets.

The big advantage of Vault is it means a team of folks can then easily run `jx boot` on the same cluster. Even if you accidentally delete your kubernetes cluster, its easy to restore from the KMS + cloud bucket.

## Webhook

Jenkins X supports a number of engines for handling webhooks and optionally supporting [ChatOps](/docs/using-jx/faq/chatops).

[Prow](/docs/reference/components/prow/) and [Lighthouse](/architecture/lighthouse/) support webhooks and [ChatOps](/docs/using-jx/faq/chatops) whereas Jenkins just supports webhooks.

### Prow

[Prow](/docs/reference/components/prow/) is currently the default webhook and [ChatOps](/docs/using-jx/faq/chatops) engine when using [Serverless Jenkins X Pipelines](/docs/concepts/jenkins-x-pipelines/) with [Tekton](https://tekton.dev/) and GitHub.

Its configured via the `webhook: prow` in `jx-requirements.yml`

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
webhook: prow
```

### Lighthouse

[Lighthouse](/architecture/lighthouse/) is currently the default webhook and [ChatOps](/docs/using-jx/faq/chatops) engine when using [Serverless Jenkins X Pipelines](/docs/concepts/jenkins-x-pipelines/) with [Tekton](https://tekton.dev/) and a git server other than https://github.com.

Once Lighthouse is more stable and well tested we'll make it the default for all installations using [Serverless Jenkins X Pipelines](/docs/concepts/jenkins-x-pipelines/).

Its configured via the `webhook: lighthouse` in `jx-requirements.yml`

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
webhook: lighthouse
```

### Jenkins

To use a Jenkins server in boot for processing webhooks and pipelines configure it via `webhook: jenkins` in `jx-requirements.yml`

## Git

Jenkins X supports a number of different git providers. You can specify the git provider you wish to use and the organisation to use for the git providers for each environment in your [jx-requirements.yml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/jx-requirements.yml) file.

{{% pageinfo %}}
**NOTE** Jenkins X creates repositories per default as private. This can cause issues when evaluating Jenkins X with GitHub, using a free GitHub _organisation_ to hold the various created (environment) repositories as free organization accounts do not have access to private repos. Using a personal Github account is not an issue though, as free private accounts have unlimited private repos.

For evaluation purposes you could use a private GitHub account as the owner of the repositories, and switch to a paid organizational account once you're ready to go all in. Alternatively, you can enable public environment repositories by setting `environmentGitPublic` to true in your jx boot configuration. In case you're using `jx create` or `jx install`, you'll need to add the `--git-public` option as part of the command to enable public repo
{{% /pageinfo %}}


### GitHub

This is the default if you don't specify anything.


```yaml
cluster:
  environmentGitOwner: myorg
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
webhook: prow
```

### GitHub Enterprise

The configuration is similar to the above but you need to specify the URL of the `gitServer` (if it differs from https://github.com) and `gitKind: github`

```yaml
cluster:
  provider: gke
  environmentGitOwner: myorg
  gitKind: github
  gitName: ghe
  gitServer: https://github.myserver.com
environments:
  - key: dev
  - key: staging
  - key: production
kaniko: true
secretStorage: local
storage:
  logs:
    enabled: true
    url: "gs://jx-logs"
  reports:
    enabled: true
    url: "gs://jx-logs"
  repository:
    enabled: true
    url: "gs://jx-logs"
webhook: lighthouse
```

### Bitbucket Server

For this specify the URL of the `gitServer` and `gitKind: bitbucketserver`. If you want to use [Serverless Jenkins X Pipelines](/docs/concepts/jenkins-x-pipelines/) with [Tekton](https://tekton.dev/) then make sure you specify the [lighthouse webhook](#webhook) via `webhook: lighthouse`.

```yaml
cluster:
  provider: gke
  environmentGitOwner: myorg
  gitKind: bitbucketserver
  gitName: bs
  gitServer: https://bitbucket.myserver.com
environments:
  - key: dev
  - key: staging
  - key: production
kaniko: true
secretStorage: local
storage:
  logs:
    enabled: true
    url: "gs://jx-logs"
  reports:
    enabled: true
    url: "gs://jx-logs"
  repository:
    enabled: true
    url: "gs://jx-logs"
webhook: lighthouse
```

### Bitbucket Cloud

For this specify`gitKind: bitbucketcloud`. If you want to use [Serverless Jenkins X Pipelines](/docs/concepts/jenkins-x-pipelines/) with [Tekton](https://tekton.dev/) then make sure you specify the [lighthouse webhook](#webhook) via `webhook: lighthouse`.

```yaml
cluster:
  provider: gke
  environmentGitOwner: myorg
  gitKind: bitbucketcloud
  gitName: bc
environments:
  - key: dev
  - key: staging
  - key: production
kaniko: true
secretStorage: local
storage:
  logs:
    enabled: true
    url: "gs://jx-logs"
  reports:
    enabled: true
    url: "gs://jx-logs"
  repository:
    enabled: true
    url: "gs://jx-logs"
webhook: lighthouse
```


### Gitlab

For this specify the URL of the `gitServer` and `gitKind: gitlab`. If you want to use [Serverless Jenkins X Pipelines](/docs/concepts/jenkins-x-pipelines/) with [Tekton](https://tekton.dev/) then make sure you specify the [lighthouse webhook](#webhook) via `webhook: lighthouse`.

```yaml
cluster:
  provider: gke
  environmentGitOwner: myorg
  gitKind: gitlab
  gitName: gl
  gitServer: https://gitlab.com
environments:
  - key: dev
  - key: staging
  - key: production
kaniko: true
secretStorage: local
storage:
  logs:
    enabled: true
    url: "gs://jx-logs"
  reports:
    enabled: true
    url: "gs://jx-logs"
  repository:
    enabled: true
    url: "gs://jx-logs"
webhook: lighthouse
```

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
    enabled: true
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

If you wish to enable external DNS (to automatically register DNS names for all of your exported services) a DNS domain name or TLS then modify the `ingress` section of your to add `ingress.domain` and `ingress.externalDNS = true` in `jx-requirements.yml` file and re-run `jx boot`. There's a complete example below.

You can also update your configuration to enable TLS via `ingress.tls.enabled = true`. Here's an example:

```yaml
cluster:
  clusterName: mycluster
  environmentGitOwner: myorg
  gitKind: github
  gitName: github
  gitServer: https://github.com
  namespace: jx
  provider: gke
  vaultName: jx-vault-myname
environments:
- key: dev
- key: staging
- key: production
gitops: true
ingress:
  domain: my.domain.com
  externalDNS: true
  namespaceSubDomain: -jx.
  tls:
    email: someone@acme.com
    enabled: true
    production: true
kaniko: true
secretStorage: vault
storage:
  logs:
    enabled: true
    url: gs://jx-prod-logs
  reports:
    enabled: false
    url: ""
  repository:
    enabled: false
    url: ""
webhook: prow
```

## Upgrading

With `jx boot` all of the versions and configuration is in git so its easy to manage change via GitOps either automatically or manually.

### Auto Upgrades

You can enable auto upgrades in the `jx-requirements.yml` via the following (where `schedule` is a cron expression)

```yaml
autoUpdate:
  enabled: true
  schedule: "0 0 23 1/1 * ? *"
```

When auto upgrades are enabled a `CronJob` is run which periodically checks for changes in the [version stream](/docs/concepts/version-stream/) or [boot configuration](https://github.com/jenkins-x/jenkins-x-boot-config). If changes are detected the [jx step boot upgrade](/commands/jx_step_boot_upgrade/) will create a Pull Request on your development git repository. Once that merges the boot configuration is upgraded and boot will be re-run inside a tekton pipeline to upgrade your installation.

### Manual upgrades

You can manually run the [jx step boot upgrade](/commands/jx_step_boot_upgrade/) command at any time which if there have been changes in [version stream](/docs/concepts/version-stream/) or [boot configuration](https://github.com/jenkins-x/jenkins-x-boot-config) will create a Pull Request on your development git repository.

Once that merges the boot configuration is upgraded and boot will be re-run inside a tekton pipeline to upgrade your installation.

### Recovering

If anything ever goes wrong (e.g. your cluster, namespace or tekton gets deleted) and your installation is incabable of running tekton pipelines you can always re-run [jx boot](/docs/getting-started/setup/boot/) on your laptop to restore your cluster.


## Backups

Jenkins X is integrated with [velero](https://velero.io) to support backing up the state of Jenkins X (the kubernetes and custom resources together with persistent volumes).

To enable velero add the following to your `jx-requirements.yml`:

```yaml
storage:
  backup:
    enabled: true
    url: gs://my-backup-bucket
velero:
  namespace: velero
```

Using whatever your cloud providers bucket URLs are. For more background checkout the [storage guide](/docs/managing-jx/common-tasks/storage/)
