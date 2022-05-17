---
title: K3s cluster
linktitle: Cluster installation
type: docs
description: Install k3s cluster on your own computer
date: 2022-04-04

weight: 50
aliases:
  - /v3/admin/platform/k3s/cluster
---

This guide explains how to install k3s for running kubernetes on your own computer.

#### Linux
```bash
# install k3s 
curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644
# copy kubeconfig
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/k3s-config
# export kubeconfig
export KUBECONFIG=~/.kube/config:~/.kube/k3s-config
```
#### macOS
For macOS, we need to first install [multipass](https://multipass.run/), create a VM with multipass and then install k3s on this VM.
```bash
# install multipass
brew install --cask multipass
# Create a vm with 4G memory and 30G disk and 4 CPU
# this worked on my machine but you may need to adjust according to your system and your needs
multipass launch --name k3sVM --mem 4G --disk 30G -c 4
# install k3s 
multipass shell k3sVM
# once you are into the k3sVM shell
curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644
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
# set permissions on the kubeconfig file
chmod 0644 k3s.yaml
# set KUBECONFIG
export KUBECONFIG=${PWD}/k3s.yaml
cat "$KUBECONFIG"
```
#### Verify k3s available
To verify that k3s has been installed successfully, and configured run:

```bash
kubectl get nodes
```

Check [k3s install guide](https://rancher.com/docs/k3s/latest/en/installation/) for more installation options.
