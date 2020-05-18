---
title: Configuration
linktitle: Configuration
description: Changing your configuration
weight: 40
---
{{% alert %}}
**NOTE: This current experiment is now closed. The work done and feedback we have received will be used to enhance Jenkins X in future versions**

**This code should not be used in production, or be adopted for usage.  It should only be used to provide feedback to the Labs team.**

Thank you for your participation,

-Labs


{{% /alert %}}

You can edit the `jx-requirements.yml` file in the git repository that was created in an earlier step for your `dev` environment, to configure various capabilities:

Make changes to the config using the help below or continue Next to run boot.

<nav>
  <ul class="pagination">
    <li class="page-item"><a class="page-link" href="../secrets">Previous</a></li>
    <li class="page-item"><a class="page-link" href="../run">Next</a></li>
  </ul>
</nav>

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
webhook: lighthouse
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
webhook: lighthouse
```

This configuration will cause `jx boot`'s pipeline to install a Vault using KMS and a cloud storage bucket to load/save secrets.

The big advantage of Vault is it means a team of folks can then easily run `jx boot` on the same cluster. Even if you accidentally delete your Kubernetes cluster, it's easy to restore from the KMS + cloud bucket.


### Google Secret Manager 

This can be explicitly configured via `secretStorage: gsm`:

```yaml
cluster:
  provider: gke
environments:
- key: dev
- key: staging
- key: production
kaniko: true
secretStorage: gsm
webhook: lighthouse
```

## Git

Jenkins X supports a number of different Git providers. You can specify the Git provider you wish to use and the organisation to use for the Git providers for each environment in your `jx-requirements.yml`

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

The configuration is similar to the above but you need to specify the URL of the `gitServer` (if it differs from ht<span>tps://github.com) and `gitKind: github`

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

For this specify the URL of the `gitServer` and `gitKind: bitbucketserver`. If you want to use [Serverless Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) with [Tekton](https://tekton.dev/)

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

For this specify`gitKind: bitbucketcloud`. If you want to use [Serverless Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) with [Tekton](https://tekton.dev/)

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

For this specify the URL of the `gitServer` and `gitKind: gitlab`. If you want to use [Serverless Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) with [Tekton](https://tekton.dev/)

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
for more information on this view the [GKE Storage Permissions](https://jenkins-x.io/docs/resources/guides/managing-jx/common-tasks/storage/#gke-storage-permissions)
{{< /pageinfo >}}
For more details see the [Storage Guide](https://jenkins-x.io/architecture/storage/).

## Ingress

When installing Jenkins X it is common that you will want to use a custom domain to access services and applications running in Kubernetes.  

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

### Custom domains with external dns

There is a very useful open source project called [external-dns](https://github.com/kubernetes-sigs/external-dns) which integrates with Cloud Providers own managed dns services, to automatically enable dns.

In labs this has been verified on GKE so far but we are looking to do more very soon.

#### Configure for Google Cloud

If you want to buy a new domain then using [Google Domains](https://domains.google.com/m/registrar/search) is nice and easy

<img src="/images/getting-started/googlednscreate.png" width="80%" float="left">

First configure [Google Cloud DNS](https://cloud.google.com/dns) in the GCP project that your Kubernetes cluster runs, to manage your custom domain, you will have a list of four servers returned

```bash
➜ jx create domain gke -d acame-trading.com

Please update your existing DNS managed servers to use the nameservers below
ns-cloud-e1.googledomains.com.
ns-cloud-e2.googledomains.com.
ns-cloud-e3.googledomains.com.
ns-cloud-e4.googledomains.com.
```

Now update your dns provider so that [Google Cloud DNS](https://cloud.google.com/dns) can manage your domain, here's an example using [Google Domains](https://domains.google.com/m/registrar/search):

<img src="/images/getting-started/googlednsconfigure.png" width="80%" float="left">

Next you can edit the `jx-requirements.yml` and add your domain:

__NOTE__ when using jxl on GKE the `externalDNS:` value is ignored and will be deprecated.  This flag used to create cloud resources but these have now been moved outside of the boot process.

```yaml
ingress:
  domain: my.domain.com
```

Edit the `jx-apps.yml` in your environment repository and add the external dns chart:

```yaml
apps:
- name: bitnami/external-dns
```

Remember to repeat this in each environment git repository, you can also use different domains for each environment by repeating all the external dns steps here.

__NOTE__ it can take a few minutes for DNS to propogate for each URL so please be patient when you first enable external dns or deploy a new application into an environment for the first time.


### Automated TLS

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
  externalDNS: false
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

Using whatever your cloud providers bucket URLs are. For more background, check out the [storage guide](/docs/resources/guides/managing-jx/common-tasks/storage/)

## User Interface

If you're looking for a UI, there is one available for the [CloudBees Jenkins X Distribution](https://www.cloudbees.com/products/cloudbees-jenkins-x-distribution/overview). It should normally work on OSS Jenkins X as well, though CloudBees won't support it unless you're also using their distribution. You can read more about it here: [Using the CloudBees Jenkins X Distribution user interface
](https://docs.cloudbees.com/docs/cloudbees-jenkins-x-distribution/latest/user-interface/)
