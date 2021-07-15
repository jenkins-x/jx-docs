---
title: Jenkins X の機能マトリックス
linktitle: 機能マトリックス
description: 主要な Kubernetes プラットフォームの Jenkins X の機能の現状を説明するマトリックス
type: docs
weight: 20
---

## Jenkins X の機能マトリックス

| 機能 | GKE | EKS | OpenShift 3.11 |
| --- | :---:| :---: | :---: |
| **クラスタ作成用 Terraform スクリプト** | Yes | Yes | No |
| **インストール用の `jx boot`** | Yes | Yes | Yes |
| **Secret 保管のための Vault** | Yes | Yes | Self Provisioned |
| **バケットログの保管** | Yes | Yes | No |
| **Kubernetes バージョン** | | | |
| - 1.13 | Yes | No | N/A |
| - 1.14 | Yes | Yes | N/A |
| - 1.15 | Preview | Preview | N/A |
| - 1.16 | Preview | Preview |  N/A |
| **ソース管理プロバイダ** | | | |
| - Github | Yes | Yes | Yes |
| - Github Enterprise | Yes | Yes | Yes |
| - Gitlab CE | Preview | Preview | Preview |
| - Gitlab EE | Preview | Preview | Preview |
| - Bitbucket Server | Preview | Preview | Preview |
| - Bitbucket Cloud | No | No | No |
