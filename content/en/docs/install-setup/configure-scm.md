---
title: Configuring SCMs
linktitle: Configuring SCMs
description: Making Source Code Managers work with Jenkins X
weight: 40
menu:
  docs:
    parent: "Install and Setup"
    title: "Configuring SCMs"
---

Jenkins X works seamlessly with Source Code Management (SCM) systems through *webhooks*, which allows repository events such as a pull request (PR) to trigger the Jenkins X Pipeline execution.

The default webhook handler for Jenkins X is  [Lighthouse](/docs/reference/components/lighthouse/), which manages webhooks similarly to Prow, but is  designed to support a variety of Git providers.


## Configuring Jenkins X for your SCM

Jenkins X has support for github.com for source code management by default. 
To enable support for other providers to work with Jenkins X, configure the `jx-requirements.yml` file according to your preferred SCM provider.

### GitHub Enterprise

[GitHub Enterprise](https://github.com/enterprise) supports the same features as the github.com service but scaled for on-premises deployment on local networks.

To configure support for GitHub Enterprise webhook events in Jenkins X, add `webhook: lighthouse` in the `cluster` section of your `jenkins-x.yml` file. For example:

```sh
cluster:
  provider: gke
  zone: europe-west1-c
  environmentGitOwner: myowner
  gitKind: github
  gitName: ghe
  gitServer: https://my-github.com
webhook: lighthouse
```

In this example, the `cluster` uses Google Kubernetes Engine (GKE) as the provider type and a server `zone` in western Europe. `gitName` is configured as GitHub Enterprise (`ghe`).

### GitLab

[GitLab](https://about.gitlab.com/stages-devops-lifecycle/source-code-management/) features a popular SCM that supports version control, code reviews, and Git-based code branching, changes and merging. 

To configure support for GitLab webhook events in Jenkins X, add `webhook: lighthouse` in the `cluster` section of your `jenkins-x.yml` file. For example:

```sh
cluster:
  provider: gke
  environmentGitOwner: myowner
  gitKind: gitlab
  gitName: gitlab
  gitServer: https://my-gitlab-server.com
webhook: lighthouse
```

In this example, the `cluster` uses Google Kubernetes Engine (GKE) as the provider type. `gitKind` and `gitName` is configured as `gitlab`.

