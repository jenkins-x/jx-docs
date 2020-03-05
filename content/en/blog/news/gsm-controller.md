---
title: "Google Secrets Manager Kubernetes controller"
date: 2020-03-05T00:00:00-00:00
draft: false
description: >
  Google Secrets Manager Kubernetes controller
categories: [blog]
keywords: [Jenkins X,Community,2020]
slug: "gsm-controller"
aliases: []
author: James Rawlings
---

<figure>
<img src="/images/logo/secret-manager.png"/>
</figure>

In Jenkins X Labs we have been working with [Google Secrets Manager](https://cloud.google.com/secret-manager/docs) (which is currently in Beta so may still change).  It is an extremely nice experience and if you also use Google Container Engine (GKE), Googles managed Kubernetes service then we can make use of another cool feature, [Workload Identity](https://cloud.google.com/kubernetes-engine/docs/how-to/workload-identity) to automatically access secrets in their hosted service using a Kubernetes service account.

One of the initial challanges we had was we didn't see an obvious way to automatically add Kubernetes secrets that include the data stored in Secrets Manager.  So we created a little standalone controller that runs in a Kubernetes cluster and watches for Kubernetes secrets.  When one is added or updated with a particular annotation the controller will access the secret using it's ID in Secrets Manager and update the Kubernetes secret with the value.

# Example

Full docs can be found here https://github.com/jenkins-x-labs/gsm-controller/blob/master/README.md

## TL;DR

Create an empty secret
```
kubectl create secret generic my-secret
```
Add the magic annotation that the controller uses to lookup the correct secret in Googles Secret Manager
```
kubectl annotate secret my-secret jenkins-x.io/gsm-secret-id=foo
```
optionally if you want the Kubernetes secret to use a specifc key for the data you can add another annotation
```
kubectl annotate secret my-secret jenkins-x.io/gsm-kubernetes-secret-key=credentials.json
```

## Demo

<iframe width="640" height="360" src="https://www.youtube.com/embed/wLHgkhzeNe8" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

# Feadback
This is still early days and we'd love folks to try it and provide feedback ([slack](https://jenkins-x.io/community/#slack) or the new [labs issues](https://github.com/jenkins-x-labs/issues/issues)) on whether it is useful to others and how we can improve it together.
 
On Jenkins X we make use of Hashicorp's Vault which is great although it is another service users have to run, manage and upgrade.  Wherever possible Jenkins X aims to use the Cloud well, so when users are installing Jenkins X onto a Cloud Provider we would like to leverage their other managed services, reducing the deployments we need to run in users clusters for Jenkins X.