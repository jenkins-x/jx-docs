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

                
To create a new Kubernetes cluster with Jenkins X installed use the  [jx create cluster](/commands/jx_create_cluster) command.
    
A number of different public cloud providers are supported as shown below.  

__For the best getting started experience we currently recommend using Google Container Engine (GKE)__. The Google Cloud Platform offers a $300 free credit if you don't have a Google Cloud account.  See https://console.cloud.google.com/freetrial

Here's a little demo showing GKE, AKS and Minikube in parallel. It can take some time to start on different machines/clouds so please be patient!

<iframe width="640" height="360" src="https://www.youtube.com/embed/ELA4tytdFeA" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>


### Using Google Cloud (GKE)

Use the [jx create cluster gke](/commands/jx_create_cluster_gke) command: 

    jx create cluster gke

The command assumes you have a google account and you've set up a default project that you can use to create the kubernetes cluster within.    
     
Now **[develop apps faster with Jenkins X](/getting-started/next/)**.
 
       
### Using Amazon (AWS)

Use the [jx create cluster aws](/commands/x_create_cluster_aws) command: 

    jx create cluster aws

This will use [kops](https://github.com/kubernetes/kops) on your Amazon account to create a new kubernetes cluster and install Jenkins X.

To try this out we recommend you follow the [AWS Workshop for Kubernetes](https://github.com/aws-samples/aws-workshop-for-kubernetes/tree/master/01-path-basics/101-start-here#create-aws-cloud9-environment) to set up an AWS Cloud9 IDE session.

Then create a new terminal in Cloud9 and try these commands:

```shell 
curl -L https://github.com/jenkins-x/jx/releases/download/v{{< version >}}/jx-linux-amd64.tar.gz | tar xzv 
sudo mv jx /usr/local/bin
jx create cluster aws
```

Now **[develop apps faster with Jenkins X](/getting-started/next/)**.

        
### Using Azure (AKS)

Use the [jx create cluster aks](/commands/jx_create_cluster_aks) command: 

    jx create cluster aks
    
Now **[develop apps faster with Jenkins X](/getting-started/next/)**.
    
### Using Minikube (local)    
    
Some folks have trouble getting minikube to work for a variety of reasons:

* minikube requires up to date virtualisation software to be installed and your machine 
* you may have an old Docker installation or old minikube / kubectl or helm binaries and so forth.

So we **highly** recommend using one of the public clouds above to try out Jenkins X. They all have free tiers so it should not cost you any significant cash and it'll give you a chance to try out the cloud.

If you still want to try minikube then we recommend starting from scratch and letting jx create it for you by running

    jx create cluster minikube

Now **[develop apps faster with Jenkins X](/getting-started/next/)**.

### Using Minishift (local)

If you want to try out Jenkins X on a local OpenShift cluster then you can try using minishift.

To create a minishift VM with Jenkins X installed on it try the [jx create cluster minishift](/commands/jx_create_cluster_minishift) command:

    jx create cluster minikube

Now **[develop apps faster with Jenkins X](/getting-started/next/)**.


### Troubleshooting

If you hit any issues installing Jenkins X then please check out our [troubleshooting guide](/troubleshooting/faq/) or [let us know](/community) and we'll try our best to help.

