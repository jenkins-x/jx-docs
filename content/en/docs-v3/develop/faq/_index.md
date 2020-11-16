---
title: FAQ
linktitle: FAQ
type: docs
description: Questions on using Jenkins X 3.x and helm 3
weight: 500
aliases:
  - /faq/
  - /docs/v3/guides/faq/
  - /docs/v3/develop/faq/
---



## How do I customise an App in an Environment

With the new helm 3 based boot every environment uses boot - so there is a single way to configure anything whether its in the `dev`, `staging` or `production` environment and whether or not you are using [multiple clusters](/docs/v3/guides/multi-cluster/).

See [how to customise a chart](/docs/v3/develop/apps/#customising-charts)


## How do I list the apps that have been deployed?

You can see the helm charts that are installed along with their version, namespaces and any configuration values by looking at the `releases` section of your `helmfile.yaml` file in your cluster git repository.

You can browse all the kubernetes resources in each namespace using the canonical layout in the `config-root` folder. e.g. all charts are versioned in git as follows:
 
```bash 
config-root/
  namespaces/
    jx/
      lighthouse/
        lighthouse-webhooks-deploy.yaml    
```

You can see the above kubernetes resource, a `Deployment` with name `lighthouse-webhooks` in the namespace `jx` which comes from the `lighthouse` chart.

There could be some additional charts installed via Terraform for the [git operator](/docs/v3/guides/operator/) and [health subsystem](/docs/v3/guides/health/) which can be viewed via:
  
```bash 
helm list --all-namespaces
```                                                                                


## Why does Jenkins X use `helmfile template`?

If you look into the **versionStream/src/Makefile.mk** file in your cluster git repository to see how the boot proccess works you may notice its defined a simple makefile and uses the [jx gitops helmfile template](https://github.com/jenkins-x/jx-gitops/blob/master/docs/cmd/jx-gitops_helmfile_template.md) command to convert the [helmfile](https://github.com/roboll/helmfile) `helmfile.yaml` files referencing helm charts into YAML.

So why don't we use `helmfile sync` instead to apply the kubernetes resources from the charts directly into kubernetes?

The current approach has a [number of benefits](/docs/v3/about/benefits/):

* we want to version all kubernetes resources (apart from `Secrets`) in git so that you can use git tooling to view the history of every kubernetes resource over time. 


  * by checking in all the kubernetes resources (apart from `Secrets`) its very easy to trace (and `git blame`) any change in any kubernetes resource in any chart and namespace to diagnose issues.
  * the upgrade of any tool such as [helm](https://helm.sh/), [helmfile](https://github.com/roboll/helmfile), [kustomize](https://kustomize.io/), [kpt](https://googlecontainertools.github.io/kpt/), [kubectl](https://kubernetes.io/docs/reference/kubectl/kubectl/) or [jx](/docs/v3/guides/jx3/) could result in different YAML being generated changing the behaivour of your applications in Production.


* this approach makes it super easy to review all Pull Requests on all promotions and configuration changes and review what is actually going to change in kubernetes inside the git commit diff.

  * e.g. promoting from `1.2.3` to `1.3.0` of application `cheese` may look innocent enough, but did you notice those new `ClusterRole` and `PersistentVolume` resources that it now brings in?
  
* we can default to using [canonical secret management mechanism](/docs/v3/guides/secrets/) based on [kubernetes external secrets](https://github.com/godaddy/kubernetes-external-secrets) (see [how it works](/docs/v3/about/how-it-works/#generate-step)) to ensure that:
 
  * no Secret value accidentally gets checked into git by mistake
  * all secrets can be managed, versioned, stored and rotated using vault or your cloud providers native secret storage mechanism
  * the combination of git and your secret store means your cluster becomes ephemeral and can be recreated if required (which often can happen if using tools like Terraform to manage infrastructure and you change significant infrastructure configuration values like node pools, version, location and so forth) 

* its easier for developers to understand what is going on as you can browse all the kubernetes resources in each namespace using the canonical layout in the `config-root` folder. e.g. all charts are versioned in git as follows:
                    
```bash 
config-root/
 namespaces/
   jx/
     lighthouse/
       lighthouse-webhooks-deploy.yaml    
```

   * you can see the above kubernetes resource, a `Deployment` with name `lighthouse-webhooks` in the namespace `jx` which comes from the `lighthouse` chart. 

* its easy to enrich the generated YAML with a combination of any additional tools [kustomize](https://kustomize.io/), [kpt](https://googlecontainertools.github.io/kpt/) or [jx](/docs/v3/guides/jx3/). e.g.

  * its trivial to run [kustomize](https://kustomize.io/) or [kpt](https://googlecontainertools.github.io/kpt/) to modify any resource in any chart before it's applied to Production and to review the generated values first 

  * its easy to use [jx gitops hash](https://github.com/jenkins-x/jx-gitops/blob/master/docs/cmd/jx-gitops_hash.md) to add some hash annotations to cause rolling upgrade to `Deployments` when git changes (when the `Deployment` YAML does not)

  * use [jx gitops annotate](https://github.com/jenkins-x/jx-gitops/blob/master/docs/cmd/jx-gitops_annotate.md) to add add support for tools like [pusher wave](https://github.com/pusher/wave) so that rotating secrets in your underlying secret store can cause rolling upgrades in your `Deployments`

However since the steps to deploy a kubernetes cluster in Jenkins X is defined in a simple makefile stored in your cluster git repository its easy for developers to modify their cluster git repository to add any combination of tools to the makefile to use any permutation of  [helm 3](https://helm.sh/), [helmfile](https://github.com/roboll/helmfile), [kustomize](https://kustomize.io/), [kpt](https://googlecontainertools.github.io/kpt/)  and [kubectl](https://kubernetes.io/docs/reference/kubectl/kubectl/)

So if you really wanted to opt out of the canonical GitOps, resource and secret management model above you can add a `helm upgrade` or `helmfile sync` command to your makefile. The entire boot job is defined in git in **versionStream/git-operator/job.yaml** so you are free to go in whatever direction you prefer. 


## What is the directory layout?

To understand the directory layout see [this document](https://github.com/jenkins-x/jx-gitops/blob/master/docs/git_layout.md)


## Does Jenkins X support helmfile hooks?

Helmfile hooks allow programs to be executed during the lifecycle of the application of your helmfiles.

Since we default to using [helmfile template](/docs/v3/develop/faq/#why-does-jenkins-x-use-helmfile-template) helmfile hooks are not supported for cluster git repositories (though you can use them in preview environments).

However its easy to add steps into the **versionStream/src/Makefile.mk** to simulate helmfile hooks.


## How do I configure the ingress domain in Dev, Staging or Production?

With the new helm 3 based boot every environment uses boot - so there is a single way to configure anything whether its in the `dev`, `staging` or `production` environment and whether or not you are using [multiple clusters](/docs/v3/guides/multi-cluster/).

You can override the domain name for use in all apps within an environment by modifying the `jx-requirements.yml` in the git repository for the `dev`, `staging` or `production` environment.

```yaml 
ingress:
  domain: mydomain.com 
```

Also by default there is a namespace specific separator added. So if your service is `cheese` the full domain name would be something like `cheese.jx-staging.mydomain.com`.

If you wish to avoid the namespace specific separator if each environment already has its own unique `domain` value then you can specify:

```yaml 
ingress:
  domain: mydomain.com  
  namespaceSubDomain: "."
```

If you wish to change any of these values for a single app only then you can use the [app customisation mechanism](/docs/v3/develop/apps/#customising-charts).

e.g. for an app called `mychart` you can create a file called `apps/mychart/values.yaml` in the git repository for your environment and add the following YAML:

```yaml 
jxRequirements:
  ingress:
    domain: mydomain.com  
    namespaceSubDomain: "."
```



## How do I configure the ingress TLS certificate in Dev, Staging or Production?

You can specify the TLS certificate to use for the `dev`, `staging` or `production` environment by modifying the `jx-requirements.yml` file in the environments git repository:


```yaml 
ingress: 
  tls:
    enabled:
    secretName: my-tls-secret-name
```

This will then be applied to all the Jenkins X ingress resources for things like `lighthouse` or `nexus` - plus any apps you deploy to `dev`, `staging` or `production`.

If you want to override the TLS secret name for a specific app in a specific environment then rather like the [above question](#how-do-i-configure-the-ingress-domain-in-dev-staging-or-production) you can use the [app customisation mechanism](/docs/v3/develop/apps/#customising-charts).
 
e.g. for an app called `mychart` you can create a file called `apps/mychart/values.yaml` in the git repository for your environment and add the following YAML:
                                                                                                                                        
```yaml 
jxRequirements:
  ingress:
    tls:
      enabled:
      secretName: my-tls-secret-name
```


## How do I use a custom container registry?

To allow a pipeline to be able to push to a container registry you can add this secret...

```bash
kubectl create secret generic container-registry-auth  \
  --from-literal=url=myserver.com \
  --from-literal=username=myuser \
  --from-literal=password=mypwd
```

This will then take effect the next time a commit merges on your cluster git repository e.g. next time you [upgrade your cluster](/docs/v3/guides/upgrade/#cluster).

The various container registry secrets get merged into a `Secret` called `tekton-container-registry-auth` in the `jx` namespace which is associated with the default pipeline `ServiceAccount` `tekton-bot`.


If you want all pipelines to use this container registry then modify the `cluster.registry` field in your `jx-requirements.yml` file:

```yaml
cluster:
  registry: myserver.com 
...
```

Otherwise you can enable this new container registry on a specific application/repository by adding this `.jx/variables.sh` file into the git repository if it doesn't exist...
 
```bash
export DOCKER_REGISTRY="myserver.com"
```


## How do I uninstall Jenkins X?

We don't yet have a nice uninstall command


## Why does Jenkins X fail to download plugins?

When I run a `jx` command I get an error like...

``` Get https://github.com/jenkins-x/jx-..../releases/download/v..../jx-.....tar.gz: dial tcp: i/o timeout```

This sounds like a network problem; the code in `jx` is trying to download from `github.com` and your laptop is having trouble resolving the `github.com` domain.

* do you have a firewall / VPN / HTTP proxy blocking things?
* is your `/etc/resolv.conf` causing issues? e.g. if you have multiple entries for your company VPN?


