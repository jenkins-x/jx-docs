---
title: Delete jx and the cluster
linktitle: Delete jx and the cluster
type: docs
description: How to delete the cluster where jx is installed
weight: 200
---

Use this if you created the kubernetes cluster using the AWS/GCP/Azure terraform module.
This will also work, if you installed Jenkins X on an existing AWS EKS cluster.

{{< alert >}} Always examine the plan of the terraform destroy command before approving it, once destroyed there is no going back. {{< /alert >}}

- In case of **AWS**, manually delete the network load balancer (NLB) created by the nginx helm chart from your aws account.
- If you are using spot io or similar services, then you need to remove those nodes from the cluster.

- You can now safely run:

```bash
terraform destroy
```

- If you installed jx on minikube/kind/k3s (local installations), refer to the docs of those platforms on how to uninstall the cluster.
