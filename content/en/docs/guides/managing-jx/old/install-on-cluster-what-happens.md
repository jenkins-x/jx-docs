---
title: What happens during installation
linktitle: What happens during installation
description: What does install Jenkins X actually do
date: 2018-07-10
publishdate: 2018-07-10
lastmod: 2018-07-10
categories: [getting started]
keywords: [install,kubernetes]
weight: 210
---

The Jenkins X CLI will do the following when installing the Jenkins X platform:

##  Install client binaries to manage your cluster

{{< alert >}}
If you are running on Mac OS X, Jenkins X is using `Homebrew` to install the various CLI. It will install it if not present.
{{< /alert >}}

### Install kubectl

[kubectl](https://kubernetes.io/docs/reference/kubectl/kubectl/) is the CLI of Kubernetes. It allows you to interact with your Kubernetes cluster via the API server. 

### Install Helm

Jenkins X will install the [helm](https://github.com/kubernetes/helm) client - (either  helm *2.x* or helm *3*), if it does not already exist in your command shell path. Helm is used for packaging applications/resources (called charts) on Kubernetes, and is rapidly becoming the default standard for doing so.

### Install cloud provider CLI

If you are using a public cloud, there will be an associated CLI for interacting with it. When install is called via the [jx create cluster](/docs/getting-started/setup/create-cluster/) command, the associated binary to your cloud provider will also be installed, if not present on your command shell path.

- `az` for AKS cluster (Azure)
- `gcloud` for GKE cluster (Google Cloud)
- `kops` for AWS cluster (Amazon Web Services)
- `eksctl` for [AWS EKS](https://aws.amazon.com/eks/) cluster
- `oci` for OKS cluster (Oracle Cloud)

If you want to run Jenkins X locally via minikube or minishift, the following binaries are added:

- `oc` (OpenShift CLI) and `minishift` for a local minishift cluster (OpenShift)
- `minikube` for a local minikube cluster

Last but not least, Jenkins X will install the VM driver when required, typically `xhyve` for Mac OS X or `hyperv` for Windows. Other drivers (VirtualBox, VMWare...) must be installed manually.

## Create the Kubernetes cluster

The cluster is then created using the cloud provider CLI (for example `az aks create` command  for Azure).

## Setup the Jenkins X platform

### Create the Jenkins X namespace

Then Jenkins X install will create a namespace for the Jenkins X platform where all the Jenkins X infrastructure components will reside. The default is *jx*

### Install Tiller (optional, only for Helm 2)

Tiller, the server part of Helm, is then deployed on the *kube-system* namespace. [Helm](https://www.helm.sh/) is THE package manager of Kubernetes and is used subsequently to deploy all other components of Jenkins X.

### Setup the Ingress controller

In a Kubernetes cluster, services and pods have IPs that are only routable from by the cluster network. In order for traffic to flow into the cluster, an Ingress must be created. An ingress is a collection of rules for routing traffic to your services inside Kubernetes. The ingress rules are configured in an ingress resource held on the Kubernetes API server, and an ingress controller has to be created to fulfil those ingress rules. Jenkins X does all this for you by setting up an ingress controller and associated backend plus ingress rules for the following services (once deployed):

- chartmuseum
- docker-registry
- jenkins
- monocular
- nexus

{{< alert >}}
By default, Jenkins X will expose the ingress via the *nip.io* domain and generate self-signed certificates. You can easily adapt them by using our own custom domain and certificate after the installation with `jx upgrade ingress --cluster`
{{< /alert >}}

### Configure git source repository

Jenkins X requires a git repository provider to be able to create the environment repositories. It defaults to GitHub if you did not provide a *git-provider-url* parameter. You need to provide a username and a token that would be used to interact with the git, especially Jenkins.

## Create Admin secrets

Jenkins X generates an administration password for Monocular/Nexus/Jenkins and save it in secrets. It then retrieves git secrets for the helm install (so they can be used in the pipelines).

### Clone the cloud environments repo

The [cloud environment repository](https://github.com/jenkins-x/cloud-environments) holds all the specific configuration and encrypted secrets that will be applied to the Jenkins Platform on your Kubernetes cluster. The secrets are encrypted and unencrypted by the Helm package manager. 

## Install the Jenkins X platform

The [Jenkins X Platform](https://github.com/jenkins-x/jenkins-x-platform) holds the Helm charts for installing the components that provide the Jenkins X true CD solution. These include 

- [Jenkins](https://github.com/jenkinsci/jenkins) a CI/CD pipeline solution
- [Nexus](https://www.sonatype.com/nexus-repository-oss) an artifact repository
- [ChartMuseum](https://github.com/kubernetes-helm/chartmuseum) - a Helm Chart repository
- [Monocular](https://github.com/kubernetes-helm/monocular) which provides a Web UI for searching and discovering charts deployed into your cluster via Jenkins X.
