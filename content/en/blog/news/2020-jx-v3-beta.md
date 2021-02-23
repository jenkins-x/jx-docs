---
title: "Jenkins X 3.x beta is here!"
date: 2020-12-09
draft: false
description: say hello to Jenkins X 3.x beta!
categories: [blog]
keywords: [Community, 2020]
slug: "jx-v3-beta"
aliases: []
author: James Strachan
---
 
I'm super excited to announce the 3.0 beta of Jenkins X! Christmas has come early this year! 

<img width="387px" src="/images/jxxx.png">

the main documentation of the changes are:

* [the new architecture](/v3/about/overview/) with modular plugins and improved [extension points](/v3/about/extending/)
* [what has changed since 3.x started](/v3/about/changes/) 
* [how 3.x compares to 2.x](/v3/about/comparison/) 
  
but here's a brief summary of the differences:
                   

### User Changes

As a user the high level UX of Jenkins X is similar:

* [automated Continuous Delivery pipelines](/about/concepts/features/#automated-pipelines) for using [tekton](/v3/develop/pipeline-catalog/) for your repositories with [automatic promotion](/about/concepts/features/#promotion) between your [environments](/about/concepts/features/#environments)
* pull requests on your repositories create separate [Preview Environments](/about/concepts/features/#preview-environments) where your team can review your changes and give fast feedback before your changes are approved and merged into the main trunk.

<img width="600" src="/images/pr-comment.png" class="img-thumbnail">

#### New features

* we now default to [vanilla tekton YAML for defining pipelines](/v3/develop/pipeline-catalog/#source-changes) while [accelerating your tekton](/blog/2020/11/11/accelerate-tekton/) with [tekton catalog](/v3/develop/pipeline-catalog/#adding-tasks-from-the-tekton-catalog)
* we include an open source [dashboard](/v3/develop/ui/dashboard/) for visualising pipelines and logs which you can invoke via:
```bash 
jx dash
```
* we have a full [Kubernetes and Jenkins X console](/v3/develop/ui/octant/) based on the excellent [octant](https://octant.dev/) which you can try out via:  
```bash 
jx ui
```
            
<iframe width="600" height="300" src="https://www.youtube.com/embed/2LCPHi0BnUg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


### Platform Changes

* we now use [helm](https://helm.sh/) (3.x) and [helmfile](https://github.com/roboll/helmfile) along with optionally [kustomize](https://kustomize.io/) in a GitOps style to define and configure both Jenkins X itself, your tools and applications in any namespace
* support [multi cluster](/v3/admin/guides/multi-cluster/) out of the box so you can keep `Staging` and `Production` in separate clusters to your development cluster where your pipelines run, you create and release immutable container images and other artifacts.
* to [setup or upgrade](/v3/admin/) Jenkins X we use [terraform](https://www.terraform.io/) to setup your cloud resources on [Azure](/v3/admin/platforms/azure/), [Amazon](/v3/admin/platforms/eks/) or [Google](/v3/admin/platforms/google/) while also supporting on premise, minkube and OpenShift - see the [Admin Guides](/v3/admin/) for more detail
  * the actual installation of kubernetes resources takes place using the [git operator](/v3/admin/guides/operator/) so it runs reliably inside the cluster itself
* we default to using [Kubernetes External Secrets](https://github.com/external-secrets/kubernetes-external-secrets) to manage all secrets for Jenkins X itself, development tools and your applications too. 
  * This means we can support various secret backends such as Alibaba Cloud KMS Secret Manager, Amazon Secret Manager, Azure Key Vault, Hashicorp Vault or GCP Secret Manager
  * It also means we can then check in all kubernetes resources and custom resources directly into git (apart from Kubernetes `Secrets`) so that it super easy to version, review and reason about your kubernetes resources in a GitOps way.
* built in [TLS and DNS](/v3/admin/guides/tls_dns/) support along with [Heath](/v3/admin/guides/health/) reporting and visualising via [kuberhealthy](https://github.com/Comcast/kuberhealthy) 
* we now have an [LTS distribution](/v3/admin/setup/upgrades/lts/) which lets you switch to a much more slower cadence of releases of Jenkins X
 
We have been using Jenkins X 3.x in production now for many months (for CI/CD of all of the [3.x codebase](/v3/about/overview/source/) and [continuously upgrading our cluster in the standard way](/v3/admin/setup/upgrades/) and it's been much simpler and easier to use, operate and configure. 

In general Jenkins X 3.x is now much simpler and more flexible. It supports [lots more platforms than before](/v3/admin/) and should be easy to extend and configure for other platforms too.

{{< admincards >}}


### Getting started

If you have never tried [3.x](/v3/about/) before then please follow the [Admin Guide](/v3/admin/) to get Jenkins X installed on your cloud provider, on premise kubernetes cluster or minikube.

If you previously tried the 3.x alpha then the [migration instructions are here](/v3/admin/guides/migrate/v3-alpha/).

For folks on older 2.x versions of Jenkins X please see [the 2.x migration instructions](/v3/admin/guides/migrate/v2/)

Once your cluster has been installed or migrated then check out the [User Guide](/v3/develop/) on how to develop software continuously with Jenkins X.


### Final thoughts

A huge thanks goes out to all the [contributors](/community/#contributors), folks in the [Jenkins X community](/community/) and the [community around all the open source projects we reuse](/v3/about/overview/projects/) who've helped get this beta together. The improvements in Jenkins X 3.x since 2.x are totally amazing, well done everyone!

Please give Jenkins X a try and [let us know what you think](https://jenkins-x.io/community/#slack) or [raise an issue](https://github.com/jenkins-x/issues
). All feedback highly appreciated - particularly how we can keep improving to help you develop faster.

If you are at all interested in Continuous Delivery with kubernetes using [tools](/v3/about/overview/projects/) like [helm](https://helm.sh/), [helmfile](https://github.com/roboll/helmfile), [knative](https://knative.dev/),  [lighthouse](https://github.com/jenkins-x/lighthouse) and last but definitely not least, [tekton](https://github.com/tektoncd/cli)  then please join the [community](/community/) - its great fun!

I hope you have a great break over the holiday season and 2021 is a little better and more fun than 2020!

For any questions and feedback please reach out on slack https://jenkins-x.io/community/#slack