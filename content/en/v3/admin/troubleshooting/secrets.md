---
title: Secrets
linktitle: Secrets
type: docs
description: How to diagnose and fix issues with secrets
weight: 120
---

# Commons problems with Secrets

Things to check:
- the general health
```
jx health status -A
```
- the boot job
```
jx admin logs
```
and make sure in the logs `jx secret populate` command is successful.

- check the external secrets deployment and logs

```
kubectl get pods -n secret-infra
kubectl logs deploy/kubernetes-external-secrets -n secret-infra
```
- check the status of the external secret using `kubectl`
```
kubectl get es -n [the namespace the secret / external secret is in]
```
