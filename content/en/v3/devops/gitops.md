---
title: GitOps
linktitle: GitOps
type: docs
description: GitOps overview
weight: 100
---

The idea of GitOps is to treat everything as source code, including your infrastructure, and check it into git and version it. 

So rather than connecting to a machine in your cluster, you make changes via Pull Requests in git. This means:

* every change is audited so you can see who changed what, when and why
* its easy to revert changes to your infrastructure if things go bad
* teams can easily review changes to work more effectively as a team, share knowledge and get better feedback

## Challenges

### Secrets

One of the biggest challenges with GitOps is dealing with secrets. 

You really want to check in all of your source code into git. But you really don't want to check in your secrets (user, passwords, tokens, certificates etc) into git - particularly public repositories!

There are techniques like [helm sealed secrets](https://github.com/bitnami-labs/sealed-secrets) so that you can encrypt secrets for storage in git. 

However we are not huge fans of the UX of using this approach; its harder to modify or rotate secrets.

We prefer [using external secrets stores](/v3/admin/setup/secrets/) via the open source  [Kubernetes External Secrets](https://github.com/external-secrets/kubernetes-external-secrets) project

This means that we [automatically convert Secret resources to ExternalSecrets which can then be stored safely in git](/v3/develop/faq/#why-does-jenkins-x-use-helmfile-template)


### Source code 

Saying use git is all well and good but what is the source code layout?

When writing actual application code in languages like Java, Node or Go there is accepted layouts and file formats. But what of GitOps?

It does depend a little on the GitOps tool you are using. We recommend trying to use a canonical source code layout that lets you change later if you need to.

Here is our current [recommended source code layout](https://github.com/jenkins-x/jx-gitops/blob/master/docs/git_layout.md)


## Recommendations

We spend more time reading source code than writing it. So try focus on things like:

* use canonical file formats that are easy to understand. 
  * e.g. [helm](https://helm.sh/), [helmfile](https://github.com/roboll/helmfile) and [Tekton YAML syntax](/v3/develop/reference/pipelines/) so that you get [IDE support](/v3/develop/pipelines/editing/#ide-support) and [easy linting](/v3/develop/pipelines/editing/#linting)
* make good use of reporting. Jenkins X generates easy to read reports to view what applications are deployed in what namespace and with what versions etc:
  * e.g. see the reports for [kubernetes](https://github.com/jx3-gitops-repositories/jx3-kubernetes/tree/master/docs ), [aws](https://github.com/jx3-gitops-repositories/jx3-eks-vault/tree/master/docs), [azure](https://github.com/jx3-gitops-repositories/jx3-azure-akv) and [gke](https://github.com/jx3-gitops-repositories/jx3-gke-gsm/tree/master/docs)
* we recommend checking in all kubernetes resources apart from Secrets into git. See [this FAQ entry for background](/v3/develop/faq/#why-does-jenkins-x-use-helmfile-template).
  * this makes it easier to review Pull Requests to see what will actually change in Kubernetes if a change is approved (e.g. changes to namespaces, deployments, images, volumes etc)
  * when diagnosing issues you can easily use your IDE to view the history of any kubernetes resource. This avoids having to mentally guess what tools like [helm](https://helm.sh/) or [kustomize](https://kustomize.io/) would actually do over time - you can just compare what they create - the YAML resources in git them mirror exactly what should exist in your kubernetes clusters.
* always version everything and never use `latest` or `SNAPSHOT` images or artifacts!
  * if you are worried about upgrading versions of things over time then look at either tools like [dependabot](https://dependabot.com/) or the [updatebot plugin](https://github.com/jenkins-x-plugins/jx-updatebot) which we use extensively throughout Jenkins X to upgrade versions of libraries, images, binaries etc.
* try run everything in the cloud rather than on your local laptop
  * as its easier to keep running for everyone in your team; rather than only work on certain machines with magic setups you forget to document or maintain. e.g. the Jenkins X v3 approach runs the [installer inside Kubernetes as a Job](/v3/about/how-it-works/#boot-job)
