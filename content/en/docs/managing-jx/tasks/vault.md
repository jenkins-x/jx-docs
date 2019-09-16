---
title: Vault
linktitle: Vault
description: Manage your secrets
date: 2019-01-08
publishdate: 2019-01-08
lastmod: 2019-01-08
weight: 200
---

[Vault](https://www.vaultproject.io) is an open source project for securely managing secrets and is our preferred way to manage secrets across your environments in Jenkins X.

## Using Vault with boot

We have integrated [Vault](https://www.vaultproject.io) into [jx boot](/docs/reference/boot/). 

To switch to `vault` you need to add `secretStorage: vault` in your `jx-requirements.yml` file:

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

Once you have modified your `jx-requirements.yml` file you just need to run `jx boot`.

For more details see [configuring secrets with boot](/docs/reference/boot/#secrets). 

## Using Vault on the CLI

First you need to download an install the [safe](https://github.com/starkandwayne/safe) CLI for Vault.

Once you have installed [safe](https://github.com/starkandwayne/safe) you can run:

``` 
eval `jx get vault-config`
```

you should now be able to use the [safe](https://github.com/starkandwayne/safe) CLI to  access your vault.

You can then get a secret via:


``` 
safe get /secret/my-cluster-name/creds/my-secret
``` 

or you can update a secret via:

``` 
safe set /secret/my-cluster-name/creds/my-secret username=myname password=mytoken
``` 