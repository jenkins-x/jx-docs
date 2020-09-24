---
title: "New UI to visualize your pipelines and logs"
date: 2020-09-23
draft: false
description: jx-pipelines-visualizer is a new open-source UI from the community, to visualize the pipelines and logs
  
categories: [blog]
keywords: [Community, 2020]
slug: "jx-pipelines-visualizer"
aliases: []
author: Vincent Behar
---

Welcome to the [Jenkins X Pipelines Visualizer](https://github.com/dailymotion/jx-pipelines-visualizer): a new open-source read-only UI for Jenkins X, with a very specific goal and scope: visualize the pipelines and logs.

This project was started at [Dailymotion](https://www.dailymotion.com/) and quickly shared with the Jenkins X community.

## Why a new UI?

There is already the [Octant-based UI](/blog/2020/08/06/octant-jx/), so why a new UI?

The main reason is that [Octant](https://octant.dev/) "is an application and is intended as a single client tool and at this time there are no plans to support hosted versions of Octant" - see [this thread on the Octant github repository](https://github.com/vmware-tanzu/octant/pull/450) for more information and details.

So while Octant answers to a lot of use-cases, there is one for which it is not suited: quickly printing the build logs on a browser, for a specific pipeline. We want to be able to click on a link from a Pull/Merge Request, and get the pipeline logs. This is the specific use-case covered by the Pipelines Visualizer.

## Features

We want to keep it small, focused, and fast. It's a read-only UI, so there won't be "actions" to trigger a pipeline - because it can already be done using "chatops" commands in the Pull Request for example.

But there are a few interesting features already:
- first, it's very fast to get the logs. Much faster than the old JXUI.
- it can retrieve the logs from pipelines that have been garbage-collected - if you configure the URL of the buckets where the logs are stored.
- it has URLs compatible with the old JXUI - so it's very easy to replace the old JXUI with this new UI and keep all the links working.

## Roadmap

This project was shared very early with the community, after just a few hours of work. So our short-term goal is to improve the UI - make it beautiful.

## Demo

We did a [demo of jx-pipelines-visualizer](https://youtu.be/zv0Dn9RYzwE?t=709) at the last [office hours](https://jenkins-x.io/community/office_hours/):

 <iframe width="80%" height="460" src="https://www.youtube.com/embed/zv0Dn9RYzwE?start=709" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Next steps

Check out the [jx-pipelines-visualizer github repository](https://github.com/dailymotion/jx-pipelines-visualizer) if you want to install it in your cluster - there is a Helm Chart which can be added to your Jenkins X Dev Environment.

And any contributions are welcomed - either create an issue or pull request in the project's github repository, or come in the [#jenkins-x-dev](https://jenkins-x.io/community/#slack) Slack Channel.
