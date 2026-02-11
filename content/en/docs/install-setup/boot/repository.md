---
title: Configure Artifact Repositories
linktitle: Configure Artifact Repositories
description: Configure various artifact repositories used by Jenkins X
weight: 80
keywords: [nexus, bucketrepo]
aliases:
  - /docs/install-setup/installing/boot/repository/
---

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

To enable cloud storage for artifacts in `bucketrepo` you need to enable the `storage.repository` configuration in which case a cloud bucket is used instead. See the [storage section for more details](/docs/install-setup/boot/storage).

### None

If you want to disable the artifact repository (nexus) but still use ChartMuseum for charts you can use the following:

```yaml
repository: none
```

Note that without using an artifact repository you will not be able to deploy Maven artifacts; though [ChartMuseum](https://chartmuseum.com/) will still be used as a repository of charts.
