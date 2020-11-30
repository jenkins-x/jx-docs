---
title: Configure Webhooks
linktitle: Configure Webhooks
description: Configure Webhooks
weight: 70
deprecated: true
aliases:
  - /docs/install-setup/installing/boot/ingress/
  - /docs/install-setup/installing/boot/webhooks/
---

## Webhook

Jenkins X supports a number of engines for handling webhooks and optionally supporting [ChatOps](/docs/resources/faq/using/chatops/).

[Prow](/docs/reference/components/prow/) and [Lighthouse](/architecture/lighthouse/) support webhooks and [ChatOps](/docs/resources/faq/using/chatops/) whereas Jenkins just supports webhooks.

### Prow

[Prow](/docs/reference/components/prow/) is currently the default webhook and [ChatOps](/docs/resources/faq/using/chatops/) engine when using [Serverless Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) with [Tekton](https://tekton.dev/) and GitHub.

It's configured via the `webhook: prow` in `jx-requirements.yml`

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

[Lighthouse](/architecture/lighthouse/) is currently the default webhook and [ChatOps](/docs/resources/faq/using/chatops/) engine when using [Serverless Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) with [Tekton](https://tekton.dev/) and a git server other than https://github.com.

Once Lighthouse is more stable and well tested we'll make it the default for all installations using [Serverless Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/).

It's configured via the `webhook: lighthouse` in `jx-requirements.yml`

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

To use a Jenkins server in boot for processing webhooks and pipelines configure it via `webhook: jenkins` in `jx-requirements.yml`
