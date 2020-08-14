---
title: Jenkinsfile support
linktitle: Jenkinsfile support
description: How 3.x handles importing Jenkinsfiles
weight: 30
---


When importing a project `jx project import` looks for a `Jenkinfile` in the source code. 

If there is no `Jenkinsfile` then the wizard assumes you wish to proceed with a [Jenkins X Pipeline](https://jenkins-x.io/about/concepts/jenkins-x-pipelines/) based on Tekton and imports it in the usual Jenkins X way. You also get to confirm the kind of build pack and language you wish to use for the automated CI/CD - so its easy to import any workload whether its a library, a binary, a container image, a helm chart or a fully blown microservice for automated kubernetes based CI/CD.

If a `Jenkinsfile` is present  then the wizard assumes you may wish to use a [remote Jenkins server](/docs/v3/guides/jenkins/) or [Jenkinsfile Runner](https://github.com/jenkinsci/jenkinsfile-runner) to run the pipelines, so it presents you with a list of the available Jenkins options to choose from. 

When using a Jenkins Server you get two options:

* use vanilla Jenkins pipelines via `Multi Branch Project` to perform the webhook handling and run the pipelines
* use  [lighthouse](https://github.com/jenkins-x/lighthouse) for webhook handling and ChatOps on Pull Requests. Then when a pipeline is triggered we use the [trigger-pipeline](https://github.com/jenkins-x-labs/trigger-pipeline) as a step to run the pipeline remotely inside a specific Jenkins server (without using the `Multi Branch Project`).

### Supported Integrations

When importing a project these approaches are supported:

* [Jenkins X Pipeline](https://jenkins-x.io/about/concepts/jenkins-x-pipelines/) using Tekton 
* Jenkins pipelines via `Multi Branch Project`
* [lighthouse](https://github.com/jenkins-x/lighthouse) for ChatOps triggering a remote Jenkins pipeline via [trigger-pipeline](https://github.com/jenkins-x-labs/trigger-pipeline) (without using `Multi Branch Project`)
* [Jenkinsfile Runner](https://github.com/jenkinsci/jenkinsfile-runner) based pipelines in Tekton. You can override the container image used for the pipeline on import via the `--jenkinsfilerunner myimage:1.2.3` command line argument 
