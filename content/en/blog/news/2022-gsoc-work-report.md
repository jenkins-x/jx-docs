---
title: "GSoC 2022 Final Report: Building Jenkins X UI"
date: 2022-11-13
draft: false
description: This project replaces the older UI with the new UI with more powerful features.
categories: [blog]
keywords: [Community, jenkins-x, gsoc, 2022]
slug: "GSoC-2022-work-report"
aliases: []
author: Rajat Gupta
---

## Jenkins X New UI
It is a web application built with [Golang](https://go.dev/) for the backend and [Sveltekit](https://kit.svelte.dev/) for the frontend, both of which are built together and used in the same container.
To function properly, it must be installed as a helm chart with Jenkins X CRDs.

🌟 It has light and dark themes.

![homepage.png](/images/gsoc-work-report-22/homepage.png)

![pipelinesPage.png](/images/gsoc-work-report-22/pipelinesPage.png)

## Why need a new UI?
A good UI is essential for a CI/CD tool, as not everyone is familiar with the CLI.
The current UI (jx-pipeline-visualizer) is a read-only UI, the user can view the logs of PipelineActivity but neither can start nor stop the pipeline.

Features that the UI will provide: 
- Start and Stop a PipelineActivity.
- Have an audit trail.
- A graphical representation of PipelineActivity.
- RBAC to limit access to certain functionalities.

New Jenkins X UI focus on Simplicity, Security and a Superb User Experience.

This is NOT GA (General Availability) yet. Visit the project repo [here](https://github.com/jenkins-x/jx-ui) to try it.

## How to use it?
- Go to the `helmfiles/jx/helmfile.yaml` in your cluster repo.
- Replace **jx-pipelines-visualizer** chart with the **jx-ui** chart.
  ```bash
  - chart: jxgh/jx-ui
    version: <latest-version>
    name: jx-ui
    values:
    - ../../versionStream/charts/jxgh/jx-ui/values.yaml.gotmpl
    - jx-values.yaml
  ```
- Do `git push`.
- Add the code snippet to **~/.config/ngrok/ngrok.yml** under `tunnels:`.
  ```bash
  ui:
  proto: http
  addr: 9200
  schemes:
    - http
  ```
- Add that domain to the ingress file, Run the following command and replace **dashboard.jx.change.me** with ngrok link.
  ```bash
  kubectl edit ing jx-ui
  ```
- And boom, visit localhost:9200 and it works, you should see the homepage screen.

## Work Done
### Stop a running or pending PipelineActivity from UI

We have added a button in pipelines page and pipelineDetails page, it asks for confirmation and on selecting **Yes** it will stop the PipelineActivity.

We can stop the PipelineActivity from the pipelines tables.
![pipelinesPageStopBtn.png](/images/gsoc-work-report-22/pipelinesPageStopBtn.png)

We can also stop the PipelineActivity from the pipelines details page.
![pipelineDetailsPageStopBtn.png](/images/gsoc-work-report-22/pipelineDetailsPageStopBtn.png)

**Issue:** https://github.com/jenkins-x/jx-ui/issues/28

**PRs:**
- https://github.com/jenkins-x/jx-ui/pull/50
- https://github.com/jenkins-x/jx-ui/pull/51
- https://github.com/jenkins-x/jx-ui/pull/59
- https://github.com/jenkins-x/jx-ui/pull/75


### Show message with status of the PipelineActivity

When a pipeline is cancelled or it has timedout, we update the status of the pipeline to cancelled or timed out.
However, we do not show the reason why a job was timed out.
That information should be displayed on the pipeline details page (along with the step which has timed out).
**Issue:** https://github.com/jenkins-x/jx-ui/issues/23

**PRs:**
- https://github.com/jenkins-x/jx-api/pull/171
- https://github.com/jenkins-x-plugins/jx-pipeline/pull/481


### Implement a DAG for PipelineActivity

To make the UI more user friendly and to explain the sequence of the steps in a PipelineActivity, we have added a [DAG](https://en.wikipedia.org/wiki/Directed_acyclic_graph) (Directed Acyclic Graph) chart to graphically visualize the PipelineActivity.

We used [D3.js](https://d3js.org/) library to create a custom component which create a DAG chart of PipelineActivity for us.
[D3-hierarchy](https://github.com/d3/d3-hierarchy) is an important part of our component.
We're unit testing the component using [vitest](https://vitest.dev/).

![pipelineDetailsPage.png](/images/gsoc-work-report-22/pipelineDetailsPage.png)

**Issue:** https://github.com/jenkins-x/jx-ui/issues/48

**PRs:**
- https://github.com/jenkins-x/jx-ui/pull/57/files
- https://github.com/jenkins-x/jx-ui/pull/65/files

## What's next?

- The UI project is just started, we have also start a seperate **UI-sig** which you can join from [calendar](https://jenkins-x.io/community/#office-hours).
- There are some amazing features that we are planning to add to the new UI: 
  - Dynamically update the list of pipelines
  - Upgrade version stream from the UI
  - Import repositories using the UI
  - Break down pipeline logs into individual steps
  - Mask secrets in the logs
  - Display logs for cancelled and timed out pipelines

To read more read the issues created [here](https://github.com/jenkins-x/jx-ui/issues)

## Acknowledgements

I never imagined I would be this sad after finishing an internship.
Just as Osama noted in his [work report](/blog/2022/11/08/gsoc-2022/), this was the most difficult experience we have had thus far, but the encouragement of the jx community and the direction of our mentor made it the best educational experience I have ever had.

I learned a lot here, but there are still many things I need to learn (I haven't finished my 30-day plan yet). I knew I could learn a lot from open source, but I didn't expect this much.
In addition, I think the CD Foundation is very special, and the community and the ways in which we can collaborate with other projects are also very valuable.

I started my intern by attending conferences like kubecon and CD Summit, we started **UI-SIG**, and in the last 2 months we've given 3 talks about Jenkins X.
As I mentioned above there are still thing to do in the UI project and since we all loved the GSoC program, I'd love to became a part of it in future with Jenkins X.

Again **Big Thanks** to all my mentor [Ankit](https://github.com/ankitm123), [Christoffer](https://github.com/babadofar), [Marten](https://github.com/msvticket), [Tom](https://github.com/tomhobson) and gsoc fellow [Osama](https://github.com/osamamagdy) and JX community for such a great opportunity.
