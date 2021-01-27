---
title: Secrets
linktitle: Secrets
type: docs
description: Setting up the secrets for your installation
weight: 30
aliases:
  - /v3/guides/secrets
---

Jenkins X 3.x uses [Kubernetes External Secrets](https://github.com/godaddy/kubernetes-external-secrets) to manage populating secrets from your underlying secret store such as:

* Alibaba Cloud KMS Secret Manager
* Amazon Secret Manager
* Azure Key Vault
* Hashicorp Vault
* GCP Secret Manager

This lets you check in all of your other kubernetes resources and custom resource definitions into git for simple and powerful GitOps.

You can then rotate secrets easily independent of git.

This is the exact same graph as [here](https://github.com/godaddy/kubernetes-external-secrets#system-architecture), with AWS Secrets Manager replaced by vault.
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

<iframe width="560" height="315" src="https://www.youtube.com/embed/_gjGfwlxEY4" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Vault

If you are using Vault as your back end for [Kubernetes External Secrets](https://github.com/godaddy/kubernetes-external-secrets) then before you try any of the following commands to populate secrets you need to make sure your termminal can access Vault.

To do this you can run the [jx secret vault portforward](https://github.com/jenkins-x/jx-secret/blob/master/docs/cmd/jx-secret_vault_portforward.md) command in a terminal:
 
```bash
jx secret vault portforward
```                  
 
You should then be able to run the following `jx secret edit` or `jx secret import` commands.

## Edit Secrets

To edit the Secrets run:

```bash
jx secret edit
```                  

This will prompt you to enter all the missing Secrets by default.

If you just want to enter a specific secret you can use `--filter` or `-f` to filter for a specific secret name.

e.g.

```bash
jx secret edit -f nexus
```                  


## Create a new Secret

If you wish to add a new custom Secret to your cluster so that you can reference it inside a Pipeline then follow these steps:

* Add an `ExternalSecret` (or `Secret` with empty values) resource via the  [add a kubernetes resources guide](/v3/develop/apps/#adding-resources).
* Submit your change as a Pull Request then merge the change.
* This should now trigger a [boot Job](/v3/about/how-it-works/#boot-job) to apply the changes in your repository
* You should now be able to see the `ExternalSecret` in the namespace you wanted via:

```bash 
kubectl get es --namespace jx
```

* You can view which External Secrets are [populated via the External Secrets service](/v3/admin/guides/secrets/) via:
  
```bash 
jx secret verify
```
                
* The `Secret` gets created by the [the External Secrets service](/v3/admin/guides/secrets/) when the underlying secret store (e.g. vault / cloud provider secret manager) is populated or updated. You can populate the secrets in a number of ways...

  * using the underlying secret store directly. e.g. using the [vault CLI directly](/v3/admin/guides/secrets/vault/#using-the-vault-cli-directly) or [vault web UI](/v3/admin/guides/secrets/vault/#using-the-vault-web-ui) or use your cloud providers secret manager's CLI or web UI
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
       


## Export Secrets

You can export the current secrets to the file system via

```bash
jx secret export -f /tmp/mysecrets.yaml
```                  

Or to view them on the terminal...

```bash
jx secret export -c
```                  


## Import Secrets

If you have previously exported the secrets as shown above you can re-import them again (maybe into a different cluster):

```bash
jx secret import -f /tmp/mysecrets.yaml 
```                  


### Migrating Local Secrets

If you have booted Jenkins X before you may well have secrets in your `~/.jx/localSecrets/mycluster/secrets.yaml`

If the file is valid you can just run:

```bash
jx secret import -f ~/.jx/localSecrets/mycluster/secrets.yaml 
```                  

### Migrating Secrets from Vault

If you have secrets already in a Vault then use the vault CLI tool to export the secrets to disk, reformat it in the above YAML layout and then import the secrets as above.
