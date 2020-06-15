---
title: Secrets
linktitle: Secrets
description: Configure secret management - local vs Vault
keywords: [vault]
weight: 30
---

## Secrets

Boot currently supports the following options for managing secrets:

This configuration will cause `jx boot`'s pipeline to install a Vault using KMS and a cloud storage bucket to load/save secrets.

The big advantage of Vault is it means a team of folks can then easily run `jx boot` on the same cluster. Even if you accidentally delete your Kubernetes cluster, it's easy to restore from the KMS + cloud bucket.

### Local Storage

This is the default or can be explicitly configured via `secretStorage: local`:

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

If enabled secrets are loaded/saved into the folder `~/.jx/localSecrets/$clusterName`.
You can use `$JX_HOME` to change the location of `~/.jx`.

### Vault

This is the recommended approach when using GKE or EKS providers. It can be explicitly configured via `secretStorage: vault`:

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
