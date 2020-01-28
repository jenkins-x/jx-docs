---
title: Google Cloud
linktitle: Google Cloud
description: Using Boot on Google Cloud (GCP)
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
weight: 10
---

## Setting up your cluster

To setup the kubernetes cluster we recommend `jx create cluster gke --skip-installation` which should add the scopes required to your node pool to be able to push images to GCR. 

If you setup your cluster directly via the web console or `gcloud` you may need to setup those scopes yourself. e.g. with `gcloud` add `--scopes` for the following scopes:

* https://www.googleapis.com/auth/cloud-platform
* https://www.googleapis.com/auth/compute
* https://www.googleapis.com/auth/devstorage.full_control
* https://www.googleapis.com/auth/service.management
* https://www.googleapis.com/auth/servicecontrol
* https://www.googleapis.com/auth/logging.write
* https://www.googleapis.com/auth/monitoring


## Configuration

On GCP we default to using GCR as the container registry (using `gcr.io`).

Please set your provider to `gke` via this in your `jx-requirements.yml` to indicate you are using GCP:

```yaml    
clusterConfig:
    provider: gke
```

We also recommend using [Jenkins X Pipelines](/architecture/jenkins-x-pipelines/) as this works out of the box with kaniko for creating container images without needing a docker daemon and works well with GCR.