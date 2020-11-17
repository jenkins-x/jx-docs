---
title: OpenShift
linktitle:  OpenShift
type: docs
description: Setup Jenkins X on an existing OpenShift cluster
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2020-02-21
weight: 200
aliases:
  - /docs/v3/getting-started/openshift
---

If you don't have a cluster or want to try Openshift on your laptop then please try <a href="/docs/v3/guides/infra/openshift-crc/" target="github" class="btn bg-primary text-light">Install Jenkins X with OpenShift CodeReady Containers</a> 
 

---
**NOTE**

Ensure you are logged into GitHub else you will get a 404 error when clicking the links below

---

## Prerequisites

* OpenShift cluster is installed and working correctly. You have also installed the `oc` binary on your `$PATH`


```bash
oc login -u kubeadmin -p ...
```

* to allow Tekton to be installed on OpenShift you also need to run the [following commands](https://github.com/tektoncd/pipeline/blob/master/docs/install.md#installing-tekton-pipelines-on-openshift):


```bash
oc new-project tekton-pipelines
oc adm policy add-scc-to-user anyuid -z tekton-pipelines-controller
oc adm policy add-scc-to-user anyuid -z tekton-pipelines-webhook
```

## Setup

*  <a href="https://github.com/jx3-gitops-repositories/jx3-openshift/generate" target="github" class="btn bg-primary text-light">Create the cluster Git Repository</a> based on the [jx3-gitops-repositories/jx3-openshift](https://github.com/jx3-gitops-repositories/jx3-openshift/generate) template

* `git clone` the new repository and `cd` into the git clone directory

* find out what your ingress domain is for your cluster then modify the `jx-requirements.yml` file and modify the `ingress.domain` section...

```yaml
cluster:
...
ingress:
  domain: mydomain.com
...
```

* git add, commit and push your changes:

```bash
git add *
git commit -a -m "fix: added domain"
git push origin master
```

* <a href="/docs/v3/guides/operator/" class="btn bg-primary text-light">Install the Git Operator</a> 

* switch to the `jx` namespace

```bash    
jx ns jx
```        

*  <a href="/docs/v3/develop/create-project/" class="btn bg-primary text-light">Create or import projects</a>


## Enable WebHooks

If your cluster is not accessible on the internet and you can't open a firewall to allow services like GitHub to access your ingress then you will need to enable webhooks as follows:
 

* [install and setup ngrok](https://ngrok.com/)

* setup a webhook tunnel to your laptop find your hook host name:

```bash
kubectl get ing
```

* copy the hook host name into...
 
```bash
ngrok http http://yourHookHost
```

* copy your personal ngrok domain name of the form `abcdef1234.ngrok.io` into the `charts/jenkins-x/jxboot-helmfile-resources/values.yaml` file in the `ingress.customHosts.hosts` file so that your file looks like this...

```yaml
ingress:
  customHosts:
    hook: "abcdef1234.ngrok.io"
...
```

