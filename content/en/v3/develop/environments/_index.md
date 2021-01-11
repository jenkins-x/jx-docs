---
title: Environments
linktitle: Environments
type: docs
description: Environments and Promotion
weight: 400
---

Jenkins X supports multiple environments for hosting your applications such as `Development`, `Staging` and `Production`.

You can also use environments for different kinds of testing: system, integration, load, soak or regression tests.

The default configuration is a single cluster setup with `Staging` and `Production` environments which map to local namespaces `jx-staging` and `jx-production` inside the same cluster.

However for real enterprise setups we recommend using the [Multi Cluster Setup](/v3/admin/guides/multi-cluster/) where your `Production` and maybe `Staging` environments are setup in separate clusters; ideally with separate cloud provider accounts so that they can be completely isolated from each other.
