---
title: K3s with vault in docker
linktitle: K3s
type: docs
description: Setup Jenkins X on a K3s cluster on your computer, with vault running in docker
date: 2021-11-22
publishdate: 2021-11-22
lastmod: 2022-04-04
weight: 50
aliases:
  - /v3/admin/platform/k3s
---

This guide will walk you though how to setup Jenkins X on your own computer using [k3s](https://k3s.io/) and vault running in docker.

If you would rather run vault inside of k3s, which makes the install procedure somewhat simpler, see this [guide](/v3/admin/platform/k3s/internal_vault)

Please see the [Troubleshooting guide](/v3/admin/platform/k3s/troubleshooting) if you run into problems.

#### K3s

Make sure you have [created a cluster using k3](/v3/admin/platforms/k3s/cluster).

#### Vault
To install vault on docker, you first need to install [docker](https://docs.docker.com/engine/install/) and [manage it as a non root user](https://docs.docker.com/engine/install/linux-postinstall/)

Install vault cli.
Refer to the [vault docs](https://www.vaultproject.io/docs/install) on how to install vault for your platform.

Make sure you have vault running in a docker container with kubernetes auth enabled.

```bash
docker run --name jx-k3s-vault -d --cap-add=IPC_LOCK -e 'VAULT_DEV_ROOT_TOKEN_ID=myroot' -e 'VAULT_DEV_LISTEN_ADDRESS=0.0.0.0:8200' --net host vault:latest
```
To verify that vault has started properly use `docker logs jx-k3s-vault`.

Next enable kubernetes auth in vault.

```bash
export VAULT_ADDR='http://0.0.0.0:8200'
vault auth enable kubernetes
```
#### Github

- Create a git bot user (different from your own personal user) e.g. https://github.com/join and generate a a personal access token, this will be used by Jenkins X to interact with git repositories. e.g. https://github.com/settings/tokens/new?scopes=repo,read:user,read:org,user:email,write:repo_hook,delete_repo,admin:repo_hook

- This bot user needs to have write permission to write to any git repository used by Jenkins X. This can be done by adding the bot user to the git organisation level or individual repositories as a collaborator. Add the new bot user to your Git Organisation, for now give it Owner permissions, we will reduce this to member permissions soon.

### Jenkins X v3 installation

- Make sure you have installed [jx 3.x binary](https://jenkins-x.io/v3/admin/setup/jx3/) and put it on your `$PATH` as the `jx admin operator` will be used

- Generate a cluster git repository from the [jx3-k3s-vault](https://github.com/jx3-gitops-repositories/jx3-k3s-vault) template, by clicking [here](https://github.com/jx3-gitops-repositories/jx3-k3s-vault/generate)

- Edit the value of the vault url in the `jx-requirements.yaml` file.
  Replace with `"http://<replace with k3s node name>:8200"`
- Commit and push your changes:

```bash
git add .
git commit -m "fix: set vault url"
git push origin main
```
- Set the GIT_USERNAME (bot username) and GIT_TOKEN (bot personal access token) env variable and run:

```bash
jx admin operator --username $GIT_USERNAME --token $GIT_TOKEN --url <url of the cluster git repo> --set "jxBootJobEnvVarSecrets.EXTERNAL_VAULT=\"true\"" --set "jxBootJobEnvVarSecrets.VAULT_ADDR=http://<replace with k3s node name>:8200"
```

> Note: The first job will fail as it cannot authenticate against vault.
> The errors will be of the form `error: failed to populate secrets: failed to create a secret manager for ExternalSecret`.
> Once the secret-infra namespace has been created, we can configure vault.
> If you get an error connecting to the cluster, try running `kubectl config view --raw >~/.kube/config` as well as checking the permissions/owner of `~/.kube/config`

### Vault configuration

Install [jq](https://stedolan.github.io/jq/download/) before running these commands.

Remember to run the following commands in a terminal where you have set the value of `VAULT_ADDR`

- Create a vault config

```bash
export VAULT_ADDR='http://0.0.0.0:8200'
VAULT_HELM_SECRET_NAME=$(kubectl -n secret-infra get secrets --output=json | jq -r '.items[].metadata | select(.name|startswith("kubernetes-external-secrets-token-")).name')
TOKEN_REVIEW_JWT=$(kubectl -n secret-infra get secret $VAULT_HELM_SECRET_NAME --output='go-template={{ .data.token }}' | base64 --decode)
KUBE_CA_CERT=$(kubectl config view --raw --minify --flatten --output='jsonpath={.clusters[].cluster.certificate-authority-data}' | base64 --decode)
KUBE_HOST=$(kubectl config view --raw --minify --flatten --output='jsonpath={.clusters[].cluster.server}')
vault write auth/kubernetes/config \
        token_reviewer_jwt="$TOKEN_REVIEW_JWT" \
        kubernetes_host="$KUBE_HOST" \
        kubernetes_ca_cert="$KUBE_CA_CERT" \
        disable_iss_validation=true
```

- Create a vault role:

```bash
vault write /auth/kubernetes/role/jx-vault bound_service_account_names='*' bound_service_account_namespaces=secret-infra token_policies=jx-policy token_no_default_policy=true disable_iss_validation=true
```

- Create a policy attached to vault role:

```bash
vault policy write jx-policy - <<EOF
path "secret/*" {
  capabilities = ["sudo", "create", "read", "update", "delete", "list"]
}
EOF
```

Once vault is configured, pull the changes commited to the cluster git repository by the bootjob, and push a dummy job

```bash
git pull
# Make a dummy change (change Readme file for example)
git add .
git commit -m "chore: dummy commit 1"
git push origin main
```

tail the logs of `jx-git-operator` pod in the `jx-git-operator` namespace.

```
not creating a Job in namespace jx-git-operator for repo jx-boot sha XXXXXX yet as there is an active job jx-boot-XXXXXXX
```

Kill that job.

```bash
kubectl delete job jx-boot-97dbb72f-4e4e-4b0e-8eb2-8908997b19f7 -n jx-git-operator
```

Once it's killed a new boot job will be triggered.
This job will create the secrets in vault which will be used by external secrets to create kubernetes secrets.

### Verify installation

- To verify the job succeeded, run `jx admin log`
- To verfiy the secrets were created, run `kubectl get es -A` and `jx secret verify`

### Set up ingress and webhook

Your cluster should now be ready and running.
To allow git to send webhooks, you can [set up a tunnel using ngrok](ngrok) 
### Next steps

- <a href="/v3/develop/create-project/" class="btn bg-primary text-light">Create or import projects</a>
