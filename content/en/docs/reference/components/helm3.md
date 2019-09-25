---
title: Helm 3
linktitle: Helm 3
description: Using Helm 3 with Jenkins X 
weight: 110
aliases:
  - /docs/managing-jx/common-tasks/helm3
---

Jenkins X uses [Helm](https://www.helm.sh/) to install both Jenkins X and to install the applications you create in each of the [Environments](/docs/concepts/features/#environments) (like `Staging` and `Production`)

**NOTE** until Helm 3 is GA we highly recommend folks use [Helm 2.x without Tiller](/news/helm-without-tiller/)

Currently Helm 3 is being developed that has a number of great improvements:

* remove the server side component, Tiller, so that `helm install` uses the current user/ServiceAccount's RBAC
* releases become namespace aware avoiding the need to come up with globally unique release names

At the time of writing helm 3 is still early in its development but to improve feedback we've added support for Helm 2 and Helm 3 into Jenkins X.

You can use either helm 2 or helm 3 to do either of these things:

* install Jenkins X itself
* install your apps into your `Staging` and `Production` environments

e.g. you could use helm 2 to install Jenkins X then use helm 3 for your `Staging` and `Production` environments.

Here's how to specify which helm to use.


## Using helm 3 to install Jenkins X

When installing Jenkins X via `jx create cluster ...` or `jx install` you can specify `--helm3` to use helm 3 instead of helm 2.x.

If you install with helm 2 then your team will default to using helm 2 for its releases. If you install with helm 3 then your team will default to also use helm 3.

To change the version of helm used by your team use [jx edit helmbin](/commands/jx_edit_helmbin/) :

```
jx edit helmbin helm3
```

or to switch to helm 2:

```
jx edit helmbin helm
```

You can view the current settings for your team via [jx get helmbin](/commands/jx_get_helmbin/):

```
jx get helmbin
```

Basically the [pod templates](/docs/managing-jx/common-tasks/pod-templates/) contain both the binaries:

* `helm` which is a 2.x distro of helm
* `helm3` which is a 3.x distro of helm