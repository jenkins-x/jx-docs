---
title: Connectivity
linktitle: Connectivity
description: Connectivity requirements for running Jenkins-X
weight: 30
---

The tables below list some of the connectivity requirements for Jenkins X. These tables only apply to JX clusters
secured with TLS.

## Ingress

| Service                   | Protocol | Port | Reason                                       |
| ------------------------- | -------- | ---- | -------------------------------------------- |
| Kube API Server           | HTTPS    | 443  | Allow the JX cli to connect to the cluster | 
| Nexus
| Hook                      | HTTPS    | 443  | To receive webhook events from the git provider |


## Egress

| Service                   | Protocol | Port | Location | Reason                                       |
| ------------------------- | -------- | ---- | -------------------------------------------- |
| Docker Images             | HTTPS    | 443  | dockerhub/gcr.io
| Docker Registry           |
| Nexus                     | 
| Git Provider              |
| Storage                   |  
| github.com                | HTTPS    | 443  | github.com | version stream, build packs & quickstarts |
