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

Currently the best experience for running Jenkins X is on Google Container Engine (GKE).

First [download](http://jenkins-x.io/getting-started/install/) the `jx` CLI which is used to create and interact with the Jenkins X cluster.

Now use the [jx create cluster gke](/commands/jx_create_cluster_gke) command:

    jx create cluster gke

If you wish to name your cluster and provide your own admin password you can run:

    jx create cluster gke --default-admin-password=mySecretPassWord123 -n myclustername
   
Then follow all the prompts on the console (mostly just hitting enter will do).

Note if you wish to use a different git provider than GitHub for your environments see [how to use a different git provider](/developing/git/#using-a-different-git-provider-for-environments)
 
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

Note if you wish to use a different git provider than GitHub for your environments see [how to use a different git provider](/developing/git/#using-a-different-git-provider-for-environments)


Now **[develop apps faster with Jenkins X](/getting-started/next/)**.

### Connecting to the cluster from your laptop

If you wish to work with the Jenkins X cluster from your laptop then click on the `Connect` button on the [Kubernetes Engine page](https://console.cloud.google.com/kubernetes/list) in the [Google Console](https://console.cloud.google.com/)
          
<img src="/images/quickstart/gke-connect.png" class="img-thumbnail">

You should now be able to use the `kubectl` and `jx` CLI tools on your laptop to talk to the GKE cluster.

       
## Using Google Cloud from your laptop

Use the [jx create cluster gke](/commands/jx_create_cluster_gke) command: 

    jx create cluster gke --verbose

Or if you are already logged in by previously using `gcloud init` or `gcloud auth login`:

    jx create cluster gke --skip-login --verbose

Those commands assume you have a google account and you've set up a default project that you can use to create the kubernetes cluster within.         
Now **[develop apps faster with Jenkins X](/getting-started/next/)**.


      
## Using Amazon (AWS)

If you are using AWS be sure to check out the detailed blog on [Continuous Delivery with Amazon EKS and Jenkins X](https://aws.amazon.com/blogs/opensource/continuous-delivery-eks-jenkins-x/) by [Henryk Konsek](https://twitter.com/hekonsek) which goes into lots of detail on how to setup AWS + EKS with Jenkins X.

We support both `kops` or `eks` to create your Kubernetes cluster with Jenkins X where EKS is the most strategic direction; increasingly AWS will manage more of the kubernetes side for you with EKS.

### Ingress options

On AWS the ideal setup is to use a Route 53 DNS wildcard CNAME to point `*.somedomain` at your ELB or NLB host name; then when prompted by `jx` you install `somedomain` (where `somedomain` is an actual DNS domain/subdomain you own). 

Then all the `Ingress` resources for any exposed service in any namespace will appear as `mysvc.myns.somedomain` - whether for things like Jenkins or Nexus or for your own microservices or Preview Environments.

Using wildcard DNS pointing to your ELB/NLB also means you'll be able to use all the availability zones on AWS.

The `jx` command will ask you if you want to automate the setup fo the Route 53 wildcard CNAME. If you want to do it yourself you need to point to the ELB host name defined via:

``` 
kubectl get service -n kube-system jxing-nginx-ingress-controller  -oyaml | grep hostname
```

#### Avoiding DNS

If you want to kick the tires of Jenkins X without going to the trouble of getting a DNS domain name to use and setting up wildcard DNS you can instead use an NLP and use one of the IP addresses of one of the availability zones as your domain via `$IP.ip`.

This is not really intended for real production installations; but can be a quick way to get started trying out Jenkins X.

When using `jx create cluster aws`, `jx create cluster eks` or `jx install --provider=(aws|eks)` you are prompted if you want to use DNS and optionally setup a wildcard DNS CNAME record on Route 53; if not we are assuming you're gonna avoid DNS to kick the tires on a single availability zone IP address by resolving the NLB host name to one of the availability zone IP addresses.

Note if you wish to use a different git provider than GitHub for your environments see [how to use a different git provider](/developing/git/#using-a-different-git-provider-for-environments)


### EKS

Use the [jx create cluster eks](/commands/jx_create_cluster_eks) command: 

    jx create cluster eks

Under the covers this will download and use the [eksctl](https://eksctl.io/) tool to create a new EKS cluster, then it'll install Jenkins X on top.


### Kops

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

Before you start you may find [this blog helpful](https://cloudblogs.microsoft.com/opensource/2019/03/06/jenkins-x-azure-kubernetes-service-setup/).

Use the [jx create cluster aks](/commands/jx_create_cluster_aks) command: 

    jx create cluster aks
    
Now **[develop apps faster with Jenkins X](/getting-started/next/)**.


## Using Oracle (OKE)

Use the [jx create cluster oke](/commands/jx_create_cluster_oke) command: 

    jx create cluster oke
    
This will use [oci](https://github.com/oracle/oci-cli) on your Oracle Cloud Infrastructure account to create a new OKE cluster and install Jenkins X. 

Please add your $HOME/bin to $PATH otherwise jx will have issue invoking OCI CLI command. If you have already installed OCI CLI, please make sure it is in $PATH.

Now **[develop apps faster with Jenkins X](/getting-started/next/)**.

## Using IBM Cloud Kubernetes Service (IKS)

Use the [jx create cluster iks](/commands/jx_create_cluster_iks) command: 

    jx create cluster iks --apikey=<IBM Cloud API Key>
    
This will use [IBM Cloud CLI](https://console.bluemix.net/docs/cli/index.html#overview) on your IBM Cloud Infrastructure account to create a new IKS cluster and install Jenkins X. 

You need to make sure you have the $HOME/.jx/bin folder in your $PATH.

Now **[develop apps faster with Jenkins X](/getting-started/next/)**.

## Using Minikube (local) 
    
Some folks have trouble getting minikube to work for a variety of reasons:

* minikube requires up to date virtualisation software to be installed and your machine 
* you may have an old Docker installation or old minikube / kubectl or helm binaries and so forth.

So we **highly** recommend using one of the public clouds above to try out Jenkins X. They all have free tiers so it should not cost you any significant cash and it'll give you a chance to try out the cloud.

**minikube does not produce a public-facing IP so webhooks will not be able to reach the cluster. As a result, only polling for changes works and it might take a long while for pipelines to fire.**

If you still want to try minikube then we recommend letting jx create the cluster for you (as opposed to installing jx into an existing minikube cluster) by running:

    jx create cluster minikube
    
You'll be prompted for the amount of memory, cores, and disk size to use, and also the driver.

A known good configuration on a 2015 model Macbook Pro is to use 8 GB of RAM, 8 cores*, a 150 GB disk size and hyperkit. For installing hyperkit, see the [hyperkit installation documentation](https://github.com/kubernetes/minikube/blob/master/docs/drivers.md#hyperkit-driver).

The disk size is particularly large as a number of images will need to be downloaded. These are used by jx and here are the sizes at the time of this document:

```
jxpv1                           8Gi        RWO            Recycle          Bound       jx/jenkins-x-nexus                                                               5d
jxpv2                           100Gi      RWO            Recycle          Bound       jx/jenkins-x-docker-registry                                                     6d
jxpv3                           8Gi        RWO            Recycle          Bound       jx/jenkins-x-mongodb                                                             22h
jxpv4                           30Gi       RWO            Recycle          Bound       jx/jenkins                                                                    6d
```

"I get `Error creating cluster exit status 1`, or it seems to be hanging - what should I do?"

Check to see if `minikube status` reports that minikube is actually already running. If it is, do `minikube stop` and then repeat the cluster creation process. Removing your `~/.minikube` directory is also known to help: you want to make sure you have a clean environment with a working driver installed before attemping to run `jx create cluster minikube`.

"I get `Error: Command failed kubectl create clusterrolebinding add-on-cluster-admin --clusterrole cluster-admin --serviceaccount kube-system:default`, help!"

The cluster role binding may exist through your use of Minikube before with RBAC. Delete any existing cluster role binding with the above name (`kubectl delete clusterrolebinding add-on-cluster-admin`) and then repeat the `jx create cluster minikube` command.

If the above proceeds OK, you'll be greeted with `Please enter the name you wish to use with git:`.

* you can specify more cores than you actually have!

Now **[develop apps faster with Jenkins X](/getting-started/next/)**.

## Using Minishift (local)

If you want to try out Jenkins X on a local OpenShift cluster then you can try using minishift.

**minishift does not produce a public-facing IP so webhooks will not be able to reach the cluster. As a result, only polling for changes works and it might take a long while for pipelines to fire.**

To create a minishift VM with Jenkins X installed on it try the [jx create cluster minishift](/commands/jx_create_cluster_minishift) command:

    jx create cluster minishift

Now **[develop apps faster with Jenkins X](/getting-started/next/)**.


## Troubleshooting

If you hit any issues installing Jenkins X then please check out our [troubleshooting guide](/troubleshooting/faq/) or [let us know](/community) and we'll try our best to help.

