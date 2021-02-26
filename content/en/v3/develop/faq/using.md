---
title: Using
linktitle: Using
type: docs
description: Questions on using Jenkins X
weight: 150
---

## How do I list the apps that have been deployed?

There is a handy HTML report in your cluster dev git repository at **docs/README.md** which lists all the charts deployed in every namespace with their version.

You can see the helm charts that are installed along with their version, namespaces and any configuration values by looking at the `releases` section of your `helmfile.yaml` and `helmfile/*/helmfile.yaml` files in your cluster git repository.

You can browse all the kubernetes resources in each namespace using the canonical layout in the `config-root` folder. e.g. all charts are versioned in git as follows:

```bash 
config-root/
  namespaces/
   jx/
     lighthouse/
       lighthouse-webhooks-deploy.yaml    
```

You can see the above kubernetes resource, a `Deployment` with name `lighthouse-webhooks` in the namespace `jx` which comes from the `lighthouse` chart.

There could be some additional charts installed via Terraform for the [git operator](/v3/guides/operator/) and [health subsystem](/v3/guides/health/) which can be viewed via:

```bash 
helm list --all-namespaces
```                                                                                


## How do I use testcontainers?

If you want to use a container, such as a database, inside your pipeline so that you can run tests against your database inside your pipeline then use a [sidecar container in Tekton](https://tekton.dev/vault/pipelines-v0.16.3/tasks/#specifying-sidecars).

Here is [another example of a sidecar in a pipeline](https://tekton.dev/vault/pipelines-v0.16.3/tasks/#using-a-sidecar-in-a-task)

If you want to use a separate container inside a preview environment then add [charts or resources](/v3/develop/apps/#adding-charts) to the `preview/helmfile.yaml`



