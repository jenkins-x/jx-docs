---
title: Configure Secret Storage
linktitle: Configure Secret Storage
description: Configure secret storage - local vs Vault
keywords: [vault]
weight: 30
aliases:
  - /docs/install-setup/installing/boot/secrets/
---

## Secrets

Boot currently supports the following options for managing secrets:

- _local_ - secrets are stored locally on your machine.
  This is useful for evaluating Jenkins X and avoids the need to install Vault.
  It is not recommended to use this option in production.
- _vault_ - the recommended approach for secret management, allowing a team to easily colloborate managing a Jenkins X cluster using Boot.

Like many other key components of Jenkins X, the secret storage method is configured in [jx-requirements.yml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/jx-requirements.yml).

The following paragraphs outline the two options in more detail.

### Local

This is the default option for managing secrets.
It can be explicitly configured via `secretStorage: local` in `jx-requirements.yml`:

```yaml
secretStorage: local
```

If enabled secrets are loaded/saved into the folder `~/.jx/localSecrets/$clusterName`.
You can use `$JX_HOME` to change the location of `~/.jx`.

### Vault

There are two ways you can use Vault in Jenkins X.
If you are already a Vault instance, you can configure Jenkins X to use this instance to store its secrets.
This way you have a central location for managing all secrets of your infrastucture.
This approach is referred to as the _external_ Vault setup.

{{% alert %}}
In case you are looking for a way to run Vault in your Kubernetes cluster, have a look at the offical [Vault Helm Chart](https://github.com/hashicorp/vault-helm).
{{% /alert %}}

If you do not have a Vault instance, Jenkins X can, depending on where you run your cluster, install Vault as part of the installation process.
In this case, the Banzai Cloud [Bank-Vaults operator](https://github.com/banzaicloud/bank-vaults) is provisioned in the Jenkins X development namespace.
This apporach is referred to as the _internal_ Vault setup.

#### Internal

This approach is currently only supported for GKE and EKS clusters.
It can be explicitly configured via `secretStorage: vault`:

```yaml
cluster:
  provider: gke
secretStorage: vault
```

After a successful run of `jx boot`, `jx-requirements.yml` will also contain a Vault configuration section containing the following information:

```yaml
vault:
  name: <cluster-name>
  bucket: <cluster-name>-<generated-id>
  key: <cluster-name>-<generated-id>
  keyring: <cluster-name>-<generated-id>
  serviceAccount: <cluster-name>-vt
```

The Vault configuration options are in this case generated and should not be modified.
They also differ between cloud providers.

#### External

In the case where you have an existing Vault instance and you want Jenkins X to store its secrets there, you also set `secretStorage: vault`.
On top setting _secretStorage_ to _vault_, you have to specify the mandatory _url_ and _serviceAccount_ options.

_url_ specifies the URL to your existing Vault instance and _serviceAccount_ is the Kubernetes service account which is allowed to authenticate using Vault's [Kubernetes Auth Method](https://www.vaultproject.io/docs/auth/kubernetes).

```yaml
secretStorage: vault
vault:
  kubernetesAuthPath: "kubernetes"
  secretEngineMountPoint: "secret"
  serviceAccount: my-sa
  url: https://my-vault.com
```

_kubernetesAuthPath_ and _secretEngineMountPoint_ are optional and default to _"secret"_ and _"kubernetes"_.
_kubernetesAuthPath_ specifies the path under which the Kubernetes auth method is enabled for your Jenkins X cluster.
_secretEngineMountPoint_ specifies the mount point for the KV engine Jenkins X is supposed to use.
The current design requires that each Jenkins X cluster gets its own Vault [KV secret engine](https://www.vaultproject.io/docs/secrets/kv).

Apart of the Jenkins X configuration in `jx-requirements.yml`, you need to configure the following:

1. Create service account and namespace in your Jenkins X cluster used to authenticate against Vault
1. Enable the Vault Kubernetes Auth
1. Create Vault policy for authenticating service account
1. Create authentication role for service account
1. Configure Kubernetes Auth
1. Enable the Vault KV secret engine

The following script can help you to make the required preparation.

```sh
export VAULT_ADDR=<url-to-vault-instance>
export VAULT_TOKEN=<vault-token>

kubernetes_api_url=<url-to-jenkins-x-cluster>
namespace=<service-account-namespace>
service_account_name=<service-account-name>
secret_mount_path=secret
kubernetes_auth_path=kubernetes

# 1.
read -r -d '' role_binding << EOF
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: role-tokenreview-binding
  namespace: ${namespace}
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: system:auth-delegator
subjects:
- kind: ServiceAccount
  name: ${service_account_name}
  namespace: ${namespace}
EOF

kubectl create namespace ${namespace}
kubectl -n ${namespace} create serviceaccount ${service_account_name}
echo "$role_binding" | kubectl apply -n ${namespace} -f -

service_account_secret=$(kubectl -n ${namespace}  get sa ${service_account_name} -o jsonpath="{.secrets[*]['name']}")
service_account_jwt=$(kubectl -n ${namespace} get secret ${service_account_secret} -o jsonpath="{.data.token}" | base64 --decode; echo)
service_account_cert=$(kubectl -n ${namespace} get secret ${service_account_secret} -o jsonpath="{.data['ca\.crt']}" | base64 --decode; echo)

# 2.
vault auth enable -path=${kubernetes_auth_path} kubernetes

# 3.
vault policy write ${service_account_name} - <<EOF
path "${secret_mount_path}/*" {
   capabilities = ["create", "update", "read", "delete", "list"]
}
EOF

# 4.
vault write auth/${kubernetes_auth_path}/role/${service_account_name} bound_service_account_names=${service_account_name}  bound_service_account_namespaces=${namespace} policies=${service_account_name} ttl=24h

# 5.
vault write auth/${kubernetes_auth_path}/config token_reviewer_jwt=${service_account_jwt} kubernetes_host=${kubernetes_api_url} kubernetes_ca_cert="${service_account_cert}"

# 6.
vault secrets enable -path=${secret_mount_path} kv-v2
```

You can verify the Vault configuration by running:

```sh
namespace=<service-account-namespace>
service_account_name=<service-account-name>
service_account_jwt=$(kubectl -n ${namespace} get secret ${service_account_name} -o jsonpath="{.data.token}" | base64 --decode; echo)
kubernetes_auth_path=kubernetes

vault write auth/${kubernetes_auth_path}/login role=${service_account_name} jwt=${service_account_jwt}
```
