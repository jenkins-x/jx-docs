---
title: Pipeline activites
linktitle: Pipeline activites
type: docs
description: Introduction to Jenkins X Pipeline activites
weight: 300
aliases:
  - /v3/about/concepts/pipeline-activities
---

Jenkins X creates pipeline activites for jobs.
It's a [kubernetes custom resource (CR)](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) which is scoped to a namespace.

Pipeline activities are made up of steps.
A step can have three kinds

- Stage
- Preview
- Promote

Each type of step has a name, status, start and end timestamp.
A pipeline activity can have steps of different kinds (for example a pipeline activity can have a stage, preview and promote step)
Let's look at each of these kinds in detail.

### Stage

A step of kind step is made up of multiple sub steps and is normally associated with the Continuous Integration (CI) part of Jenkins X.
The build controller which runs in the development environment creates a stage for every [tekton taskrun](https://tekton.dev/docs/pipelines/taskruns/).

Example of a pipeline activity with a step of kind stage is shown below (some fields are left out for simplicity):

```yaml
apiVersion: jenkins.io/v1
kind: PipelineActivity
spec:
  pipeline: jenkins-x-plugins/jx-secret/PR-382
  startedTimestamp: "2022-06-28T21:58:12Z"
  status: Succeeded
  steps:
    - kind: Stage
      stage:
        completedTimestamp: "2022-06-28T22:12:20Z"
        name: jx secret lint
        startedTimestamp: "2022-06-28T21:58:21Z"
        status: Succeeded
        steps:
          - completedTimestamp: "2022-06-28T21:58:23Z"
            name: Git Clone
            startedTimestamp: "2022-06-28T21:58:21Z"
            status: Succeeded
          - completedTimestamp: "2022-06-28T22:12:20Z"
            name: Make Lint
            startedTimestamp: "2022-06-28T21:58:25Z"
            status: Succeeded
```

This is a simple Jenkins X pipeline activity which has a step of kind **stage**.

### Preview

A Preview step is responsible for creating a preview environment as part of a pull request.
To learn more about environments see [this](../environments).

A simple pipeline activity with a step of kind preview is shown below (some fields are left out for simplicity):

```yaml
apiVersion: jenkins.io/v1
kind: PipelineActivity
spec:
  steps:
    - kind: Stage
      stage:
        completedTimestamp: "2022-07-01T20:33:32Z"
        name: from build pack
        startedTimestamp: "2022-07-01T20:31:14Z"
        status: Succeeded
        steps:
          - completedTimestamp: "2022-07-01T20:31:33Z"
            name: Git Clone
            startedTimestamp: "2022-07-01T20:31:14Z"
            status: Succeeded
          - completedTimestamp: "2022-07-01T20:31:34Z"
            name: Git Merge
            startedTimestamp: "2022-07-01T20:31:33Z"
            status: Succeeded
          - completedTimestamp: "2022-07-01T20:33:32Z"
            name: Promote Jx Preview
            startedTimestamp: "2022-07-01T20:33:10Z"
            status: Succeeded
    - kind: Preview
      preview:
        applicationURL: https://jx-docs-jx-jenkins-x-jx-docs-pr-3619.infra.jenkins-x.rocks
        pullRequestURL: https://github.com/jenkins-x/jx-docs/pull/3619
        startedTimestamp: "2022-07-01T20:33:32Z"
```

Apart from the stage step, there is a preview step in the pipeline activity.

### Promote

A Promote step is responsible for deploying a version of the application to an environment.
To learn more about environments see [this](../environments).

A simple pipeline activity with step of kind promotion is shown below (some fields are left out for simplicity):

```yaml
apiVersion: jenkins.io/v1
kind: PipelineActivity
spec:
  steps:
    - kind: Stage
      stage:
        completedTimestamp: "2022-06-05T18:21:44Z"
        name: from build pack
        startedTimestamp: "2022-06-05T18:20:23Z"
        status: Succeeded
        steps:
          - completedTimestamp: "2022-06-05T18:20:24Z"
            name: Git Clone
            startedTimestamp: "2022-06-05T18:20:23Z"
            status: Succeeded
          - completedTimestamp: "2022-06-05T18:20:25Z"
            name: Next Version
            startedTimestamp: "2022-06-05T18:20:24Z"
            status: Succeeded
    - kind: Promote
      promote:
        environment: staging
        pullRequest:
          pullRequestURL: https://github.com/jx/jx-promote/pull/28
          startedTimestamp: "2022-06-05T18:21:35Z"
          status: Succeeded
        startedTimestamp: "2022-06-05T18:21:35Z"
        status: Succeeded
    - kind: Promote
      promote:
        environment: production
        pullRequest:
          pullRequestURL: https://github.com/jx/jx-promote/pull/29
          startedTimestamp: "2022-06-05T18:21:41Z"
          status: Succeeded
        startedTimestamp: "2022-06-05T18:21:41Z"
        status: Succeeded
  version: 0.1.3
```

This pipeline activity has two steps of kind promote (apart from the one step of kind stage).
The first promote step promotes to staging environment and the second step promotes to production environment.

You can view all pipeline activities in your cluster by running:

```bash
kubectl get pipelineactivities -A
```
