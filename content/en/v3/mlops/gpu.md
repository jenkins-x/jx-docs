---
title: "Working with GPUs"
date: 2020-03-13T15:03:05Z
linktitle: "Working with GPUs"
description: Setting up Jenkins X for use with GPU resources.
weight: 15
type: docs
aliases:
  - /v3/mlops/gpu
---

To use CUDA to accelerate your ML training and services, you first need to set up your Kubernetes cluster to add some physical GPU resources to your nodes.

To do this, typically you will need to request an allocation of GPU resources from your Cloud provider and then configure an additional Node Pool to provision a set of Nodes such that each Node has access to at least one physical GPU card.

See the documentation for your Cloud platform for details.
The instructions for GCP are here: [https://cloud.google.com/kubernetes-engine/docs/how-to/gpus](https://cloud.google.com/kubernetes-engine/docs/how-to/gpus)

Additionally, each Node will require a CUDA installation and the drivers appropriate to the physical accelerator cards chosen. Note that this introduces fixed dependencies upon the driver version for your specific hardware and the installed CUDA version that spans the entire Node Pool, impacting every service you deploy to this pool.

Be aware that you will be charged for use of the GPU resources from the point at which each Node starts up, NOT just whilst you are running a training! It is recommended to use elastic node scaling on your pool so that you release GPU resources that are not currently being utilised.

Once your cluster is configured, you can allocate GPU resources to containers as part of your application config.

For the training project, you will need to ensure that the build container used has access to GPU resources. This can be provisioned by overriding the pipeline default for the build-training step in that project, like this:

```
➜ jx pipeline override
? pick the pipeline:  postsubmit/release
? pick the step:   [Use arrows to move, enter to select, type to filter]
  uses:jenkins-x/jx3-pipeline-catalog/tasks/git-clone/git-clone.yaml@versionStream
  next-version
  jx-variables
  build-flake8
> build-training
  build-export-model
```

This will modify your local copy of the pipeline in .lighthouse/jenkins-x/release.yaml like this:

```
apiVersion: tekton.dev/v1beta1
kind: PipelineRun
metadata:
  creationTimestamp: null
  name: release
spec:
  pipelineSpec:
    tasks:
    - name: from-build-pack
      resources: {}
      taskSpec:
        metadata: {}
        stepTemplate:
          image: uses:jenkins-x/jx3-pipeline-catalog/tasks/ml-python-gpu-training/release.yaml@versionStream
          name: ""
          resources:
            requests:
              cpu: "1"
              memory: 4Gi
              nvidia.com/gpu: "0"
            limits:
              cpu: "1"
              memory: 4Gi
              nvidia.com/gpu: "0"
          workingDir: /workspace/source
        steps:
        - image: uses:jenkins-x/jx3-pipeline-catalog/tasks/git-clone/git-clone.yaml@versionStream
          name: ""
          resources: {}
        - name: next-version
          resources: {}
        - name: jx-variables
          resources: {}
        - name: build-flake8
          resources: {}
        - image: ghcr.io/jenkins-x/builder-machine-learning-gpu:0.1.1317
          name: build-training
          resources:
            requests:
              cpu: "1"
              memory: 4Gi
              nvidia.com/gpu: "1"
            limits:
              cpu: "1"
              memory: 4Gi
              nvidia.com/gpu: "1"
          script: |
            #!/bin/sh
            source /root/.bashrc
            python3 -m pip install -r ./requirements.txt
            python3 app.py
        - name: build-export-model
          resources: {}
  podTemplate: {}
  serviceAccountName: tekton-bot
  timeout: 12h0m0s
status: {}

```

The first set of resources specified in this file are the default values that are applied to any step that doesn't have a dedicated local resource spec. You can normally leave these as they are. Don't specify a GPU here, or every step will be allocated a GPU unnecessarily, which will be expensive.

The resources for the step called 'build-training' are the ones that specify the allocation for the container executing your training script. Increase these until your training runs consistently.

To configure the service project, you can adjust the resource section of the `values.yaml` file in the project chart to set `nvidia.com/gpu: 2` to indicate how many GPU cards to allocate to each Pod instance. Note that you cannot exceed the number of GPUs available to a Node and Pods may become unschedulable if there are insufficient free GPU cards in the pool.

Once you have deployed a GPU-based service, it will reserve the cards allocated to it, so care is needed to avoid running up unnecessarily large bills by leaving non-essential services or preview environments up.

You will, of course, have to ensure that your training script and service implementation code are set up to use CUDA features.
