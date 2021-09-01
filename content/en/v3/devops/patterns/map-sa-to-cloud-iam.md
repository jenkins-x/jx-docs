---
title: Map Cloud IAM to Kubernetes Service Accounts
linktitle: Map Cloud IAM to Kubernetes Service Accounts
description: Simplify your setup on the cloud by mapping kubernetes Service Accounts to cloud IAM roles
type: docs
weight: 320
---
      
Cloud providers make it relatively easy to map kubernetes `Service Account` resources to cloud IAM roles and accounts which avoids having to expose secrets to access cloud resources which simplifies things and makes your applications more secure.

On AWS use [IAM roles for service accounts](https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts.html) (IRSA)

On GCP use [Workload Identity](https://cloud.google.com/kubernetes-engine/docs/how-to/workload-identity) (WLI)

In both cases this maps cloud IAM roles to kubernetes `ServiceAccount` resources using annotations.

This means that you don't have to populate your kubernetes cluster with cluster-admin style cloud IAM secrets - which makes your system more secure and reduces the possibility of accidentally exposing a secret.

Note that if you use [Jenkins X to configure your clusters with Terraform and GitOps](/v3/admin/) then you get this out of the box!
