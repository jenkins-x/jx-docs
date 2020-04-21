---
title: Connectivity
linktitle: Connectivity
description: Connectivity requirements for running Jenkins-X
weight: 30
---

The tables below list some of the connectivity requirements for Jenkins X. These tables only apply to JX clusters
secured with TLS.

## Ingress

| Service                   | Protocol | Port | Reason                                     |
| ------------------------- | -------- | ---- | ------------------------------------------ |
| Kube API Server           | HTTPS    | 443  | Allow the JX cli to connect to the cluster | 
| Nexus                     | HTTPS    | 443  | For developers using maven, to allow them to download/proxy artifacts stored in nexus |
| Hook                      | HTTPS    | 443  | To receive webhook events from the git provider |
| Chartmuseum               | HTTPS    | 443  | Remote clusters to download helm charts |

## Egress

| Service                   | Protocol | Port | Location | Reason |
| ------------------------- | -------- | ---- | -------- | ------ |
| Docker Images             | HTTPS    | 443  | dockerhub/gcr.io | |
| Docker Registry           | HTTPS    | 443  | gcr.io | | 
| Docker Registry (Internal) | HTTP    | 8080 | docker-registry-pod | |
| Nexus                     | HTTPS    | 443  | mirrored repositories | |
| Git Provider              | HTTPS    | 443  | provider dependent | 
| Storage                   | HTTPS    | 443  | GCS/S3 | Log Storage | 
| github.com                | HTTPS    | 443  | github.com | version stream, build packs & quickstarts |
