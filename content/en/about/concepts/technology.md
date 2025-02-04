---
title: Technology Questions
linktitle: Technology Questions
description: Technology questions on Kubernetes and the associated opens source projects
weight: 50
---

## What is Helm?

[helm](https://www.helm.sh/) is the open source package manager for Kubernetes.

It works like other package mangers (brew, yum, npm etc) where there's one or more repositories with packages to install (called `charts` in helm to keep with the nautical kubernetes theme) which can be searched/installed and upgraded.

A [helm chart is basically a versioned tarball of kubernetes yaml](https://docs.helm.sh/developing_charts/#charts) which can be easily installed on any kubnernetes cluster.

Helm supports composition (a chart can contain other charts) via the `requirements.yaml` file.
