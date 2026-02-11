---
title: GitOps
linktitle: GitOps
description: Define your infrastructure and environments as source code git 
type: docs
weight: 100
---

The `GitOps` pattern means you use source code and git repositories for both your applications, your infrastructure and environments too.

In the DevOps space we have been using git to version infrastructure configuration with many tools like [terraform](https://www.terraform.io/) and before that tools like [Ansible](https://www.ansible.com/).

With [kubernetes](https://kubernetes.io/) you can connect to a cluster and modify it via `kubectl apply` or helm install`.

However with the `GitOps` pattern developers don't modify kubernetes directly; instead they propose changes to a git repository via a Pull Request which when it gets approved and merged causes the kubernetes cluster to be modified via some kind of operator such as the [Jenkins X git operator](https://github.com/jenkins-x/jx-git-operator)

### Benefits of GitOps

* all changes made to each environment are stored in git so it is easy to see who changed what, when and why.
* it is easy to revert changes if things go bad
* it helps share information between the team and to get feedback and reviews on changes to infrastructure


### Implementation approaches

You could implement the GitOps pattern by just running `helm install mychart` in some kind of script or operator. 

We recommend checking in every kubernetes resource and custom resource definition to git - apart from kubernetes Secrets. For details why see [the reasoning behind this decision](/v3/develop/faq/general/#why-does-jenkins-x-use-helmfile-template). 


Essentially having a canonical file in git for every non-Secret kubernetes and custom resource really helps when it comes to diagnosing issues with a cluster; since you don't have to keep in your head what tools like [helm](https://helm.sh/), [helmfile](https://github.com/roboll/helmfile), [kustomize](https://kustomize.io/), [kpt](https://googlecontainertools.github.io/kpt/), [kubectl](https://kubernetes.io/docs/reference/kubectl/kubectl/) or [jx](/v3/guides/jx3/) do - you can just look at how the resource has changed in git to see why things are going wrong. 
