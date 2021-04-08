---
title: "Traces for your pipelines"
date: 2021-04-08
draft: false
description: Jenkins X v3 now comes with tracing support for your pipelines out of the box
categories: [blog]
keywords: [Community, 2021]
slug: "jx3-pipeline-trace"
aliases: []
author: Vincent Behar
---

Now that Jenkins X has solid integration with [Grafana](https://grafana.com/) for its [observability](/blog/2021/04/01/jx3-builtin-observability/), it's time to start building fun things!

And the first one is **tracing for all your pipelines**:

![](/images/jx-pipelines-visualizer/pipeline-trace.gif)

With it, you can easily see the timings of all your pipelines, stages, and steps. This is great to inspect a "slow" pipeline and quickly see the slower steps.

We are using [OpenTelemetry](https://opentelemetry.io/) to generate a "logical" view of the pipeline, with 1 trace per pipeline and 1 span for each stage and step.

![](/images/v3/observability_pipeline_trace.png)

By default, these traces are ingested by [Grafana Tempo](https://github.com/grafana/tempo). But if you prefer to export them to a different destination, it's very easy, and thanks to the [OpenTelemetry Collector](https://opentelemetry.io/docs/collector/) you can export to a lot of different services. You can see the full list [here](https://github.com/open-telemetry/opentelemetry-collector/tree/main/exporter) and [here](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/exporter).

The trace identifier is also stored in the pipeline itself so that the [Jenkins X Pipelines Visualizer UI](https://github.com/jenkins-x/jx-pipelines-visualizer) can link directly to the trace.

### How can you benefit from it in your own Jenkins X cluster?

You just need to enable the observability stack, as explained in the [observability admin guide](/v3/admin/guides/observability/).

Then, trigger a pipeline, and once it's finished, go to the web UI, and click on the "Trace" button on the top-right. That's it!

### What's next?

This is only the first step of native tracing support in Jenkins X. Stay tuned for more!
