---
title: Install on Kubernetes - what happens
linktitle: Install on Kubernetes what happens
description: What does install Jenkins X actually do
date: 2018-07-10
publishdate: 2018-07-10
lastmod: 2018-07-10
categories: [getting started]
keywords: [install,kubernetes]
menu:
  docs:
    parent: "getting-started"
    weight: 30
weight: 30
sections_weight: 30
draft: false
toc: true
---

The Jenkins X CLI will do the following when installing the Jenkins X platform:

### Install Helm 

Jenkins X will install the [helm](https://github.com/kubernetes/helm) client - (either  helm *2.x* or helm *3*), if it does not already exist in your command shell path. Helm is used for packaging applications/resources (called charts) on Kubernetes, and is rapidly becoming the defacto standard for doing so.

Helm 2.x normally requires a cluster-side component - called tiller, that Jenkins X CLI will install on your kubernetes cluster for you, if it is not already present. Tiller is responsible for managing the deployment of your applications. In Helm 3, Tiller is no longer required.

### Install client binary for your cluster

If you are using a public cloud, there will be an associated CLI for interacting with it. When install is called via the [jx create aws](/getting-started/create-cluster/) command, the associated binary to your cloud provider will also be installed, if not present on your command shell path.

### Create the Jenkins X platform namespace

The Jenkins X install will create a namespace for the Jenkins X platform where all the Jenkins X infrastructure components will reside. The default is *jx*

### Setup the Ingress controller

In a Kubernetes cluster, services and pods have IPs that are only routable from by the cluster network. In order for traffic to flow into the cluster, an Ingress must be created. An ingress is a collection of rules for routing traffic to your services inside Kubernetes. The ingress rules are configured in an ingress resource held on the Kubernetes API server, and an ingress controller has to be created to fulfil those ingress rules. Jenkins X does all this for you - so you don't need to worry - phew!

### Create Admin secrets

Jenkins X generates an administration password for Monocular/Nexus/Jenkins, retrieves git secrets for the helm install (so they can be used in the pipelines).

### Configure Jenkins

Update Jenkins with the git server being used and the authorization for it

#### Clone the cloud environments repo

The (cloud environment repository)[https://github.com/jenkins-x/cloud-environments] holds all the specific configuration and encrypted secrets that will be applied to the Jenkins Platform on your Kubernetes cluster. The secrets are encrypted and unencrypted by the Helm package manager. 

### Install the Jenkins X platform

The (Jenkins X Platform)[https://github.com/jenkins-x/jenkins-x-platform] holds the Helm charts for installing the components that provide the Jenkins X true CD solution. These include [Jenkins](https://github.com/jenkinsci/jenkins) a CI/CD pipeline solution, [Nexus](https://www.sonatype.com/nexus-repository-oss) - an artifact repository,  [Chartmuseum](https://github.com/kubernetes-helm/chartmuseum) - a Helm Chart repository,and [Monocular]
(https://github.com/kubernetes-helm/monocular) which provides a Web UI for searching and discovering charts deployed into your cluster via Jenkins X.
