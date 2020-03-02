---
title: Configuration
linktitle: Configuration
description: Changing your configuration
weight: 40
---


You can edit the `jx-requirements.yml` file in your git repository for your `dev` environment to configure various capabilities: 

## Git

Jenkins X supports a number of different Git providers. You can specify the Git provider you wish to use and the organisation to use for the Git providers for each environment in your `jx-requirements.yml`

{{< pageinfo >}}
**NOTE** Jenkins X creates repositories per default as private. This can cause issues when evaluating Jenkins X with GitHub, using a free GitHub _organisation_ to hold the various created (environment) repositories as free organization accounts do not have access to private repos. Using a personal Github account is not an issue though, as free private accounts have unlimited private repos.

For evaluation purposes you could use a private GitHub account as the owner of the repositories, and switch to a paid organizational account once you're ready to go all in. Alternatively, you can enable public environment repositories by setting `environmentGitPublic` to true in your jx boot configuration. In case you're using `jx create` or `jx install`, you'll need to add the `--git-public` option as part of the command to enable public repo
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
webhook: lighthouse
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

For this specify the URL of the `gitServer` and `gitKind: bitbucketserver`. If you want to use [Serverless Jenkins X Pipelines](/docs/concepts/jenkins-x-pipelines/) with [Tekton](https://tekton.dev/)

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

For this specify`gitKind: bitbucketcloud`. If you want to use [Serverless Jenkins X Pipelines](/docs/concepts/jenkins-x-pipelines/) with [Tekton](https://tekton.dev/)

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

For this specify the URL of the `gitServer` and `gitKind: gitlab`. If you want to use [Serverless Jenkins X Pipelines](/docs/concepts/jenkins-x-pipelines/) with [Tekton](https://tekton.dev/)

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

Jenkins X lets you configure different artifact repositories. We use artifact repositories to:

* store artifacts from some kinds of build (e.g. Java builds tend to deploy jars, `pom.xml` files and tarballs)
* act as a Maven proxy to cache maven dependencies when using java/maven builds
* implement a chart repository for releasing helm charts

### Nexus

By default if you don't make any explicit configuration then Jenkins X uses:

* [Nexus](https://www.sonatype.com/nexus-repository-oss) as an artifact repository to store artifacts (e.g. Java jars, `pom.xml` files, tarballs or npm modules etc)
* [ChartMuseum](https://chartmuseum.com/) as a repository of charts

You can explicitly configure nexus via the following `jx-requirements.yml` file:

```yaml
repository: nexus
```

### Bucketrepo

The [bucketrepo](https://github.com/jenkins-x/bucketrepo) chart is a small footprint microservice that is an alternative to both [Nexus](https://www.sonatype.com/nexus-repository-oss) and [Chartmusem](https://chartmuseum.com/) which can:

* act as a Maven proxy to cache maven dependencies when using java/maven builds
* act as an artifact repository (e.g. to deploy maven artifacts)
* implement a chart repository for releasing helm charts

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

You can also specify the URLs of the storage buckets in the `storage` section. The following URL syntax is supported

* `gs://anotherBucket/mydir/something.txt` : using a GCS bucket on GCP
* `s3://nameOfBucket/mydir/something.txt` : using S3 bucket on AWS
* `azblob://thatBucket/mydir/something.txt` : using an Azure bucket
* `http://foo/bar` : file stored in Git not using HTTPS
* `https://foo/bar` : file stored in a Git repo using HTTPS

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
for more information on this view the [GKE Storage Permissions](https://jenkins-x.io/docs/managing-jx/common-tasks/storage/#gke-storage-permissions)
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

Using whatever your cloud providers bucket URLs are. For more background, check out the [storage guide](/docs/managing-jx/common-tasks/storage/)

## User Interface

If you're looking for a UI, there is one available for the [CloudBees Jenkins X Distribution](https://www.cloudbees.com/products/cloudbees-jenkins-x-distribution/overview). It should normally work on OSS Jenkins X as well, though CloudBees won't support it unless you're also using their distribution. You can read more about it here: [Using the CloudBees Jenkins X Distribution user interface
](https://docs.cloudbees.com/docs/cloudbees-jenkins-x-distribution/latest/user-interface/)
