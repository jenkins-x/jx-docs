---
title: Secrets
linktitle: Secrets
description: Setting up the secrets for your installation
weight: 30
---

You need to specify a few secret values before you can boot up. 

We don't store the secrets in git but use some kind of secret manager. Over time we want to support many providers. Currently we support

* Google Secret Manager: the `secrets.yaml` file is stored in a google secret manager secret
* [Vault](vault) using HashiCorp's Vault
* Kubernetes Secrets: a single Kubernetes `Secret` stores the `secrets.yaml` file

## Populate Secrets

To populate the Secrets run:


```
jxl boot secrets edit --git-url https://github.com/myuser/environment-mycluster-dev.git
```                  

This will prompt you to enter all the missing Secrets required.

<nav>
  <ul class="pagination">
    <li class="page-item"><a class="page-link" href="../repository">Previous</a></li>
    <li class="page-item"><a class="page-link" href="../config">Next</a></li>
  </ul>
</nav>

### Re-enter all secrets

If you want to re-enter them all again or recreate tokens do the following:

```
jxl boot secrets edit -a --git-url https://github.com/myuser/environment-mycluster-dev.git
```                                                                        

Note that once you have booted up a cluster you can omit the `--git-url` parameter as it can be discovered from the current kubernetes cluster (via the `dev` `Environment` resource)

## Importing Secrets

If you have an existing secrets.yaml file on the file system that looks kinda like this (with the actual values included)...

```yaml
secrets:
  adminUser:
    username: 
    password: 
  hmacToken: 
  pipelineUser:
    username: 
    token: 
    email:  
```

Then you can import this YAML file via:

```
jxl boot secrets import -f /tmp/mysecrets.yaml --git-url https://github.com/myuser/environment-mycluster-dev.git
```                  


### Migrating Local Secrets

If you have booted Jenkins X before you may well have secrets in your `~/.jx/localSecrets/mycluster/secrets.yaml`

If the file is valid you can just run:

```
jxl boot secrets import -f ~/.jx/localSecrets/mycluster/secrets.yaml --git-url https://github.com/myuser/environment-mycluster-dev.git
```                  

### Migrating Secrets from Vault

If you have secrets already in a Vault then use the vault CLI tool to export the secrets to disk, reformat it in the above YAML layout and then import the secrets as above.

## Exporting Secrets

You can export the current secrets to the file system via

```
jxl boot secrets export -f /tmp/mysecrets.yaml
```                  

Or to view them on the terminal...

```
jxl boot secrets export -c
```                  

