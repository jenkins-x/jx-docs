---
title: Comparison
linktitle: Comparison
type: docs
description: Comparison of Jenkins X version 3.x to 2.x
weight: 90
aliases: 
    - /docs/v3/about/comparison/
---


This document outlines the similarities and differences of the 3.x approach for those who are aware of `jx boot` with helm 2 in 2.x of Jenkins X.

## Similarities between 2.x and 3.x

Just like classic boot with the [jenkins-x-boot-config](https://github.com/jenkins-x/jenkins-x-boot-config/) git repository, this new [helmfile](https://github.com/roboll/helmfile) solution supports:

* you can install and upgrade Jenkins X via GitOps
* you can reuse helm charts from the internet, local charts or charts built by Jenkins X in any environment
* a YAML file is used to store all the charts that are applied during install/upgrade

## Differences with in 3.x

* we support any permutation of tools such as: [helm 3](https://helm.sh/), [helmfile](https://github.com/roboll/helmfile), [kustomize](https://kustomize.io/) and/or [kpt](https://googlecontainertools.github.io/kpt/) to create the kubernetes resources
* in 3.x the installation/upgrade of Jenkins X is run inside the kubernetes cluster via a `Job` rather than on a developers laptop which helps with consistency and security.
* in 3.x we use a single git repository for each cluster; which can manage as many teams/namespaces as you like within the cluster
  * so any local environments like `Staging` which reside in the same kubernetes cluster are defined in the same git repository in 3.x - whereas in 2.x we used a separate git repository for `Dev`, `Staging` and `Production` when sharing the same cluster.
  * if `Dev`, `Preprod` and `Production` environments are in separate kubernetes clusters then those will have a git repository each.
* any helm chart can be deployed in any namespace (previously we used a single namespace for all charts in the [env/requirements.yaml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/env/requirements.yaml))
* instead of using [env/requirements.yaml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/env/requirements.yaml) we now use a simple and more powerful [helmfile.yaml](https://github.com/jenkins-x-labs/boot-helmfile-poc/blob/master/helmfile.yaml) file which is similar but supports:
  * we can specify a `namespace` on any chart
  * we can add extra `values` files to use with the chart to override the helm `values.yaml` files
* instead of copying lots of `env/$appName/values*.yaml` files into the boot config like we do in [these folders](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/env/) such as [the lighthouse/values.tmpl.yaml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/env/lighthouse/values.tmpl.yaml) we can instead default all of these from the version stream at [apps/jenkins-x/lighthouse](https://github.com/jenkins-x/jxr-versions/tree/master/apps/jenkins-x/lighthouse) - which means the boot config git repository is much simpler, we can share more configuration with the version stream and it avoids lots of git merge/rebase issues.
* adding and removing apps in your GitOps repository causes those resources to be properly installed or uninstalled
  * you can also review exactly what kubernetes resources will change on the Pull Request
* we no longer use a composite chart for `env/Chart.yaml` and instead deploy each chart independently
  * this means that each chart has its own unique version number you can see in the `helmfile.yaml` file
* we have done away with the complexity of `jenkins-x-platform` (a composite chart containing logs of [dependencies](https://github.com/jenkins-x/jenkins-x-platform/blob/master/jenkins-x-platform/requirements.yaml) like `jenkins` + `chartmuseum` + `nexus` etc) so that each chart can be added/removed independently or swapped out with a different version/distribution
