---
title: Source
linktitle: Source
description: The location of the various source code repositories
parent: "components"
weight: 400
aliases:
  - /docs/resources/guides/managing-jx/common-tasks/source
---

Jenkins X is built on the shoulders of giants and also has lots of different source repositories to make various things from CLI tools, docker images, helm charts and [addon Apps](/docs/contributing/addons/)

This page lists the main organisations and repositories.

## Organisations

* [jenkins-x](https://github.com/jenkins-x) the main organisation for source code
* [jenkins-x-apps](https://github.com/jenkins-x-apps) contains the standard  [addon Apps](/docs/contributing/addons/) for Jenkins X
* [jenkins-x-buildpacks](https://github.com/jenkins-x-buildpacks) contains the available [build packs](/docs/create-project/build-packs/)
* [jenkins-x-charts](https://github.com/jenkins-x-charts) the main helm charts we distribute
* [jenkins-x-images](https://github.com/jenkins-x-images) contains some custom docker image builds
* [jenkins-x-quickstarts](https://github.com/jenkins-x-quickstarts) the quickstart projects used by [create quickstart](/docs/getting-started/first-project/create-quickstart/)
* [jenkins-x-test-projects](https://github.com/jenkins-x-test-projects) test projects we use in test cases 

## Repositories

Here we'll call out of some of the main repositories in the above organisations:

* [jenkins-x/jx](https://github.com/jenkins-x/jx) the main repository which creates the `jx` CLI and reusable pipeline steps
* [jenkins-x/jx-docs](https://github.com/jenkins-x/jx-docs) the Hugo based documentation which generates this website
* [jenkins-x/bdd-jx](https://github.com/jenkins-x/bdd-jx) the BDD tests we use to verify the platform changes and verify PRs on [jenkins-x/jx](https://github.com/jenkins-x/jx)
* [jenkins-x/jenkins-x-platform](https://github.com/jenkins-x/jenkins-x-platform) the main composite helm chart for the Jenkins X platform
* [jenkins-x/jenkins-x-versions](https://github.com/jenkins-x/jenkins-x-versions) contains the [version stream](/about/concepts/version-stream/) - the stable versions of all _charts_ and CLI _packages_
* [jenkins-x/jenkins-x-boot-config](https://github.com/jenkins-x/jenkins-x-boot-config) the default boot configuration for a `jx boot` based install
 
### Build pods and images

* [jenkins-x/jenkins-x-builders](https://github.com/jenkins-x/jenkins-x-builders) generates the static jenkins server build pod docker images        
* [jenkins-x/jenkins-x-image](https://github.com/jenkins-x/jenkins-x-image) generates the docker image for the static jenkins server we use by default

### Tools

* [jenkins-x/lighthouse](https://github.com/jenkins-x/lighthouse) the strategic solution for webhooks and ChatOps for multiple git providers. For more details see  
* [jenkins-x/exposecontroller](https://github.com/jenkins-x/exposecontroller) a `Deployment` or `Job` that can be used to generate/update `Ingress` resources (or `Route` on OpenShift) if you change your DNS domain or enable TLS - it can also inject external URLs into your application via `ConfigMap` injection 
