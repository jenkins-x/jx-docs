---
title: Vault
linktitle: Vault
description: Manage your secrets
date: 2019-01-08
publishdate: 2019-01-08
weight: 200
aliases:
  - /docs/resources/guides/managing-jx/common-tasks/vault
  - /architecture/vault
---

## What is Vault

[Hashicorp Vault](https://www.vaultproject.io) is an open source project for securely managing secrets.
Secrets are resources that provide authentication to your computing environment such as tokens, keys, passwords, and certificates.
Vault is the preferred way in Jenkins X to manage these secrets.
For example, the GitHub personal access token generated for the pipeline bot is stored in Vault.

There are two ways you can use Vault in Jenkins X.
If you are already a Vault instance, you can configure Jenkins X to use this instance to store its secrets.
This way you have a central location for managing all secrets of your infrastucture.
If you do not have a Vault instance, Jenkins X can, depending on where you run your cluster, install Vault as part of the installation process.
In this case, the Banzai Cloud [Bank-Vaults operator](https://github.com/banzaicloud/bank-vaults) is provisioned in the Jenkins X development namespace.

{{% alert %}}
The Bank-Vaults operator is currently only supported with GKE or EKS.
{{% /alert %}}

## Configuration

The configuration of Vault occurs during Jenkins X [Boot](/docs/install-setup/boot/).
Refer to the [Boot setup instructions for Vault](/docs/install-setup/boot/secrets/#vault) to see how to configure Jenkins X to use an internal or external Vault instance.

### Security

From a security point of view it is important that the communication with the Vault API is secured by TLS.
If you use your own external Vault instance, TLS configuration is in your hands and hopefully already setup.
If you let Jenkins X install and manage the Bank-Vaults operator, TLS is per default not enabled.
Refer to [Configuring DNS and TLS on GKE](/docs/install-setup/boot/clouds/google) and [Configuring DNS and TLS on EKS](/docs/install-setup/boot/clouds/amazon/#configuring-dns-and-tls-on-eks) for more information on how to secure your Jenkins X installation using TLS for the cloud providers Google and AWS.

## Accessing secrets

You can read and write secrets stored in Vault from the command line.
To do so, you need first to download an install the [`vault`](https://learn.hashicorp.com/vault/getting-started/install) CLI.
Once you have `vault` installed you can configure your terminal session to connect to Vault by running:

```sh
eval `jx get vault-config`
```

### Listing secrets

You can start exploring the Jenkins X secrets stored in Vault by runnning:

```sh
vault kv list secret
```

_secret_ is the default [mount point](https://www.vaultproject.io/docs/secrets) for the Jenkins X secrets.
If you are using an external Vault instance this mount point is configurable via the _secretEngineMountPoint_ option in _jx-requirements.yml_.
You find more information in the Vault configuration paragraph of the [Boot](/docs/install-setup/boot/) documentation.

{{% alert %}}
The Vault configuration is also stored in the _jx-install-config_ ConfigMap of your Jenkins X development namespace.
You can retrieve it by running:

```sh
kubectl get cm jx-install-config -o=jsonpath="{.data['vaultSecretEngineMountPoint']}"
```

{{% /alert %}}

### Reading secrets

You can then read a secret via:

```sh
 vault kv get secret/<cluster-name>/pipelineUser
```

### Updating secrets

You can update a secret via:

```sh
vault kv put secret/<cluster-name>/pipelineUser token=<token-value>
```

If you have a blob of JSON to encode as a secret, such as a service account key then base64 encode the data first:

```sh
cat my-service-account.json | base64 > my-service-account-base64.txt
vault kv put secret/<cluster-name>/my-secret token=my-service-account-base64.txt
```

## Rotating secrets

To rotate a secret, follow the steps described in the [Updating a secret](/docs/reference/components/vault#updating-secrets) section followed by rerunning [Boot](/docs/install-setup/boot/) (`jx boot`).
The reason you need to run Boot, either locally or kicking of the master pipline of the dev repository, is that as part of the Boot process the secrets within Vault get copied into appropriate Kubernetes Secrets which then are accessed by the various components of Jenkins X.
Without running Boot the changes to Vault will not take effect yet.
