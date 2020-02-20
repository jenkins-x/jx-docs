---
title: Google
linktitle: Google
description: How to create a kubernetes cluster on the Google Cloud Platform (GCP)?
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
weight: 50
---
# Creating a Google cluster

To create a Google cluster you can either do so using the `jx` command line,
[Google Cloud Console](#using-the-google-cloud-console) or
[gcloud](#using-gcloud),
be aware though that the smallest possible machine
to host Jenkins X is the `n1-standard-2` machine-type.

Furthermore, to be able to use `jx` storage features like log storage or backups,
your cluster needs additional permissions, see [GKE Storage Permissions](https://jenkins-x.io/docs/managing-jx/common-tasks/storage/#gke-storage-permissions).

## Using the JX command line

If you have the JX command line setup locally, you can run `jx create cluster gke --skip-installation` to create a GKE cluster from there with defaults.

## Using the Google Cloud Console or CLI

To setup the kubernetes cluster we recommend `jx create cluster gke --skip-installation` which should add the scopes required to your node pool to be able to push images to GCR. 

If you setup your cluster directly via the web console or `gcloud` you may need to setup those scopes yourself. e.g. with `gcloud` add `--scopes` for the following scopes:

* https://www.googleapis.com/auth/cloud-platform
* https://www.googleapis.com/auth/compute
* https://www.googleapis.com/auth/devstorage.full_control
* https://www.googleapis.com/auth/service.management
* https://www.googleapis.com/auth/servicecontrol
* https://www.googleapis.com/auth/logging.write
* https://www.googleapis.com/auth/monitoring


### Using the Google Cloud Console

You can create Kubernetes clusters in a few clicks on the [Google Cloud Console](https://console.cloud.google.com/).

First make sure you have created/selected a Project:

<img src="/images/quickstart/gke-select-project.png" class="img-thumbnail">


Now you can click the `create cluster` button on the [kubernetes clusters](https://console.cloud.google.com/kubernetes/list) page or try [create cluster](https://console.cloud.google.com/kubernetes/add).


### Using gcloud

The CLI tool for working with google cloud is called `gcloud`. If you have not done so already please [install gcloud](https://cloud.google.com/sdk/install).

To create a cluster with gcloud [follow these instructions](https://cloud.google.com/kubernetes-engine/docs/how-to/creating-a-cluster).




## Connecting to your cluster

Once you have created a cluster, you need to connect to it so you can access it via the `kubectl` or [jx](/docs/getting-started/setup/install/) command line tools.

To do this click on the `Connect` button on the [Kubernetes Engine page](https://console.cloud.google.com/kubernetes/list) in the [Google Console](https://console.cloud.google.com/).

<img src="/images/quickstart/gke-connect.png" class="img-thumbnail">

You should now be able to use the `kubectl` and `jx` CLI tools on your laptop to talk to the GKE cluster. e.g. this command should list the nodes in your cluster:

```sh
kubectl get node
```
