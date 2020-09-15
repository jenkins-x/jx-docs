---
title: On Premise
linktitle:  On Premise
description: Setup Jenkins X on vanilla Kubernetes  
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2020-02-21
weight: 120
---

## On Premise Kubernetes

If you are using kubernetes we highly recommend you use one of the managed cloud providers like [Amazon](/docs/v3/getting-started/eks/) or [Google](/docs/v3/getting-started/gke/) as this comes with lots of additional features like:

* container registries and bucket storage
* IAM and workload identity (e.g. so kubernetes Service Accounts can be assigned roles to be able to read/write to certain buckets or container registries) 

However sometimes you need to run kubernetes on your premise. Longer term we hope the cloud providers can run their managed kubernetes and associated infrastructure on your premise too so you get to reuse the same storage + IAM anywhere. But until then, this guide is intended to get you started installing Jenkins X on a vanilla kubernetes cluster on premise.

### Prerequisites

The following are the prerequisites of your on-premise kubernetes cluster:

#### kubectl access

You need to be able to connect to your kubernetes cluster via [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) so that you can run commands like:

```bash 
kubectl get ns
kubectl get node
```

To view the namespaces and nodes respectively.
 
#### Ingress

To use Jenkins X we need ingress to work. This means being able to create a kubernetes `Ingress`  resource with a domain name which can be resolved outside of kubernetes to network into kubernetes services.

Jenkins X installs `nginx` which has a `LoadBalancer` kubernetes `Service` to implement ingress. But the underlying kubernetes platform needs to implement the load balancing network and infrastructure. This comes out of the box on all public clouds.
 
With an on-premise kubernetes cluster you need to install something like [MetalLB](https://metallb.universe.tf/)

#### Storage

We need your kubernetes cluster to have a default [storage class](https://kubernetes.io/docs/concepts/storage/storage-classes/) so that `PersistentVolumeClaim` resources in helm charts get resolved to `PersistentVolume` resources so that persistent disks can be used.


### Getting Started

This is our current recommended quickstart for on premise kubernetes:

*  <a href="https://github.com/jx3-gitops-repositories/jx3-kubernetes/generate" target="github" class="btn bg-primary text-light">Create Git Repository</a> 

* ensure you are connected to your cluster so you can run the following [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) commands 

```bash 
kubectl get ns
kubectl get node      
```        

*  <a href="/docs/v3/guides/operator/" 
    target="github" class="btn bg-primary text-light" 
    title="install the git operator to setup Jenkins X in your cluster">
    Install the git operator
  </a> from inside a git clone of your git repository via something like: 

```bash 
git clone https://github.com/myuser/mygitops-repo.git myrepo
cd myrepo
jx admin operator    
```  

*  <a href="/docs/v3/create-project/" class="btn bg-primary text-light">Create or import projects</a> 
