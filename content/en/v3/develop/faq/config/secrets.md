---
title: Secrets
linktitle: Secrets
type: docs
description: Questions on secrets and external secrets
weight: 200
---

## How do I add a new Secret?
 
 See [how to add a new Secret](/v3/admin/setup/secrets/#create-a-new-secret)
 
## How do I edit a secret?
 
Secrets are [stored in external secret storage](/v3/admin/setup/secrets/) like Vault or your cloud providers secret store. 
 
So you can edit them in the underlying secret store directly (e.g. with your cloud providers CLI or the vault CLI).
                                                        

Or you can use [jx secret edit](/v3/admin/setup/secrets/#edit-secrets) command to do this for you.

The [interactive mode](/v3/admin/setup/secrets/#interactive-mode) is a nice way to find the secret and property you want to edit, then edit...

```bash
jx secret edit -i
```                  
                       

## How do I edit the bot token?

The git operator secret is normally updated whenever you re-install the git operator via Terraform or [install the operator via the CLI](/v3/admin/setup/operator/). 

You can delete the git operator via:

 ```bash
helm delete jx-git-operator -n jx-git-operator 
````

There are a number of other places you need to change the bot token.

First check out [how to edit secrets](/v3/develop/faq/config/secrets/#how-do-i-edit-a-secret) for background.

Secrets are [stored in external secret storage](/v3/admin/setup/secrets/) like Vault or your cloud providers secret store. 
 
So you can edit them in the underlying secret store directly (e.g. with your cloud providers CLI or the vault CLI).
                                                        
When you first boot up Jenkins X it will auto-populate the secrets in the external secret store with the bot user and password you pass in when you run.

The bot user and password is replicated into a number of different secrets. This is so that you can use separate accounts and tokens if you wish; or even change scopes per use.

Though it does mean you've a few different places to change the bot token if you choose to change it.


The [interactive mode](/v3/admin/setup/secrets/#interactive-mode) is probably the simplest way to change a secret:
 
 ```bash
 jx secret edit -i
 ```                  

Then to change a bot token you will need to change these secrets:
    

| Secret Name | Property |
| --- | --- |
| `lighthouse-oauth-token` | `oauth` | 
| `tekton-git` | `username` `password` | 
      

Once you have made your changes you can verify the changes have taken place. 

e.g. if you have [ksd](https://github.com/mfuentesg/ksd) installed on your `$PATH`: 

 ```bash
kubectl get secret -oyaml lighthouse-oauth-token | ksd
 ```                  


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
        

