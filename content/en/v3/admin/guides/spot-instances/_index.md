---
title: Spot Instances For Builds
linktitle: Spot Instances For Builds
type: docs
description: How to use spot instances to handle all Tekton builds
weight: 120
aliases:
  - /v3/guides/spot-instances-for-builds
---

Using spot instances for builds is a great way to detach your builds (increasing stablility on your deployed applications) and save money.

Jenkins X supports a [Tekton](https://Tekton.dev/) helm chart that lets configuring spot instances for builds really easy. 

Let's discuss:
* Why spot instances are a good fit for builds 
* How to setup spot instances with your terraform module
* Making Tekton run all jobs with those taints/affinity by default


## Why spot instances are a good fit for builds

Spot instances are the free resources your cloud provider are not using, this means you can use them for a reduced price at the cost of disruption to the service.

Spot instances are ideal for:
* Dev/Test environments
* CI/CD workloads
* High performance computing
* Batch processing jobs

It's a great way for us to save money on builds while ensuring you can give them enough resources to run quickly. It's also a scalable to zero and doesn't matter if you have to wait for a machine to be allocated.

## How to setup spot instances with your terraform module

Work has been completed on [AWS](https://github.com/jenkins-x/terraform-aws-eks-jx/pull/76) and [Azure](https://github.com/jenkins-x-terraform/terraform-jx-Azure/pull/23), if someone would like to implement this on GCP (or another cloud provider), please join us in #jenkins-x-dev in slack.

### Azure

On Azure, there are a few parameters to configure to enable spot instances:

```
# This sets whether to use spot or standard nodes for the builds, so we'll leave this as true
use_spot=true

# Sets the max price that you want to pay for your certain machine, if this is -1 that makes it so you'll pay the current max price for spot
spot_max_price = -1

# Sets the type of vm you would like, if this isn't specified, the build node pool won't be created
build_node_size="Standard_D4s_v3"

# The minimum count of nodes, for spot, you have to use 0
min_build_node_count = 0

# The maximum amount of nodes you'd like to have
max_build_node_count = 5
```

Then run your:

`terraform plan`

`terraform apply`

## Making Tekton run all jobs with those taints/affinity by default

As all the builds are handled by Tekton, we can use their strategy for applying defaults to pipelineActivities, which is done through a configmap in the tekton-pipelines namespace.

We'll want to add the toleration to the pod template, so that they're able to be allocated to the new spot nodes that we've created.
If we want to ensure the builds are done on the nodes that we've created, without an option to be allocated to the other machines, we'll also want to add an affinity.

**I'm going to be showing this with the Azure examples, Azure by default adds a specific spot taint, so we'll need to add that too.**


### Applying the helmfile changes to the gitops repository
The Tekton helm chart has a value override for config-defaults, we can apply this in the gitops repository helmfile by modifying:
`helmfiles/Tekton-pipelines/helmfile.yaml`

**Modify this entry:**
```
- chart: cdf/Tekton-pipeline
  version: 0.27.2
  name: Tekton-pipeline
  values:
  - ../../versionStream/charts/cdf/Tekton-pipeline/values.yaml.gotmpl
  - jx-values.yaml
```

**To be:**
```
- chart: cdf/Tekton-pipeline
  version: 0.27.2
  name: Tekton-pipeline
  values:
  - ../../versionStream/charts/cdf/Tekton-pipeline/values.yaml.gotmpl
  - jx-values.yaml
  - Tekton-pipeline.yaml
```

**We now need to create the Tekton-pipeline.yaml file within the same directory as the helmfile we've just created:**
```
configDefaults:
  default-pod-template: |
    tolerations:
    - key: "sku"
      operator: "Equal"
      value: "build"
      effect: "NoSchedule"
    - key: "kubernetes.Azure.com/scalesetpriority"
      operator: "Equal"
      value: "spot"
      effect: "NoSchedule"
    affinity:
      nodeAffinity:
        requiredDuringSchedulingIgnoredDuringExecution:
          nodeSelectorTerms:
          - matchExpressions:
            - key: "agentpool"
              operator: "In"
              values: 
              - "buildnode"
```

Here we can see that we're adding 2 tolerations to make the pipeline activites allowed to be assigned to these nodes.
```
sku: build
kubernetes.Azure.com/scalesetpriority: spot
```

We're also adding the affinity to specfically select the nodes with the label:
```
agentpool: buildnode
```

Then if we apply this to the gitops repository, spot instances will start running your builds and saving you money!