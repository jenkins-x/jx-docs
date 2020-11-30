---
title: Configure Storage
linktitle: Configure Storage
description: Configure long term storage for logs and reports
keywords: [logs]
weight: 60
deprecated: true
aliases:
  - /install-setup/installing/boot/storage/
---

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
