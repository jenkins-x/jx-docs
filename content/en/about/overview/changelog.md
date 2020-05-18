---
title: Changelog
linktitle: Changelog
description: Current status of Jenkins X
date: 2018-02-01
publishdate: 2018-02-01
lastmod: 2018-02-01
weight: 10
type: docs
---

# Support Matrix

| Install Kind | Supported Git Providers |
| --- | ---  |
| Serverless Jenkins X pipelines with Tekton | GitHub only (due to Prow restriction - we are working on it!) |
| Static Jenkins Server | GitHub, GitHub Enterprise, BitBucket Cloud, BitBucket Server, GitLab. Gitea in beta |


| Clouds with Kaniko Support |
| --- |
| GKE |
| EKS |

| Clouds supporting bucket log storage |
| --- |
| GKE |
| EKS |


# Status Reports

This section describes any specific manual work arounds you may require above and beyond changes described in the [News section](/blog/news/) or using [jx upgrade](/commands/jx_upgrade/) to upgrade the [CLI](/commands/jx_upgrade_cli/) or [platform](/commands/deprecation/).


## 25th June 2019: missing image: bitnami/monocular-api

It looks like the monocular docker images got removed today!

It turns out that monocular is not an absolute requirement for Jenkins X; it works great without it.

So a quick workaround to the problem is to scale down your monocular deployment:

```sh
kubectl scale deploy jenkins-x-monocular-api --replicas=0
kubectl scale deploy jenkins-x-monocular-prerender --replicas=0
kubectl scale deploy jenkins-x-monocular-ui --replicas=0
```

The latest [version stream release](/about/concepts/version-stream/) has removed monocular so if you [upgrade your platform
](/docs/resources/guides/managing-jx/common-tasks/upgrade-jx/) this issue should be resolved.

We can always add monocular back as an optional [App](/docs/contributing/addons/) later on when it works again.


## 12th June 2019: Knative Build now deprecated

Knative Build was our first attempt at building a serverless offering in Jenkins X. Since then Knative build got replaced with the more powerful Knative Build Pipelines which then got moved and renamed to [Tekton](https://tekton.dev/).

So we highly recommend anyone who has created a Jenkins X installation using Knative build to move to a [Serverless Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) cluster using Tekton instead.

Now the `jx` binary will warn that any attempt at using `--knative-build` when installing is deprecated.

We will soon have a build pack for [Jenkinsfile runner](https://github.com/jenkinsci/jenkinsfile-runner) when using Tekton in case you need to reuse a Jenkinsfile within [Serverless Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) and Tekton along with support for orchestrating `Jenkinsfile` within a [custom Jenkins server](/docs/resources/guides/managing-jx/common-tasks/custom-jenkins/).

## 21st May 2019: Skaffold upgrade to v0.29.0

We have noticed an incompatibility with older Skaffold configuration files and the new v0.29.0 Skaffold release.  Freshly generated applications will not suffer from this problem, but for existing applications changes to the configuration file may be required.

If you are running a static master or serverless (Jenkins file runner) cluster and are having issues building existing applications with the following error `creating runner: invalid skaffold config: required value not set: image` you will need to modify your `skaffold.yaml`.

In the `dev` profile, remove the following section:

```yaml
    artifacts:
    - docker: {}
```

For more information, refer to this [PR](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes/pull/50/files).

## 16th April 2019: Jenkins X 2.x

We are pleased to announce 2.0.x of Jenkins X.

We have changed some of the default CLI arguments when installing Jenkins X.

* we are now deprecating the use of Knative build with Prow / Serverless Jenkins in favor of [Jenkins X Pipelines and Tekton](/about/concepts/jenkins-x-pipelines/).
* we default to using `--no-tiller`  to [disable the use of helm's tiller](/news/helm-without-tiller/). We recommend to avoid tiller. If you really still want to use it then use `--no-tiller false` on the CLI when installing Jenkins X.


## 6th Feb 2019: Regression in `jx-install-config` secret.

We have spotted a regression in the install process that generates an invalid config file inside the secret `jx-install-config` secret.  Whilst the original defect has been fixed, the invalid secret will create an issue with `jx upgrade platform` causing the cluster to loose all secrets.

To work around this, we have added some logic into `jx upgrade platform` to detect the invalid secret and attempt to fix.  This feature is included in jx version `1.3.842`.  An extract of a running upgrade is shown below:

```sh
Creating /Users/garethjevans/.jx/adminSecrets.yaml from jx-install-config
Creating /Users/garethjevans/.jx/extraValues.yaml from jx-install-config
We have detected that the /Users/garethjevans/.jx/adminSecrets.yaml file has an invalid format
? Would you like to repair the file? Yes
```

## 1st Feb 2019: Changes to the default Nexus configuration

Anonymous access to Nexus has been disabled by default, this has implications to those running Maven based builds.  To support this, the maven settings.xml injected into each build pod needs to be modified.

This can be done automatically using:

```sh
jx upgrade platform --update-secrets
```

NOTE: this will regenerate the settings.xml from a defined template.

If you would prefer to apply this changes manually, edit the secret `jenkins-maven-settings`, duplicating the server block for `local-nexus`, changing the server id to `nexus` e.g.

```xml
<server>
    <id>local-nexus</id>
    <username>admin</username>
    <password>%s</password>
</server>
<server>
    <id>nexus</id>
    <username>admin</username>
    <password>%s</password>
</server>
```

## 8 Jan 2019: Prow and Knative Build upgrade

There are three critical bugs with the prow based Jenkins X
https://github.com/jenkins-x/jx/issues/2539
https://github.com/jenkins-x/jx/issues/2561
https://github.com/jenkins-x/jx/issues/2544

The fixes involve upgrading to a newer version of Prow and Knative Build, the latter caused an issue when performing a traditional `jx upgrade addon` so we recommend uninstalling Knative Build first (removes Knative Build related Custom Resource Definitions) and install the latest release.

```sh
jx delete addon knative-build
```

And to be extra sure it’s gone maybe do an extra:

```sh
helm del --purge knative-build
```

then:

```sh
jx upgrade cli
jx upgrade addon prow
```

But this means any existing builds or custom changes to `BuildTemplate` resources will be lost.


## 5 Jan 2019: environment git repository issue

There was a regression added a few weeks ago which led to new installations setting up invalid `exposecontroller` configuration in your `Staging/Production` git repositories. See the [issue and workaround](https://github.com/jenkins-x/jx/issues/2591#issuecomment-451516674).

Make sure that the `env/values.yaml` file for your environment git repository uses `expose:` as the key in the YAML and not `exposecontroller:` - if it uses `exposecontroller:` just edit it back to `expose:` and you should be good to go!

Also we have noticed a possible regression with helm where if you have multiple `expose:` sections in your environment `env/values.yaml` it can disable the `exposecontroller` post install helm hook which can break the creation of `Ingress` resources in your environment - if you have more than one `expose:` sections please combine them into a single entry.

