---
title: Projects
linktitle: Projects
type: docs
description: The open source projects used by Jenkins X
weight: 55
---

Jenkins X stands on the shoulders of many open source giants...

## Command Line Tools

* [helm](https://helm.sh/) a package manager for kubernetes
* [helmfile](https://github.com/roboll/helmfile) a tool for installing, upgrading and configuring [helm](https://helm.sh/) charts
* [kaniko](https://github.com/GoogleContainerTools/kaniko) creates container images on kubernetes using the familiar `dockerfile`
* [kapp](https://get-kapp.io/) is a tool for applying changes to kubernetes resources safely with dependency tracking
* [kpt](https://googlecontainertools.github.io/kpt/) provides tools for sharing and configuring YAML files across git repositories
* [kubectl](https://kubernetes.io/docs/reference/kubectl/kubectl/) a command line tool for interacting with kubernetes clusters
* [kustomize](https://kustomize.io/) a tool for configuring and modifying kubernetes resources 
* [mink](https://github.com/mattmoor/mink) a command line tool for building container images and resolving the image digest in JSON/YAML files for local development or for use inside pipelines (we use the [mink plugin for this](https://github.com/jenkins-x-plugins/mink)
* [octant](https://octant.dev/) an awesome kubernetes console with plugins which we use for the [Jenkins X Console](/v3/develop/ui/octant/)
* [skaffold](https://github.com/GoogleContainerTools/skaffold) a tool for incremental development of container images and deployments
* [tekton cli](https://github.com/tektoncd/cli) the CLI tool for working with [tekton pipelines](https://github.com/tektoncd/pipeline)
* [terraform](https://www.terraform.io/) a tool managing infrastructure as code

## Microservices

* [CNCF build packs](https://buildpacks.io/) for packaging source code as container images. Or you can use [kaniko](https://github.com/GoogleContainerTools/kaniko) which uses a familiar `dockerfile` to package container images
* [cert-manager](https://docs.cert-manager.io/en/latest/index.html) for managing certificates for [TLS and DNS](/v3/admin/guides/tls_dns/)
* [external-dns](https://github.com/kubernetes-sigs/external-dns) for managing certificates for [TLS and DNS](/v3/admin/guides/tls_dns/)
* [knative](https://knative.dev/) a framework for building auto scaling (to zero) serverless style applications on kubernetes
* [kuberhealthy](https://github.com/Comcast/kuberhealthy) for health reporting of Kubernetes itself, Jenkins X and other microservices
* [kubernetes external secrets](https://github.com/external-secrets/kubernetes-external-secrets) for [managing secrets](/v3/admin/guides/secrets/) via [Hashicorp Vault](https://www.vaultproject.io/) or the cloud native secret managers on Alibaba, Amazon, Azure, Google etc
* [jenkins](https://jenkins.io) the most popular build automation server which can be [setup via GitOps with Jenkins X](/v3/admin/guides/jenkins/) and a fellow [CDF founding project](https://cd.foundation/projects/)
* [jenkinsfile runner](https://github.com/jenkinsci/jenkinsfile-runner) a way of running a jenkins pipeline in a container
* [lighthouse](https://github.com/jenkins-x/lighthouse) our strategic solution for webhooks and ChatOps for multiple git providers
* [push-wave](https://github.com/jenkins-x-charts/pusher-wave#wave) for automatically performing rolling upgrades when secrets are rotated in your secret store
* [tekton pipelines](https://github.com/tektoncd/pipeline) cloud native pipeline engine for kubernetes and a fellow [CDF founding project](https://cd.foundation/projects/)
* [tekton catalog](https://github.com/tektoncd/catalog) a catalog of reusable [tekton pipelines](https://github.com/tektoncd/pipeline) which [can be used easily with Jenkins ](/v3/develop/pipelines/#adding-tasks-from-the-tekton-catalog)
* [vault](https://www.vaultproject.io/) a secret store
* [vault operator](https://banzaicloud.com/products/bank-vaults/) an operator for installing and unsealing [vault](https://www.vaultproject.io/)
