---
title: Repository
linktitle: Repository
type: docs
description: Changing your artifact or chart repository
weight: 200
---

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

To replace `nexus` by `bucketrepo` use the following `jx-requirements.yml` file:

```yaml
repository: bucketrepo
```
Then replace the nexus chart in `helmfiles/jx/helmfile.yaml` by:
```yaml
- chart: jenkins-x/bucketrepo
  name: bucketrepo
```

If you also want to replace `chartmuseum` by bucketrepo, change `jx-requirements.yml` with:
```yaml
apiVersion: core.jenkins-x.io/v4beta1
kind: Requirements
spec:
  ...
  cluster:
    chartRepository: http://bucketrepo.jx.svc.cluster.local/bucketrepo/charts
```
Another alternative for the helm chart repository is to use Github gh-pages, as explained [here](/v3/develop/faq/config/registries/#how-do-i-switch-to-github-pages-for-charts). Note that in that case and if you don't have any maven artifact, you don't need bucketrepo.

By default the local file system in the bucket repo is used to store artifacts.

To enable cloud storage for artifacts in `bucketrepo` you need to enable the `storage.repository` configuration in `jx-requirements.yml`, in which case a cloud bucket is used instead. See the [storage section for more details](/v3/admin/setup/config/storage.md).

### None

If you want to disable the artifact repository (nexus) but still use ChartMuseum for charts you can use the following:

```yaml
repository: none
```

Note that without using an artifact repository you will not be able to deploy Maven artifacts; though [ChartMuseum](https://chartmuseum.com/) will still be used as a repository of charts
