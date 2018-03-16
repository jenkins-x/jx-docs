---
title: Create new Cluster
linktitle: Create new Cluster
description: How to create a new Kubernetes cluster with Jenkins X installed 
date: 2013-07-01
publishdate: 2013-07-01
categories: [getting started]
keywords: [install]
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
    
A number of different public cloud providers are supported as shown below.

Here's a little demo showing GKE, AKS and Minikube in parallel. It can take some time to start on different machines/clouds so please be patient!

<iframe width="640" height="360" src="https://www.youtube.com/embed/ELA4tytdFeA" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>


### Using Google Cloud (GKE)

Use the [jx create cluster gke](/commands/jx_create_cluster_gke) command: 

    jx create cluster gke

The command assumes you have a google account and you've setup a default project that you can use to create the kubernetes cluster within.    
        
### Using Amazon (AWS)

Use the [jx create cluster aws](/commands/x_create_cluster_aws) command: 

    jx create cluster aws

This will use [kops](https://github.com/kubernetes/kops) on your Amazon account to create a new kubernetes cluster and install Jenkins X.

To try this out we recommend you follow the [AWS Workshop for Kubernetes](https://github.com/aws-samples/aws-workshop-for-kubernetes/tree/master/01-path-basics/101-start-here#create-aws-cloud9-environment) to setup an AWS Cloud9 IDE session.

Then create a new terminal in Cloud9 and try these commands:

```shell 
curl -L https://github.com/jenkins-x/jx/releases/download/v{{< version >}}/jx-linux-amd64.tar.gz | tar xzv 
sudo mv jx /usr/local/bin
jx create cluster aws
```

Hopefully that works and then you can try [use your Jenkins X installation](/getting-started/next/)    
        
### Using Azure (AKS)

Use the [jx create cluster aks](/commands/jx_create_cluster_aks) command: 

    jx create cluster aks
    
    
### Using Minikube (local)    
    
Some folks have trouble getting minikube to work for a variety of reasons:

* minikube requires up to date virtualisation software to be installed and your machine 
* you may have an old Docker installation or old minikube / kubectl or helm binaries and so forth.

So we **highly** recommend using one of the public clouds above to try out Jenkins X. They all have free tiers so it should not cost you any significant cash and it'll give you a chance to try out the cloud.

If you still want to try minikube then we recommend you try [install minikube](https://github.com/kubernetes/minikube#installation) and start it first

    minikube start
    
To ensure your machine can run [minikube](https://github.com/kubernetes/minikube). Any issues getting this far please [report them on the minikube issue tracker](https://github.com/kubernetes/minikube/issues) they are a pretty helpful group of folks! 

Once you have minikube running then try the [jx install](/commands/jx_install) command:

    jx install --provider=minikube


We also have a shortcut command that starts minikube and installs Jenkins X if you are confident your machine can run minikube: [jx create cluster minikube](/commands/jx_create_cluster_minikube/) 

    jx create cluster minikube        


### Troubleshooting

If you hit any issues installing Jenkins X then please check out our [troubleshooting guide](/troubleshooting/faq/) or [let us know](/community) and we'll try our best to help.

