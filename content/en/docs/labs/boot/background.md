---
title: Background
linktitle: Background
description: Background and the enhancement proposal
weight: 120
---
{{% alert %}}
**NOTE: This current experiment is now closed. The work done and feedback we have received will be used to enhance Jenkins X in future versions**

**This code should not be used in production, or be adopted for usage.  It should only be used to provide feedback to the Labs team.**

Thank you for your participation,

-Labs


{{% /alert %}}

see the [issue](https://github.com/jenkins-x/jx/issues/6442) and [enhancement proopsal](https://github.com/jenkins-x/enhancements/tree/master/proposals/2)

## Requirements

We want a simple canonical way to install any helm chart in any namespace without having to manually hack the `jx boot` pipeline file: `jenkins-x.yml`.

This will make it easy for people or software to easily add/remove apps to any git repository for any Environment (dev / staging / production).

The boot config repo has become quite complex and hard to manage upgrades to and share common config between different flavours of base boot config repos.  It’s also hard to experiment by adding new helm charts / features / applications that require changes to the boot install pipeline.

We want a simpler more modular system that lets us, say, swap out nginx-controller and use gloo/knative/istio for ingress without a deep knowledge of the jenkins-x.yml pipeline for boot.

What we’d really like is for folks to type commands like…

```
jx delete app nginx-controller
jx add app istio
jx delete app knative
```

And for it to just work and generically add those to the right namespace.

## Current Limitations

The current apps model lets you add/remove charts fine - but there are a number of limitations:

### Only works in 1 namespace

Currently apps can only work inside the dev namespace - we can’t support things like knative, gloo, cert-manager, nginx, velero which tend to be installed in separate namespaces.

### Does not handle boot phases

This is not surprising as we created the App extension model before boot. But right now boot has a number of distinct phases with pipeline steps between them where we may want to add apps:

* pre/post ingress setup (in the case of nip.io / nginx-controller)
* pre/post vault setup
* pre/post vault population of parameters
* pre/post setup of certmanager/external dns

There is currently no way for an apps to specify a namespace + specify which phase its to be installed in & have (say) the domain / certs / secrets injected easily.

So rather than adding steps at the right point in a list of steps in the jenkins-x.yml it would be nice to have a more declarative YAML file to describe which apps are to be enabled.

E.g. we need a new YAML file with list of charts to be installed along with metadata for which phase to install them. We also want to invoke a selection of those appss to be installed at the different phases of the boot pipeline.

### Limitations of the current deploy model

We have some issues with the current way we deploy apps in Staging / Production:

#### Composite charts hide the individual versions

Right now we deploy all charts in Staging/Production as a single chart. That means if you use `helm list` we don't show any actual versions of the dependent charts - its just 1 chart (with no version).

#### Removing Apps on Dev doesn't work

If you remove a chart from `env/requirements.yaml`  in the Dev repository the pipeline does not remove the chart. e.g. if you add `lighthouse` and remove `prow` you need to manually delete the prow resources yourself.


### Limitation of boot

We currently manually configure in the boot pipeline the install of multiple systems usually in separate namespaces:

* velero (if enabled)
* nginx
* externaldns
* cert-manager
* acme certs chart

Ideally those should be modular and optional. e.g it should be really trivial to disable nginx if folks are using, say, istio - without having to hack a pipeline yaml.

We'd also like to make it easy to add a number of other systems in order in separate namespaces independently of the `Staging / Production` environment namespaces:

* knative https://github.com/jenkins-x/jx/issues/6331
* gloo
* istio
* linkerd https://github.com/jenkins-x/jx/issues/6330
* flagger

so it'd be nice to have a simple app model where anyone can add any systems/charts to any namespace at any point in the flow before we setup the dev/staging/production environment in the traditional way.


## Proposal

We propose we combine the extensibility of Jenkins X using Apps with `jx boot` via a simple declarative YAML file declaring the charts to be installed. 

e.g. a file `apps.yaml`  something like this:

```yaml    
defaultNamespace: jx

releases: 
- alias: velero
  name: velero
  repository: https://kubernetes-charts.storage.googleapis.com
  phase: system  
  namespace: velero   
- alias: nginx-ingress
  name: nginx-ingress
  repository: https://kubernetes-charts.storage.googleapis.com
  phase: system  
  namespace: kube-system   
- name: external-dns
  repository: https://charts.bitnami.com/bitnami
  phase: post-ingress  
- alias: cert-manager
  name: cert-manager
  repository: https://charts.jetstack.io
  namespace: cert-manager  
  phase: post-ingress  
- name: jxboot-resources
  repository: http://chartmuseum.jenkins-x.io
- alias: tekton
  name: tekton
  repository: http://chartmuseum.jenkins-x.io
- alias: prow
  condition: prow.enabled
  name: prow
  repository: http://chartmuseum.jenkins-x.io
- alias: lighthouse
  condition: lighthouse.enabled
  name: lighthouse
  repository: http://chartmuseum.jenkins-x.io
- alias: bucketrepo
  condition: bucketrepo.enabled
  name: bucketrepo
  repository: http://chartmuseum.jenkins-x.io
- name: jenkins-x-platform
  repository: http://chartmuseum.jenkins-x.io
```

Using a yaml file in a boot config repo we list the apps that should be installed.  This means we can instead have a bare minimum base boot config repo and list the apps we want installed and different points of the installation process.


The above YAML looks quite like the `env/requirements.yaml` file only: 

* it allows the `namespace` to be specified if its different from the `defaultNamespace`
* we add the `phase` label so that we can filter the apps by phase so we can install different charts at different points in the boot pipeline.


### Strawman Solutions

The above `apps.yaml` proposal looks very much like helmfile. 

So lets look into helmfile and try using it with a stripped back boot config repo to see how things might fit together 

One possible solution might be to add a single step the boot pipeline to invoke helmfile: https://github.com/roboll/helmfile#configuration

e.g. given the `apps.yaml` file in the file system then run helmfile as a step on the file.

It looks like helmfile already supports tillerless + helm3 and lets us define namespaces and orders etc.

We may need to build our own step to wrap helmfile so that we can do some of the things we do with `jx step helm apply` right now (e.g. exposing the `jx-requirements.yml` file as a `values.yaml` its values can be used inside any `values.yaml` we use in the charts).


* should we support access to secrets in vault / local file system via URLs or Parameters injection?
* do we need to support exposing the properties from the `jx-requirements.yml` as values.yaml files that can be reused inside the helmfile templates?
* do we need to improve access to certs / domain after we've set those up in boot?
* allow the use of version streams to manage versions of things if no version is specified in the `helmfile.yaml` - like we do with helm charts requirements.yaml file right now (in `jx step helm apply`)

So if we do need anything other than vanilla helmfile we could maybe do a similar thing to `jx step helm apply` where we copy the directory where helmfile lives, then generate any secret yamls + `jx-requirements.yaml` files and then run helmfile in a temporary directory (to avoid accidentally committing any secrets to git). Hopefully we don't need to fork helmfile; but we could just wrap it slightly with a pre-processor?


We want to allow the `jx boot` pipeline to invoke a helmfile like thing at the different phases.

e.g. currently in boot we do something like this:

* install a bunch of charts in different namespaces with a defined order
* then we modify the requirements based on ingress: `jx step create install values` (to handle things like detecting the domain/ingress)
* install more charts (e.g. external dns/cert manager/vault)
* populate parameters/secrets (`jx step create values --name parameters`)
* do the traditional install and maybe other charts

so we already have 3 natural places to invoke a helmfile-like thing to install charts in different phases. So maybe thats 3 places where we invoke helmfile with a selector as @vbehar mentions if thats something helmfile can do? or we use 3 separate helmfiles maybe?

e.g. the pipeline with boot apps could be something like this...

```
jx step helmfile --selector phase=pre-ingress

# populate ingress stuff (e.g. default domain from nip.io if not using custom domain)
jx step create install values

# add any charts that need a domain injected
jx step helmfile --selector phase=post-ingress


# populate any missing charts in vault
jx step create values --name parameters

# lets include generated secrets after they have been populated in vault
jx step helmfile --selector "!phase" --secrets
```

Then we could have a list of apps which we group as to where they get added based on what they are & whether they need integration with secrets / TLS / domain / certs etc?


We can then modify the existing `jx add app / jx delete app` to detect the `apps.yaml` file and create the necessary code change in a Pull Request.

Maybe over time we move more towards this kind of helmfile-like approach for all environments too (`Dev` / `Staging` and `Production`)?


### Proposed Schedule

We can easily try a prototype a new boot config repo where we add helmfile and add some helmfile steps and see how it works and what we think of the general git source code & if it helps us and users have modular boot apps without committing to any significant changes in the jx repos.



* try out helmfile for installing things like gloo / knative / linkerd / istio?
* if that works and we are happy with it, we could look at adding the phases approach for easier app composition
* if thats all looking good try migrate existing things like nginx / cert manager / external dns to the helmfile approach in a new git repository
* anyone can then try out the helmfile approach without changing the core upstream boot configuration [jenkins-x-boot-config](https://github.com/jenkins-x/jenkins-x-boot-config/tree/master/env)
* we could try create a new remote cluster boot configuration for multi-cluster which installs a small subset of Jenkins X (e.g. lighthouse + tekton + a single `SourceRepository + Schedule` for replicating the logic of the `environment controller`)
* create a demo repository which replaces nginx-controller with knative + gloo we can use for Progressive Delivery demos

Maybe we find when we look at migrating the current charts to boot apps (nginx / cert manager / external-dns in particular) we may find its got some limitations and building a simple similar tool might be easier. Or we may find helmfile gets us where we need to go faster.

