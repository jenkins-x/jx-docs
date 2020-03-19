---
title: Google
linktitle: Google
description: Using Boot on Google Cloud (GCP)
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
weight: 10
---

## Configuration

On GCP we default to using GCR as the container registry (using `gcr.io`).

Please set your provider to `gke` via this in your `jx-requirements.yml` to indicate you are using GCP:

```yaml
clusterConfig:
    provider: gke
```

We also recommend using [Jenkins X Pipelines](/architecture/jenkins-x-pipelines/) as this works out of the box with kaniko for creating container images without needing a docker daemon and works well with GCR.