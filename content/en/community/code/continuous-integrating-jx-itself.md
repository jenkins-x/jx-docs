---
title: Continuous Integration of JX itself
linktitle: Continuous Integration of JX itself
description: How we use jx to test every change into jx
type: docs
weight: 30
aliases:
- /docs/contributing/code/continuous-integrating-jx-itself/
---

You may be wondering how JayeX introduce changes to JayeX. Of course, JayeX is built using JayeX itself! That means that
new changes to the project go through a CI process, and are built and tested using pipelines that run on a JayeX
Kubernetes cluster.

## Pipelines

A Pull Request in the [jx repository](https://github.com/jenkins-x/jx) will automatically trigger some jobs to do CI.
The jobs are triggered [by Lighthouse](https://github.com/jenkins-x/lighthouse), and we
can [configure which jobs to execute](https://github.com/jenkins-x/jx/blob/main/.lighthouse/jenkins-x/triggers.yaml).
The jobs with always_run configured to be true, will be run when the PR is opened. All jobs (independently of having
always_run set to true or false) can be manually triggered writing a comment in the PR. The comment needed to trigger
the job is also in the configuration, in the trigger key. For example, to trigger the pr tests manually, you may
write a new comment in the PR containing "/test pr", and the pr job will be triggered.

The jobs all have a name and a context in the configuration. The name is the name what will show up on GitHub, and the
context is the JayeX pipeline to execute.

![Jobs executed during CI](/images/contribute/ci-jobs.png)

The pipelines that are executed are [JayeX pipelines](/v3/develop/pipelines/), that underneath use
[Tekton pipelines](https://tekton.dev/docs/pipelines/). These pipelines execute tests to make sure everything still
works.

## Release

After a PR to `jx` is merged a numnber of release artifacts are created:
- images published to GitHub Container Registry (GHCR)
- helm chart
- command binaries which are attached to a release in the application repository

The release is in this stage makrked as pre-release.

Pull requestss are opened to update the version of jx in several repositories: 

- https://github.com/jenkins-x/jx3-pipeline-catalog
- https://github.com/jenkins-x/jx3-versions
- https://github.com/jenkins-x-charts/jxboot-helmfile-resources

## End to end tests

The end-to-end tests run before a PR is merged to `jx3-versions` is called `bdd`. The rough steps that are taken are:

- a cluster is created as described [here](/v3/admin/platforms/google/) 
- in the cluster a [helm chart](https://github.com/jenkins-x-charts/jx-bdd/) that starts a job running further 
  [e2e tests](https://github.com/jenkins-x/bdd-jx3).
- These e2e test create a new application, push it to a new GitHub repository, and deploy it
using jx. 
- Then a PR is opened in the application repository and it is verifeid that a preview is succesfully created and 
  that a new release is built after the PR is approved and merged. 

The tests repositories (for terraform, helmfiles and application) are created on 
[in a private GitHub Organisation  called jenkins-x-bdd](https://github.com/jenkins-x-bdd/).

Crucially the software versions specified in the PR for jx3-version are used during all the steps of the bdd tests. 

## Release

It is when the PR on jx3-versions is merged (after successful end-to-end tests) that the corresponding release in the
[jx repository](https://github.com/jenkins-x/jx) is marked as the latest release.