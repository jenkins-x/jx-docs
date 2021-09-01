---
title: "New features in the pipelines visualizer UI"
date: 2021-01-18
draft: false
description: overview of the recent new features in the pipelines visualizer UI
categories: [blog]
keywords: [Community, 2021]
slug: "jx-pipelines-visualizer-v1"
aliases: []
author: Vincent Behar
---

The [Jenkins X Pipelines Visualizer UI](https://github.com/jenkins-x/jx-pipelines-visualizer) has recently received a number of new features, so let's do a little tour of these new features!

## Pipeline View

When viewing a pipeline, the biggest new feature is the **collapsed logs**. No more hundreds - or thousands - of log lines, we now group the logs per-container (step), which are collapsed by default. Along with the status of the step and its duration, so it's easier to go to the interesting part of the logs.

![](/images/jx-pipelines-visualizer/v1-pipeline-success.png)

Clicking on a log line will expand the logs for this specific container. You can also use the "Toggle Steps" button to expand/collapse the logs for all the steps at once.

While we're talking about the logs, you can notice the 2 new buttons:

- View raw logs
- Download raw logs

On top of the logs, we now display some information about the pipeline:

- the pipeline **meta information**: name, context, build, and a link to see the raw YAML representation of the pipeline
- the pipeline **status**: status, started/finished date/time, and duration
- the pipeline **source**: git repository, pull request or branch, commit SHA, author
- the pipeline **stages**, with links to see the timeline of the steps in each stage. You can also click on the "Show Timeline" button to view the pipeline timeline with all stages and steps.

The **pipeline timeline** has been improved to include all the steps for all stages, but it is currently hidden by default - to avoid using too much space. Clicking on a stage will bring you to the steps, and clicking on a step will bring you to the logs for this step.

![](/images/jx-pipelines-visualizer/v1-pipeline-success-with-timeline.png)

Note that for a pipeline which includes a deployment to a Preview Environment, the UI will also display a link to the application's URL in that specific Preview Environment.

## Homepage

The homepage got some love too, with:

- a few stats about the pipelines: top statuses, repositories, authors and durations - with links to filter the pipelines
- direct links to the git repositories and pull requests
- the Jenkins X logo
- and a favicon

![](/images/jx-pipelines-visualizer/v1-home.png)

## Roadmap

We started this project at v0, and we believe that now it has enough features to be a v1!

On our roadmap - without any specific order - we have:

- [#73](https://github.com/jenkins-x/jx-pipelines-visualizer/issues/73) **live refresh of a running pipeline** - for now only the logs are updated live, not the meta information of the pipeline (status, stages/steps timings)
- [#42](https://github.com/jenkins-x/jx-pipelines-visualizer/issues/42) **support local timezone** - for now everything is in UTC
- **improve the support for archived pipelines**: load pipelines archived in the long-term storage

### Contributing

Thanks to all the contributors!

All contributions are welcomed, the source code is: [github.com/jenkins-x/jx-pipelines-visualizer](https://github.com/jenkins-x/jx-pipelines-visualizer).
