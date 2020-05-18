---
title: 使用Jenkins X Boot
linktitle: 使用Jenkins X Boot
description: 通过GitOps和Jenkins X Pipeline安装，配置或升级Jenkins X
categories: [getting started]
keywords: [install]
weight: 10
---



## 概述

_Jenkins X Boot_使用以下方法：

* 根据你的实际情况创建kubernetes集群：
  * 使用Terraform创建您的kubernetes集群+相关的云资源
  * 使用您的云提供商Web控制台创建一个新的kubernetes集群
  * 使用 jx 命令行例如
```
jx create cluster gke --skip-installation
```

  * 使用选择的一些你们团队自定义工具，或者由您的运营团队提供给您的工具

* 安装成功以后，您可以通过以下方式验证是否可以与kubernetes集群正常沟通：
```
kubectl get ns
```

* 运行 [jx boot](/commands/jx_boot/) 命令行:
```
jx boot
```

程序会提示您安装所需的其他参数，例如您的管理员用户/密码，Pipeline所在git用户和令牌等。

最后Jenkins X会在kubernetes集群上安装并设置完。

### 关于 'jx boot'

[jx boot](/commands/jx_boot/) 使用本地`jx`命令行的可执行文件来解析boot pipeline流水线定义，接着通过在kubernetes中的Tekton运行这个流水线来安装启动Jenkins X。 如果Jenkin X安装后了出了问题，您可以随时再次执行`jx boot`来恢复运行状态（例如，如果有人不小心删除了您的集群）。


#### 安装前后验证方法

在尝试进行任何安装之前，jx 会运行[jx step verify preinstall](/commands/jx_step_verify_preinstall/)命令以检查一切是否正常。 如果您使用的是Terraform（您的“jx-requirements.yml”文件会有“terraform：true”），如果这个时候Terraform没有创建所需的云资源的情况下， jx 安装将会失败。

安装完成后，将运行[jx step verify install](/commands/jx_step_verify_install/) 命令以验证您的安装成功.

## 更改已有安装

您可以随时重新运行 [jx boot](/commands/jx_boot/) 以更改已有的应用配置.  

因此，只需编辑所需配置中的任何内容，然后重新运行 [jx boot](/commands/jx_boot/) -就可以添加或删除Apps，更改参数或配置，升级或降级依赖项的版本号。

## 需求

有一个名为[jx-requirements.yml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/jx-requirements.yml) 的文件，用于指定安装逻辑要求，如：

* 使用什么kubernetes服务提供商
* 是否将机密存储在本地文件系统或保管库中
* 如果您正在使用Terraform来管理您的云资源
* 如果您希望使用kaniko进行容器映像构建

这是`jx boot`的主要配置文件，您可以在其中进行大部分更改。 您可能需要查看[jx-requirements.yml]（https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/jx-requirements.yml）文件并进行任何需要更改。

## Secrets

Boot 当前支持以下用于管理敏感信息Secrets的选项:

### 本地存储

本地存储时默认设置，也可以通过以下方式改变存储配置 `secretStorage: local`:

```yaml
cluster:
  provider: gke
environments:
- key: dev
- key: staging
- key: production
kaniko: true
secretStorage: local
webhook: prow
```

如果Secrets启用后是加载/保存到文件夹中 `~/.jx/localSecrets/$clusterName`的话， 你可以通过 `$JX_HOME` 来改变 `~/.jx`的路径.

### Vault

使用我们推荐的GKE或EKS提供的Kubernetes服务时，可以通过以下方式配置 `secretStorage: vault`:

```yaml
cluster:
  provider: gke
environments:
- key: dev
- key: staging
- key: production
kaniko: true
secretStorage: vault
webhook: prow
```

这种配置会让 `jx boot` 的流水线使用KMS和云存储安装的Vault来加载/保存机密。

Vault的最大优势在于同一个团队的人可以轻松地在同一群集上运行 `jx boot`。即使某人不小心删除了kubernetes集群，团队中其他人也很容易从KMS+云存储中还原之前的安装。

## Webhook

Jenkins X 支持许多用于处理Webhook的引擎，还可以选择支持[ChatOps](/docs/resources/guides/using-jx/faq/chatops/).

[Prow](/docs/reference/components/prow/) 和 [Lighthouse](/architecture/lighthouse/) 可以支持webhooks的方式和 [ChatOps](/docs/resources/guides/using-jx/faq/chatops/)。 但是Jenkins只能支持 webhooks.

### Prow

当用户选择 [Serverless Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) 的安装方式，安装后Jenkins X服务会使用 [Tekton](https://tekton.dev/)的流水线引擎和GitHub的git服务。 [Prow](/docs/reference/components/prow/) 是默认的webhook和[ChatOps](/docs/resources/guides/using-jx/faq/chatops/)的引擎。 
 
它的配置方式在 `jx-requirements.yml` 里 `webhook: prow` 

```yaml
cluster:
  provider: gke
environments:
- key: dev
- key: staging
- key: production
kaniko: true
storage:
  logs:
    enabled: false
  reports:
    enabled: false
  repository:
    enabled: false
webhook: prow
```

### Lighthouse

 当用户选择 [Serverless Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) 和 [Tekton](https://tekton.dev/) 的安装方式，但是没有采用 github的服务而是其他git服务的时候， [Lighthouse](/architecture/lighthouse/) 变成了默认的webhook和[ChatOps](/docs/resources/guides/using-jx/faq/chatops/)引擎。现在Prow的开源软件只支持github的Git服务。

以后如果Lighthouse开源软件经过了充分的测试后更加稳定，我们会将它设为默认 [Serverless Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/)。

Its configured via the `webhook: lighthouse` in `jx-requirements.yml`

```yaml
cluster:
  provider: gke
environments:
- key: dev
- key: staging
- key: production
kaniko: true
storage:
  logs:
    enabled: false
  reports:
    enabled: false
  repository:
    enabled: false
webhook: lighthouse
```

### Jenkins

要使用Jenkins服务器来处理Webhook和pipeline，请改动`jx-requirements.yml`中的`webhook: jenkins`。

## Git

Jenkins X支持许多不同的git服务。 您可以在[jx-requirements.yml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/jx-requirements.yml) 文件里为每个环境指定相应的git服务供应商及git定义的组织 - organization。

### GitHub

如果您没做任何改动，这些是默认设置。


```yaml
cluster:
  environmentGitOwner: myorg
  provider: gke
environments:
- key: dev
- key: staging
- key: production
kaniko: true
storage:
  logs:
    enabled: false
  reports:
    enabled: false
  repository:
    enabled: false
webhook: prow
```

### GitHub Enterprise

配置与上面类似，但是您需要指定 `gitServer` 的URL (如果您用的git服务不是https://github.com) 和 `gitKind: github`

```yaml   
cluster:
  provider: gke
  environmentGitOwner: myorg
  gitKind: github
  gitName: ghe
  gitServer: https://github.myserver.com
environments:
  - key: dev
  - key: staging
  - key: production
kaniko: true
secretStorage: local
storage:
  logs:
    enabled: true
    url: "gs://jx-logs"
  reports:
    enabled: true
    url: "gs://jx-logs"
  repository:
    enabled: true
    url: "gs://jx-logs"
webhook: lighthouse
```

### Bitbucket Server

您要指定 `gitServer` 和 `gitKind: bitbucketserver`. 如果您安装的是 [Serverless Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) 和 [Tekton](https://tekton.dev/)， 您需要通过指定 `webhook: lighthouse` 来使用[lighthouse webhook](#webhook)。   

```yaml   
cluster:
  provider: gke
  environmentGitOwner: myorg
  gitKind: bitbucketserver
  gitName: bs
  gitServer: https://bitbucket.myserver.com
environments:
  - key: dev
  - key: staging
  - key: production
kaniko: true
secretStorage: local
storage:
  logs:
    enabled: true
    url: "gs://jx-logs"
  reports:
    enabled: true
    url: "gs://jx-logs"
  repository:
    enabled: true
    url: "gs://jx-logs"
webhook: lighthouse
```

### Bitbucket Cloud

您要指定 `gitKind: bitbucketcloud`. 如果您安装的是 [Serverless Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) 和 [Tekton](https://tekton.dev/)， 您需要通过指定 `webhook: lighthouse` 来使用[lighthouse webhook](#webhook)。

```yaml   
cluster:
  provider: gke
  environmentGitOwner: myorg
  gitKind: bitbucketcloud
  gitName: bc
environments:
  - key: dev
  - key: staging
  - key: production
kaniko: true
secretStorage: local
storage:
  logs:
    enabled: true
    url: "gs://jx-logs"
  reports:
    enabled: true
    url: "gs://jx-logs"
  repository:
    enabled: true
    url: "gs://jx-logs"
webhook: lighthouse
```


### Gitlab

您要指定 `gitServer` 的URL 和 `gitKind: gitlab`. 如果您安装的是 [Serverless Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) 和 [Tekton](https://tekton.dev/)， 您需要通过指定 `webhook: lighthouse` 来使用[lighthouse webhook](#webhook)。

```yaml   
cluster:
  provider: gke
  environmentGitOwner: myorg
  gitKind: gitlab
  gitName: gl
  gitServer: https://gitlab.com
environments:
  - key: dev
  - key: staging
  - key: production
kaniko: true
secretStorage: local
storage:
  logs:
    enabled: true
    url: "gs://jx-logs"
  reports:
    enabled: true
    url: "gs://jx-logs"
  repository:
    enabled: true
    url: "gs://jx-logs"
webhook: lighthouse
```

## Storage

文件 [jx-requirements.yml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/jx-requirements.yml)  可以配置您是否要对日志和报告使用长期存储，和选择用于存储数据的云存储。

下面这个 `jx-requirements.yml` 文件是使用长期存储的例子:

```yaml
cluster:
  provider: gke
environments:
- key: dev
- key: staging
- key: production
kaniko: true
storage:
  logs:
    enabled: true
  reports:
    enabled: false
  repository:
    enabled: false
```


您还可以在`storage`部分中指定存储分区的URL。支持以下URL语法：

* `gs://anotherBucket/mydir/something.txt` : 使用谷歌云的GCS bucket
* `s3://nameOfBucket/mydir/something.txt` : 使用亚马逊AWS的 S3 bucket
* `azblob://thatBucket/mydir/something.txt` : 使用微软的Azure bucket
* `http://foo/bar` : 不使用HTTPS方式存储在git中的文件
* `https://foo/bar` : 使用HTTPS方式存储在git中的文件

e.g.

```yaml
cluster:
  provider: gke
environments:
- key: dev
- key: staging
- key: production
kaniko: true
storage:
  logs:
    enabled: false
    url: gs://my-logs
  reports:
    enabled: false
    url: gs://my-logs
  repository:
    enabled: false
    url: gs://my-repo
```

For more details see the [Storage Guide](/docs/guides/managing-jx/common-tasks/storage/).

## Ingress

如果您采用[jx-requirements.yml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/jx-requirements.yml) 默认设置， jx boot 会使用HTTP 而不是 HTTPS，同时也会使用 [nip.io](https://nip.io/) 作为DNS机制。

在默认情况下运行boot后， `jx-requirements.yml` 配置如下：  

```yaml
cluster:
  provider: gke
  clusterName: my-cluster-name
  environmentGitOwner: my-git-org
  project: my-gke-project
  zone: europe-west1-d
environments:
- key: dev
- key: staging
- key: production
ingress:
  domain: 1.2.3.4.nip.io
  externalDNS: false
  tls:
    email: ""
    enabled: false
    production: false
kaniko: true
secretStorage: local
storage:
  logs:
    enabled: false
  reports:
    enabled: false
  repository:
    enabled: false
webhook: prow
```

如果您希望启用外部DNS（为所有导出的服务自动注册DNS名称）使用DNS域名或者TLS，请修改您的 `ingress` 部分，可以在`jx-requirements.yml`文件中添加 `ingress.domain` 和 `ingress.externalDNS = true` ，然后重新运行`jx boot`。  

您也可以通过`ingress.tls.enabled = true`更新配置以启用TLS。下面有一个完整的示例。

```yaml
cluster:
  clusterName: mycluster
  environmentGitOwner: myorg
  gitKind: github
  gitName: github
  gitServer: https://github.com
  namespace: jx
  provider: gke
  vaultName: jx-vault-myname
environments:
- key: dev
- key: staging
- key: production
gitops: true
ingress:
  domain: my.domain.com
  externalDNS: true
  namespaceSubDomain: -jx.
  tls:
    email: someone@acme.com
    enabled: true
    production: true
kaniko: true
secretStorage: vault
storage:
  logs:
    enabled: true
    url: gs://jx-prod-logs
  reports:
    enabled: false
    url: ""
  repository:
    enabled: false
    url: ""
webhook: prow
```
