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
jx gitops helmfile add --chart jenkinsci/jenkins --namespace myjenkins
```

That will add a new `helmfile/myjenkins/helmfile.yaml` file.

Now git commit that file:

```bash 
git commit -a -m "fix: added new jenkins service"
```

To see how to customize your Jenkins server see [how to customize the charts](/v3/develop/apps/#customising-charts) by adding a `values.yaml` file via the `values:` entry in the helmfile to configure whatever you need (e.g. Jenkins plugins and jobs etc).


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
