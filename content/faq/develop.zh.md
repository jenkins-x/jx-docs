---
title: 开发问题
linktitle: 开发问题
description: 有关如何使用 Kubernetes， Helm 和 Jenkins X 构建云原生应用
date: 2018-02-10
categories: [faq]
menu:
  docs:
    parent: "faq"
keywords: [faqs]
weight: 15
toc: true
aliases: [/faq/]
---

## 如何注入特定的环境配置

Each environment in Jenkins X is defined in a git repository; we use GitOps to manage all changes in each environment such as:

* adding/removing apps
* changing the version of an app (up or down)
* configuring any app with environment specific values

The first two items are defined in the `env/requirements.yaml`  file in the git repository for your environment. the latter is defined in the `env/values.yaml` file.

Helm charts use a [values.yaml file](https://github.com/helm/helm/blob/master/docs/chart_template_guide/values_files.md) so that you can override any configuration inside your Chart to modify settings such as labels or annotations on any resource or configurations of resources (e.g. `replicaCount`) or to pass in things like environment variables into a `Deployment`.

So if you wish to change, say, the `replicaCount` of an app `foo` in `Staging` then find the git repository for the `Staging` environment via [jx get env](/commands/jx_get_environments/) to find the git URL.

Navigate to the `env/values.yaml` file and add/edit a bit of YAML like this:

```yaml
foo:
  replicaCount: 5
```

Submit that change as a Pull Request so it can go through the CI tests and any peer review/approval required; then when its merged it master it will modify the `replicaCount` of the `foo` application (assuming there's a chart called `foo` in the `env/requirements.yaml` file)

You can use vanilla helm to do things like injecting the current namespace if you need that.

To see a more complex example of how you can use a `values.yaml` file to inject into charts, see how we use these files to [configure Jenkins X itself](/getting-started/config/)


## How do I manage secrets in each environment?

We’re using sealed secrets ourselves to manage our production Jenkins X install for all of our CI/CD - so the secrets get encrypted and checked into the git repo of each environment. We use the [helm-secrets](https://github.com/futuresimple/helm-secrets) plugin to do this.

Though a nicer approach would be using a Vault operator which we’re investigating now - which would fetch + populate secrets (and recycle them etc) via Vault.
