---
title: Vault
linktitle: Vault
type: docs
description: Questions on vault
weight: 210
---

## After an upgrade the boot job is waiting for vault in jx-vault

In the alpha we used to install vault via the `helmfile/secret-infra/helmfile.yaml` file and install vault into the `secret-infra` namespace.

A production installation of vault requires cloud resources such as a key ring, crypto key and bucket.

So to make it easier to manage vault properly with cloud resources and to simplify the operation of Jenkins X (so that the secret store can be used on an empty cluster before we boot anything in the boot process) we have moved the installation of vault into terraform. (e.g for [GKE](https://github.com/jenkins-x/terraform-google-jx/blob/master/modules/jx-boot/vault.tf))

So ideally you would re-apply your terraform using the latest terraform modules so that you get the new vault setup in the `jx-vault` namespace.

A workaround if you wish to keep using your vault in your `secret-infra` namespace is to modify the first few lines starting with `VAULT` of the file: `versionStream/Makefile.mk` as follows:

```makefile
VAULT_ADDR ?= https://vault.secret-infra:8200
VAULT_NAMESPACE ?= secret-infra
VAULT_ROLE ?= secret-infra
```
