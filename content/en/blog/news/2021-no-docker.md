---
title: "Don't use docker, use kubernetes"
date: 2021-05-17
draft: false
description: If you are developing for kubernetes then don't use docker locally
categories: [blog]
keywords: [Community, 2021]
slug: "dont-use-docker"
aliases: []
author: James Strachan
---
 
Are you developing software that's intended to run on kubernetes? If so we recommend not to use docker on your laptop.

Docker on Windows/MacOS helps you run a VM that can then run linux containers easily. But why bother?

We highly recommend just use a development kubernetes cluster - build and run your containers there instead then you're closer to a production like environment. 

## Why use kubernetes instead of docker?

* why test on a completely different VM and container orchestrator than production? It's better to test on a similar environment to where you are really going to deploy your code
* test your kubernetes yaml / helm chart and associated configuration at the same time as you run your containers helps you catch mistakes earlier:
    * it's not just about running the container image; it's about lots of other things too like networking, configuration, secrets, storage/volumes, cloud infrastructure, service mesh, liveness/readiness/startup probes - so why not test all of those things rather than just the image?
* some corporate environments don't let you run VMs on your laptop anyway so running docker locally isn't an option

## How to get kubernetes?

First you'll need a kubernetes cluster.
 
I fully agree with James Ward that [developers should not need to run kubernetes](https://twitter.com/_JamesWard/status/1393270529474408450?s=20). Friends don't let friends setup and manage kubernetes clusters by hand :). 

So try ask your infrastructure team for a development cluster or, if you can, use the cloud to set-up a managed kubernetes cluster. All the public clouds have a relatively straightforward way to spin up a fully managed kubernetes cluster for you that will be relatively inexpensive & they are easy to scale down when you don't need them. 

e.g. on [Google Cloud](https://cloud.google.com/kubernetes-engine) it's a couple of clicks and about 5 minutes later you'll have a fully managed kubernetes cluster ready to use. Its easy to enable auto-scaling too. Plus there's a free tier. 

If that's not easy for you to achieve you could try reuse a namespace in your staging cluster? Though we don't recommend developing on a production cluster; its too easy to accidentally mess up production; e.g. by using up too many resources or overwriting a cluster scoped resource like a `CustomResourceDefinition` or `ClusterRole` etc.

If you have zero budget you could try [minikube](https://minikube.sigs.k8s.io/docs/start/) or [kind](https://kind.sigs.k8s.io/docs/user/quick-start/) on top of docker; though its much better to reuse as close to the production setup of kubernetes as you can - there can be large variations in platform, version, setup, network, machine size and so forth.

If you are deploying software on kubernetes then I'd hope you've some managed kubernetes solution; so why not use that and spin up another cluster for your team for development?

If your budget is so stretched that you can't afford 2 kubernetes clusters; one for production and one for development + staging; maybe it's time to look at using just pure serverless / FaaS instead of kubernetes anyway? Even in that case it's better to use your serverless / FaaS infrastructure than docker locally for similar reasons.  
         
## How do I connect to kubernetes?

So first you'll need to [install kubectl](https://kubernetes.io/docs/tasks/tools/) and connect to your kubernetes cluster. This step is provider specific - so refer to your kubernetes provider / cloud vendor for that bit.

You can then verify you are connected by running some [kubectl get](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get) commands such as

```bash 
kubectl get ns
kubectl get node
kubectl get pod
```


## How do I replace docker with kubernetes?

### docker run => kubectl run 

Instead of `docker run` to run container images you can use [kubectl run](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#run) to run a container image

If you wish to expose a DNS name for a pod you can use [kubectl expose](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#expose)

### docker build => kubectl build

A drop in replacement for `docker build` is this [kubectl plugin](https://github.com/vmware-tanzu/buildkit-cli-for-kubectl#buildkit-cli-for-kubectl)

![Pants Cast](https://raw.githubusercontent.com/vmware-tanzu/buildkit-cli-for-kubectl/main/docs/pants-cast.svg)

### compose => helm 

Some folks use docker compose files to define all of their various microservices; front end, back end, database etc.

If you have deployed your applications to staging/production then you are probably already using either [helm charts](https://helm.sh/) or kubernetes yaml to define those deployments and services already.

So just reuse all of them when running things locally in your own cluster/namespace.
                                                                                     
Then you don't have to keep 2 completely different configuration files in sync; you can usually just reuse the same helm charts in all environments and clusters.
  

### testcontainers => sidecars / kubedock

Some folks use [testcontainers](https://www.testcontainers.org/) for running extra containers in docker to make it easier to do testing. e.g. to run a database service to run tests using the database.

You could try [kubedock](https://github.com/joyrex2001/kubedock) with testcontainers to see if that solves your problem without requiring a local docker installation.

It does depend a little on what your solution is for CI. 

If you are using [Jenkins X](https://jenkins-x.io/v3) or [tekton pipelines](https://github.com/tektoncd/pipeline) then you can [define sidecars](https://github.com/tektoncd/pipeline/blob/main/docs/taskruns.md#specifying-sidecars) in your pipeline to make sure you have whatever additional services you need when running your tests.

If you are using [Jenkins](https://www.jenkins.io/) then you can add the side cars to the `pod.yaml` you use with the [kubernetes plugin](https://plugins.jenkins.io/kubernetes/) or you could reuse the [tekton client plugin](https://www.jenkins.io/blog/2021/04/21/tekton-plugin/) and use tekton pipelines and sidecars 

If you are [GitHub Actions](https://github.com/features/actions) then you can spin up a kubernetes cluster using [kind](https://kind.sigs.k8s.io/) via this [kind github action](https://github.com/marketplace/actions/kind-kubernetes-in-docker-action) - you can then spin up whatever services you need for your tests via [kubectl apply](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#apply) or `helm install`


### help! we are not even using kubernetes yet

If you have not even started on your journey to kubernetes and have no idea what a [helm chart](https://helm.sh/) is, you could consider [setting up Jenkins X](https://jenkins-x.io/v3/admin/) in your cluster which will then: 

* [automate setting up the CI / CD](/v3/develop/create-project/) for your projects including automatically creating versioned container images and helm charts whenever you merge changes to the main branch
* [automatic promotion through environments via GitOps](https://jenkins-x.io/v3/develop/environments/promotion/) so that new versions of your services are automatically promoted to your `Staging` environment and, by default, when approved are promoted to `Production`
* [Preview Environments](https://jenkins-x.io/v3/develop/environments/preview/) automatically spin up Preview Environments for your Pull Requests so you can get fast feedback before changes are merged to the main branch
    
Once someone on your team has [setup up Jenkins X](https://jenkins-x.io/v3/admin/) then please follow the [development guide](/v3/develop/developing/)
          

### other handy kubectl commands

You may find these handy:

* [kubectl logs](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#logs) to view the logs of any running pod (which is kubernetes terminology for 1 or more containers deployed together as a single unit on the same node)

* [kubectl port-forward](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#port-forward) lets you easily port forward from a pod to a local port so you can easily test things out without having to expose things via ingress
                                                                                                    

### inner loop

If you want to optimise your inner loop so you can edit source code and see the changes running quickly on kubernetes then please check out the options for [inner development loop](/v3/develop/pipelines/inner-loop/)


## Conclusion

Lots of developers have grown fond of their docker installation over the years. Docker was a total game changer in its day!

However if you are building/testing/debugging software to deploy on kubernetes we highly recommend you consider reclaiming the memory, CPU & disk from your laptop and stop running docker locally and just use more kubernetes. 

It will help you go faster, find those kubernetes related issues sooner and help you learn more about kubernetes which will be useful for figuring out production issues whenever they happen. 


