---
title: Azure
linktitle: Azure
description: How to create a kubernetes cluster on Azure
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
weight: 40
---

You may find [this blog helpful](https://cloudblogs.microsoft.com/opensource/2019/03/06/jenkins-x-azure-kubernetes-service-setup/).


Otherwise ensure you [have installed the jx CLI](/docs/getting-started/setup/install/) then run:

```sh
jx create cluster aks --skip-installation
```