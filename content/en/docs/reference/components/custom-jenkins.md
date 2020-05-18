---
title: Custom Jenkins Servers
linktitle: Custom Jenkins Servers
description: How to work with Custom Jenkins Servers in Jenkins X
weight: 70
aliases:
  - /docs/resources/guides/managing-jx/common-tasks/custom-jenkins
---

Jenkins X provides automated CI/CD for your libraries and microservices you want to deploy on Kubernetes, but what about those other `Jenkinsfile` based pipelines you have already created on a custom Jenkins Server?

Jenkins X now has a [Jenkins App](https://github.com/jenkins-x-apps/jx-app-jenkins) that makes it easy to add one or more custom Jenkins servers to your Team and use the custom Jenkins Server to implement any custom pipelines you have developed.

**NOTE** the Jenkins App is intended only for running custom `Jenkinsfile` pipelines you've developed by hand - its not an execution engine for the automated CI/CD pipelines in Jenkins X for Kubernetes workloads; for that we actually recommend [serverless Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) - but you can use an embedded static Jenkins Server as well.

## Why Custom Jenkins?

This app lets you maintain your investment in your existing Jenkins pipelines, invoking them in a custom Jenkins Server of your own choosing and configuration while you start to use more of the automated CI/CD in Jenkins X for new libraries and microservices using either [serverless Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) or the embedded static Jenkins server in Jenkins X.

You can then mix and match between the automated CI/CD in Jenkins X and your custom Jenkins pipelines - all orchestrated nicely together with Jenkins X!

## Installing a custom Jenkins

To install the custom Jenkins server you need to run the following command:

```sh
jx add app jenkins
```

This will install a new Jenkins Server in your current Team. It should then show up via...

```sh
jx open
```

This will also create an API token automatically so that the `jx` CLI can query or start pipelines in the custom Jenkins server. It can take a minute or so for the setup job to complete.

## Getting the login/password

Unfortunately there is a limitation on the current Jenkins app that it does not prompt you with the password as you add the Jenkins App.

So to find the password you will need to find it by hand I'm afraid.

* download [ksd](https://github.com/mfuentesg/ksd) and add it to your $PATH
* type the following (you may need to change the `Secret` name if you use a different alias for your Jenkins server):

```sh
kubectl get secret jx-jx-app-jenkins -o yaml | ksd
```

Then you will see your user/pwd on the screen if you want to login to the Jenkins UI via [jx console](/commands/deprecation/)


## Using the custom Jenkins

The `jx` command which work with Jenkins servers can all work directly with your new custom Jenkins server; though you need to specify that you want to interact with a custom Jenkins Server as opposed to the built in execution engine in Jenkins X (e.g. [serverless Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) or the built in Jenkins server inside Jenkins X)

If you only have one custom Jenkins App in your Team you can use `-m` to specify you want to work with a custom Jenkins server. Otherwise you can specify `-n myjenkinsname`.

```sh
# view the pipelines
jx get pipeline -m

# view the log of a pipeline
jx get build log -m

# view the Jenkins console
jx console -m

# lets start a pipeline in the custom jenkins
jx start pipeline -m
```

## Managing custom Jenkins Servers via GitOps

We have designed the Jenkins App for Jenkins X using the [App extension framework](/docs/contributing/addons/) which means you can manage your custom Jenkins servers via [GitOps](/docs/resources/guides/managing-jx/common-tasks/manage-via-gitops/) - keeping all of the apps, their version and configuration in git and using the Jenkins X tooling to add/update/configure/delete apps.


