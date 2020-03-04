---
title: gcloud
linktitle: gcloud
description: Using gcloud to setup google cloud resources
weight: 10
---

# Prerequisites

Before you begin you need to install [gcloud](https://cloud.google.com/sdk/gcloud)

You may want to upgrade to the latest `gcloud`:

```bash 
gcloud components update
```

Now define a few environment variables:

- `NAMESPACE` is the Kubernetes namespace the base Jenkins X installation will installed into, note optionl apps installed during the boot process can be installed into different namespaces
- `CLUSTER_NAME` provide a unique cluster name for the GCP project
- `PROJECT_ID` the GCP project the cluster and other cloud resources will be created into
- `ZONE` the GCP zone to create the new cluster, e.g. `europe-west1-b`
- `ENV_GIT_OWNER` the GitHub organisation the GitOps environments are created, these are the repos that contain the meta data for each Jenkins X environment.  _Note_ the pipline user env vars below must have permission to create repos in the GitHub organisation

e.g.

```bash
export NAMESPACE=jx
export CLUSTER_NAME=test-cluster-foo
export PROJECT_ID=jx-development
export ZONE=europe-west1-b
export ENV_GIT_OWNER=<your git id>
```

## Simple way

To use the simple bash script to run the [gcloud](https://cloud.google.com/sdk/gcloud) commands run the following command in a terminal:


```bash
git clone https://github.com/jenkins-x-labs/cloud-resources.git
cd cloud-resources/gcloud
./create_cluster.sh
```

## Harder way

This way we'll list out all the [gcloud](https://cloud.google.com/sdk/gcloud) commands you will need to run in a terminal:

### Creating the Kubernetes Cluster

<div class="highlight">
<pre style="color:#f8f8f2;background-color:#272822;-moz-tab-size:4;-o-tab-size:4;tab-size:4"><code class="language-bash hljs" data-lang="bash">{{<gcp-create-cluster>}}</code></pre>
</div>


### Creating the cloud resources

<div class="highlight">
<pre style="color:#f8f8f2;background-color:#272822;-moz-tab-size:4;-o-tab-size:4;tab-size:4"><code class="language-bash hljs" data-lang="bash">{{<gcp-create-resources>}}</code></pre>
</div>
