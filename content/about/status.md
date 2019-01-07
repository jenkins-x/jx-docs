---
title: Status
linktitle: Status
description: Current status of Jenkins X
date: 2018-02-01
publishdate: 2018-02-01
lastmod: 2018-02-01
menu:
  docs:
    parent: "about"
    weight: 120
weight: 120
sections_weight: 120
draft: false
aliases: [/about/status]
categories: [fundamentals]
toc: true
---

This page describes any specific manual work arounds you may require above and beyond changes described in the [News section](/news/) or using [jx upgrade]() to upgrade the [CLI](http://localhost:1313/commands/jx_upgrade_cli/) or [platform](/commands/jx_upgrade_platform/)

## 7 Jan 2019: knative upgrade

If you wish to upgrade to the latest [serverless jenkins](/news/serverless-jenkins/) and Prow we recommend you uninstall knative, update the platform and reinstall again:

## 5 Jan 2019: environment git repository issue

There was a regression added a few weeks ago which led to new installations setting up invalid `exposecontroller` configuration in your `Staging/Production` git repositories. See the [issue and workaround](https://github.com/jenkins-x/jx/issues/2591#issuecomment-451516674)

Make sure that the `env/values.yaml` file for your environment git repository uses `expose:` as the key in the YAML and not `exposecontroller:` - if it uses `exposecontroller:` just edit it back to `expose:` and you should be good to go!


