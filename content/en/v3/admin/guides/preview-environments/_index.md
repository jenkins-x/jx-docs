---
title: Preview Environments
linktitle: Preview Environments
type: docs
description: How to scale Preview Environments in Jenkins X 3
weight: 120
aliases:
  - /v3/guides/preview-environments
---

[Preview environments](/v3/develop/environments/preview/) are temporary environments created automatically by Jenkins X for each Pull Request.

This is very nice, but if you start adding applications to your Jenkins X cluster, and each application repository has a few opened Pull Requests - each with a preview environment including a few dependencies - then you'll quickly get tens of preview environments and a lot more running pods. But these pods are usually only used to run the integration tests in the Pull Request pipelines, or when someone manually visits the preview environment URL. Most of the time, these pods are just idle, waiting and using resources. What if you could easily scale them down when they are idle?

This guide will help you install [Osiris](https://github.com/dailymotion-oss/osiris) in your Jenkins X cluster. Osiris is a Kubernetes component that will inject itself as a proxy in front of your applications, and scale them down when it notices that they are idle for more than a pre-configured period. And if someone wants to access your application, Osiris will receive the request, scale up the application, and forward the request to the application.

Combined with a cluster autoscaler, Osiris will help you scale down/up your cluster nodes automatically based on your workload.

## Installation

Please follow the usual [getting started guide for boot and helm 3](/v3/admin/platform/) first.

The first step is to edit your main `helmfile.yaml` file located in the root directory of your development environment git repository, so that it references the `helmfiles/osiris-system/helmfile.yaml` file, such as:

```yaml
helmfiles:
- path: helmfiles/jx/helmfile.yaml
- path: helmfiles/osiris-system/helmfile.yaml
- path: helmfiles/tekton-pipelines/helmfile.yaml
...
```

The second step is to create the `helmfiles/osiris-system/helmfile.yaml` file, with the following content:

```yaml 
namespace: osiris-system
releases:
- chart: osiris/osiris
```

Commit and push these changes, and after a few minutes you should see a few osiris pods running in the `osiris-system` namespace:

```bash 
$ kubectl get pod -n osiris-system
NAME                                           READY   STATUS    RESTARTS   AGE
osiris-activator-696b8c85f9-99hnn              1/1     Running   0          31m
osiris-endpoints-controller-67f4877645-k4pxv   1/1     Running   0          31m
osiris-endpoints-hijacker-686586df7c-72cmx     1/1     Running   0          31m
osiris-proxy-injector-847f6f46c6-bjjtp         1/1     Running   0          31m
osiris-zeroscaler-5d757dcb98-kl7ts             1/1     Running   0          31m
```

## Usage

Osiris requires specific annotations to be added to your application's Deployment and Service, otherwise, it won't do anything. You can read the [Osiris documentation](https://github.com/dailymotion-oss/osiris) to see which annotations you need to add to your resources.

## Configuration

The configuration is defined in a ["values file" stored in the Jenkins X Version Stream](https://github.com/jenkins-x/jx3-versions/tree/master/charts/osiris/osiris/values.yaml.gotmpl).

If you want to change anything from the default configuration, you can either:
- submit a Pull Request if you believe this change is beneficial for everybody
- or create a new values file in your development environment git repositor: `values/osiris/values.yaml`
