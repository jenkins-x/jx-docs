---
title: Comparison
linktitle: Comparison
description: Comparison of helm 3 + helmfile versus helm 2 with boot
weight: 90
---


This document outlines the similarities and differences of the 3.x approach for those who are aware of `jx boot` with helm 2.

## Similarities with `jx boot` and helm 2

Just like classic boot with the [jenkins-x-boot-config](https://github.com/jenkins-x/jenkins-x-boot-config/) git repository, this new [helmfile](https://github.com/roboll/helmfile) solution supports:

* you can run `jx boot` to spin up a new git repository for your development environment
* you can run `jx boot` at any time to reapply changes from your laptop or can trigger a CI/CD pipeline using tekton to do the same thing
* the git repository contains a `jenkins-x.yml` to implement the boot pipeline
* a YAML file is used to store all the charts that are applied using `jx boot`

## Differences with `jx boot` and helm 3

* we use helm 3 along with [helmfile](https://github.com/roboll/helmfile) to actually apply the helm charts into a kubernetes cluster
* any helm chart can be deployed in any namespace (previously we used 1 namespace for all charts in the [env/requirements.yaml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/env/requirements.yaml))
* we no longer use a composite chart for `env/Chart.yaml` and instead deploy each chart independently
  * this means that each chart has its own unique version number; so that `helm list` gives nice meaningful results
* we have done away with the complexity of `jenkins-x-platform` (a composite chart containing logs of [dependencies](https://github.com/jenkins-x/jenkins-x-platform/blob/master/jenkins-x-platform/requirements.yaml) like `jenkins` + `chartmuseum` + `nexus` etc) so that each chart can be added/removed independently or swapped out with a different version/distribution
* instead of using [env/requirements.yaml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/env/requirements.yaml) we now use a simple and more powerful [jx-apps.yml](https://github.com/jenkins-x-labs/boot-helmfile-poc/blob/master/jx-apps.yml) file which is similar but supports:
  * we can specify a `namespace` on any chart
  * we can add extra `valuesFiles` to use with the chart to override the helm `values.yaml` files
  * different `phase` values so that we can default some charts like `nginx-ingress` to the `system` phase before we setup ingress, DNS, TLS and certs
* instead of copying lots of `env/$appName/values*.yaml` files into the boot config like we do in [these folders](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/env/) such as [the lighthouse/values.tmpl.yaml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/env/lighthouse/values.tmpl.yaml) we can instead default all of these from the version stream at [apps/jenkins-x/lighthouse](https://github.com/jenkins-x/jenkins-x-versions/tree/master/apps/jenkins-x/lighthouse) - which means the boot config git repository is much simpler, we can share more configuration with the version stream and it avoids lots of git merge/rebase issues.
* since we are using helm 3 directly you can add/remove apps and re-run `jx boot` and things are removed correctly.
