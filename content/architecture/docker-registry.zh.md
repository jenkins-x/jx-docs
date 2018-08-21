---
title: Docker Registry
linktitle: Docker Registry
description: 配置你的 docker registry 
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
menu:
  docs:
    parent: "architecture"
    weight: 100
weight: 100
sections_weight: 100
draft: false
toc: true
---

为了能够创建和发布 docker 镜像，我们需要使用 Docker Registry。

默认，Jenkins X 会在系统命名空间中带一个 Docker Registry，以及 Jenkins 和 Nexus。当 Docker Registry 运行在你的 Kubernetes 集群中，它会在集群内部使用，它很难通过带有自签名证书的 HTTPS 暴露 —— 因此，在你的 Kubernetes 集群服务中，我们默认使用 insecure 的 Docker Registry。

## 使用不同的 Docker Registry

如果你使用公有云的话，可能希望利用你的云服务商的 Docker Registry；或者复用你已有的 Docker Registry。

为了指定 Docker Registry 的主机、端口，你可以使用 Jenkins 控制台：

```
jx console
``` 

然后，定位到 `管理 Jenkins -> 系统配置`，并修改环境变量 `DOCKER_REGISTRY` 指向你选择的 Docker Registry。

另一种方法是，把下面的内容添加到你的自定义 Jenkins X 平台 helm charts 的`values.yaml` 文件中：

```yaml 
jenkins:
  Servers:
    Global:
      EnvVars:
        DOCKER_REGISTRY: "gcr.io"
```

## 更新 config.json

下一步，你需要为 docker 更新 `config.json` 中的认证。

如果为你的 Docker Registry 创建一个 `config.json` 文件，例如：Google 云的 GC，它可能看起来像：

```json
{
    "credHelpers": {
        "gcr.io": "gcloud",
        "us.gcr.io": "gcloud",
        "eu.gcr.io": "gcloud",
        "asia.gcr.io": "gcloud",
        "staging-k8s.gcr.io": "gcloud"
    }
}
```

对于 AWS 则像：

```json
{
	"credsStore": "ecr-login"
}
```

Then to update the `jenkins-docker-cfg` secret you can do:

```
kubectl delete secret jenkins-docker-cfg
kubectl create secret generic jenkins-docker-cfg --from-file=./config.json
```   

## Using Docker Hub

If you want to publish images to docker hub then you need to modify your `config.json` as described above to something like:

```json 
{
    "auths": {
        "https://index.docker.io/v1/": {
            "auth": "MyDockerHubToken",
            "email": "myemail@acme.com"
        }
    }
}
``` 

### Mount a Secret for your registry

Your docker registry will require a Secret to be mounted into the [Pod Templates](/architecture/pod-templates/).

