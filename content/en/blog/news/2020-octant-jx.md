---
title: "Octant: the OSS UI for Jenkins X"
date: 2020-08-06
draft: false
description: a shiny new open source UI for Jenkins X
  
categories: [blog]
keywords: [Community, 2020]
slug: "octant-jx"
aliases: []
author: James Strachan
---

A common question we have heard in the community over the years is [Is there an open source UI for Jenkins X?](/docs/resources/faq/config/#is-there-a-ui-available-for-jenkins-x). 

Well we now have an answer: its [Octant](https://github.com/vmware-tanzu/octant) using the [octant-jx](https://github.com/jenkins-x/octant-jx) plugin.

## Why Octant?

We love [Octant](https://github.com/vmware-tanzu/octant) because:

* open source and very easy to extend with plugins in Go or TypeScript/JavaScript
* lets you visualise and work with all kubernetes and custom resources across multiple clusters
* thanks to [octant-jx](https://github.com/jenkins-x/octant-jx)  has awesome integration with Jenkins X components like apps, environments, pipelines, repositories etc.

## Features

Longer term we're planning on making most of the developer and operations features of Jenkins X available through the UI via [octant-jx](https://github.com/jenkins-x/octant-jx). 

e.g. we hope as part of [Jenkins X 3.x](https://github.com/jenkins-x/enhancements/issues/36) you'll be able to install or upgrade Jenkins X and watch the installation proceed all via Octant.
 
But already right now today you can:

* view applications, environments, pipelines, repositories
* for a pipeline quickly navigate to:
  * its Pod, Log, Pull Request or Preview Environment
  * for each step you can view the step detail or log of the step
* see the various jobs and pipelines used to operate Jenkins X itself
* over time will add management UI capabilities for installing, upgrading and administering Jenkins  

Find out [more about installing and using Octant here](https://github.com/vmware-tanzu/octant#usage).

## Demo

We did a [demo of octant-jx](https://youtu.be/Njl247hjRuU?t=186) at the last [office hours](https://jenkins-x.io/community/office_hours/). We also [presented octant-jx](https://www.youtube.com/watch?v=Njl247hjRuU&t=2027s) at the [octant office hours this week](https://octant.dev/community/).

Here is a [demo video showing octant in action with Jenkins X](https://www.youtube.com/watch?v=2LCPHi0BnUg&feature=youtu.be):

 <iframe width="1292" height="654" src="https://www.youtube.com/embed/2LCPHi0BnUg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
