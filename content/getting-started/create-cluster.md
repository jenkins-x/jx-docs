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

    jx create cluster gke
    
        
### Using Azure (AKS)

    jx create cluster aks
    
    
### Using Minikube (local)    
    
We recommend you try [install minikube](https://github.com/kubernetes/minikube#installation) and start it first

    minikube start
    
To ensure your machine can run [minikube](https://github.com/kubernetes/minikube). 

Once you have minikube running then try:

    jx install


We also have this shortcut command that does the above:
                
    jx create cluster minikube        


### Demo

Here's a little demo showing GKE, AKS and Minikube in parallel. It can take some time to start on different machines/clouds so please be patient!

<iframe width="640" height="360" src="https://www.youtube.com/embed/ELA4tytdFeA" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

### Troubleshooting

If you hit any issues installing Jenkins X then please check out our [troubleshooting guide](/troubleshooting/faq/) or [let us know](/community) and we'll try our best to help.

