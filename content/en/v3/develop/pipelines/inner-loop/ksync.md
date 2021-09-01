---
title: ksync
linktitle: ksync
type: docs
description: Using ksync with Jenkins X
weight: 200
---
          
You can use [ksync](https://ksync.github.io/ksync/) to synchronise your local source code with a running pod which you can then use to perform incremental builds inside kubernetes.

```bash
kubectl run -ti --image maven maven-build-pod bash
ksync create -n jx --pod maven-build-pod $(pwd) /
ksync watch

# then in your build pod run `mvn clean install` or `mvn spring-boot:run` or whatever
```
