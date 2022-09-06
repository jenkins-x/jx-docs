---
title: Environments
linktitle: Environments
type: docs
description: Introduction to Jenkins X Environments
weight: 200
aliases:
  - /v3/about/concepts/environments
---

Environment is a [kubernetes custom resource (CR)](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) in Jenkins X where the application code lives.
Examples of environment include development, testing, staging and production.
Environments are scoped to kubernetes namespaces and essentially extend a namespace with additional Jenkins X related metadata.

After installing Jenkins X, a development environment is created.
This is the environment where all Jenkins X related resources like lighthouse, build controller, nexus, chart museum are installed.
Dev environment by default is in the `jx` namespace, but it is configurable.
This is also the environment where all your pipelines will run.

Other environments like staging and production can be in the same cluster as the development environment or in remote clusters.

Environments can be of different types:

- Permanent
- Preview
- Test
- Edit
- Development

Applications can be promoted to environments by using any of the three stratergies:

- Manual
- Auto
- Never

An example of an environment is as follows (some fields are removed for simplicity):

```yaml
apiVersion: jenkins.io/v1
kind: Environment
metadata:
  labels:
    env: dev
  name: dev
  namespace: jx
spec:
  kind: Development
  label: Development
  namespace: jx
  promotionStrategy: Never
  source:
    ref: master
    url: https://github.com/jenkins-x/jx3-eks-vault.git
  webHookEngine: Lighthouse
```

This is an environment of type `Development` that is located in the namespace `jx`.
It has promotion strategy set to `never` to not allow your application specific code to be deployed in this development namespace.

You can view all environments in your cluster by running:

```bash
kubectl get environments -A
```
