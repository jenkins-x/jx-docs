---
title: Create new Cluster
linktitle: Create new Cluster
description: How to create a new Kubernetes cluster with Jenkins X installed 
date: 2013-07-01
publishdate: 2013-07-01
categories: [getting started]
keywords: [quick start,usage]
menu:
  docs:
    parent: "getting-started"
    weight: 20
weight: 20
sections_weight: 20
draft: false
aliases: [/quickstart/,/overview/quickstart/]
toc: true
---

                
To create a new Kubernetes cluster with Jenkins X installed use the  [jx create cluster](/commands/jx_create_cluster) command:

    jx create cluster
    
A number of different public cloud providers are supported such as

### Using Google Cloud (GKE)

Use the [jx create cluster gke](/commands/jx_create_cluster_gke) command: 

    jx create cluster gke
    
        
### Using Amazon (AWS)

Use the [jx create cluster aws](/commands/x_create_cluster_aws) command: 

    jx create cluster aws

This will use [kops](https://github.com/kubernetes/kops) on your Amazon account to create a new kubernetes cluster and install Jenkins X    
        
### Using Azure (AKS)

Use the [jx create cluster aks](/commands/jx_create_cluster_aks) command: 

    jx create cluster aks
    
    
### Using Minikube (local)    
    
Use the [jx create cluster minikube](/commands/jx_create_cluster_minikube/) command:
                
    jx create cluster minikube        


### Demo

Here's a little demo showing GKE, AKS and Minikube in parallel. It can take some time to start on different machines/clouds so please be patient!

<iframe width="640" height="360" src="https://www.youtube.com/embed/ELA4tytdFeA" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

### Troubleshooting

If you hit any issues installing Jenkins X then please check out our [troubleshooting guide](/troubleshooting/faq/) or [let us know](/community) and we'll try our best to help.

