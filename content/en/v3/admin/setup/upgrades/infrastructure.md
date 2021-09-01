---
title: Infrastructure
linktitle: Infrastructure
type: docs
description: Upgrade the Jenkins X Cloud infrastructure
weight: 30
aliases:
  - /v3/guides/upgrades/infrastructure
---

## Infrastructure

If you have used one of the Jenkins X Terraform Git repositories to create and manage your cloud resources then you have two options.

### Terraform manual apply

If you are running the Terraform apply commands yourself then from your infrastructure Git repository run:

```
export TF_VAR_jx_bot_username=[your bot username]
export TF_VAR_jx_bot_token=[your bot token]
terraform get -update
terraform plan
terraform apply
```

### Terraform Cloud

If you are using [Terraform Cloud](https://www.terraform.io/) then from your infrastructure Git repository run:

```
terraform get -update
git commit -a -m 'chore: upgrade cloud infra'
git push
```

Terraform Cloud should trigger automatically and apply the updates, view the log in Terraform Cloud.
