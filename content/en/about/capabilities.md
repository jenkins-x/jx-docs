---
title: Jenkins X Capabilities Matrix
linktitle: Capabilities Matrix
description: Matrix that describes the current state of Jenkins X capabilities for major Kubernetes platforms
type: docs
weight: 20
---

## Jenkins X Capabilities Matrix

| Capability | GKE | EKS | OpenShift 3.11 |
| --- | :---:| :---: | :---: |
| **Terraform scripts for cluster creation** | Yes | Yes | No |
| **`jx boot` for installation** | Yes | Yes | Yes |
| **Vault for secret storage** | Yes | Yes | Self Provisioned |
| **Kubernetes Versions** | | | |
| - 1.13 | Yes | No | N/A |
| - 1.14 | Yes | Yes | N/A |
| - 1.15 | Preview | Preview | N/A |
| - 1.16 | Preview | Preview |  N/A |
| **Source Control Providers** | | | |
| - Github | Yes | Yes | Yes |
| - Github Enterprise | Yes | Yes | Yes |
| - Gitlab CE | Preview | Preview | Preview |
| - Gitlab EE | Preview | Preview | Preview |
| - Bitbucket Server | Preview | Preview | Preview |
| - Bitbucket Cloud | No | No | No |
