---
title: UI
linktitle: UI
description: Octant the OSS web UI for Jenkins X
parent: "components"
weight: 5
deprecated: true
---

If you want an open source web UI for working with Jenkins X we highly recommend [Octant](https://github.com/vmware-tanzu/octant) along with the [octant-jx](https://github.com/jenkins-x/octant-jx) plugin.

See the [installation guide](https://github.com/jenkins-x/octant-jx#install) to get started.

## Why Octant?

We love [Octant](https://github.com/vmware-tanzu/octant) because:

* open source and very easy to extend with plugins in Go or TypeScript/JavaScript
* lets you visualise and work with all kubernetes and custom resources across multiple clusters
* thanks to [octant-jx](https://github.com/jenkins-x/octant-jx)  has awesome integration with Jenkins X components like apps, environments, pipelines, repositories etc.

## Features

Longer term we're planning on making most of the developer and operations features of Jenkins X available through the UI via [octant-jx](https://github.com/jenkins-x/octant-jx) but already you can:

* view applications, environments, pipelines, repositories
* for a pipeline quickly navigate to:
  * its Pod, Log, Pull Request or Preview Environment
  * for each step you can view the step detail or log of the step
* see the various jobs and pipelines used to operate Jenkins X itself
* over time will add management UI capabilities for installing, upgrading and administering Jenkins  

## Demo

Here is a [demo video showing octant in action with Jenkins X](https://www.youtube.com/watch?v=2LCPHi0BnUg&feature=youtu.be):

 <iframe width="1292" height="654" src="https://www.youtube.com/embed/2LCPHi0BnUg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
  
We also [presented octant-jx](https://www.youtube.com/watch?v=Njl247hjRuU&t=2027s) at the [octant office hours this week](https://octant.dev/community/).