---
title: "How to use GitOps and Kubernetes External Secrets for better audit and security"
date: 2021-08-17
draft: false
description: How do you use GitOps and secrets nicely?
categories: [blog]
keywords: [Community, 2021]
slug: "gitops-secrets"
aliases: []
author: James Strachan
---

So **GitOps** is a cool approach to managing kubernetes resources in a cluster, by checking in the source code for:

* the kubernetes YAMLs
* details of the helm charts you want to install along with any configuration
* kustomize scripts. 

Then everything is versioned and audited; you know who changed what, when and why. If a change breaks things, just revert via git like any other source code change.

You can then add pipelines to [verify](https://github.com/jenkins-x-plugins/jx-kube-test#readme) changes in the Pull Requests result in valid kubernetes YAML etc.

Then if you merge changes to git then an operator detect the change and do the `kubectl apply` (or `helm install` or whatever). 

There are a number of tools out there for doing this. e.g. [Anthos Config Management](https://cloud.google.com/anthos/config-management), [argo cd](https://argoproj.github.io/argo-cd/), [fleet](https://rancher.com/docs/rancher/v2.x/en/deploy-across-clusters/fleet/), [flux cd](https://fluxcd.io/) and [kapp controller](https://github.com/vmware-tanzu/carvel-kapp-controller)

So why did Jenkins X not use these tools and instead created its own [git operator](https://github.com/jenkins-x/jx-git-operator)?


## Standardising GitOps layouts

Over time it would be great to have more standardisation of the Git layout given the different tool.

Our current recommended layout that works with many GitOps tools is [described here](https://github.com/jenkins-x-plugins/jx-gitops/blob/main/docs/git_layout.md).


## Why Jenkins X uses helmfile template

A number of solutions in the GitOps space define which helm charts to install in git with configuration files; or specify which kustomize templates to apply etc.

However Jenkins X defaults to using [helmfile](https://github.com/roboll/helmfile) to manage installing, upgrading and configuring multiple helm charts. Then we use **`helmfile template`** to render the helm charts as kubernetes resources.

We do this for a very good reason; so that we can easily [version all kubernetes resources in git including those that come from a helm chart](/v3/develop/faq/general/#why-does-jenkins-x-use-helmfile-template) - which means you can easily view the entire history of changes of any kubernetes resources - whether they come from inside a helm chart, some configuration values of a chart or kustomize scripts etc. 

This avoids you having to mentally understand how helm charts will change over time with the helm chart version and/or helm configuration; or the effect of kustommize scripts. You can just view the history of any kubernetes resource.

We use conventions to ensure that each kubernetes resource has a canonical file name in git to make this whole process much simpler.

e.g. this is the git history of the [cert manager deployment resource in our production cluster](https://github.com/jenkins-x/jx3-eagle/commits/master/config-root/namespaces/cert-manager/cert-manager/cert-manager-cainjector-deploy.yaml) so you can see what changed when over time.

The exception to this rule is kubernetes `Secrets` which are stored instead as `ExternalSecrets` but which have their own history (e.g. in case you change the location of where the secrets are stored or modify the metadata, annotations or labels etc).


## Why we use Kubernetes External Secrets

Jenkins X 3.x uses [Kubernetes External Secrets](https://github.com/external-secrets/kubernetes-external-secrets) to manage populating secrets from your underlying secret store such as:

* Alibaba Cloud KMS Secret Manager
* Amazon Secret Manager
* Azure Key Vault
* Hashicorp Vault
* GCP Secret Manager

{{<mermaid>}}
graph TB
    subgraph A[Kubernetes Cluster]
        sqB[External Secrets Controller]
        subgraph C[secrets-infra ns]
            sqCV[Cloud Secret Manager]
        end
        subgraph D[Kube api server]
        end
        D -- Get ExternalSecrets --> sqB
        sqB --> D
        sqB -- Fetch secrets properties --> sqCV
        sqCV --> sqB
        subgraph E[app ns]
            sqEP[pods]
            sqES[secrets]
        end
        sqB -- Upsert Secrets --> sqES
    end
{{</mermaid>}}

You can then keep all your secrets inside your cloud native secret store which also allows:

* easy to automatically rotate any secret  at any time independently of git
* use fine grained RBAC on each secret


## How to use this approach to GitOps and Secrets if not using Jenkins X

If you use [Jenkins X](/v3/admin/) then you get all of the above benefits. But what if you want to use some other kind of GitOps operator toolchain?

One option is to use the [jx-secret-postrenderer](https://github.com/jenkins-x-plugins/jx-secret-postrenderer#jx-secret-postrenderer) yourself if you use helm or [helmfile](https://github.com/roboll/helmfile) to then render the helm charts as raw YAML you can check into your git repository and implementing the conversion from `Secret` to `ExternalSecret`.

Another option is to reuse the Jenkins X `Makefile` and pipeline to setup the `config-root` [git layout](https://github.com/jenkins-x-plugins/jx-gitops/blob/main/docs/git_layout.md) after converting Secrets to ExternalSecretes and pre-populating any missing secret store values.
 

## Summary

If you are looking at adopting GitOps then we highly recommend you [check into git all of your kubernetes resources including those that come from a helm charts or kustomize scripts](/v3/develop/faq/general/#why-does-jenkins-x-use-helmfile-template) (apart from `Secrets`!) as it massively simplifies understanding how kubernetes resources change over time using just pure git.

If you are using GitOps you may want to look into using [Kubernetes External Secrets](https://github.com/external-secrets/kubernetes-external-secrets) to simplify integrating secrets for cloud native secret stores into your kubernetes cluster to provide finer grained RBAC and easier secret rotation.

