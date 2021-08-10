---
title: Octant
linktitle: Octant
type: docs
description: desktop Jenkins X Console based on Octant 
weight: 60
aliases:
  - /v3/develop/ui/octant
---

As a general purpose console for working with Kubernetes, Jenkins X, Tekton and more resources we highly recommend either [Octant](https://octant.dev/) or [Lens](/v3/develop/ui/lens/)

To run the [Octant](https://octant.dev/) UI please make sure you are in a local terminal (not inside a VM) as it will run a local process and open a web browser to access a local port. 

Also make sure you are connected to the kubernetes cluster you wish to use first. e.g. run something like this to check you are connected first:

```bash 
kubectl get ns
```

To run Octant with the Jenkins X plugins if you [have a recent jx binary](/v3/guides/upgrade/#cli) run:

```bash 
jx ui
```

This will download the [octant](https://octant.dev/) binary and the [octant-jx](https://github.com/jenkins-x/octant-jx) plugin then startup  [Octant](https://octant.dev/) for you

### More Information

Please check out the [documentation on using Octant and Jenkins X](/docs/reference/components/ui/) to get started.

* [why we love Octant](/blog/2020/08/06/octant-jx/) 

* [demo of using octant](/blog/2020/08/06/octant-jx/#demo)

 <iframe width="1292" height="654" src="https://www.youtube.com/embed/2LCPHi0BnUg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
