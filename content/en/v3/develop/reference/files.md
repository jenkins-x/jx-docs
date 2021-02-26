---
title: Files
linktitle: Files
type: docs
description: File names and formats when using GitOps
weight: 200
---

Jenkins X uses [GitOps](/v3/devops/gitops/) and so has a number of different source files with declarative schemas. 

You may also find the [git layout document](https://github.com/jenkins-x/jx-gitops/blob/master/docs/git_layout.md) useful. 
                     
## Files in any repository

| File | Schema | Description |
| --- | ---| --- |
| `.jx/settings.yaml` | [Settings](https://github.com/jenkins-x/jx-api/blob/master/docs/config.md#settings) | Optional file to override any settings from the development cluster git repository; such as the chart repository, container registry or environments to promote to. Usually the [Requirements](https://github.com/jenkins-x/jx-api/blob/master/docs/config.md#requirements) in the dev cluster git repository are used. |
| `.jx/updatebot.yaml` | [Updatebot](https://github.com/jenkins-x-plugins/jx-updatebot/blob/master/docs/config.md#updatebot.jenkins-x.io/v1alpha1.UpdateConfig) | Describes the settings when using the [jx updatebot](https://github.com/jenkins-x-plugins/jx-updatebot) plugin to promote versions of a repository to different git repositories using different strategies |
| `.lighthouse/*/triggers.yaml` | [TriggerConfig](/v3/develop/reference/pipelines/#lighthouse) | Defines the pipeline triggers in [lighthouse](https://github.com/jenkins-x/lighthouse) which start tekton pipelines in response to git or ChatOps activity |
| `.lighthouse/*/*.yaml`  | [PipelineRun](https://tekton.dev/docs/pipelines/pipelineruns/#configuring-a-pipelinerun) | Tekton pipelines to define pull request pipelines (or `presubmits`) and release pipelines (`postsubmits`). For more detail check out the [pipeline reference](/v3/develop/pipelines/reference) |
| `charts` | [helm chart](https://helm.sh/) | Defines the kubernetes resources to be installed in a kubernetes cluster |
| `Dockerfile` | [Dockerfile](https://docs.docker.com/engine/reference/builder/) | Defines how to create a container image for repositories that create images |
| `OWNERS` | [OWNERS](https://github.com/jenkins-x/lighthouse/tree/master/pkg/plugins/approve/approvers#overview) | this [lighthouse](https://github.com/jenkins-x/lighthouse) configuration file defines who can review and approve files |
| `OWNERS_ALIASES` | [OWNERS_ALIASES](https://github.com/jenkins-x/lighthouse/tree/master/pkg/plugins/approve/approvers#overview) | this [lighthouse](https://github.com/jenkins-x/lighthouse) configuration file defines aliases for who can review and approve files |
| `preview/helmfile.yaml` | [helmfile](https://github.com/roboll/helmfile#configuration) | The [helmfile](https://github.com/roboll/helmfile) defines the helm charts, version and value mappings to be installed in a preview environment |


## Files in a dev cluster repository

The following files are only used in a development cluster git repository


| File | Schema | Description |
| --- | ---| --- |
| `.jx/gitops/source-config.yaml` | [SourceConfig](https://github.com/jenkins-x/jx-gitops/blob/master/docs/config.md#gitops.jenkins-x.io/v1alpha1.SourceConfig)| Defines the git owners (organisations/users) and repositories which are imported into Jenkins X and so have webhooks and [lighthouse](https://github.com/jenkins-x/lighthouse) [triggers](/v3/develop/reference/pipelines/#lighthouse) defined. Also supports [slack](/v3/develop/ui/slack/) and [jenkins](/v3/develop/create-project/jenkinsfile/) configuration  |
| `.jx/gitops/kpt-strategy.yaml` | [KptStrategies](https://github.com/jenkins-x/jx-gitops/blob/master/docs/config.md#gitops.jenkins-x.io/v1alpha1.KptStrategies) | Lets you define what kind of [kpt](https://googlecontainertools.github.io/kpt/) upgrade strategy you wish to you for different folders. See [upgrade cluster](/v3/admin/setup/upgrades/cluster/) |
| `.jx/secret/mapping/secret-mappings.yaml` | [SecretMapping](https://github.com/jenkins-x/jx-gitops/blob/master/docs/config.md#gitops.jenkins-x.io/v1alpha1.SecretMapping) | Defines the generic mapping of `Secrets` to `ExternalSecrets`. For more detail see [how we use ExternalSecrets](/v3/admin/setup/secrets/) |
| `config-root` | Kubernetes | Defines the kubernetes resources and custom resource definitions generated from the [helmfile](https://github.com/roboll/helmfile#configuration) | The [helmfile](https://github.com/roboll/helmfile) files.
| `docs/README.md` | | A markdown report of all the helm charts and versions installed in each namespace in your cluster. Its generated from the `**/helmfile.yaml` files during the [boot Job](/v3/about/how-it-works/#boot-job) via the [jx gitops helmfile report](https://github.com/jenkins-x/jx-gitops/blob/master/docs/cmd/jx-gitops_helmfile_report.md) command |
| `extensions/pipeline-catalog.yaml` | [PipelineCatalog](https://github.com/jenkins-x/jx-gitops/blob/master/docs/config.md#gitops.jenkins-x.io/v1alpha1.PipelineCatalog) | Defines the pipeline catalog or catalogs to use to define the shared pipelines for your repositories |
| `extensions/quickstarts.yaml` | [Quickstarts](https://github.com/jenkins-x/jx-gitops/blob/master/docs/config.md#gitops.jenkins-x.io/v1alpha1.Quickstarts) | Defines the quickstarts used by your team when [creating a quickstart project](/v3/develop/create-project/) |
| `jx-requirements.yml` | [Requirements](https://github.com/jenkins-x/jx-api/blob/master/docs/config.md#requirements) | The kubernetes cluster and infrastructure requirements such as kubernetes provider kind, chart repository, container registry and environments |
| `helmfiles/ns/helmfile.yaml` | [helmfile](https://github.com/roboll/helmfile#configuration) | The [helmfile](https://github.com/roboll/helmfile) defines the helm charts, version and value mappings to be installed in a namespace in a cluster. We use a folder inside `helmfiles` for each namespace so its easy to keep namespaces separate in git |
| `versionStream` | | The shared version stream which contains chart, image and git versions and default configuration files |

