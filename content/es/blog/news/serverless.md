---
title: "Using Jenkins X To Define And Run Serverless Deployments"
date: 2019-07-23T12:20:42-02:00
draft: false
description: >
  Using Jenkins X To Define And Run Serverless Deployments
categories: [blog]
keywords: [Jenkins X, Serverless, Knative, 2019]
slug: "serverless-deployments"
aliases:
  - /news/serverless-jenkins
author: Viktor Farcic
---

<figure>
<img src="/images/2019-dwjw-san-fran-rev.png"/>
</figure>

# Using Jenkins X To Define And Run Serverless Deployments

## What is Serverless Computing?

To understand serverless computing, one needs to understand the challenges we are facing with more "traditional" types of deployments of our applications. A long time ago, most of us were deploying our apps directly to servers. We had to decide the size (memory and CPU) of the nodes where our applications would run, we had to create those servers, and we had to maintain them. The situation improved with the emergence of cloud computing. We still had to do all those things, but now those tasks were much easier due to the simplicity of the APIs and services cloud vendors gave us. Suddenly, we had (a perception of) infinite resources and all we had to do is run a command, and a few minutes later the servers (VMs) we needed would materialize. Things become much easier and faster. But, that did not remove the tasks of creating and maintaining servers. Instead, that made them more straightforward. Concepts like immutability become mainstream as well. As a result, we got much-needed reliability, reduced drastically lean time, and started to rip benefits of elasticity.

Still, some important questions were left unanswered. Should we keep our servers running even when our applications are not serving any requests? If we shouldn't, how can we ensure that they are readily available when we do need them? Who should be responsible for the maintenance of those servers? Is it our infrastructure department, our cloud provider, or can we build a system that will do that for us without human intervention?

Things changed with the emergence of containers and schedulers. After a few years of uncertainty created by having too many options on the table, the situation stabilized around Kubernetes that become the de-facto standard. At roughly the same time, in parallel with the rise of popularity of containers and schedulers, solutions for serverless computing concepts started to materialize. Those solutions were not related to each other or, to be more precise, they were not during the first few years. Kubernetes provided us with means to run microservices as well as more traditional types of applications, while serverless focused on running functions (often only a few lines of code).

The name serverless is misleading by giving the impression that they are no servers involved. They are certainly still there, but the concept and the solutions implementing them allow us (users) to ignore their existence. The major cloud providers (AWS, Microsoft Azure, and Google) all came up with solutions for serverless computing. Developers could focus on writing functions with a few additional lines of code specific to our serverless computing vendor. Everything else required for running and scaling those functions become transparent.

But not everything is excellent in the serverless world. The number of use-cases that can be fulfilled with writing functions (as opposed to applications) is limited. Even when we do have enough use-cases to make serverless computing worthwhile effort, a more significant concern is lurking just around the corner. We are likely going to be locked to a vendor given that none of them implements any type of industry standard. No matter whether we choose AWS Lambda, Azure Functions, or Google Cloud Functions, the code we write will not be portable from one vendor to another. That does not mean that there are no serverless frameworks that are not tied to a specific cloud provider. There are, but we'd need to maintain them ourselves, be it on-prem or inside clusters running in a public cloud. That removes one of the most essential benefits of serverless concepts.

That's where Kuberentes comes into play.

## Serverless Deployments In Kubernetes

At this point, I must make an assumption that you, dear reader, might dissagree with. Most of the companies will run at least some (if not all) of their applications in Kubernetes. It is becoming (or it already is) a standard API that will be used by (almost) everyone. Why is that assumption important? If I am right, then (almost) everyone will have a Kubernetes cluster. Everyone will spend time maintaining it, and everyone will have some level of in-house knowledge of how it works. If that assumption is correct, it stands to reason that Kubernetes would be the best choice of a platform to run serverless applications as well. That would avoid vendor lock-in since Kubernetes can run (almost) anywhere.

Kubernetes-based serverless computing would provide quite a few other benefits. We could be free to write our applications in any language, instead of being limited by those supported by function-as-a-service solutions offered by cloud vendors. Also, we would not be limited to writing only functions. A microservice or even a monolith could run as a serverless application. We just need to find a solution to make that happen. After all, proprietary cloud-specific serverless solutions use containers (of sorts) as well, and the standard mechanism for running containers is Kubernetes.

There is an increasing number of Kubernetes platforms that allow us to run serverless applications. We won't go into all of those, but fastrack the conversation by me stating that Knative is likely going to become the de-facto standard how to deploy serverless load to Kubernetes.

[Knative](https://knative.dev/) is an open source project that delivers components used to build and run serverless applications on Kubernetes. We can use it to scale-to-zero, to autoscale, for in-cluster builds, and as an eventing framework for applications on Kubernetes. The part of the project we're interested in right now is its ability to convert our applications into serverless deployments. That should allow us both to save resources (memory and CPU) when our applications are idle, as well as to scale them fast when trafic increases.

Now that we discussed what is serverless and that I made an outlandish statement that Kubernetes is the platform where your serverless applications should be running, let's talk which types of scenarios are a good fit for serverless deployments.

## Which Types Of Applications Should Run As Serverless?

Initially, the idea was to have only functions running as serverless loads. Those would be single-purpose pieces of code that contain only a small number of lines of code. A typical example of a serverless application would be an image processing function that responds to a single request and can run for a limited period. Restrictions like the size of applications (functions) and their maximum duration are imposed by implementations of serverless computing in cloud providers. But, if we adopt Kubernetes as the platform to run serverless deployments, those restrictions might not be valid anymore. We can say that any application that can be packaged into a container image can run as a serverless deployment in Kubernetes. That, however, does not mean that any container is as good of a candidate as any other. The smaller the application or, to be more precise, the faster its boot-up time is, the better the candidate for serverless deployments.

However, things are not as straight forward as they may seem. Not being a good candidate does not mean that one should not compete at all. Knative, as many other serverless frameworks do allow us to fine-tune configurations. We can, for example, specify with Knative that there should never be less than one replica of an application. That would solve the problem of slow boot-up while still maintaining some of the benefits of serverless deployments. In such a case, there would always be at least one replica to handle requests, while we would benefit from having the elasticity of serverless providers.

The size and the booot-up time are not the only criteria we can use to decide whether an application should be serverless or not. We might want to consider traffic as well. If, for example, our app has high traffic and it receives requests throughout the whole day, we might never need to scale it down to zero replicas. Similarly, our application might not be designed in a way that every request is processed by a different replica. After all, most of the apps can handle a vast number of requests by a single replica. In such cases, serverless computing implemented by cloud vendors and based on function-as-a-service might not be the right choice. But, as we already discussed, there are other serverless platforms, and those based on Kubernetes do not follow those rules. Since we can run any container as serverless, any type of applications can be deployed as such, and that means that a single replica can handle as many requests as its design allows. Also, Knative and other platforms can be configured to have a minimum number of replicas, so they might be well suited even for the applications with a constant flow of traffic.

All in all, if it can run in a container, it can be converted into a serverless deployment, as long as we understand that smaller applications with faster boot-up times are better candidates than others. If there is a rule we should follow when deciding whether to run an application as serverless, it is related to the state. Or, to be more precise, the luck of it. If an application is stateless, it might be the right candidate for serverless computing.

Now, let us imagine that you have an application that is not the right candidate to be serverless. Does that mean that we cannot rip any benefit from frameworks like Knative? We can since there is still the question of deployments to different environments.

Typically, we have permanent and temporary environments. The examples of the former would be staging and production. If we do not want our application to be serverless in production, we will probably not want it to be any different in staging. Otherwise, the behavior would be different, and we could not say that we tested precisely the same behavior as the one we expect to run in production. So, in most cases, if an application should not be serverless in production, it should not be serverless in any other permanent environment. But, that does not mean that it shouldn't be serverless in temporary environments.

Let's take an environment in which we deploy an application as a result of making a pull request as an example. It would be a temporary environment since we'd remove it the moment that pull request is closed. Its time span is relatively short. It could exist for a few minutes, but sometimes that could be days or even weeks. It all depends on how fast we are in closing pull requests.

Nevertheless, there is a high chance that the application deployed in such temporary environment will have low trafic. We would typically run a set of automated tests when the pull request is created or when we make changes to it. That would certainly result in a traffic spike. But, after that, the traffic would be much lower and most of the time non-existent. We might open the application to have a look at it, we might run some manual tests, and then we would wait for the pull request to be approved or for someone to push additional changes if we found some issues or inconsistencies. That means that the deployment in question would be unused most of the time. Still, if it would be a "traditional" deployment, it would oocupy resources for no particular reason. That might even discourage us from making temporary environments due to high costs.

Given that  deployments based on pull requests are not used for final validations before deploying to production (that's what permanent environments are for), we do not need to insist that they are the same as production. On the other hand, the applications in such environments are mostly unused. Those facts lead us to conclude that temporary (often pull-request based) environments are a great candidate for serverless deployments, no matter the deployment type we use in permanent environments (e.g., staging and production).

Now that we saw some of the use cases for serverless computing, there is still an important one that we did not discuss.

## Why Do We Need Jenkins X To Be Serverless?

There are quite a few problems with the traditional Jenkins. Most of us already know them, so I'll repeat them only briefly. Jenkins (without X) does not scale, it is not fault-tolerant, it's resource usage is heavy, it is slow, it is not API-driven, and so on. In other words, it was not designed yesterday, but when those things were not as important as they are today. Jenkins had to go away for Jenkins X to take its place.

Initially, Jenkins X had a stripped-down version of Jenkins but, since the release 2, not a single line of the traditional Jenkins is left in Jenkins X. Now it is fully serverless thanks to Tekton and a lot of custom code written from scratch to support the need for a modern Kubernetes-based solution. Excluding a very thin layer that mostly acts as an API gateway, Jenkins X is fully serverless. Nothing runs when there are no builds, and it scales to accommodate any load. And that might be the best example of serverless computing we can have.

Coontinuous integration and continuous delivery flows are temporary by their nature. When we make a change to a Git repository, it notifies the cluster, and a set of processes are spun. Each Git webhook request results in a pipeline run that builds, validates, and deploys a new release and, once those processes are finished, it dissapears from the system. Nothing is executing when there are no pipeline runs, and we can have as many of them in parallel as we need. It is elastic and resource-efficient, and the heavy lifting is done by Tekton.

Continuous integration and continuous delivery tools are probably one of the best examples of a use-case that fits well in serverless computing concepts.

## What Is Tekton And How Does It Fix Jenkins X?

Those of you using serverless Jenkins X already experienced Knative, of sorts. Tekton is a spin-off project of Knative, and it is the essential component in the solution. It is in charge of creating pipeline runs (a special type of Pods) when needed and destroying them when finished. Thanks to Tekton, the total footprint of serverless Jenkins X is very small when idle. Similarly, it allows the solution to scale to almost any size when that is needed.

Tekton is designed only for "special" type of processes, mostly those associated with continuous integration and continuous delivery pipelines. It is not, however, suited for long-running applications designed to handle requests. So, why am I talking about Tekton if it does not allow us to run our applications as serverless? The answer lies in Tekton's father.

Tekton is a Knative spin-off. It was forked from it in hopes to provide better CI/CD capabilities. Or, to be more precise, Tekton was born out of the [Knative Build](https://knative.dev/docs/build/) component, which is now considered deprecated. But, Knative still stays the most promising way to run serverless applications in Kubernetes. It is the father of Tekton, which we've been using for a while now given that it is an integral part of serverless Jenkins X.

Now, I could walk you through the details of Knative definitions, but that would be out of the scope of this subject. It's about Jenkins X, not about Knative and other platforms for running serverless application. But, my unwilingness to show you the ups and downs of Knative does not mean that we cannot use it. As a matter of fact, Jenkins X already provides means to select whether we want to create a quickstart or import an existing project that will be deployed as a serverless application using Knative. We just need to let Jenkins X know that's what we want, and it'll do the heavy lifing of creating the definition (YAML file) that we need.

So, Jenkins X is an excellent example of both a set of serverless applications that constitute the solution, as well as a tool that allows us to convert our existing applications into serverless deployments. All we have to do to accomplish the latter is to express that as our desire, and Jenkins X will do all the heavy lifting of creating the correct definitions for our applications as well as to move them through their life cycles.
