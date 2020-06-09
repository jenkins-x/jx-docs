---
title: Consolidate Apps and Addons
linktitle: Consolidate Apps and Addons
description: Consolidate Apps and Addons
type: docs
weight: 10
---

## 1: Consolidate Apps and Addons

This proposal tries to conslidate Apps and Addons inside Jenkins X to avoid confusion

### Background

Two years ago we added the addon framework to Jenkins X as a way of extending the Jenkins X platform to provide additional capabilities. 

#### We created Addons

`Addons` were either generic helm charts or a combination of helm chart plus some custom go code to install and integrate them with the Jenkins X platform.

At this point we referred to `apps` as the charts developers created. e.g. the output of `jx create quickstart` was an app and `jx get apps` would list the quickstarts folks had added to `Staging` or `Production`.

#### We created Apps

We wanted to avoid having to change the `jx` binary to add a new extension to the Jenkins X platform; so we then introduced the `Apps` framework which provided a more generic way of adding charts chatting to Jenkins X such that anybody could create an app without having to modify the underlying `jx` code.

#### Confusion

That's now left us with confusing over what an App is.

This is made worse by having support for `apps` and `addons` in the current CLI.

Developers like to talk about the `apps` they are developing. 

### Proposal

Going forward lets refer to everything as an `App` and deprecate the use of the word `Addon`. 

Then all of these things would be an `App`:

* system charts like knative, gloo, nginx-controller, flagger, prometheus, external-dns, cert-manager
* instantiations of Quickstarts or repositories that folks import

### Status: Proposed

### Implementation

We would be able to reuse the current `jx add app` and `jx delete app` commands and folks could reuse them to add any app to any environment `dev`, `Staging` or `Production`.

One possible confusion is between `jx promote` and `jx add app`. In many ways `promote` is for promoting a different version to a different environment; `jx add app` adds an app to the current environment (usually `Dev` by default).
