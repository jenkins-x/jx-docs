---
title: Vault
linktitle: Vault
type: docs
description: Using Vault for your Secret storage
weight: 30
aliases:
  - /v3/guides/secrets/vault
---

## Installing Vault

### Internal vault (vault inside kubernetes cluster)

If you are using Terraform with one of the [Cloud Providers](/v3/admin/) then your Vault will be installed automatically via Terraform.

Otherwise please see the [On-Premises Vault Install Guide](/v3/admin/platforms/on-premises/vault/)

whichever apporoach take you should have:

- [Kubernetes External Secrets](https://github.com/external-secrets/kubernetes-external-secrets) is installed to populate Secrets from vault
- the [vault operator](https://banzaicloud.com/products/bank-vaults/) is installed for operating vault
- a vault instance is created in the `jx-vault` namespace

You can wait for the `vault-0` pod in namespace `jx-vault` to be ready via [jx secret vault wait](https://github.com/jenkins-x/jx-secret/blob/master/docs/cmd/jx-secret_vault_wait.md) command:

```bash
jx secret vault wait
```

#### External vault

{{< alert >}}
External vault is only supported for jx versions greater than `3.2.203`
{{< /alert >}}

Configure external vault to support [kubernetes auth method](https://www.vaultproject.io/docs/auth/kubernetes#configuration).
This step needs to be done before any jenkinsx related changes are made.

Set `vault_url` to the url of the external vault in the terraform [module](https://github.com/jenkins-x/terraform-aws-eks-jx/blob/master/variables.tf#L36-L40).
Add vault_url to the main.tf file (replace `https://external-vault.com` with the actual vault url):

```bash
...
module "eks-jx" {
  source               = "jenkins-x/eks-jx/aws"
  ...
  vault_url            = "https://external-vault.com"
  ....
}
....
```

This will prevent the terraform module from creating any vault resources in the kubernetes cluster and the cloud (AWS/GCP/Azure) account.

Next, in the cluster git repository (the one generated from https://github.com/jx3-gitops-repositories/jx3-eks-vault ), modify the [Makefile](https://github.com/jx3-gitops-repositories/jx3-eks-vault/blob/main/versionStream/src/Makefile.mk) to add 2 extra environment variables (replace `https://external-vault.com` with the actual vault url):

```bash
VAULT_ADDR=http://external-vault.com
EXTERNAL_VAULT=true
```

and modify the `secrets-populate` target to

```bash
-VAULT_ADDR=$(VAULT_ADDR) EXTERNAL_VAULT=$(EXTERNAL_VAULT) VAULT_NAMESPACE=$(VAULT_NAMESPACE) jx secret populate --secret-namespace $(VAULT_NAMESPACE) --no-wait
```

Now your vault can be used.

#### Local `jx-secret` with External vault

`jx-secret` uses the `JWT` token type to authenticate with vault.  The `JWT` token is only valid when used from inside the Kubernetes cluster and because of this we have to proxy the connection through a host inside the cluster.

Launch a pod in the jx cluster to act as the proxy host:
```bash
kubectl -n jx run vault-proxy --image=hpello/tcp-proxy --port=8200 -- vault.example.com 8200
```

Forward local port 8200 to the vault-proxy pod:
```bash
kubectl port-forward pods/vault-proxy 8200:8200&
jobid=`echo $!`
```

Setup your local environment:
```bash
unset VAULT_TOKEN
export VAULT_ADDR=https://localhost:8200/
export VAULT_SKIP_VERIFY=True
export JX_VAULT_MOUNT_POINT=kubernetes
export JX_VAULT_ROLE=jx-vault
export EXTERNAL_VAULT=true
```

Run `jx-secret` as you normally would:
```bash
jx secret edit -i
```

Cleanup:
```bash
kill $foo #stop the port-forward
kubectl -n jx delete pod vault-proxy #delete the pod
```
### Configuration

To indicate that Vault is being used as the storage engine for your Secrets you need to [configure vault](/v3/guides/config/#vault) via `secretStorage: vault` in your `jx-requirements.yml`. Note that this is usually done automatically for Cloud providers and Terraform:

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

## Using Vault

To be able to import, export or edit secrets from your laptop you need to make sure you are running the [jx secret vault portforward](https://github.com/jenkins-x/jx-secret/blob/master/docs/cmd/jx-secret_vault_portforward.md) command to port forward the 8200 port on your laptop to the vault service:

```bash
jx secret vault portforward
```

This will allow the [jx 3.x binary](/v3/guides/jx3/) to access the Vault REST API.

You can now follow the instructions to [edit secrets](/v3/guides/secrets/#edit-secrets) or [import secrets](/v3/guides/secrets/#import-secrets).

## Using the vault web UI

Once you are running the `jx secret vault portforward` command described above you can access the vault web UI at [https://localhost:8200](https://localhost:8200)

## Using the vault CLI directly

Someday we might have a nice [jx secret vault shell](https://github.com/jenkins-x/jx-secret/issues/5) command to automate all of this but until then...

Download the [vault CLI binary](https://www.vaultproject.io/downloads/) and add it to your `$PATH`.

You can now setup a shell to access vault as follows:

```bash
export VAULT_TOKEN=$(kubectl get secrets vault-unseal-keys  -n jx-vault -o jsonpath={.data.vault-root} | base64 --decode)

# Tell the CLI that the Vault Cert is signed by a custom CA
kubectl get secret vault-tls -n jx-vault -o jsonpath="{.data.ca\.crt}" | base64 --decode > $PWD/vault-ca.crt
export VAULT_CACERT=$PWD/vault-ca.crt

# Tell the CLI where Vault is listening (the certificate has 127.0.0.1 as well as alternate names)
export VAULT_ADDR=https://127.0.0.1:8200

# Now we can use the vault CLI to list/read/write secrets...

# List all the current secrets
vault kv list secret

# Lets store a secret
vault kv put secret/mything foo=bar whatnot=cheese
```
