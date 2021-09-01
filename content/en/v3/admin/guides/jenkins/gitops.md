---
title: GitOps Recommendations
linktitle: GitOps
type: docs
description: Recommendations on using GitOps to for your Jenkins servers
weight: 100
---

One of the awesome things about Jenkins is you can use it to do anything in any way you like. e.g. you can add/configure any Jenkins server via the UI which then modifies the state on disk. This can make things harder to manage at scale; tracking who changes what and to diagnose issues and perform backup and restore etc.

We have been using the GitOps approach to managing things in production for the last few years on the Jenkins X project and it has lots of benefits:

* every change is audited so you can see exactly what was changed and by who in git
* you can easily revert changes if they go bad
* all state being in git means its super easy to recreate your infrastructure in another region or using different machine types without complex backup/restore processes being in place

So we recommend trying to follow the GitOps approaches for your Jenkins servers too. e.g.

* try store in git all of the Jenkins servers with their [configuration](/v3/admin/guides/jenkins/getting-started/#configure-jenkins)
* try use the [Job DSL in git](/v3/admin/guides/jenkins/getting-started/#job-dsl) to import projects into your jenkins servers then its very easy to move projects to different servers via a simple Pull Request on the `.jx/gitops/source-config.yaml` file
* try use [Jenkins Configuration As Code](https://www.jenkins.io/projects/jcasc/) as much as you can as its simpler and easier to work with via GitOps
* try use use [kubernetes external secrets](https://github.com/external-secrets/kubernetes-external-secrets) to manage all of your secrets in a secret store like vault or your cloud providers secret manager via [Jenkins X secret support](/v3/admin/setup/secrets/)
  * you can then consume the secrets managed via [kubernetes external secrets](https://github.com/external-secrets/kubernetes-external-secrets) using the [kubernetes credentials provider plugin](https://plugins.jenkins.io/kubernetes-credentials-provider/)
  * we use this mechanism to reuse the Jenkins X pipeline bot user and token we use for [tekton](https://github.com/tektoncd/pipeline) in each Jenkins server via properly labelled Secrets created via  [kubernetes external secrets](https://github.com/external-secrets/kubernetes-external-secrets). e.g. [here's how we share the git token](https://github.com/jenkins-x-charts/jenkins-resources/blob/main/charts/jenkins-resources/templates/tekton-git-secret.yaml#L15-L18) by using a kubernetes Secret with the labels for the [kubernetes credentials provider plugin](https://plugins.jenkins.io/kubernetes-credentials-provider/) which is automatically populated from the vault / cloud provider secret store
