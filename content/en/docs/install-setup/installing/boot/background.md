---
title: Background
linktitle: Background
description: Why we created Jenkins X Boot
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
weight: 50
aliases:
  - /docs/getting-started/setup/boot/background
  - /docs/getting-started/setup/boot/background/
toc_hide: true
---

We've learnt over the last 1-2 years that there are many different kinds of Kubernetes cluster and ways of setting up things like Ingress, DNS, domains, certificates which leads to complexity in the current [jx create cluster](/commands/jx_create_cluster/) and [jx install](/commands/deprecation/) commands.

Plus its now recommended to use tools like Terraform to manage all of your cloud resources: creating/updating Kubernetes clusters, cloud storage buckets, service accounts, KMS etc.

We found we had lots of different bits of install logic spread across all kinds of different ways of installing (e.g. [jx create cluster](/commands/jx_create_cluster/), [jx install](/commands/deprecation/), the use of the [--gitops flag](/docs/resources/guides/managing-jx/common-tasks/manage-via-gitops/) together with the different ways of managing production secrets - that were hard to test and keep solid.

We also hit issues that the [jx create cluster](/commands/jx_create_cluster/) and [jx install](/commands/deprecation/) commands would install things like ingress controller and not give users the chance to configure/override their installation.

Users often struggled with understanding how to easily configure and override things; or upgrade values after things have been installed.

So we wanted to come up with a new cleaner approach which worked for every kind of installation and provided a standard way to extend and customise the configuration via [Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) and Helm style configuration.
