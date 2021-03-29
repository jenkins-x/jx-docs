---
title: Prefer Cloud Over Kubernetes
linktitle: Prefer Cloud Over Kubernetes
description: Prefer your cloud provider service over a kubernetes chart
type: docs
weight: 300
---

You can deploy a database via a helm chart in your kubernetes cluster. Or you can configure your cloud provider to create a managed database offering.

You can deploy, say, [vault](https://www.vaultproject.io/) as helm charts inside your kubernetes cluster. Or you can use your cloud providers secret store solution such as:

* Alibaba Cloud KMS Secret Manager
* Amazon Secret Manager
* Azure Key Vault
* GCP Secret Manager

However installing a chart in kubernetes is a very different thing to having a fully managed service which considers things like:

* backups and replication of state across regions
* upgrades and schema migration
                  
So we recommend using the cloud provider implementation for things like databases, secret stores, log storage and and other services as it removes undifferentiated heavy lifting. 

[More background here](/v3/devops/cloud-native/#prefer-cloud-over-kubernetes)

Note that we absolutely love [kubernetes](https://kubernetes.io/); this pattern is not in any way a criticism of kubernetes. Its more that adopting this pattern is about outsourcing work work in managing, migrating, backing up and restoring persistent state to your cloud provider.