---
title: Version Stream Manual Migrations
linktitle: Version Stream Manual Migrations
type: docs
description: Upgrading the jx cli
weight: 590
aliases:
- /v3/guides/upgrades/changelog
---

## Version Stream Manual Migrations

The sections below document manual migration steps required that occur from time to time where an automated upgrade is
not possible or practical

### v0.0.969

NB: These steps are only relevant if you are using Hashicorp Vault as secret storage within `jx`. Ignore for all other secret stores

v0.0.969 introduced a change to remove Hashicorp Vault from `jx` control and become an explicit cluster dependency
installed either via Terraform (for cloud environments) or Helm (for on-premises). The reasoning behind this is to reduce
cyclic complexity within `jx` where the platform requires secrets and the `jx` platform is also responsible for provisioning
where to store these secrets.

#### Migration steps

1. First delete all your external-secrets and secrets within your cluster to temporarily stop External Secrets trying to synchronise
   these by running the following
   
```shell
kubectl get es -n jx --no-headers=true | awk '/./{print $1}' | tee >(xargs kubectl delete -n jx es) >(xargs kubectl delete -n jx secret)
```

2. If using Terraform then upgrade your infrastructure using the latest jx terraform module for your provider
From your Terraform repo,
```shell
rm -rf .terraform
terraform init
terraform apply
```

3. Alternatively if not using Terraform, simply install the following charts in the `jx-vault` namespace,

```shell
helm repo add jx3 https://jenkins-x-charts.github.io/repo
helm repo add banzaicloud-stable https://kubernetes-charts.banzaicloud.com
helm repo update
helm install vault-operator banzaicloud-stable/vault-operator --version 1.10.0 -n jx-vault 
helm install vault-instance jx3/vault-instance --version 1.0.20 -n jx-vault 
```

4. If you wish to migrate secrets from your existing (soon to be decommissioned) Vault then now is the time to do that by
connecting to the new Vault instance in `jx-vault` and putting secrets you want to maintain there

5. Run the `jx gitops upgrade` process and commit the files to git and push to trigger the boot job. (Don't worry if
you've already done this step previously - in which case just re-trigger a boot job with a dummy commit).
   This boot job will populate any missing secrets in Vault within the `jx secret populate` step
   
6. After the boot job completes confirm the presence of synchronised External Secrets by running
```shell
kubectl get es -n jx
```

7. Once you're happy with your new Vault installation you can tidy up the older vault in `secret-infra` by removing
the vault-instance and vault-operator from your helmfile located in `helmfiles/secret-infra/helmfile.yaml` and
   running a boot job
