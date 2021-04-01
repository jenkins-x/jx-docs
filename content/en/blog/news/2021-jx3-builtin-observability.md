---
title: "Jenkins X v3: now with built-in observability"
date: 2021-04-01
draft: false
description: overview of the new built-in observability for Jenkins X
categories: [blog]
keywords: [Community, 2021]
slug: "jx3-builtin-observability"
aliases: []
author: Vincent Behar
---

As a Continuous Delivery platform, Jenkins X has a central part in your infrastructure. If it becomes unstable or unusable, it will impact the whole software delivery of your organization.

{{< tweet 1341177825525547012 >}}

This is why observability is a critical topic for Jenkins X, and work has started to get observability built-in for Jenkins X v3:
- **Platform Observability**: visualize logs and metrics for everything running in the Kubernetes cluster: Jenkins X's own components - Tekton, Lighthouse, cert-manager, ... - but also your own applications, that will be deployed either in preview environments or in the staging/prod environments.
- **Continuous Delivery Indicators**: visualize pull requests, pipelines, releases, and deployments metrics, collected from cluster events and git events.

We're using [Grafana](https://grafana.com/) as the central visualization component: the main entry point from which you can get a complete overview of both your application's lifecycle - development, build, tests, releases, deployments, runtime - and your Continuous Delivery platform.

## Platform Observability

Platform observability is not enabled by default for the moment, so the first step is to enable it, as explained in the [platform observability admin guide](/v3/admin/guides/observability/platform-observability/).

Once it's done, you'll get a running Grafana instance, pre-configured with data sources for applications logs - using [Loki](https://grafana.com/oss/loki/) - and applications metrics - using [Prometheus](https://prometheus.io/). But most important, it comes with a set of pre-defined [Grafana dashboards](https://github.com/jenkins-x-charts/grafana-dashboard) for the main platform components: Tekton, Lighthouse, cert-manager, ...

Here is an example of such a dashboard, using a mix of data sources to display [cert-manager](https://cert-manager.io/) metrics collected by Prometheus - including the certificates expiration dates - and logs collected by Loki/Promtail:

![cert-manager grafana dashboard for Jenkins X](/images/v3/observability_platform_cert-manager.png)

## Continuous Delivery Indicators

Continuous Delivery Indicators' main goal is to give people insights into their workflows/processes so that they can continuously improve them. This is based on the [DORA devops metrics](https://www.devops-research.com/research.html) and the [SPACE framework](https://queue.acm.org/detail.cfm?id=3454124k).

The [CD Indicators](https://github.com/jenkins-x/cd-indicators) addon is not enabled by default for the moment, so the first step is to enable it, as explained in the [continuous delivery indicators admin guide](/v3/admin/guides/observability/cd-indicators/).

Once it's done, you'll get a running collector, along with a PostgreSQL database. The collector will listen for various events, both from the cluster and the git repositories, and store pull requests, pipelines, releases, and deployments data in the PostgreSQL database. The addon will also expose a new Grafana data source along with pre-configured Grafana dashboards, which will be picked up by your running Grafana instance.

Here is an example of such a dashboard, displaying various indicators for a single repository/application: contributors, reviews, pull requests, releases, deployments, ...

![Continuous Delivery Indicators for a single repository](/images/v3/observability_cd_indicators_repository.png)

## Roadmap

This is only the beginning! The next steps - in no particular order:
- configure alerting - using Prometheus alertmanager and Grafana alerting features - with a set of pre-defined alerts
- improve the dashboards
- enable it by default, so that users can benefit from it out of the box

Contributions are welcomed:
- [Grafana/loki/prometheus/... configuration in the versionstream](https://github.com/jenkins-x/jx3-versions)
- [Grafana dashboards](https://github.com/jenkins-x-charts/grafana-dashboard)
- [Continuous Delivery Indicators Collector & Grafana dashboards](https://github.com/jenkins-x/cd-indicators)
