---
title: "Jenkins X Key Takeaways from Jenkins World 2019"
date: 2019-09-03
draft: false
description: >
  The top 12 things I learned about Jenkins X at DevOps World | Jenkins World
categories: [blog]
keywords: [Jenkins X,DevOps World,Jenkins World,2019]
slug: "jenkinsworld-2019-takeaways"
aliases: []
author: John McGehee
---
Jenkins X was the star of the show at DevOps World | Jenkins World 2019. In this article I will
share with you the dozen key things I learned about this exciting new cloud native CI/CD tool.
Beyond its capabilities as a CI/CD tool, Jenkins X also provides an excellent example of how to architect
a cloud native application on Kubernetes.

Jenkins X is a completely new CI/CD system that shares little but its name with the existing Jenkins. Jenkins X incorporates the best practices from the *State of DevOps* reports and the seminal book, *Accelerate* by [Nicole Forsgren](https://twitter.com/nicolefv), [Jez Humble](https://twitter.com/jezhumble) and [Gene Kim](https://twitter.com/RealGeneKim).

<img width="70%" height="70%" alt="Capabilities of Jenkins X" src="https://www.cloudbees.com/sites/default/files/jenkinsx_capabilities.png">

I attended multiple presentations by [James Strachan](https://twitter.com/jstrachan), [Andrew Bayer](https://twitter.com/abayer) and [James Rawlings](https://twitter.com/jdrawlings) of CloudBees, and [Mauricio Salatino](https://twitter.com/salaboy). Mr. Rawlings even gave two presentations. Each presentation covered Jenkins X from a different perspective, so here I compose everything into a unified summary.

## Setting up Kubernetes

[Terraform is recommended](https://cb-technologists.github.io/posts/gitops-series-part-1/) for
setting up the required Kubernetes cluster and storage buckets. As explained below, you may find it
useful to run `jx boot` from within Terraform.

By default, Terraform stores its state in local file `terraform.tfstate`. In an ephemeral cloud
environment, this state gets lost and you would create a new cluster each time you applied
Terraform. Remedy this by specifying a [Terraform backend](https://www.terraform.io/docs/
backends/index.html) to store the state in more durable storage like Google Cloud Storage or
Amazon S3.

Presenters recommended nginx as an ingress controller and
[cert-manager](https://cb-technologists.github.io/posts/gitops-series-part-1/) to manage TLS
(HTTPS SSL) certificates.

For introspection, navigation and object management of your Kubernetes cluster, try
[VMWare's Octant UI tool](https://github.com/vmware/octant). It runs on your local client just like
`kubectl`. An advantage of Octant is that it authenticates the same way as `kubectl`: if `kubectl` works, octant works.

## Setting up Jenkins X

For a stable build of Jenkins X, get the
[CloudBees Jenkins X Distribution](https://www.cloudbees.com/products/cloudbees-jenkins-x-distribution).

Jenkins X has two modes:

* Static traditional Jenkins master with Jenkins pipelines. Use this if you want to continue
  using your existing Jenkinsfiles.
* Jenkins X pipelines based on [Tekton pipelines](https://github.com/tektoncd/pipeline).
  This is now the default, and is recommended for the long term. This mode is controlled by
  the new `jenkins-x.yml` file, whose syntax resembles the Jenkinsfile declarative pipeline
  syntax.

There are two interactive quick start commands. The older and presumably more stable is:
```sh
jx create quickstart
```

The new way to install, configure and upgrade Jenkins X is:
```sh
jx boot
```

`jx boot` interactively queries the user for the required setup data, recording the responses in file `jx-requirements.yml`. It is re-entrant so you can run it repeatedly. Running `jx boot` from within Terraform is a useful technique.

Jenkins X evolves quickly, so `jx boot` records the Jenkinx X version to use in field
`versionStream` within `jx-requirements.yml`. This establishes the version to use on subsequent
invocations of `jx boot`. Update `versionStream` when you want to start using a newer version of
Jenkins X.

## Getting status

Get logs using:
```sh
jx get build logs
```

Track execution with:
```sh
jx get activity
```

List preview environments using:
```sh
jx get environments
```

## Basic concepts in Jenkins X pipelines

At this point a little vocabulary lession is in order.

### Step

A step is a command that runs in a separate container, sharing a workspace with other steps. Once a step fails, subsequent steps will not run. Step names must be unique within a stage. There is also a loop step, which runs the same command for each value in a list.

All the usual Kubernetes container configuration of resources, limits, volume mounts and so on are available within steps.

### Stage

A stage is a unit of work in a pipeline. A stage contains either steps or nested stages. Each stage with steps runs in its own pod. The workspace is copied from one stage's pod to the next.

### Pipeline

There are two types of pipelines:

* Release pipelines merge into master, create a release and trigger promotion
* As the name implies, pull request pipelines are used to create a merge request preview environment

A pipeline is controlled by a `jenkins-x.yml` file at the top of the source control repository.

### Meta pipeline

Jenkins X has a bootstrapping problem: how to create a pipeline? The meta pipeline creates the real pipeline, sort of like Maven `release:prepare`.

## Defining pipelines

There are three ways to define a Jenkins X pipeline:

* Automatically via a build pack. The build pack automatically detects the source code language.
* Specify a build pack and then override portions of it in `jenkins-x.yml`
* Fully define an entirely new pipeline in `jenkins-x.yml`. This is only useful for a pipeline
  that will not be reused. For reusable pipelines, define a build pack.

Build packs are standard, opinionated pipelines for languages. They consist of a predefined
sequence of steps that run in a consistent order. They are similar to stages in that they can be
overridden and extended.

Jenkins X is controlled by a `jenkins-x.yml` file that lives at the root of the Git repository.
In `jenkins-x.yml`, you can:

* Override build packs
* Run steps before existing step using setup
* Use `type: replace` to replace a step
* To add a step to the end of the stage, leave the step name unspecified
* To apply an override to all pipelines, leave the pipeline name unspecified
* Modify container configuration or environment variables. Override environment variables
  using the same syntax as Kubernetes.

You can also define a completely new pipeline in `jenkins-x.yml`, but this is useful chiefly for debugging and testing. Again, make a pipeline reusable by defining it as a build pack.

### Default pipeline

Pull request and release pipelines are often very similar, so define common attributes for both
in a default pipeline.

## Validating syntax and IDE autocompletion

Check your pipelines using:
```sh
jx step syntax validate
```

Pipelines are usually defined by multiple YAML files. See how they fit together in a single flat pipeline file:
```sh
jx step syntax effective
```

The Jenkins X YAML schema is uploaded to [schemastore.org](https://schemastore.org), where amazingly IntelliJ and the VS Code YAML Language Extension automatically pick it up.

## GitOps, Prow and Lighthouse

GitOps is at the core of Jenkins X. GitOps extends Infrastructure as code by using pull requests to manage infrastructure changes. These pull requests might be created by developers, or they might be generated automatically by tooling.

Accordingly, Jenkins X creates a preview environment for each run of a pull request pipeline.

Jenkins X currently uses Prow as a webhook handler and ChatOps engine for pull requests. Importantly, **at this time Prow supports only GitHub.**

Since Jenkins X uses only a small portion of Prow, and since Prow supports only GitHub, the
Jenkins X team is developing [Lighthouse](https://github.com/jenkins-x/lighthouse) as a
lightweight replacement. In this very experimental webhook handler, the Git provider is factored
out so that new providers can be easily added.

As an aside, adding a [new Git provider for Lighthouse](https://github.com/jenkins-x/go-scm) would be an excellent way to learn the Go language.

## Avoiding committing secrets

It can be difficult to avoid commiting secrets to Git. Thus separate file `parameters.yml` contains URL references to a secret. Also, Jenkins X runs Helm in a temporary directory.

The Helm chart `values.yml` files are separated into individual `values.tmpl.yml` files. These are templates so you can easily interpolate secrets into them.

## Implementing HTTPS in preview environments

It is difficult to get HTTPS to work in preview environments because each preview environment gets a different URL. James Rawlings demonstrated the solution:

1. Specify that you want to use DNS for HTTPS in `jx boot`. This will cause [external-dns](https://github.com/kubernetes-incubator/external-dns) to be installed automatically.
2. Add `externalDNS` in `requirements.yml`:
   ```
   ingress:
     externalDNS: true
   ```

3. Then, create the domain (this example assumes you are using GKE):
   ```
   jx create domain gke --domain rawlingsdemo.co.uk
   ```

4. Finally, go to your domain registrar and replace their name servers with Google's name servers

## Using Jenkins X in multiple clusters

Strictly speaking, Jenkins X does not require its own cluster, but things work better operationally if you use separate clusters for testing, staging and production.

You only need to install Jenkins X on the development cluster. Install the Jenkins X [environment controller](https://github.com/jenkins-x-charts/environment-controller) on the staging and production clusters. This is further explained in the article [Multiple Clusters](https://jenkins-x.io/getting-started/multi-cluster/).

## Upcoming Jenkins X features

Jenkins X is evolving rapidly. Upcoming features are:

* Conditional execution of stages
* Jenkins X apps to inject steps and stages
* More advanced configuration of stage pods
* More advanced solution for pipeline and stage sharing across repos

## Learning Jenkins X

Many fine examples with source code on GitHub were presented:

* Mauricio Salatino presented what was by far
  [the most extensive example](https://salaboy.com/2019/08/12/building-cloud-native-platforms-with-jenkins-x/).
  Starting with a monolithic application, he decomposed it into microservices, built it with
  Jenkins X and deployed it on Kubernetes.
* For instruction on how to use Kubernetes itself, Mauricio recommends
  [learnk8s.io](https://learnk8s.io/academy/).
* Kurt Madel's CloudBees Technologists Group gave
  [several lightning talks](https://cb-technologists.github.io/posts/lightning-talks-dw-jw-2019/)
  that discuss Jenkins X.
  [GitOps for Jenkins Infrastructure](https://cb-technologists.github.io/posts/gitops-series-part-1/)
  contains great Terraform tips for regular Jenkins (not Jenkins X). Whether or not you really
  want to use GitOps for your blog,
  [GitOps for Blogging, Why Not?](https://github.com/cb-technologists/blog)
  demonstrates GitOps principles.

## Getting involved with the Jenkins Community

Multiple presenters recommended the [Jenkins X Slack channels](https://jenkins-x.io/community/) as the best source of help and information. For more ways to get involved, see the [Jenkins X community page](https://jenkins-x.io/community/). I'll see you there.
