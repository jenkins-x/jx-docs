---
title: Vault
linktitle: Vault
description: Using Vault for your Secret storage
weight: 30
---


To be able to use Vault as the storage engine for your Secrets you need to specify `--secret vault` when [creating your development git repository](/docs/labs/boot/getting-started/repository/) or [configure vault](/docs/labs/boot/getting-started/config/#vault) via `secretStorage: vault` in your `jx-requirements.yml`:

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

Before you try to [run the boot job](/docs/labs/boot/getting-started/run/) you need to ensure your Vault installation is set up and the secrets are populated.

So please install the [vault operator](https://banzaicloud.com/products/bank-vaults/) in some namespace such as `vault-infra`.

```bash 
# Create a namespace for the vault operator
kubectl create namespace vault-infra
kubectl label namespace vault-infra name=vault-infra

# Install the vault-operator to the vault-infra namespace
helm repo add banzaicloud-stable https://kubernetes-charts.banzaicloud.com
helm upgrade --namespace vault-infra --install vault-operator banzaicloud-stable/vault-operator --wait
```

Now you need to create a vault custom resource instance in the namespace you are installing Jenkins X which is `jx` by default. 

The following commands assumes you are using the `jx` namespace. If you wish to modify to use a different namespace please modify the `operator/deploy/cr.yaml` file appropriately (replacing `jx` with the namespace you are using).

```bash
# make sure we are in the jx namespace

jxl ns jx

git clone https://github.com/jenkins-x-labs/bank-vaults
cd bank-vaults

# Create a Vault instance
kubectl apply -f operator/deploy/rbac.yaml
kubectl apply -f operator/deploy/cr.yaml
```                    

Now you need to wait for teh `vault-0` pod to be ready:

```bash 
kubectl wait --for=condition=Ready pod/vault-0
```

Now your vault can be used.

## Using Vault

To be able to import, export or edit secrets from your laptop you need to make sure you are running the following command:

```
kubectl port-forward service/vault 8200
```                  

This will allow the [jxl binary](/docs/labs/jxl/) to access the Vault REST API.

You can now follow the instructions to [populate secrets](/docs/labs/boot/getting-started/secrets/#populate-secrets) or [import secrets](/docs/labs/boot/getting-started/secrets/#importing-secrets).


## Using the vault CLI

Download the [vault CLI binary](https://www.vaultproject.io/downloads/) and add it to your `$PATH`.

You can now setup a shell to access vault as follows:

```bash 
export VAULT_TOKEN=$(kubectl get secrets vault-unseal-keys -o jsonpath={.data.vault-root} | base64 --decode)

# Tell the CLI that the Vault Cert is signed by a custom CA
kubectl get secret vault-tls -o jsonpath="{.data.ca\.crt}" | base64 --decode > $PWD/vault-ca.crt
export VAULT_CACERT=$PWD/vault-ca.crt

# Tell the CLI where Vault is listening (the certificate has 127.0.0.1 as well as alternate names)
export VAULT_ADDR=https://127.0.0.1:8200

# Now we can use the vault CLI to list/read/write secrets...
                                           
# List all the current secrets
vault kv list secret

# Lets store a secert
vault kv put secret/mything foo=bar whatnot=cheese
```

