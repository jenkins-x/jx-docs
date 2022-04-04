---
title: K3s with vault inside kubernetes
linktitle: Vault inside k3s
type: docs
description: Setup Jenkins X on a K3s cluster on your computer, with vault installed inside Kubernetes
date: 2022-04-04
publishdate: 2022-04-04
weight: 50
aliases:
  - /v3/admin/platform/k3s/k3s-vault
---

This guide will walk you though how to setup Jenkins X on your own computer using [k3s](https://k3s.io/) and vault running inside the k3s cluster.

Please see the [troubleshooting guide](/v3/admin/platform/k3s/troubleshooting) if you run into problems.

#### K3s

Make sure you have [created a cluster using k3](/v3/admin/platforms/k3s/cluster).

### Vault installed in cluster
Once kubernetes is running, enter the following commands to have vault started inside the k3s clusters

```bash
cd jx-vault
helmfile sync
```

### Github

- Create a git bot user (different from your own personal user) e.g. https://github.com/join and generate a a personal access token, this will be used by Jenkins X to interact with git repositories. e.g. https://github.com/settings/tokens/new?scopes=repo,read:user,read:org,user:email,write:repo_hook,delete_repo,admin:repo_hook
- This bot user needs to have write permission to write to any git repository used by Jenkins X. This can be done by adding the bot user to the git organisation level or individual repositories as a collaborator Add the new bot user to your Git Organisation, for now give it Owner permissions, we will reduce this to member permissions soon.

### Jenkins X v3 installation

- Make sure you have installed [jx 3.x binary](https://jenkins-x.io/v3/admin/setup/jx3/) and put it on your `$PATH` as the `jx admin operator` will be used

- Generate a cluster git repository from the [jx3-k3s-vault](https://github.com/jx3-gitops-repositories/jx3-k3s-vault) template, by clicking [here](https://github.com/jx3-gitops-repositories/jx3-k3s-vault/generate)
 Commit and push your changes:

```bash
git add .
git commit -m "fix: set vault url"
git push origin main
```
- Set the GIT_USERNAME (bot username) and GIT_TOKEN (bot personal access token) env variable and run:

```bash
jx admin operator --username $GIT_USERNAME --token $GIT_TOKEN --url <url of the cluster git repo>
```
It should install.

### Verify installation

- To verify the job succeeded, run `jx admin log`
- To verfiy the secrets were created, run `kubectl get es -A` and `jx secret verify`

### Set up ingress and webhook

- Get the external IP of the traefik service (loadbalancer)

```bash
kubectl get svc -A | grep LoadBalancer
kube-system   traefik          LoadBalancer   <cluster-ip>    <external-ip>    80:31123/TCP,443:31783/TCP   40m
```

- Edit the jx-requirements.yaml file by editing the ingress domain:

```bash
# There may be some changes committed by the jx boot job
git pull
jx gitops requirements edit --domain <external-ip>.nip.io
```

- Next, download and install [ngrok](https://ngrok.com/). Run this in a new terminal window/tab:

```bash
ngrok http 8080
```

- Once this tunnel is open, paste the ngrok url (without http and https) in the hook field in the helmfiles/jx/jxboot-helmfile-resources-values.yaml file in the cluster git repository.
- commit and push the changes.

```bash
git add .
git commit -m "chore: new ngrok ip"
git push origin main
```

- In another terminal run the following command to enable webhooks via ngrok

```bash
jx ns jx
kubectl port-forward svc/hook 8080:80
```

- Once the bootjob has succeeded, you should see:

```bash
HTTP Requests
-------------

POST /hook                     200 OK
```

### Next steps

- <a href="/v3/develop/create-project/" class="btn bg-primary text-light">Create or import projects</a>
