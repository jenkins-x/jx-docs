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

### Importing projects or creating quickstarts

If you want to import repositories into your jenkins server or create quickstarts using `Jenkinsfile` files then follow the usual [user guide approach of creating projects](/v3/develop/create-project/).

Your new jenkins server will be added to the `.jx/gitops/source-config.yaml` file and so will be available to developers as a Jenkins server that can be used when importing projects.

### Configure Jenkins 

To configure your Jenkins server edit the `helmfile/myjenkins/values.yaml` according to the [configuration guide](https://github.com/jenkinsci/helm-charts/blob/main/charts/jenkins/VALUES_SUMMARY.md).

Each Jenkins server has its own namespace so that its possible to use fine grained role based access for each server using Kubernetes RBAC.

In addition by default each Jenkins server gets to share the pipeline git user name and token so that it can access private git repositories in the same way as tekton pipelines.


### Job DSL

When you import projects or create quickstarts with the above approach, your projects get added to the jenkins server you choose in  `.jx/gitops/source-config.yaml`. 

Then during the [boot job](/v3/about/how-it-works/#boot-job) Jenkins X will create a [Jenkins Job DSL script](https://plugins.jenkins.io/job-dsl/) for each project in your `.jx/gitops/source-config.yaml` file for each Jenkins server.

The Job DSL scripts are generated in the file `helmfiles/myjenkins/job-values.yaml` which is then passed into the [Jenkins helm chart](https://github.com/jenkinsci/helm-charts) via the `values:` item in the `helmfiles/myjenkins/helmfile.yaml`

By default the boot job uses [these templates for the Job DSL](https://github.com/jenkins-x/jx3-versions/tree/master/jenkins/templates) for folders (e.g. organisations) and for repositories.

You can configure which templates you wish to use in the `.jx/gitops/source-config.yaml` file; either globally or on a per organsation or repository basis. Please refer to the [SourceConfig](https://github.com/jenkins-x/jx-gitops/blob/master/docs/config.md#gitops.jenkins-x.io/v1alpha1.SourceConfig) reference guide. In particularly see how you can specify `jenkinsFolderTemplate` or `jenkinsJobTemplate` values at the global, organisation or repository level inside the [jenkinsServer](https://github.com/jenkins-x/jx-gitops/blob/master/docs/config.md#gitops.jenkins-x.io/v1alpha1.JenkinsServer) entry.


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
           
