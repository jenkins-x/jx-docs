---
title: Troubleshooting guide
type: docs
description: Tips to troubleshoot Jenkins X on k3s
date: 2022-04-04
publishdate: 2022-04-04
weight: 50
aliases:
  - /v3/admin/platform/k3s/troubleshooting
---

### Git
- If you get a 404 error when clicking on the links to create a repository, check that you are actually logged in to GitHub or your git provider.



### Vault
- If you get the error `Error enabling kubernetes auth: Post "https://127.0.0.1:8200/v1/sys/auth/kubernetes": http: server gave HTTP response to HTTPS client`, try the command `vault login myroot`.

### Kubernetes config

You will probably need to access kubernetes in multiple terminals later, so setting these env variables in the bashrc or zshrc might help you.

```bash
nano ~/.bashrc
#go to the end of the file and paste the export command
export KUBECONFIG=~/.kube/config:~/.kube/k3s-config
```

- If you have problems with kubeconfig, copy the configuration from /etc/rancher/k3s/k3s.yaml to the ~/.kube/config instead (if you don't have any other clusters, that should be fine)
```bash
sudo rm ~/.kube/k3s-config  #to make k3s uses ~/.kube/config
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
```
- If you still get `permission denied`
```bash
sudo chmod 777 ~/.kube/config #warning: this maybe vulnerable to multiple users
```
