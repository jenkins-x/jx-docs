---
title: Amazon (AWS)
linktitle: Amazon (AWS)
description: Using Boot on Amazon (AWS)
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
weight: 20
---

We recommend you setup your cluster via [eksctl](https://eksctl.io/).

Please set your provider to `eks` via this in your `jx-requirements.yml` to indicate you are using EKS:

```yaml    
clusterConfig:
    provider: eks
```

If you wish to use AWS via something like `kops` and not use EKS then use the `aws` provider:

```yaml    
clusterConfig:
    provider: aws
```

If you wish to setup your EKS cluster by hand and not use [eksctl](https://eksctl.io/) then please specify `terraform: true` to indicating you are setting up all of the AWS related cloud resources yourself and that you do not want `jx boot` to try set anything up.

