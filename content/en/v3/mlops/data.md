---
title: "Managing Data"
date: 2020-03-13T15:03:05Z
linktitle: "Managing Data"
description: Approaches for working with data.
weight: 20
type: docs
aliases:
  - /v3/mlops/data
---

In most scenarios, you will be expecting to remotely access data hosted elsewhere on your network and can manage this in code as part of your training scripts and service implementations. There are however a couple of situations in which Jenkins X can help you to manage certain types of data.

## Handling data in Buckets

If you are working with data in the form of arbitrary files, you can transfer these to your training environment via a Storage Bucket in your Cloud project.

This usually results in your data being located at a URL thas should be in the form: s3://mybucket/tests/myOrg/myData/trainingset.xml where the protocol is set as appropriate to the Cloud provider you are using. You can then reference this in your training script.

You must ensure that the data has been uploaded to this bucket prior to starting the training build and should bear in mind that this command copies the specified file from the bucket to the working volume of the build container executing the current build step.

## Working with Volumes

Under some circumstances, you may wish to create versioned collections of immutable training data that can be shared across multiple models and which are too large to easily copy from buckets in a timely manner.

Under these circumstances, it is straightforward to create a named, persistent Kubernetes Volume within your Cloud project, mount it in read/write mode and upload your training data files to it, then unmount it ready for use.

Within your training pipelines, you can then specify that this volume be mounted during the training build, in read-only mode, in more than one project in parallel.

To do this, you need to modify your local copy of the pipeline in .lighthouse/jenkins-x/release.yaml in your training projects to reference the `volume` and `volumeMount` config necessary to connect the build container instance to your training data volume.

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
          volumeMounts:
            - name: trainingset
              mountPath: /trainingset
              readOnly: true 
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
  podTemplate: 
    volumes:
      - name: trainingset
        gcePersistentDisk:
          pdName: mytrainingvolume01
          fsType: ext4
          readonly: true
  serviceAccountName: tekton-bot
  timeout: 12h0m0s
status: {}
```

Note that it is only possible to simultaneously share volumes that are mounted read-only.
