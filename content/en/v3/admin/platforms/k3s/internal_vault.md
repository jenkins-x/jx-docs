---
title: K3s with vault inside kubernetes
linktitle: Vault inside k3s
type: docs
description: Setup Jenkins X on a K3s cluster on your computer, with vault installed inside Kubernetes
date: 2022-04-04
publishdate: 2022-04-04
weight: 40
aliases:
  - /v3/admin/platform/k3s/k3s-vault
---

This guide will walk you though how to setup Jenkins X on your own computer using [k3s](https://k3s.io/) and vault running inside the k3s cluster.

Please see the [troubleshooting guide](https://jenkins-x.io/v3/admin/platform/k3s/troubleshooting) if you run into problems.

#### K3s

Make sure you have [created a cluster using k3](https://jenkins-x.io/v3/admin/platforms/k3s/cluster).

### Github

- Create a git bot user (different from your own personal user) e.g. https://github.com/join and generate a a personal access token, this will be used by Jenkins X to interact with git repositories. e.g. https://github.com/settings/tokens/new?scopes=repo,read:user,read:org,user:email,write:repo_hook,delete_repo,admin:repo_hook
- This bot user needs to have write permission to write to any git repository used by Jenkins X. This can be done by adding the bot user to the git organisation level or individual repositories as a collaborator Add the new bot user to your Git Organisation, for now give it Owner permissions, we will reduce this to member permissions soon.

### Checkout Jenkins X github repository

- Make sure you have installed [jx 3.x binary](https://jenkins-x.io/v3/admin/setup/jx3/) and put it on your `$PATH` as the `jx admin operator` will be used

- Generate a cluster git repository from the [jx3-k3s-vault](https://github.com/jx3-gitops-repositories/jx3-k3s-vault) template, by clicking [here](https://github.com/jx3-gitops-repositories/jx3-k3s-vault/generate)

### Install Jenkins X

- Set the GIT_USERNAME (bot username) and GIT_TOKEN (bot personal access token) env variable and cluster run from the root folder of the cluster repo:

```bash
jx admin operator
```
Jenkins X should now install.

### Verify installation

- To verify the job succeeded, run `jx admin log`
- To verify the secrets were created, run `kubectl get es -A` and `jx secret verify`

### Set up ingress and webhook

Your cluster should now be ready and running.
To allow git to send webhooks, you can [set up a tunnel using ngrok](https://jenkins-x.io/v3/admin/platform/k3s/ngrok)

### Next steps

- <a href="/v3/develop/create-project/" class="btn bg-primary text-light">Create or import projects</a>
