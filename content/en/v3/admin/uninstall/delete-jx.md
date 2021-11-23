---
title: Delete only jx
linktitle: Delete only jx
type: docs
description: How to delete jx components from your cluster
weight: 100
---

Use this if you want to only delete Jenkins X from your cluster.

```bash
kubectl delete -R -f config-root/namespaces
kubectl delete -R -f config-root/cluster
```

If you installed jx on minikube/kind/k3s (local installations), refer to the docs of those platforms on how to uninstall the cluster.
