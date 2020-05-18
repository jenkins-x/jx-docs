---
title: Pod Templates
linktitle: Pod Templates
description: Pods used to implement Jenkins pipelines
weight: 160
aliases:
  - /docs/resources/guides/managing-jx/common-tasks/pod-templates
---

We implement CI/CD pipelines using declarative Jenkins pipelines using a `Jenkinsfile` in the source of each application or environment git repository.

We use the [kubernetes plugin](https://github.com/jenkinsci/kubernetes-plugin) for Jenkins to be able to spin up new pods on kubernetes for each build - giving us an elastic pool of agents to run pipelines thanks to kubernetes.

The Kubernetes plugin uses _pod templates_ to define the pod used to run a CI/CD pipeline which consists of:

* one or more build containers for running commands inside (e.g. your build tools like `mvn` or `npm` along with tools we use for other parts of the pipeline like `git, jx, helm, kubectl` etc)
* volumes for persistence
* environment variables
* secrets so the pipeline can write to git repositories, docker registries, maven/npm/helm repositories and so forth

## Referring to Pod Templates

Jenkins X comes with a default set of pod templates for supported languages and runtimes in our [build packs](/architecture/build-packs/) and are named something like: `jenkins-$PACKNAME`.

For example the [maven build pack](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes/blob/master/packs/maven/) uses the pod template `jenkins-maven`.

We can then [refer to the pod template name in the Jenkinsfile](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes/blob/master/packs/maven/Jenkinsfile#L1-L4) using the `agent { label "jenkins-$PACKNAME" }` syntax in the declarative pipeline. e.g.

```groovy
// my declarative Jenkinsfile

pipeline {
    agent {
      label "jenkins-maven"
    }
    environment {
      ...
    }
    stages {
      stage('CI Build and push snapshot') {
        steps {
          container('maven') {
            sh "mvn deploy"
          }
          ...
```

## Submitting new Pod Templates

If you are working on a new [build pack](/architecture/build-packs/) then we'd love you to [submit](/docs/contributing/) a new pod template and we can include it in the Jenkins X distribution!

There now follows instructions on how to do this - please if anything is not clear come [join the community and just ask](/community/) we are happy to help!

To submit a new build pack:

* fork the [jenkins-x-platform](https://github.com/jenkins-x/jenkins-x-platform/) repository
* add your build pack to the [values.yaml file in the jenkins-x-platform repository](https://github.com/jenkins-x/jenkins-x-platform/blob/master/jenkins-x-platform/values.yaml) in the `jenkins.Agent.PodTemplates` section of the YAML
* you may want to start by copy/pasting the most similar existing pod template (e.g. copy `Maven` if you are working on a Java based build pod) and just configuring the name, label and `Image` etc.
* now submit a Pull Request on the [jenkins-x-platform](https://github.com/jenkins-x/jenkins-x-platform/) repository for your pod template

### Build containers

When using pod templates and Jenkins pipelines you could use lots of different containers for each tool. e.g. one container for `maven` and another for `git` etc.

We've found its much simpler to just have a single builder container with all the common tools inside. This also means you can use `kubectl exec` or [jx rsh](/commands/jx_rsh/) to open a shell inside the build pod and have all the tools you need available for use when debugging/diagnosing problem pipelines.

So we have a [builder-base](https://github.com/jenkins-x/builder-base) docker image which [contains all the different tools](https://github.com/jenkins-x/jenkins-x-builders-base/blob/master/Dockerfile.common#L4-L15) we tend to use in CI/CD pipelines like `jx, skaffold, helm, git, updatebot`.

If you want to use a single builder image for your new pod template then you could use builder base as the base and then add your custom tools on top.

e.g. [builder-maven](https://github.com/jenkins-x/jenkins-x-builders/tree/master/builder-maven) uses a [Dockerfile](https://github.com/jenkins-x/jenkins-x-builders/blob/master/builder-maven/Dockerfile#L1) to reference the builder base.

So the simplest thing could be to copy a similar builder - like [builder-maven](https://github.com/jenkins-x/jenkins-x-builders/tree/master/builder-maven) and then edit the `Dockerfile` to add whatever build tools you need.

We love Pull Requests and [contributions](/docs/contributing/) so please submit Pull Requests for new build containers and Pod Templates and we're more than happy to [help](/docs/contributing/)!

## Adding your own Pod Templates

To keep things DRY and simple we tend to define pod templates in the Jenkins configuration then refer to the by name in the `Jenkinsfile`.

There are attempts to make it easy to inline pod template definitions inside your `Jenkinsfile` if you need it; though a pod template tends to have lots of developer environment specific stuff inside it, like secrets, so we'd prefer to keep most of the pod templates inside the source code of your development environment rather than copy/pasting them into each app.

Today the easiest way to add new Pod Templates is via the Jenkins console. e.g.

```sh
jx console
```

That will open the Jenkins console. Then navigate to `Manage Jenkins` (on the left hand menu) then `Configure System`.

You will now be faced with a large page of configuration options ;) The pod templates are usually towards the bottom; you should see all the current pod templates for things like maven, NodeJS etc.

You can edit/add/remove pod templates in that page and hit Save.

Note though that longer term we are hoping to [maintain your development environment via GitOps like we do for Staging & Production](https://github.com/jenkins-x/jx/issues/604) - which means changes made via the Jenkins UI will be lost when [upgrading your development environment](/commands/deprecation/).

So longer term we're hoping to add the Pod Templates into your `values.yaml` file in your developer environment git repository like we do for the [jenkins-x-platform chart](https://github.com/jenkins-x/jenkins-x-platform/blob/master/values.yaml#L194-L431).

If you are creating pod templates using open source build tools then it may be simpler for you to just [submit your pod template in a Pull Request](#submitting-new-pod-templates) and we can bake that pod template into future releases of Jenkins X?

