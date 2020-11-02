---
title: Overview
linktitle: Overview
description: Overview of the architecture, concepts and motivations for Jenkins X 3.x
weight: 50
---
 
Jenkins X 3.x creates clearer separation of concerns between conceptual areas and releasable components.
 
<iframe style="border:none" width="800" height="450" src="https://whimsical.com/embed/SnJBgXG6jz9pqQewiDTNRt@2Ux7TurymNDXVRa4FpLk"></iframe>
 
__NOTE__ The diagram shows intent, as Jenkins X 3 is still in __alpha__ not all integrations are complete.
 
## Microservices 

Jenkins X uses the following microservices by namespace.

Note that if you have a working Jenkins X installation you can browse all the actual kubernetes resources used across each namespace via the `config-root/namespaces/$namespace/$chartName` folder in your cluster git repository.


### `jx-git-operator`

Contains the [git operator](/docs/v3/about/how-it-works/#git-operator) from [jenkins-x/git-operator](https://github.com/jenkins-x/jx-git-operator) microservice and the associated [boot jobs](/docs/v3/about/how-it-works/#boot-job).

### `jx` 

Contains the main development services of Jenkins X:

* **jx-build-controller** watches for `PipelineRun` resources and creates/updates the associated `PipelineActivity` resources used by `jx get build log`, [octant](/docs/v3/develop/ui/#octant) and the [pipelines visualizer](/docs/v3/develop/ui/#pipeline-visualizer) 
* **jx-pipelines-visualizer** visualises `PipelineActivity` resources and the associated build logs in a read only UI
* **jx-preview-gc-jobs** periodically garbage collects `Preview` resources and their associated preview environments created by [jx preview](https://github.com/jenkins-x/jx-preview)
* **jxboot-helmfile-resources-gcactivities** periodically garbage collects old and completed `PipelineActivity` resources
* **jxboot-helmfile-resources-gcpods** periodically garbage collects completed `Pods`
* **jx-kh-check** supports additional [kuberhealthy](https://github.com/Comcast/kuberhealthy) based [health checks](/docs/v3/guides/health/) for Jenkins X specific resources

[jenkins-x/lighthouse](https://github.com/jenkins-x/lighthouse) creates [tekton pipelines](https://tekton.dev/) and triggers [ChatOps](/docs/resources/faq/using/chatops/) on Pull Requests. Its made up of the following components:

* **lighthouse-webhooks** converts webhooks from your git provider into `LighthouseJob` custom resources
* **lighthouse-tekton-controller** converts `LighthouseJob` custom resources into [tekton](https://tekton.dev/) `PipelineRun` resources (the [tekton controller](https://tekton.dev/) converts `PipelineRun` resources into kubernetes `Pods`
* **lighthouse-foghorn** watches the execution of `PipelineRun` resources triggered by lighthouse and updates the pipeline status in git so that you see pipelines start, complete or fail on your git provider along with having links the [pipelines visualizer](/docs/v3/develop/ui/#pipeline-visualizer) on each context on a Pull Request
* **lighthouse-keeper** looks for open Pull Requests with green pipelines and the necessary **approve** labels to be able to auto merge
* **lighthouse-gc-jobs** periodically garbage collects `LighthouseJob` resources and their associated resources (e.g. `PipelineRun` and `Pods`

the following are optional extras:

* [bucket repository](https://github.com/jenkins-x/bucketrepo) a lightweight cloud native artifact, chart repository and maven proxy that can be configured to use cloud storage. It's a lightweight cloud native alternative to [nexus](https://www.sonatype.com/nexus/repository-oss)
* [chart museum](https://github.com/helm/chartmuseum) an optional chart repository
* [nexus](https://www.sonatype.com/nexus/repository-oss) if used as an artifact repository and maven proxy


### `kuberhealthy`

Contains the [kuberhealthy](https://github.com/Comcast/kuberhealthy) service to support [health and improve observability](/docs/v3/guides/health/) which used by [jx health](https://github.com/jenkins-x-plugins/jx-health)

### `nginx`

Contains the [nginx-ingress](https://github.com/helm/charts/tree/master/stable/nginx-ingress) provider if enabled

### `secret-infra` 

* **kubernetes-external-secrets** contains the [godaddy/kubernetes-external-secrets](https://github.com/godaddy/kubernetes-external-secrets) service for handling `ExternalSecrets`. See [how we use secrets](/docs/v3/guides/secrets/))
* **pusher-wave** contains the [pusher/wave](https://github.com/pusher/wave) service for performing a rolling upgrade of any microservice which consumes `Secret` resources from either vault or a cloud providers secret store and the secrets change in the underlying store 

the following are optional extras if not using your cloud providers native secret manager:

* **vault-operator** contains the [vault operator](https://banzaicloud.com/docs/bank-vaults/operator/) which converts `Vault` resources into instances of [HashiCorp Vault](https://www.vaultproject.io/)
* **vault-instance** contains the [vault instance](https://github.com/jenkins-x-charts/vault-instance) which creates the default `Vault` resource

### `tekton-pipelines`

Contains the [tekton pipelines](https://tekton.dev/) controllers
 
