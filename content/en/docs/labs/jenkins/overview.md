---
title: Overview
linktitle: Overview
description: Overview of the Jenkins and Jenkins X interoperability
weight: 10
---
{{% alert %}}
**NOTE: This current experiment is now closed. The work done and feedback we have received will be used to enhance Jenkins X in future versions**

**This code should not be used in production, or be adopted for usage.  It should only be used to provide feedback to the Labs team.**

Thank you for your participation,

-Labs


{{% /alert %}}

The [Trigger Jenkins Proposal](https://github.com/jstrachan/enhancements/blob/jenkins-trigger/proposals/trigger-jenkins/README.md) aims to improve the interoperability of Jenkins and Jenkins X so you can use both together to solve all of your CI/CD needs.

We want to make it easy to reuse existing remote Jenkins servers with Jenkins X / tekton so that folks can work with either 100% cloud native tekton based automated CI/CD from Jenkins X or reuse existing Jenkins pipelines with remote Jenkins servers.


## How it works

We maintain registry of Jenkins Servers using  Kubernetes `Secrets` for each Jenkins Server with details of the URL, username and API Token.

We then have a command line tool and container image which can then invoke a `Jenkinsfile` based pipeline in any of the Jenkins Servers in the registry.

This allows any Jenkins pipelines to be triggered from:

* any Jenkins X Pipeline
* Tekton
* Kubernetes Job


Over time we can then bring more value to folks using a mixture of Jenkins + Jenkins X. e.g.

*   Reuse ChatOps from Jenkins X for existing projects that use Jenkins pipelines
*   Reuse Jenkins X Apps / Build Packs on projects released by Jenkins
    *   E.g. reuse Jenkins X Apps / Pipelines for linting, code quality, security scanning - while preserving the existing Jenkins pipelines

 

## Known issues

If you see this error when trying to trigger a pipeline:

``` 
403 No valid crumb was included in the request
```

Then until we figure out a better workaround you need to go into `Manage Jenkins` -> `Configure Global Security` then make sure you uncheck `Prevent Cross Site Request Forgery exploits` 