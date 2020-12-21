---
title: Getting Started 
linktitle: Getting Started
type: docs
description: Getting started with Jenkins and Jenkins X interop
weight: 20
aliases:
  - /v3/guides/jenkins/getting-started
---


Make sure you have got the [jx 3.x binary](/v3/guides/jx3/) and you have installed [version 3](/v3/admin/platform/) before proceeding.


## Adding Jenkins Servers into Jenkins X

You can use Jenkins X to install one or more Jenkins servers by running the following command in a git clone of your dev cluster git repository:

```bash 
jx gitops jenkins add --name myjenkins
```

That will add a new `helmfile/myjenkins/helmfile.yaml` file for the jenkins charts along with `helmfile/myjenkins/values.yaml` file that can be used to configure the [jenkins helm chart configuration values](https://github.com/jenkinsci/helm-charts/blob/main/charts/jenkins/VALUES_SUMMARY.md).

Now git commit that file:

```bash 
git commit -a -m "fix: added new jenkins service"
```

### Configure Jenkins 

To configure your Jenkins server edit the `helmfile/myjenkins/values.yaml` according to the [configuration guide](https://github.com/jenkinsci/helm-charts/blob/main/charts/jenkins/VALUES_SUMMARY.md).

Each Jenkins server has its own namespace so that its possible to use fine grained role based access for each server using Kubernetes RBAC.

In addition by default each Jenkins server gets to share the pipeline git user name and token so that it can access private git repositories in the same way as tekton pipelines.


### Importing projects or creating quickstarts

If you want to import repositories into your jenkins server or create quickstarts using `Jenkinsfile` files then follow the usual [user guide approach of creating projects](/v3/develop/create-project/).

Your new jenkins server will be added to the `.jx/gitops/source-config.yaml` file and so will be available to developers as a Jenkins server that can be used when importing projects.


### Accessing the Jenkins server 

You can switch to the jenkins namespace via the following and see the host name to open the console:

```bash 
jx ns myjenkins

kubectl get ing
```

Jenkins X will have generated a username of **admin** and a random password which is stored in your secret store (either Vault or your cloud secret manager).

To find the admin password so that you can login to Jenkins try:

```bash 
kubectl get secret jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode
```

You can find the URL to open Jenkins via: 

```bash 
echo http://`kubectl get ingress jenkins -o jsonpath="{.spec.rules[0].host}"`
```
