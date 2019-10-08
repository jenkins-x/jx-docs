---
title: Google
linktitle: Google
description: How to create a kubernetes cluster on the Google Cloud Platform (GCP)
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
weight: 50
---


## Using the Google Cloud Console

You can create Kubernetes clusters in a few clicks on the [Google Cloud Console](https://console.cloud.google.com/)

First make sure you have created/selected a Project:

<img src="/images/quickstart/gke-select-project.png" class="img-thumbnail">


Now you can click the `create cluster` button on the [kubernetets clusters](https://console.cloud.google.com/kubernetes/list) page or try [create cluster](https://console.cloud.google.com/kubernetes/add)



## Using gcloud

The CLI tool for working with google cloud is called `gcloud`. If you have not done so already please [install gcloud](https://cloud.google.com/sdk/install)

To create a cluster with gcloud [follow these instructions](https://cloud.google.com/kubernetes-engine/docs/how-to/creating-a-cluster)


## Using Google Cloud Shell

To avoid having to install `gcloud` you can use the [Google Cloud Shell](https://console.cloud.google.com/) as it already comes with most of the things you may need to install (`git, gcloud, kubectl` etc).

First you need to open the Google Cloud Shell via the button in the toolbar:

<img src="/images/quickstart/gke-start-shell.png" class="img-thumbnail">

You can then create a cluster with `gcloud` by [following these instructions](https://cloud.google.com/kubernetes-engine/docs/how-to/creating-a-cluster)

## Connecting to your cluster

Once you have created a cluster, you need to connect to it so you can access it via the `kubectl` or [jx](/docs/getting-started/setup/install/) command line tools.

To do this click on the `Connect` button on the [Kubernetes Engine page](https://console.cloud.google.com/kubernetes/list) in the [Google Console](https://console.cloud.google.com/)

<img src="/images/quickstart/gke-connect.png" class="img-thumbnail">

You should now be able to use the `kubectl` and `jx` CLI tools on your laptop to talk to the GKE cluster. e.g. this command should list the nodes in your cluster:

```sh
kubectl get node
```
