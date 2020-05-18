---
title: Cloud Native Jenkins
linktitle: Cloud Native Jenkins
description: Lets make Jenkins cloud native
weight: 31
aliases:
  - /docs/resources/guides/managing-jx/common-tasks/cloud-native-jenkins
---

Jenkins X helps to support _cloud native Jenkins_ via:

* orchestrating either [serverless Jenkins](/news/serverless-jenkins/) using [prow](/architecture/prow/) or a Static Jenkins masters per team. This lets teams move towards serverless while bring along static masters too.
* each team can install its own Jenkins X in its own namespace (via `jx install --namespace myteam`)
* support for different workloads per team (see [jx edit buildpack](/commands/jx_edit_buildpack/)).


## Different workloads

Some teams develop cloud native applications on kubernetes and so should use the `kubernetes workloads` option.

For teams that do not deploy applications to kubernetes - such as delivering libraries or binaries - there's a new `library workloads` option which has CI and automated releases but no CD.

When you [create a cluster](/docs/getting-started/setup/create-cluster/) or [install Jenkins X](/docs/resources/guides/managing-jx/common-tasks/install-on-cluster/) you are prompted to pick between the available build packs.

```sh
? Pick workload build pack:   [Use arrows to move, type to filter]
> Kubernetes Workloads: Automated CI+CD with GitOps Promotion
  Library Workloads: CI+Release but no CD
```

You can change this configuration at any time via [jx edit buildpack](/commands/jx_edit_buildpack/).

By default just hit enter to stick to the `kubernetes workloads` option. Though if you have a significant number of libraries you wish to manage you could setup a separate team for this and import your various library projects there.


## Current workloads

We store our build packs in [jenkins-x-buildpacks](https://github.com/jenkins-x-buildpacks/) organization at GitHub. Currently we support:

* the [jenkins-x-classic](https://github.com/jenkins-x-buildpacks/jenkins-x-classic) build pack supports CI+Releases but does not include CD. e.g. do CI and release of your Java libraries or Node modules but don't deploy to Kubernetes
* the [jenkins-x-kubernetes](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes) build pack supports automated CI+CD with GitOps promotion and Preview Environments for `kubernetes workloads`

However you should be able to extend either of these build packs to add alternative platforms and capabilities.

## Writing your own build pack

We want you to [extend Jenkins X](/docs/contributing/addons/) so please check out the [documentation on creating your own build packs](/docs/create-project/build-packs/#creating-new-build-packs)
