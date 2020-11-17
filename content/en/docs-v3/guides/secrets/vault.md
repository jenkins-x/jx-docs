---
title: Vault
linktitle: Vault
type: docs
description: Using Vault for your Secret storage
weight: 30
aliases:
  - /docs/v3/guides/secrets/vault
---


To be able to use Vault as the storage engine for your Secrets you need to [configure vault](/docs/v3/guides/config/#vault) via `secretStorage: vault` in your `jx-requirements.yml`:

```yaml
cluster:
  provider: gke
environments:
- key: dev
- key: staging
- key: production
kaniko: true
secretStorage: vault
webhook: lighthouse
```

## Installing Vault

Make sure that your `helmfile.yaml` file has the necessary vault charts included such as...

```yaml 
apps:
- name: external-secrets/kubernetes-external-secrets
- name: banzaicloud-stable/vault-operator
- name: jx-labs/vault-instance   
...
```

which ensures that:

* [Kubernetes External Secrets](https://github.com/godaddy/kubernetes-external-secrets) is installed to populate Secrets from vault
* the [vault operator](https://banzaicloud.com/products/bank-vaults/) is installed for operating vault 
* a vault instance is created in the `secret-infra` namespace

You can wait for the `vault-0` pod in namespace `secret-infra` to be ready via [jx secret vault wait](https://github.com/jenkins-x/jx-secret/blob/master/docs/cmd/jx-secret_vault_wait.md) command:

```bash 
jx secret vault wait
```

Now your vault can be used.

## Using Vault

To be able to import, export or edit secrets from your laptop you need to make sure you are running the [jx secret vault portforward](https://github.com/jenkins-x/jx-secret/blob/master/docs/cmd/jx-secret_vault_portforward.md) command to port forward the 8200 port on your laptop to the vault service:


```
jx secret vault portforward
```                  

This will allow the [jx 3.x binary](/docs/v3/guides/jx3/) to access the Vault REST API.

You can now follow the instructions to [edit secrets](/docs/v3/guides/secrets/#edit-secrets) or [import secrets](/docs/v3/guides/secrets/#import-secrets).

You can also access the vault web UI at [https://localhost:8200](https://localhost:8200)

## Using the vault CLI directly

Someday we might have a nice [jx secret vault shell](https://github.com/jenkins-x/jx-secret/issues/5) command to automate all of this but until then...

Download the [vault CLI binary](https://www.vaultproject.io/downloads/) and add it to your `$PATH`.

You can now setup a shell to access vault as follows:

```bash 
export VAULT_TOKEN=$(kubectl get secrets vault-unseal-keys  -n secret-infra -o jsonpath={.data.vault-root} | base64 --decode)

# Tell the CLI that the Vault Cert is signed by a custom CA
kubectl get secret vault-tls -n secret-infra -o jsonpath="{.data.ca\.crt}" | base64 --decode > $PWD/vault-ca.crt
export VAULT_CACERT=$PWD/vault-ca.crt

# Tell the CLI where Vault is listening (the certificate has 127.0.0.1 as well as alternate names)
export VAULT_ADDR=https://127.0.0.1:8200

# Now we can use the vault CLI to list/read/write secrets...
                                           
# List all the current secrets
vault kv list secret

# Lets store a secert
vault kv put secret/mything foo=bar whatnot=cheese
```

