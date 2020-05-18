---
title: Continuous Integrating JX itself
linktitle: Continuous Integrating JX itself
description: How we use jx to test every change into jx
type: docs
weight: 30
aliases:
    - /docs/contributing/code/continuous-integrating-jx-itself/
---

You may be wondering how Jenkins X introduce changes to Jenkins X. Of course, Jenkins X is built using Jenkins X itself! That means that new changes to the project go through a CI process, and are built and tested using pipelines that run on a Jenkins X Kubernetes cluster.

## Pipelines
A Pull Request in the [jx repository](https://github.com/jenkins-x/jx) will automatically trigger some jobs to do CI. The jobs are triggered [by Prow](/docs/reference/components/prow/), and we can [configure which jobs to execute](https://github.com/jenkins-x/prow-config-tekton/blob/f1a74a38c2936722f8507769e5a30b56ca96fe45/prow/config.yaml#L902-L932). The jobs with always_run configured to be true, will be ran when the PR is opened. All jobs (independently of having always_run set to true or false) can be manually triggered writing a comment in the PR. The comment needed to trigger the job is also in the configuration, in the trigger key. For example, to trigger the end-to-end tests manually, you may write a new comment in the PR containing "/test bdd", and the bdd job will be triggered.

The jobs all have a name and a context [in the configuration](https://github.com/jenkins-x/prow-config-tekton/blob/f1a74a38c2936722f8507769e5a30b56ca96fe45/prow/config.yaml#L902-L932). The name is the name what will show up on GitHub, and the context is the Jenkins X pipeline to execute.

![Jobs executed during CI](/images/contribute/ci-jobs.png)

These pipelines are defined in the root of the jx repository. For example, [here you can see the bdd pipeline](https://github.com/jenkins-x/jx/blob/master/jenkins-x-bdd.yml) that executes the end-to-end (e2e) tests that will get triggered when we tell Prow to execute the bdd job.

The pipelines that are executed are [Jenkins X pipelines](/about/concepts/jenkins-x-pipelines/), that underneath use [Tekton pipelines](https://cloud.google.com/tekton/). These pipelines execute tests to make sure everything still works. Typically, they execute unit tests and functional e2e tests.

Following our bdd pipeline example, here are the steps executed as part of [the bdd pipeline](https://github.com/jenkins-x/jx/blob/master/jenkins-x-bdd.yml)

![BDD Pipeline](/images/contribute/bdd-pipeline.png)

## End to end tests
For the e2e tests, the application binary is compiled with the changes on the pull request so that the tests use these changes. Docker images are also published to Google Cloud Registry (GCR) with the changes on the pull request, so testing locally is easier.

[The e2e tests live on a different repository](https://github.com/jenkins-x/bdd-jx), and they are ran using [a bash script](https://github.com/jenkins-x/jx/blob/master/jx/scripts/ci.sh), that will be executed inside a container (like all the other steps in all the other pipelines). The bash script reads some secrets from the Kubernetes cluster where this job is running, and prepares the container where the step is being ran to run the tests configuring the Git client locally, creating a valid kubeconfig file to be able to talk to a Kubernetes cluster, etc.

One of the most common e2e test is to create a new application, push it to a new GitHub repository, and deploy it using jx. These repositories created for testing are created on [a GitHub Enterprise instance called beescloud](https://github.beescloud.com/). Credentials to do that are read from the Kubernetes cluster, and passed as parameters while invoking the tests.

The last command on the bash script is actually running the tests using the jx step bdd command, that basically clones [the tests repository](https://github.com/jenkins-x/bdd-jx) and runs a [Makefile target in that repository](https://github.com/jenkins-x/bdd-jx/blob/master/Makefile). Some of the logic executed by Jenkins X during the e2e tests is executed using the jx binary that we compiled on the first step of the pipeline. But not all. Other parts of the logic is executed inside the containers used on the steps of the pipeline.

The containers used as part of the Jenkins X pipelines are called builders. If we want our pull request changes to be used in the builder containers too, we need to tell Jenkins X to use the container images published on a previous step of the pipeline, which contain the pull request changes. Fortunately, [Jenkins X allows you to pass a file that will override the "values.yaml" file used to install Helm charts as part of the Jenkins X installation](/docs/resources/guides/managing-jx/common-tasks/config/). If you don't use a custom values file, [this is the default used when installing Jenkins X](https://github.com/jenkins-x/jenkins-x-platform/blob/master/jenkins-x-platform/values.yaml).

The jx step bdd command allows you to create a new jx cluster to run the e2e tests, or use an existing one. When creating a new cluster, the different components that make up a Jenkins X cluster are installed. By default latest versions for those components would be installed, so two consecutive installations could yield different behaviors because a change on some component between the two. That's not suited for testing, where deterministic scenarios are preferred. That's why the jx step bdd command uses [a versions repository](https://github.com/jenkins-x/jenkins-x-versions) which specifies which version to use for every Jenkins X cluster component. The jx step bdd command may receive a "config" parameter pointing to [a configuration file](https://github.com/jenkins-x/jenkins-x-versions/blob/master/jx/bdd/tekton/cluster.yaml) that specifies how the cluster will be created. If no config parameter is passed, then the Kubernetes cluster referenced in the kubeconfig file that was created before executing the jx step bdd command will be used.

## Release
If all tests pass and the pull request is merged, a new version of jx [will be released](https://github.com/jenkins-x/jx/releases). Not everyone can approve pull requests, only people whose names appear on [the OWNERS file](https://github.com/jenkins-x/jx/blob/master/OWNERS) can approve them. Remember, every merged pull request generates a new jx version. By default, new versions increment the patch part of the version string. This is done automatically, so when merging a pull request if jx is currently at version 1.3.152, after merging the pull request, the version 1.3.53 will be released. But when breaking changes are merged, the minor or major parts of the version string may be manually increased.
