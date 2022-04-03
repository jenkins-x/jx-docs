---
title: K3s using Vault inside kubernetes
linktitle: K3s-internal-vault
type: docs
description: Setup Jenkins X on a K3s cluster running locally, with Vault installed inside Kubernetes
date: 2022-04-03
publishdate: 2022-04-03
weight: 50
aliases:
  - /v3/admin/platform/k3s/internal-vault
---

---
This is an alternative procedure to install k3s with Vault running inside the cluster.  

**NOTE**

Ensure you are logged into GitHub else you will get a 404 error when clicking the links below

This guide will walk you though how to setup Jenkins X on your laptop using [k3s](https://k3s.io/)

### Prerequisites

#### K3s

Make sure you have created a cluster using k3s.

If you dont have an existing k3s cluster, you can install one by running:

#### Linux
```bash
# install k3 with kubernetes version 1.21 (We don't support Kubernetes 1.22+ yet)
curl -sfL https://get.k3s.io | INSTALL_K3S_CHANNEL=v1.21 sh -s - --write-kubeconfig-mode 644
# copy kubeconfig
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/k3s-config
# export kubeconfig
export KUBECONFIG=~/.kube/config:~/.kube/k3s-config
```
#### macOS
```bash
# install multipass
brew install --cask multipass
# Create a vm with 2G memory and 5G disk
multipass launch --name k3sVM --mem 4G --disk 10G
# install k3 with kubernetes version 1.21 (We don't support Kubernetes 1.22+ yet)
multipass shell k3sVM
# once you are into the k3sVM shell
curl -sfL https://get.k3s.io | INSTALL_K3S_CHANNEL=v1.21 sh -s - --write-kubeconfig-mode 644
# after this install you should be able to run kubectl get nodes
kubectl get nodes
# exit the k3sVM shell
exit
```

Next, after exiting the k3sVM shell, find the IP address of the running node, and export the kubeconfig file
```bash
multipass info k3sVM
# Export the IP address
K3S_IP=$(multipass info k3sVM | grep IPv4 | awk '{print $2}')
# export `kubeconfig` file
multipass exec k3sVM sudo cat /etc/rancher/k3s/k3s.yaml > k3s.yaml
# replace the ip adress with the external
sed -i '' "s/127.0.0.1/${K3S_IP}/" k3s.yaml
# set KUBECONFIG
export KUBECONFIG={$PWD}/k3s.yaml
```
#### Verify k3s available
To verify that k3s has been installed successfully, and configured run:

```bash
kubectl get nodes
```

This value of the node will be used later during installation and configuring of Jenkins X.

Check [k3s install guide](https://rancher.com/docs/k3s/latest/en/installation/) for more installation options.



##### Vault installed in  cluster
Once kubernetes is running, enter the following commands to have Vault started inside the k3s clusters
```
cd infra
helmfile sync

```

#### Github

- Create a git bot user (different from your own personal user) e.g. https://github.com/join and generate a a personal access token, this will be used by Jenkins X to interact with git repositories. e.g. https://github.com/settings/tokens/new?scopes=repo,read:user,read:org,user:email,write:repo_hook,delete_repo,admin:repo_hook
- This bot user needs to have write permission to write to any git repository used by Jenkins X. This can be done by adding the bot user to the git organisation level or individual repositories as a collaborator Add the new bot user to your Git Organisation, for now give it Owner permissions, we will reduce this to member permissions soon.

### Jenkins X v3 installation

- Generate a cluster git repository from the [jx3-k3s-vault](https://github.com/jx3-gitops-repositories/jx3-k3s-vault) template, by clicking [here](https://github.com/jx3-gitops-repositories/jx3-k3s-vault/generate)
 Commit and push your changes:

```bash
git add .
git commit -m "fix: set vault url"
git push origin main
```
- Set the GIT_USERNAME (bot username) and GIT_TOKEN (bot personal access token) env variable and run:

#### Using internal vault:

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
