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


## Using Google Cloud (GKE)

First make sure you have created/selected a Project in the [Google Cloud Console](https://console.cloud.google.com/). 

<img src="/images/quickstart/gke-select-project.png" class="img-thumbnail">
 
## Using the Google Cloud Shell

The simplest way to install Jenkins X on Google Cloud is using the [Google Cloud Shell](https://console.cloud.google.com/) as it already comes with most of the things you may need to install (`git, gcloud, kubectl` etc).

First you need to open the Google Cloud Shell via the button in the toolbar:

<img src="/images/quickstart/gke-start-shell.png" class="img-thumbnail">

Then you need to download the `jx` binary:

```shell
curl -L https://github.com/jenkins-x/jx/releases/download/v{{< version >}}/jx-linux-amd64.tar.gz | tar xzv 
sudo mv jx /usr/local/bin
```

Now use the [jx create cluster gke](/commands/jx_create_cluster_gke) command:

    jx create cluster gke --skip-login

If you wish to name your cluster and provide your own admin password you can run:

    jx create cluster gke --skip-login  --default-admin-password=mySecretPassWord123 -n myclustername
   
Then follow all the prompts on the console (mostly just hitting enter will do).

Now **[develop apps faster with Jenkins X](/getting-started/next/)**.


### Connecting to the cluster from your laptop

If you wish to work with the Jenkins X cluster from your laptop then click on the `Connect` button on the [Kubernetes Engine page](https://console.cloud.google.com/kubernetes/list) in the [Google Console](https://console.cloud.google.com/)
          
<img src="/images/quickstart/gke-connect.png" class="img-thumbnail">

You should now be able to use the `kubectl` and `jx` CLI tools on your laptop to talk to the GKE cluster.

       
## Using Google Cloud from your laptop

Use the [jx create cluster gke](/commands/jx_create_cluster_gke) command: 

    jx create cluster gke --verbose

The command assumes you have a google account and you've set up a default project that you can use to create the kubernetes cluster within.         
Now **[develop apps faster with Jenkins X](/getting-started/next/)**.


      
## Using Amazon (AWS)

Use the [jx create cluster aws](/commands/jx_create_cluster_aws) command: 

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

        
## Using Azure (AKS)

Use the [jx create cluster aks](/commands/jx_create_cluster_aks) command: 

    jx create cluster aks
    
Now **[develop apps faster with Jenkins X](/getting-started/next/)**.


## Using Oracle (OCE)

Use the [jx create cluster oce](/commands/jx_create_cluster_oce) command: 

    jx create cluster oce
    
This will use [oci](https://github.com/oracle/oci-cli) on your Oracle Cloud Infrastructure account to create a new OCE cluster and install Jenkins X. 

We **highly** recommend adding your $HOME/bin in $PATH otherwise you will have trouble getting OCI CLI to work in your environment. 

Now **[develop apps faster with Jenkins X](/getting-started/next/)**.

    
## Using Minikube (local)    
    
Some folks have trouble getting minikube to work for a variety of reasons:

* minikube requires up to date virtualisation software to be installed and your machine 
* you may have an old Docker installation or old minikube / kubectl or helm binaries and so forth.

So we **highly** recommend using one of the public clouds above to try out Jenkins X. They all have free tiers so it should not cost you any significant cash and it'll give you a chance to try out the cloud.

If you still want to try minikube then we recommend letting jx create cluster for you (as opposed to installing jx into existing minikube cluster) by running:

    jx create cluster minikube

Now **[develop apps faster with Jenkins X](/getting-started/next/)**.

## Using Minishift (local)

If you want to try out Jenkins X on a local OpenShift cluster then you can try using minishift.

To create a minishift VM with Jenkins X installed on it try the [jx create cluster minishift](/commands/jx_create_cluster_minishift) command:

    jx create cluster minishift

Now **[develop apps faster with Jenkins X](/getting-started/next/)**.


## Troubleshooting

If you hit any issues installing Jenkins X then please check out our [troubleshooting guide](/troubleshooting/faq/) or [let us know](/community) and we'll try our best to help.

