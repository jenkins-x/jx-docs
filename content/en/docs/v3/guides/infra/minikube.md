---
title: Minikube
linktitle: Minikube
description: Using minikube to run Jenkins X on your laptop
weight: 50
---


This guide will walk you though how to setup Jenkins X on your laptop using [minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/)

## Prerequisites

* [Download and install the jx 3.x binary](/docs/v3/guides/jx3/)

* [Install minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/)

NOTE:- User of windows 10 home (Hyper-V not supported). To install Minikube consider Docker as driver(docker should be pre-installed)
       instead of virtualBox driver. Use command "minikube start --driver=docker".

* You need to create a `minikube` cluster via the following command:

```bash
minikube start --cpus 4 --memory 8048 --disk-size=100g --addons=ingress --vm=true
```

## Setup

*  <a href="https://github.com/jx3-gitops-repositories/jx3-minikube/generate" target="github" class="btn bg-primary text-light">Create the cluster Git Repository</a> based on the [jx3-gitops-repositories/jx3-minikube template](https://github.com/jx3-gitops-repositories/jx3-minikube/generate) 

* `git clone` the new repository and `cd` into the git clone directory

* configure the `ingress.domain` to point to your `$(minikube ip).nip.io`:

```bash
export DOMAIN="$(minikube ip).nip.io"
jx gitops requirements edit --domain $DOMAIN
```

* the `ingress.domain` in `jx-requirements.yml` should now be configured to the value of `$DOMAIN`

* to enable webhooks you need to [install and setup ngrok](https://ngrok.com/)

* setup a webhook tunnel to your laptop:

```bash
ngrok http 8080
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
git commit -a -m "fix: configurations for local minikube"
git push origin master
```

* <a href="/docs/v3/guides/operator/" class="btn bg-primary text-light">Install the Git Operator</a> 

* switch to the `jx` namespace

```bash    
jx ns jx
```        

* once Jenkins X is installed run the following command to enable webhooks via `ngrok`

```bash   
kubectl port-forward svc/hook 8080:80
```

*  <a href="/docs/v3/develop/create-project/" class="btn bg-primary text-light">Create or import projects</a>
