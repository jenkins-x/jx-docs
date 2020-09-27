---
title: Benefits
linktitle: Benefits
description: Benefits of using Jenkins X 3.x
weight: 80
---


* We can use vanilla tools like [helm 3](https://helm.sh/), [helmfile](https://github.com/roboll/helmfile), [kustomize](https://kustomize.io/), [kpt](https://googlecontainertools.github.io/kpt/) to install, update or delete charts in any namespace without needing helm 2.x or tiller or custom code to manage `helm template`.
  * We can avoid all the complexities of the `jx step helm apply` logic we used in Jenkins X 2.x
  * Instead we can replace this with vanilla [helmfile](https://github.com/roboll/helmfile) to allow optional templating of `values.yaml` files when using helm
* The new [Getting Started](/docs/v3/getting-started/) approach is much simpler, easier to configure and customise and is cleanly integrated with tools like Terraform and works well with different cloud infrastructure platforms.
  * The default install/upgrade pipelines check in all the generated kubernetes resources and custom resources as YAML so its easy to understand
  * You can read more about the [git layout here](https://github.com/jenkins-x/jx-gitops/blob/master/docs/git_layout.md)
    * The `config-root/cluster` folder contains all the global cluster level resources like `ClusterRole`, `Namespace` or Custom Resources
    * The `config-root/namespaces/jx` folder contains all the namespaced resources in the `jx` namespace
  * This makes it easy to use flexible apply logic in different boot `Jobs` with different RBAC (or a system admin could apply the cluster level resources for you by hand) - to make it easier to install Jenkins X on more locked down and restricted clusters
* We use [Kubernetes External Secrets](https://github.com/godaddy/kubernetes-external-secrets) to provide a single way to manage secrets which supports the following back end systems:
  * Alibaba Cloud KMS Secret Manager
  * AWS Secrets Manager
  * Azure Key Vault
  * GCP Secret Manager
  * Hashicorp Vault
* It opens the door to a flexible [multi-cluster support](/docs/v3/guides/multi-cluster/) so that every cluster can be managed in the same canonical GitOps approach from a single git repository 
* The new [getting started approach](/docs/v3/getting-started/) runs the boot pipeline as a `Job` inside the Kubernetes cluster. This ensures consistency in tooling used and also improves security by avoiding having the secrets on a developers laptop. 
  * The only thing you run on your local machine when installing Jenkins X is [installing the git operator](/docs/v3/guides/operator/) which is a simple helm chart.
* Everything is now an app. So if you want to remove our `nginx-ingress` chart and replace it with another ingress solution (knative / istio / gloo / ambassador / linkerd or whatever) just go ahead and use the [apps commands](/docs/v3/guides/apps/) to add/remove apps and have boot manage everything in a consistent way
    * e.g. here's [an example](https://github.com/jx3-gitops-repositories/jx3-kind-vault/blob/master/helmfile.yaml#L17) of removing `chartmusem` and `nexus` and replacing it with `bucketrepo` via a single simple yaml change.
* You can install an app in a specific namespace if you wish
    * This also opens the door to using boot to setup multi-team installations where multiple teams use different namespaces but share services in the same cluster
* The cluster GitOps repository is simpler and easier to keep in sync/rebase/merge with the upstream git repositories.
  * We use [kpt](https://googlecontainertools.github.io/kpt/) to do that for us
  * We now include the [version stream](https://jenkins-x.io/about/concepts/version-stream/) inside your GitOps repository too inside the `versionStream` directory after installation so that all the information about your installation is inside a single git repository so its simpler to test changes & ensure consistency.
* We can avoid composite charts to simplfiy configuration and upgrades
* We no longer use `exposecontroller`, instead use regular helm configuration to create `Ingress` resources and [override domain names](/docs/v3/guides/faq/#how-do-i-configure-the-ingress-domain-in-dev-staging-or-production)
* secret handling is currently much simpler using Kubernetes External Secrets for any secrets in any namespace or cluster for your own apps or for those used by Jenkins X.
