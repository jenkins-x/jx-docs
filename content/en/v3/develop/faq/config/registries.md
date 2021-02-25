---
title: Registries
linktitle: Registries
type: docs
description: Questions on registries and repositories
weight: 150
---

## How do I use a custom container registry?

To allow a pipeline to be able to push to a container registry you can add this secret...

```bash
kubectl create secret generic container-registry-auth  \
  --from-literal=url=myserver.com \
  --from-literal=username=myuser \
  --from-literal=password=mypwd
```

This will then take effect the next time a commit merges on your cluster git repository e.g. next time you [upgrade your cluster](/v3/guides/upgrade/#cluster).

The various container registry secrets get merged into a `Secret` called `tekton-container-registry-auth` in the `jx` namespace which is associated with the default pipeline `ServiceAccount` `tekton-bot`.


If you want all pipelines to use this container registry then modify the `cluster.registry` field in your `jx-requirements.yml` file:

```yaml
cluster:
  registry: myserver.com 
...
```

Otherwise you can enable this new container registry on a specific application/repository by adding this `.jx/variables.sh` file into the git repository if it doesn't exist...
 
```bash
export DOCKER_REGISTRY="myserver.com"
```
      
## How do I switch to github pages for charts?

Using a local chart museum or bucket repo chart for installing charts can be troublesome if you just have 1 cluster and you are using it for dev, staging and production. 

e.g. if you delete your cluster and try reboot everything, there's initially no chart museum or bucket repo so that the staging / production helmfiles won't be able to find the charts and your boot job will fail.
    
Using [multiple clusters](/v3/admin/guides/multi-cluster/) at least lets you destroy and recreate each cluster independently.

A workaround while you bring back your cluster is to comment out the staging and production `helmfile.yaml` files in the `helmfile.yaml` file in the root directory.

We recommend [using cloud services and storage where possible](/v3/devops/cloud-native/#prefer-cloud-over-kubernetes). 

Longer term we expect folks to move towards using OCI and your container registry to host your helm charts so that its always highly available in all clusters/locations. Though there is still integration work required with [helm](https://helm.sh/) and [helmfile](https://github.com/roboll/helmfile) to make that completely seamless right now (particularly with secrets and cloud IAM roles).

So one option is to use github pages as your chart repository - so that your charts are always accessible for the staging/production namespaces/clusters even if you recreate your cluster from scractch.

To switch to use github pages for your container registry, modify your [jx-requirements.yml](https://github.com/jenkins-x/jx-api/blob/master/docs/config.md#requirements) to:
          
```yaml
apiVersion: core.jenkins-x.io/v4beta1
kind: Requirements
spec:
  ...
  cluster:
    chartRepository: https://github.com/myorg/mycharts.git
    chartKind: pages  
    ...
```


## How do I switch to bucketrepo?

To switch from `nexus` to `bucketrepo` in V3 there are a few changes you need to make. 

Incidetally the [jx3-kubernetes](https://github.com/jx3-gitops-repositories/jx3-kubernetes/blob/master/) repository is already setup for`bucketrepo`.

Please make the following changes...

* remove your old `nexus` chart from `helmfiles/jx/helmfile.yaml`
* add this to your `jx-requirements.yml` file so its like [this one](https://github.com/jx3-gitops-repositories/jx3-kubernetes/blob/master/jx-requirements.yml#L8)

```yaml 
apiVersion: core.jenkins-x.io/v4beta1
kind: Requirements
spec:
  ...
  cluster:
    chartRepository: http://bucketrepo.jx.svc.cluster.local/bucketrepo/charts
...
  repository: bucketrepo
    
```
* add the `bucketrepo` chart to your `helmfiles/jx/helmfile.yaml` file [like this](https://github.com/jx3-gitops-repositories/jx3-kubernetes/blob/master/helmfiles/jx/helmfile.yaml#L42):

```yaml 
...
releases:
- chart: jenkins-x/bucketrepo
  name: bucketrepo
...
```

then git commit and you should have your cluster switched to bucketrepo



