---
title: Run Boot
linktitle: Jenkins X Boot
description: Install, configure or upgrade Jenkins X via GitOps and a Jenkins X Pipeline
categories: [getting started]
keywords: [install, cluster]
weight: 30
aliases:
  - /getting-started/boot/
  - /docs/reference/boot/
  - /architecture/tls/
  - /docs/getting-started/setup/boot
  - /docs/getting-started/setup/boot/
  - /docs/install-setup/boot
  - docs/install-setup/boot/
---

## Overview

_Jenkins X Boot_ uses the following approach:

- Create your Kubernetes cluster however you want:
    - use `jx create cluster --skip-installation` e.g. for Google Cloud use `jx create cluster gke --skip-installation`. To see all the different providers see [jx create cluster](/commands/jx_create_cluster/)  
    - use Terraform to create your Kubernetes clusters + the associated cloud resources
    - use your cloud providers web console to create a new Kubernetes cluster
    - use some custom tool of your choice (maybe it's provided to you by your operations team)

    Please check out our [Cloud Providers Guide](/docs/getting-started/setup/boot/clouds/) on our recommendations for your cloud provider.

    You can verify you can communicate correctly with your Kubernetes cluster via:

    ``` sh
    kubectl get ns
    ```

- Run the [jx boot](/commands/jx_boot/) command:

    ```sh
    jx boot
    ```

You will now be prompted for any missing parameters required to install, such as your admin user/password, the Pipeline git user and token etc.

Then Jenkins X should be installed and set up on your Kubernetes cluster.

### About `jx boot`

The [jx boot](/commands/jx_boot/) interprets the boot pipeline using your local `jx` binary.
The underlying pipeline for booting Jenkins X can later be run inside Kubernetes via Tekton.
If ever something goes wrong with Tekton you can always `jx boot` again to get things back up and running (e.g., if someone accidentally deletes your cluster).

#### Pre and Post Validation

Before any installation is attempted, Boot runs the [jx step verify preinstall](/commands/jx_step_verify_preinstall/) command to check everything looks OK.
It will also check whether your installed package versions are within the upper and lower version limits, see [here](https://github.com/jenkins-x/jenkins-x-versions/tree/master/packages) for further information.
If you are using Terraform (so that your `jx-requirements.yml` file has `terraform: true`) it will fail if Terraform has not created the required cloud resources.
Otherwise they are lazily created for you if they don't exist.

Once the installation has completed the [jx step verify install](/commands/jx_step_verify_install/) command is run to verify your installation is valid.

#### Packages

For any boot based installation package versions which are used by `jx` are checked against the upper and lower version limits specified within the [version stream](https://github.com/jenkins-x/jenkins-x-versions/tree/master/packages).
Usually the upgrade process of a local pacage is pain free, however, downgrading can sometimes be difficult.

##### Brew

This [gist](https://gist.github.com/rdump/b79a63084b47f99a41514432132bd408) describes how you can switch to different versions of the `kubectl` package using the `brew` package manager.

## Changing your installation

At any time you can re-run [jx boot](/commands/jx_boot/) to re-apply any changes in your configuration. To do this git clone your development environment git repository, change directory into the git clone and run `jx boot`. e.g.

```sh
git clone https://github.com/myuser/environment-mycluster-dev.git
cd environment-mycluster-dev
jx boot
```

So just edit anything in the configuration you like and re-run [jx boot](/commands/jx_boot/) - whether that's to add or remove apps, to change parameters or configuration, or upgrade or downgrade versions of dependencies.

Note that you can also just submit a Pull Request on your development git repository which if merged, will trigger a pipeline to run the above commands to apply the changes.

## Requirements

There is a file called [jx-requirements.yml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/jx-requirements.yml) which is used to specify the logical requirements of your installation; such as:

- what Kubernetes provider to use
- whether to store secrets in the local file system or vault
- if you are using Terraform to manage your cloud resources
- if you wish to use kaniko for container image builds

This is the main configuration file for `jx boot` where you make most of your changes. You may want to review the  [jx-requirements.yml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/jx-requirements.yml) file and make any changes you need.

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

The big advantage of Vault is it means a team of folks can then easily run `jx boot` on the same cluster. Even if you accidentally delete your Kubernetes cluster, it's easy to restore from the KMS + cloud bucket.

## Webhook

Jenkins X supports a number of engines for handling webhooks and optionally supporting [ChatOps](/docs/resources/guides/using-jx/faq/chatops/).

[Prow](/docs/reference/components/prow/) and [Lighthouse](/architecture/lighthouse/) support webhooks and [ChatOps](/docs/resources/guides/using-jx/faq/chatops/) whereas Jenkins just supports webhooks.

### Prow

[Prow](/docs/reference/components/prow/) is currently the default webhook and [ChatOps](/docs/resources/guides/using-jx/faq/chatops/) engine when using [Serverless Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) with [Tekton](https://tekton.dev/) and GitHub.

It's configured via the `webhook: prow` in `jx-requirements.yml`

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

[Lighthouse](/architecture/lighthouse/) is currently the default webhook and [ChatOps](/docs/resources/guides/using-jx/faq/chatops/) engine when using [Serverless Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) with [Tekton](https://tekton.dev/) and a git server other than https://github.com.

Once Lighthouse is more stable and well tested we'll make it the default for all installations using [Serverless Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/).

It's configured via the `webhook: lighthouse` in `jx-requirements.yml`

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

Jenkins X supports a number of different Git providers.
You can specify the Git provider you wish to use and the organisation to use for the Git providers for each environment in your [jx-requirements.yml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/jx-requirements.yml) file.

{{< pageinfo >}}
**NOTE** Jenkins X creates repositories per default as private.
This can cause issues when evaluating Jenkins X with GitHub, using a free GitHub _organisation_ to hold the various created (environment) repositories as free organization accounts do not have access to private repos.
Using a personal Github account is not an issue though, as free private accounts have unlimited private repos.

For evaluation purposes you could use a private GitHub account as the owner of the repositories, and switch to a paid organizational account once you're ready to go all in.
Alternatively, you can enable public environment repositories by setting `environmentGitPublic` to true in your jx boot configuration.
In case you're using `jx create` or `jx install`, you'll need to add the `--git-public` option as part of the command to enable public repo
{{< /pageinfo >}}

### GitHub

This is the default Git provider if you don't specify one.

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

For this specify the URL of the `gitServer` and `gitKind: bitbucketserver`.
If you want to use [Serverless Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) with [Tekton](https://tekton.dev/) then make sure you specify the [Lighthouse webhook](#webhook) via `webhook: lighthouse`.

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

For this specify`gitKind: bitbucketcloud`.
If you want to use [Serverless Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) with [Tekton](https://tekton.dev/) then make sure you specify the [lighthouse webhook](#webhook) via `webhook: lighthouse`.

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

### GitLab

For this specify the URL of the `gitServer` and `gitKind: gitlab`.
If you want to use [Serverless Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) with [Tekton](https://tekton.dev/) then make sure you specify the [Lighthouse webhook](#webhook) via `webhook: lighthouse`.

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

## Repository

Jenkins X lets you configure different artifact repositories.
We use artifact repositories to:

- store artifacts from some kinds of build (e.g. Java builds tend to deploy jars, `pom.xml` files and tarballs)
- act as a Maven proxy to cache maven dependencies when using java/maven builds
- implement a chart repository for releasing helm charts

### Nexus

By default if you don't make any explicit configuration then Jenkins X uses:

- [Nexus](https://www.sonatype.com/nexus-repository-oss) as an artifact repository to store artifacts (e.g. Java jars, `pom.xml` files, tarballs or npm modules etc)
- [ChartMuseum](https://chartmuseum.com/) as a repository of charts

You can explicitly configure nexus via the following `jx-requirements.yml` file:

```yaml
repository: nexus
```

### Bucketrepo

The [bucketrepo](https://github.com/jenkins-x/bucketrepo) chart is a small footprint microservice that is an alternative to both [Nexus](https://www.sonatype.com/nexus-repository-oss) and [Chartmusem](https://chartmuseum.com/) which can:

- act as a Maven proxy to cache maven dependencies when using java/maven builds
- act as an artifact repository (e.g. to deploy maven artifacts)
- implement a chart repository for releasing helm charts

To enable `bucketrepo` use the following `jx-requirements.yml` file:

```yaml
repository: bucketrepo
```

By default the local file system in the bucket repo is used to store artifacts.

To enable cloud storage for artifacts in `bucketrepo` you need to enable the `storage.repository` configuration in which case a cloud bucket is used instead. See the [storage section for more details](#storage).

### None

If you want to disable the artifact repository (nexus) but still use ChartMuseum for charts you can use the following:

```yaml
repository: none
```

Note that without using an artifact repository you will not be able to deploy Maven artifacts; though [ChartMuseum](https://chartmuseum.com/) will still be used as a repository of charts

## Storage

the [jx-requirements.yml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/jx-requirements.yml) file can configure whether you want to use long-term storage for logs + reports and what cloud storage buckets to use to store the data.

e.g. the following `jx-requirements.yml` file enables long-term storage:

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

You can also specify the URLs of the storage buckets in the `storage` section.
The following URL syntax is supported

- `gs://anotherBucket/mydir/something.txt` : using a GCS bucket on GCP
- `s3://nameOfBucket/mydir/something.txt` : using S3 bucket on AWS
- `azblob://thatBucket/mydir/something.txt` : using an Azure bucket
- `http://foo/bar` : file stored in Git not using HTTPS
- `https://foo/bar` : file stored in a Git repo using HTTPS

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

{{< pageinfo >}}
**NOTE** On GKE your node-pool requires additional permissions to write into GCS buckets,
for more information on this view the [GKE Storage Permissions](https://jenkins-x.io/docs/resources/guides/managing-jx/common-tasks/storage/#gke-storage-permissions)
{{< /pageinfo >}}
For more details see the [Storage Guide](https://jenkins-x.io/architecture/storage/).

## Ingress

If you don't specify anything in your [jx-requirements.yml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/jx-requirements.yml) file then boot will default to using HTTP (rather than HTTPS) and using [nip.io](https://nip.io/) as the DNS mechanism.

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

If you wish to enable external DNS (to automatically register DNS names for all of your exported services) a DNS domain name or TLS then modify the `ingress` section of your to add `ingress.domain` and `ingress.externalDNS = true` in `jx-requirements.yml` file and re-run `jx boot`.
There's a complete example below.

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

With `jx boot` all of the versions and configuration is in Git so it's easy to manage change via GitOps either automatically or manually.

### Auto Upgrades

You can enable auto upgrades in the `jx-requirements.yml` via the following (where `schedule` is a cron expression).

```yaml
autoUpdate:
  enabled: true
  schedule: "0 12 */5 * *"
```

When auto upgrades are enabled a `CronJob` is run which periodically checks for changes in the [version stream](/about/concepts/version-stream/) or [boot configuration](https://github.com/jenkins-x/jenkins-x-boot-config).
If changes are detected the [jx upgrade boot](/commands/jx_upgrade_boot/) will create a pull request on your development Git repository.
Once that merges the boot configuration is upgraded and boot will be re-run inside a tekton pipeline to upgrade your installation.

### Manual upgrades

You can manually run the [jx upgrade boot](/commands/jx_upgrade_boot/) command at any time which if there have been changes in [version stream](/about/concepts/version-stream/) or [boot configuration](https://github.com/jenkins-x/jenkins-x-boot-config) will create a Pull Request on your development git repository.

Once that merges the boot configuration is upgraded and boot will be re-run inside a Tekton pipeline to upgrade your installation.

### Recovering

If anything ever goes wrong (e.g. your cluster, namespace or tekton gets deleted) and your installation is incabable of running tekton pipelines you can always re-run [jx boot](/docs/getting-started/setup/boot/) on your laptop to restore your cluster.

## Backups

Jenkins X is integrated with [Velero](https://velero.io) to support backing up the state of Jenkins X (the Kubernetes and custom resources together with persistent volumes).

To enable Velero add the following to your `jx-requirements.yml`:

```yaml
storage:
  backup:
    enabled: true
    url: gs://my-backup-bucket
velero:
  namespace: velero
```

Using whatever your cloud providers bucket URLs are.
For more background, check out the [storage guide](/docs/resources/guides/managing-jx/common-tasks/storage/)

## User Interface

If you're looking for a UI, there is one available for the [CloudBees Jenkins X Distribution](https://www.cloudbees.com/products/cloudbees-jenkins-x-distribution/overview).
It should normally work on OSS Jenkins X as well, though CloudBees won't support it unless you're also using their distribution.
You can read more about it here: [Using the CloudBees Jenkins X Distribution user interface
](https://docs.cloudbees.com/docs/cloudbees-jenkins-x-distribution/latest/user-interface/)
