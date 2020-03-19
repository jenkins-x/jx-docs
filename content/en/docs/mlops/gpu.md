---
title: "Working with GPUs"
date: 2020-03-13T15:03:05Z
linktitle: "Working with GPUs"
description: Setting up Jenkins X for use with GPU resources.
weight: 15
aliases:
  - /documentation/mlops/gpu
---

To use CUDA to accelerate your ML training and services, you first need to set up your Kubernetes cluster to add some physical GPU resources to your nodes.

To do this, typically you will need to request an allocation of GPU resources from your Cloud provider and then configure an additional Node Pool to provision a set of Nodes such that each Node has access to at least one physical GPU card.

See the documentation for your Cloud platform for details.
The instructions for GCP are here: [https://cloud.google.com/kubernetes-engine/docs/how-to/gpus](https://cloud.google.com/kubernetes-engine/docs/how-to/gpus)

Additionally, each Node will require a CUDA installation and the drivers appropriate to the physical accelerator cards chosen. Note that this introduces fixed dependencies upon the driver version for your specific hardware and the installed CUDA version that spans the entire Node Pool, impacting every service you deploy to this pool.

Be aware that you will be charged for use of the GPU resources from the point at which each Node starts up, NOT just whilst you are running a training! It is recommended to use elastic node scaling on your pool so that you release GPU resources that are not currently being utilised.

Once your cluster is configured, you can allocate GPU resources to containers as part of your application config.

For the training project, you will need to ensure that the build container used has access to GPU resources. This can be provisioned via the `jenkins-x.yml` file in that project, like this:

```
buildPack: ml-python-gpu-training

pipelineConfig:
  pipelines:
    overrides:
      - pipeline: release
        stage: training
        name: training
        containerOptions:
          resources:
            limits:
              cpu: 4
              memory: 32Gi
              nvidia.com/gpu: 1
            requests:
              cpu: 0.5
              memory: 8Gi
              nvidia.com/gpu: 1
```
Note that at the moment, it is not possible to modify the container resources of a single pipeline step, but only the resources for every container in a stage. As a result, it is necessary to perform all ML build activities in a single step in a dedicated stage or Kubernetes will attempt to allocate a physical GPU to a new container for every step in the stage, draining all available resources and likely blocking the build.

This pipeline config is set up for you in all the existing GPU quickstarts.

To configure the service project, you can adjust the resource section of the `values.yaml` file in the project chart to set `nvidia.com/gpu: 2` to indicate how many GPU cards to allocate to each Pod instance. Note that you cannot exceed the number of GPUs available to a Node and Pods may become unschedulable if there are insufficient free GPU cards in the pool.

Once you have deployed a GPU-based service, it will reserve the cards allocated to it, so care is needed to avoid running up unnecessarily large bills by leaving non-essential services or preview environments up.

You will, of course, have to ensure that your training script and service implementation code are set up to use CUDA features.