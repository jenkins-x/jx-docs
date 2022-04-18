---
title: ngrok for K3s cluster
linktitle: ngrok for k3s cluster
type: docs
description: How to make k3s cluster accept connections from the internet
date: 2022-04-13

weight: 350
aliases:
  - /v3/admin/platform/k3s/ngrok
---

This guide explains how we can use [ngrok](https://ngrok.com/) to allow a kubernetes cluster running on your own computer to accept connections from the internet. 

- Get the external IP of the traefik service (loadbalancer)

```bash
LOADBALANCER=$(kubectl get svc traefik -n kube-system --template="{{range .status.loadBalancer.ingress}}{{.ip}}{{end}}")
echo $LOADBALANCER

```

- Edit the jx-requirements.yaml file by editing the ingress domain:

```bash
# There may be some changes committed by the jx boot job
git pull
jx gitops requirements edit --domain "${LOADBALANCER}.nip.io"
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
