---
title: OpenShift CodeReady Containers
linktitle: OpenShift CRC
type: docs
description: Use Jenkins X and OpenShift 4.x on your laptop
weight: 70
aliases:
  - /v3/admin/guides/infra/openshift-crc
  - /docs/v3/guides/infra/openshift-crc
---


This guide will walk you though how to setup Jenkins X on your laptop using [OpenShift 4.x with CodeReady Containers](https://cloud.redhat.com/openshift/install/crc/installer-provisioned)

## Prerequisites

* [download OpenShift 4.x with CodeReady Containers](https://cloud.redhat.com/openshift/install/crc/installer-provisioned)


* once you have the `crc` binary setup the amount of memory and disk:


```bash
crc config set cpus 6
crc config set memory 11264

crc start
```      

* once your cluster boots up you can setup your environment...

```bash
eval $(crc oc-env)
```

You can copy/paste the `oc login -u kubeadmin` login command....

```bash
oc login -u kubeadmin -p XXXX https://api.crc.testing:6443
```

* to allow Tekton to be installed on OpenShift you also need to run the [following commands](https://github.com/tektoncd/pipeline/blob/master/docs/install.md#installing-tekton-pipelines-on-openshift):


```bash
oc new-project tekton-pipelines
oc adm policy add-scc-to-user anyuid -z tekton-pipelines-controller
oc adm policy add-scc-to-user anyuid -z tekton-pipelines-webhook
```

## Setup

*  <a href="https://github.com/jx3-gitops-repositories/jx3-openshift-crc/generate" target="github" class="btn bg-primary text-light">Create the cluster Git Repository</a> based on the [jx3-gitops-repositories/jx3-openshift-crc](https://github.com/jx3-gitops-repositories/jx3-openshift-crc/generate)                                                                                                                                       template

* `git clone` the new repository and `cd` into the git clone directory

* to enable webhooks you need to [install and setup ngrok](https://ngrok.com/)

* setup a webhook tunnel to your laptop:

```bash
ngrok http http://hook-jx.apps-crc.testing
```

* copy your personal ngrok domain name of the form `abcdef1234.ngrok.io` into the `charts/jenkins-x/jxboot-helmfile-resources/values.yaml` file in the `ingress.customHosts.hosts` file so that your file looks like this...

```yaml
ingress:
  customHosts:
    hook: "abcdef1234.ngrok.io"
...
```

* git add, commit and push your changes:

```bash
git add *
git commit -a -m "fix: configure webhooks"
git push origin master
```

* <a href="/docs/v3/guides/operator/" class="btn bg-primary text-light">Install the Git Operator</a> 

* switch to the `jx` namespace

```bash    
jx ns jx
```        

*  <a href="/docs/v3/develop/create-project/" class="btn bg-primary text-light">Create or import projects</a>
