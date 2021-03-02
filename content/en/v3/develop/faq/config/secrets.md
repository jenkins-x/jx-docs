---
title: Secrets
linktitle: Secrets
type: docs
description: Questions on secrets and external secrets
weight: 200
---

## How do I add a new Secret?
 
 See [how to add a new Secret](/v3/admin/setup/secrets/#create-a-new-secret)

## How do I change the secret poll period in kubernetes external secrets?

Your cloud provider could charge per read of a secret and so a frequent poll of your secrets could cost $$$. You may want to tone down the poll period.

You can do this via the `POLLER_INTERVAL_MILLISECONDS` setting in the [kubernetes external secrets configuration](https://github.com/external-secrets/kubernetes-external-secrets/tree/master/charts/kubernetes-external-secrets#configuration)

For more details [see how to configure charts](https://jenkins-x.io/v3/develop/apps/#customising-charts)

## How do I switch to GSM from Vault?

We recommend you use [cloud secret managers over vault](/v3/devops/cloud-native/#prefer-cloud-over-kubernetes) as its easier to manage; let your cloud provider do the undifferentiated heavy lifting for you.

If you spin up a cluster on vault and want to switch over to, say, GSM here's how:

* set the `gsm` variable to true in terraform as [described in the getting started guide](https://github.com/jx3-gitops-repositories/jx3-terraform-gke/blob/master/README.md#getting-started) using your terraform/infrastructure git repository:
                     
``` bash
echo "gsm = true" >> values.auto.tfvars 

git add *
git commit -a -m "fix: enable gsm"

terraform plan
terraform apply
```

* in your dev cluster git repository (which has a `helmfile.yaml` inside) modify the `jx-requirement.yml` switch the `secretStorage` line to:

```yaml 
  secretStorage: gsm
```
                         
* download [kpt](https://github.com/GoogleContainerTools/kpt/releases) and add it to your $PATH

* run the following to replace your vault secret mapping files with gsm versions:

```bash 
rm -rf .jx/secret/mapping

kpt pkg get https://github.com/jenkins-x/jx3-gitops-template.git/.jx/secret/gsm/mapping .jx/secret/mapping
ls -al .jx/secret/mapping

# echo we should see secret-mappings.yaml
git add .jx/secret
git commit -a -m "fix: migrate to gsm secret mapping"

# now lets push and watch the git operator
git push
jx admin log -w
```
        

