---
title: Cloud Native
linktitle: Cloud Native
type: docs
description: Cloud Native recommendations
weight: 200
---

One of the [Accelerate](/v3/devops/accelerate/) recommendations is around using the cloud well; letting developers use the cloud to solve software problems.

Here are a few of the lessons we have learnt about using the cloud well.


## Prefer cloud over kubernetes

You can deploy a database via a helm chart in your kubernetes cluster. Or you can configure your cloud provider to create a managed database offering.

You can deploy, say, [vault](https://www.vaultproject.io/) as helm charts inside your kubernetes cluster. Or you can use your cloud providers secret store solution such as:

* Alibaba Cloud KMS Secret Manager
* Amazon Secret Manager
* Azure Key Vault
* GCP Secret Manager

We recommend that if you have a choice; go with the cloud version. 

The main reason is these kinds of things are undifferentiated heavy lifting. Your cloud provider already can install, upgrade, backup and manage these services for you.

If you go with helm charts inside kubernetes then you need to make sure you backup to long term storage all the data (e.g. every Persistent Volume) and test out your backup and restore mechanisms.


### Prefer cloud databases

As your cloud provider can handle backups, upgrades and elastic scaling for you.

### Prefer cloud secret stores 

Over installing, upgrading, backing up + managing your own Vault

### Prefer cloud container registries

Over installing and managing your own nexus / artifactory / harbor / chart museuem

### Prefer hosted git hosting

Over installing and managing your own gitlab / gitea / bitbucket server

### Try avoid Persistent Volumes

Similar to the above; if you use cloud storage, cloud buckets, cloud container registries you have less data to backup since the cloud provider typically does this for you.

Remember that `Persistent Volume` resources in kubernetes are not free; you need to backup and manage them.
                                                                       

## Treat kubernetes clusters as cattle not pets

Get used to the idea you can delete a kubernetes cluster at any time and recreate it quickly.

e.g. to change region or machine type this will usually happen.


## Map IAM Roles to kubernetes Service Accounts

On AWS use [IAM roles for service accounts](https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts.html)

On GCP use [Workload Identity](https://cloud.google.com/kubernetes-engine/docs/how-to/workload-identity)

In both cases this maps cloud IAM roles to kubernetes `ServiceAccount` resources using annotations. 

This means that you don't have to populate your kubernetes cluster with cluster-admin style cloud IAM secrets - which makes your system more secure and reduces the possibility of accidentally exposing a secret.

Note that if you use [Jenkins X to configure your clusters with Terraform and GitOps](/v3/admin/) then you get this out of the box! 

## Terraform for cloud infrastructure

We are all using an increasing amount of cloud infrastructure. You can use your cloud providers CLI or web console to set things up. However it's hard to manage and version.

So we recommend the [GitOps approach](/v3/devops/gitops/) to all infrastructure; both cloud infrastructure and kubernetes charts, resources and configuration.

So to manage your infrastructure use a git repository with your [terraform](https://www.terraform.io/) configuration.

There is a catch 22 of how do you start to provision your first, say, kubernetes cluster using [terraform](https://www.terraform.io/) before you have any cloud infrastructure.

You could look at using [Terraform Cloud](https://www.terraform.io/cloud) as the place to setup your core cloud infrastructure.


## Try use the same GitOps approach everywhere

If you treat different clusters very differently in how you setup them up, install, upgrade, manage and monitor them you've given yourself more work to do and increase the changes of things going wrong or getting out of step.

So try using the same [GitOps approach](/v3/admin/guides/jenkins/gitops/) for all clusters in all environments.
