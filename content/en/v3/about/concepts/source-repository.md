---
title: Source Repositories
linktitle: Source Repositories
type: docs
description: Introduction to Jenkins X Source Repositories
weight: 100
aliases:
  - /v3/about/concepts/sourcerepositories
---

Source Control Management (SCM) Repositories which have been configured to run CI/CD pipelines using Jenkins X are represented as Source Repositories.
Source Repositories are a [kubernetes custom resource (CR)](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) scoped to a namespace and created in the development namespace/environment.

A source repository includes information about the SCM provider, Organization, Repository name and clone URLs.

A simple example of a source repository is shown below

```yaml
apiVersion: jenkins.io/v1
kind: SourceRepository
metadata:
  labels:
    gitops.jenkins-x.io/pipeline: namespaces
    owner: jenkins-x
    provider: github
    repository: jx
  name: jenkins-x-jx
  namespace: jx
spec:
  httpCloneURL: https://github.com/jenkins-x/jx.git
  org: jenkins-x
  provider: https://github.com
  providerKind: github
  providerName: github
  repo: jx
  url: https://github.com/jenkins-x/jx
```

This shows a source repository named `jenkins-x-jx` in the namespace `jx`.
It represents a repository named `jx` in the `jenkins-x` organization which is hosted in `github`.

You can view all source repositories in your cluster by running:

```bash
kubectl get sourcerepositories -A
```
