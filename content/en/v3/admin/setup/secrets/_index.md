---
title: Secrets
linktitle: Secrets
type: docs
description: Setting up the secrets for your installation
weight: 60
aliases:
  - /v3/guides/secrets
  - /v3/admin/guides/secrets
---

Jenkins X 3.x uses [External Secrets Operator](https://github.com/external-secrets/external-secrets) to manage populating secrets from your underlying secret store such as:

* Akeyless
* AWS Secrets Manager
* Azure Key Vault
* Doppler
* Fake
* Gitlab Project Variables
* Google Secrets Manager
* IBM Secrets manager
* Hashicorp Vault
* senhasegura DevOps Secrets Management
* Oracle Vault
* Webhook
* Yandex Certificate Manager
* 1Password Secrets Automation

This lets you check in all of your other kubernetes resources and custom resource definitions into git for simple and powerful GitOps.

You can then rotate secrets easily independent of git.

This is the exact same graph as [here](https://github.com/external-secrets/external-secrets-operator#system-architecture), with AWS Secrets Manager replaced by vault.
{{<mermaid>}}
graph TB
    subgraph A[Kubernetes Cluster]
        sqB[External Secrets Controller]
        subgraph C[secrets-infra ns]
            sqCV[Vault]
        end
        subgraph D[Kube api server]
        end
        D -- Get ExternalSecrets --> sqB
        sqB --> D
        sqB -- Fetch secrets properties --> sqCV
        sqCV --> sqB
        subgraph E[app ns]
            sqEP[pods]
            sqES[secrets]
        end
        sqB -- Upsert Secrets --> sqES
    end
{{</mermaid>}}
    

## Demo
      
The following demo walks through how to manage External Secrets via GitOps: 

<iframe width="700" height="315" src="https://www.youtube.com/embed/_gjGfwlxEY4" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
      

## Verify 

To view which secrets have been populated use:

```bash
jx secret verify
```   

This will list all of the `ExternalSecret` resources and visualise which ones are populated correctly.

You can also use [UI](/v3/develop/ui/octant/) via `jx ui` and navigate to the [Secrets View](http://127.0.0.1:7777/#/ojx/secrets)

## Vault

If you are using Vault as your back end for [External Secrets Operator](https://github.com/external-secrets/external-secrets) then before you try any of the following commands to populate secrets you need to make sure your termminal can access Vault.

To do this you can run the [jx secret vault portforward](https://github.com/jenkins-x/jx-secret/blob/master/docs/cmd/jx-secret_vault_portforward.md) command in a terminal:
 
```bash
jx secret vault portforward
```                  
 
You should then be able to run the following `jx secret edit` or `jx secret import` commands.

## Edit Secrets

To edit the Secrets use the [jx secret edit](https://jenkins-x.io/v3/develop/reference/jx/secret/edit/) command:

```bash
jx secret edit
```                  

This will prompt you to enter all the missing Secrets by default.
       
If you just want to enter a specific secret you can use `--filter` or `-f` to filter for a specific secret name.

e.g.

```bash
jx secret edit -f nexus
```                  

### Interactive mode

If you want to pick which secrets you wish to edit you can use interactive mode via:

```bash
jx secret edit -i
```                  

You will then be prompted for the Secret name to edit. When you pick a Secret name you are then prompted to pick the names of the properties in the secret you wish to edit.


## Create a new Secret

If you wish to add a new custom Secret to your cluster so that you can reference it inside a Pipeline then follow these steps:

* Add an `ExternalSecret` (or `Secret` with empty values) resource via the  [add a kubernetes resources guide](/v3/develop/apps/#adding-resources).
* Submit your change as a Pull Request then merge the change.
* This should now trigger a [boot Job](/v3/about/how-it-works/#boot-job) to apply the changes in your repository
* You should now be able to see the `ExternalSecret` in the namespace you wanted via:

```bash 
kubectl get es --namespace jx
```

* You can view which External Secrets are [populated via the External Secrets service](/v3/admin/setup/secrets/) via:
  
```bash 
jx secret verify
```
                
* The `Secret` gets created by the [the External Secrets service](/v3/admin/setup/secrets/) when the underlying secret store (e.g. vault / cloud provider secret manager) is populated or updated. You can populate the secrets in a number of ways...

  * using the underlying secret store directly. e.g. using the [vault CLI directly](/v3/admin/setup/secrets/vault/#using-the-vault-cli-directly) or [vault web UI](/v3/admin/setup/secrets/vault/#using-the-vault-web-ui) or use your cloud providers secret manager's CLI or web UI
  * using `jx secret edit -f mysecret-name`
  * using a generator or template. You can define a `secret-schema.yaml` in `versionStream/charts/chartRepoName/chartName/secret-schema.yaml` file which describes how to generate the secret (e.g. using a random password generator or a template) such as [this example to generate a dynamic password for MySQL](https://github.com/jenkins-x/jx3-versions/blob/master/charts/presslabs/mysql-operator/secret-schema.yaml) 
    

## Replicating Secrets among namespaces

Its quite common to need to replicate the same Secrets across namespaces. For example [Image Pull Secrets](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/) to pull images from container registries which may need to be used in dev, staging and production.

The Jenkins X boot job does this automatically for any secret labelled with `secret.jenkins-x.io/replica-source=true` using the [jx secret replicate](https://github.com/jenkins-x/jx-secret/blob/master/docs/cmd/jx-secret_replicate.md) command:

```bash 
jx secret replicate --selector secret.jenkins-x.io/replica-source=true
```

This will replicate the secret to all permanent enivronments in the same cluster (e.g. a local Staging or Production environment).

If you want to replicate another secret just add the label `secret.jenkins-x.io/replica-source=true` or you can add a new [jx secret replicate](https://github.com/jenkins-x/jx-secret/blob/master/docs/cmd/jx-secret_replicate.md) to the [boot makefile](/v3/about/how-it-works/#boot-job)
       

### Migrating Secrets from Vault

If you have secrets already in a Vault then use the vault CLI tool to export the secrets to disk, reformat it in the above YAML layout and then import the secrets as above.
