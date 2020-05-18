---
title: Prow
linktitle: Prow
description: The CI/CD system that Kubernetes uses to build itself
parent: "components"
weight: 40
aliases:
  - /docs/resources/guides/managing-jx/common-tasks/prow
  - /architecture/prow
---

Prow is a Kubernetes based CI/CD system. Jobs can be triggered by various types of events and report their status to many different services. In addition to job execution, Prow provides GitHub automation in the form of policy enforcement, chat-ops via /foo style commands, and automatic PR merging.

Prow has a microservice architecture implemented as a collection of container images that run as Kubernetes deployments

## hook
There is a [binary called hook](https://github.com/kubernetes/test-infra/tree/master/prow/cmd/hook) that receives all the web hooks from GitHub. It is a stateless server that listens for GitHub webhooks and dispatches them to the appropriate plugins. Hook's plugins are used to trigger jobs, implement 'slash' commands, post to Slack, and more. The hook binary exposes a /hook endpoint to receive the Git server web hook requests (basically all web hooks go to /hook). There is an ingress rule that exposes that endpoint to outside the cluster.

## Prow Plugins
The [hook binary](https://github.com/kubernetes/test-infra/tree/master/prow/cmd/hook) uses several different plugins that can be enable/disable independently, to do different things. They are basically event handlers for the different GitHub events received through web hooks. These plugins are configured using a yaml config that is passed from a kubernetes ConfigMap to hook and can be enabled per repo or org. 
All plugins have the same interface. The hook process passes two objects to every plugin: a plugin client that let them talk to k8s, git, GitHub, owners file in git repo, slack, etc., and the deserialized GitHub event (like IssueCommentEvent).

### lgtm plugin
[The LGTM plugin](https://github.com/kubernetes/test-infra/tree/master/prow/plugins/lgtm) is a good example to get started on plugins. It's a plugin that adds the LGTM label when someone comments /lgtm on a Pull Request.

### UpdateConfig plugin
[A plugin that automatically updates a ConfigMap](https://github.com/kubernetes/test-infra/tree/master/prow/plugins/updateconfig) whenever a PR is merged in a repository. That way you can automatically keep your ConfigMaps up to date, following a GitOps flow.
You can map specific files to ConfigMaps, or even use regex.
It’s normally used to update the ConfigMap that contains the prow configuration, so every time a PR is merged with changes in the files containing the prow configuration, the ConfigMap is automatically updated.

### Trigger plugin
Probably the most important plugin. It's plugin that reacts to comments on PR’s, so we can trigger builds (by writing “test” as a comment or any other trigger). It determines which jobs to run based on the job config. When find a job that needs to be trigger, it creates a [ProwJob CRD](https://github.com/kubernetes/test-infra/blob/master/prow/apis/prowjobs/v1/types.go#L85), using the configuration found in the hook ConfigMap (that way you can create a different [ProwJob](https://github.com/kubernetes/test-infra/blob/master/prow/apis/prowjobs/v1/types.go#L85) object depending on the org or repo, like using a different build agent (Jenkins vs Knative vs pods), the type of the job, etc). This CRD contains some interesting fields:

- agent: to select which k8s controller will take care of this job
- refs: GitHub repository and revision to use for the source code
- type: whether is presubmit or post submit (run the job before merging or post merge)
- pod_spec: spec to create a Pod object, if we use [plank](https://github.com/kubernetes/test-infra/tree/master/prow/plank)
- build_spec: spec to create a [Knative Build object](https://github.com/knative/docs/blob/master/build/builds.md), if we use [prow-build](https://github.com/kubernetes/test-infra/blob/master/prow/cmd/build/controller.go)

The life cycle of a [ProwJob](https://github.com/kubernetes/test-infra/blob/master/prow/apis/prowjobs/v1/types.go#L85) is handled by the ProwJob controllers running on the cluster. Potential ProwJob states are:

- triggered: the job has been created but not yet scheduled.
- pending: the job is scheduled but not yet running.
- Success/failure: the job has completed.
- aborted: means prow killed the job early (new commit pushed, perhaps).
- error: means the job could not schedule (bad config, perhaps).

#### Job Type
In the Prow configuration you can configure per-repo Presubmits and Postsubmits jobs that are triggered by the trigger plugin. Presubmits are run when the PR code changes (opening a new PR or pushing code to the PR’s branch), so you can test your new code changes. Postsubmits are run whenever there is a new commit appearing on an origin branch (GitHub push event).

The use-case for postsubmits is that there may be fewer than 100 merges a day to a really high-volume repo, but there could be ten or one hundred times that many presubmit jobs run. Postsubmits can be used when something is very expensive to test and is not necessarily blocking for merge, but you do want signal. Similarly, the way the system works is that your presubmit check will run with your code merged into the branch you're targeting, so technically the merge commit that ends up in `master` branch has effectively been tested already and often this means you may want a presubmit job but not to duplicate it also postsubmit as it gives you no more signal.

### ProwJob controllers
We can later use different Kubernetes Operators that react to ProwJob objects to run our builds, based on the agent field (each operator looks for ProwJobs with specific agent value):

- [Plank](https://github.com/kubernetes/test-infra/blob/master/prow/plank/controller.go) is one that uses kubernetes pods. Uses the `pod_spec` field.
- [prow-build](https://github.com/kubernetes/test-infra/blob/master/prow/cmd/build/controller.go) is a build operator that uses Knative Build CRD. Uses the build_spec field.
- There is a [jenkins-operator](https://github.com/kubernetes/test-infra/blob/master/prow/jenkins/controller.go) that runs builds on Jenkins. This is currently not recommended.

These controllers manage the [the life cycle of a ProwJob](https://github.com/kubernetes/test-infra/blob/master/prow/life_of_a_prow_job.md).

#### [plank](https://github.com/kubernetes/test-infra/tree/master/prow/plank)
Plank is a Kubernetes operator that reacts to ProwJob custom resources. It creates a Pod to run the build associated with the ProwJob object. The ProwJob object itself contains a PodSpec.

- If ProwJob doesn’t have a Pod, it creates a pod to run the build. Use init-containers to do VCS checkout.
- If ProwJob has a Pod with completed status, mark ProwJob as completed.
- If ProwJob is completed, do nothing.

We are using Knative build in Jenkins X, which uses the [prow-build controller](https://github.com/kubernetes/test-infra/blob/master/prow/cmd/build/controller.go), so you shouldn't have to worry about plank.

#### [prow-build](https://github.com/kubernetes/test-infra/blob/master/prow/cmd/build/controller.go)
Kubernetes operator that watches ProwJob objects, and reacts to those whose agent field is the Knative build agent. It will create [a Knative Build object](https://github.com/knative/docs/blob/master/build/builds.md) based on the build_spec field of the ProwJob object. 
[The Knative build controller](https://github.com/knative/build/blob/master/cmd/controller/main.go) reacts to it and creates a Pod to run the build. All the ProwJob, the Build and the Pod have the same name (a UUID).

The Build object contains interesting fields:

- serviceAccountName: [ServiceAccount that contains the Secrets required to access the Git server or the Docker registry](https://github.com/knative/docs/blob/master/build/auth.md).
- source: Git repository and revision to use for source code.
- steps: Specifies one or more container images that you want to run in your build. Each container image runs until completion or until the first failure is detected.
- template: contains the name of a registered Knative BuildTemplate, along with environment variables to pass to the Build object. The template must be a BuildTemplate object that exists in the cluster. **If template field is defined, the steps field will be ignored**.

##### Steps
The steps in a build are the different actions that will be executed as part of that build. Each step in a build must specify a Builder image, or type of container image that adheres to the [Knative builder contract](https://github.com/knative/docs/blob/master/build/builder-contract.md). These steps/builder images

- Are run and evaluated in order, starting from the top of the configuration file.
- Each runs until completion or until the first failure is detected.
- Have two volumes that are shared between all the steps. One will be mounted in /workspace, which contains the code specified in the Build source field. Another one is /builder/home that is mounted in $HOME, and it’s mostly used to save credential files that will be used in different steps.

A builder image is a special image that we can run as a Build CRD's step, and that it is typically a purpose-built container whose entrypoint is a tool that performs some action and exits with a zero status on success. These entrypoints are often command-line tools, for example, git, docker, mvn, and so on.

##### BuildTemplate
[A BuildTemplate](https://github.com/knative/docs/blob/master/build/build-templates.md) encapsulates a shareable build process with some limited parameterization capabilities.

A template contains steps to be executed in the build. Instead of specifying the same steps in different builds, we can reuse those steps creating a BuildTemplate that contains these steps. We use BuildTemplates to share steps between different Builds. [There are community BuildTemplates](https://github.com/knative/build-templates/) that you can use, or you can define your own templates.

###### Jenkins X Build Templates
Jenkins X uses custom BuildTemplates to run the builds of the applications. [In this repository](https://github.com/jenkins-x/jenkins-x-serverless) you can find the different BuildTemplates available, depending on the application language. These BuildTemplates use a different Step builder image depending on the language, since they have to build the application using different tools like maven, go or Gradle. So every Builder image has different tools installed, although eventually all the builder images basically run [serverless Jenkins](/news/serverless-jenkins/) (AKA [Jenkinsfile-Runner](https://github.com/jenkinsci/jenkinsfile-runner)). That allows our builds to define the steps in a Jenkinsfile. All these steps are executed inside the same [Jenkinsfile Runner container](https://hub.docker.com/r/jenkins/jenkinsfile-runner/dockerfile/), which doesn't match the Knative Build steps model.

##### The job is run inside a Pod
The Pod that’s created to run the actual build has a container that does nothing, but it has init containers to do the steps required to run the job:

- [creds-init](https://github.com/knative/build/tree/master/cmd/creds-init): Service account secrets are mounted in /var/build-secrets/ so this container has access to them. It aggregates them into their respective credential files in $HOME, which is another volume shared between all the steps. Typically credentials for git server and docker registry.
- [git-init](https://github.com/knative/build/tree/master/cmd/git-init): clones the specified SHA/revision Git repository into one of the shared volumes /workspace.
- Another init-container for every step defined in the Build or BuildTemplate.

Remember that each init container uses its own container image. Also, they have different filesystem linux namespaces. But they have some shared volumes like the $HOME and the /workspace folders.

## sinker
[Garbage collector](https://github.com/kubernetes/test-infra/tree/master/prow/cmd/sinker) for ProwJobs and Pods created to run builds. It removes completed ProwJobs after 2 days, and completed pods after 30 minutes.

## crier
Another Kubernetes controller that watches ProwJobs CRDs. It contains different reporters to notify ProwJob changes to external clients, like GitHub status check, or message to PubSub.

It's used to update the GitHub commit status when the ProwJob finishes.

## deck
[Presents a UI of recent jobs](https://prow.k8s.io/), and [command/plugin help information](https://prow.k8s.io/command-help).

## tide
PRs satisfying a set of predefined criteria can be configured to be automatically merged by [Tide](https://github.com/kubernetes/test-infra/blob/master/prow/cmd/tide/README.md). It will automatically retest PRs that meet the criteria ("tide comes in") and automatically merge them when they have up-to-date passing test results ("tide goes out”).

It will query GitHub every once in a while trying to merge PR’s. It doesn’t react to events, it’s not a plugin.

## Ongoing efforts
Using init-containers for steps [may change in the future](https://github.com/knative/build/pull/470), due to limitations on init-containers.
Knative Build CRD is being deprecated in favor of the Pipeline CRD. The Build CRD will be superseded by the new Task CRD, but they are really similar.
