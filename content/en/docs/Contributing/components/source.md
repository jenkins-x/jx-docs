---
title: Source
linktitle: Source
description: The location of the various source code repositories
parent: "components"
weight: 40
---

Jenkins X is built on the shoulders of giants and also has lots of different source repositories to make various things from CLI tools, docker images, helm charts and [addon Apps](/docs/contributing/addons/)

This page lists the main organisations and repositories.

## Organisations

* [jenkins-x](https://github.com/jenkins-x) the main organisation for source code
* [jenkins-x-apps](https://github.com/jenkins-x-apps) contains the standard  [addon Apps](/docs/contributing/addons/) for Jenkins X
* [jenkins-x-buildpacks](https://github.com/jenkins-x-buildpacks) contains the available [build packs](/docs/managing/tasks/build-packs/)
* [jenkins-x-charts](https://github.com/jenkins-x-charts) the main helm charts we distribute
* [jenkins-x-images](https://github.com/jenkins-x-images) contains some custom docker image builds
* [jenkins-x-quickstarts](https://github.com/jenkins-x-quickstarts) the quickstart projects used by [create quickstart](/docs/getting_started/first_project/create-quickstart/)
* [jenkins-x-test-projects](https://github.com/jenkins-x-test-projects) test projects we use in test cases 

## Repositories

Here we'll call out of some of the main repositories in the above organisations:

* [jenkins-x/jx](https://github.com/jenkins-x/jx) the main repository which creates the `jx` CLI and reusable pipeline steps
* [jenkins-x/jx-docs](https://github.com/jenkins-x/jx-docs) the Hugo based documentation which generates this website
* [jenkins-x/bdd-jx](https://github.com/jenkins-x/bdd-jx) the BDD tests we use to verify the platform changes and verify PRs on [jenkins-x/jx](https://github.com/jenkins-x/jx)
* [jenkins-x/jenkins-x-platform](https://github.com/jenkins-x/jenkins-x-platform) the main composite helm chart for the Jenkins X platform
* [jenkins-x/jenkins-x-versions](https://github.com/jenkins-x/jenkins-x-versions) contains the [version stream](/docs/concepts/version-stream/) - the stable versions of all _charts_ and CLI _packages_
* [jenkins-x/cloud-environments](https://github.com/jenkins-x/cloud-environments) the helm configurations for different cloud providers
 
### Build pods and images

* [jenkins-x/jenkins-x-builders](https://github.com/jenkins-x/jenkins-x-builders) generates the static jenkins server build pod docker images        
* [jenkins-x/jenkins-x-image](https://github.com/jenkins-x/jenkins-x-image) generates the docker image for the static jenkins server we use by default
* [jenkins-x/jenkins-x-serverless](https://github.com/jenkins-x/jenkins-x-serverless) generates the [serverless jenkins](/news/serverless-jenkins/) docker images when using [prow](/architecture/prow)

### Tools

* [jenkins-x/exposecontroller](https://github.com/jenkins-x/exposecontroller) a `Deployment` or `Job` that can be used to generate/update `Ingress` resources (or `Route` on OpenShift) if you change your DNS domain or enable TLS - it can also inject external URLs into your application via `ConfigMap` injection 
* [jenkins-x/updatebot](https://github.com/jenkins-x/updatebot) a command line bot we use to perform Continuous Delivery of libraries, executables, charts and images. i.e. we it generates Pull Requests on downstream dependent git repositories when a new upstream release is done
