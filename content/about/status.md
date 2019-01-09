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

This page describes any specific manual work arounds you may require above and beyond changes described in the [News section](/news/) or using [jx upgrade](/commands/jx_upgrade/) to upgrade the [CLI](/commands/jx_upgrade_cli/) or [platform](/commands/jx_upgrade_platform/)

## 8 Jan 2019: Prow and Knative Build upgrade

There are three critical bugs with the prow based Jenkins X
https://github.com/jenkins-x/jx/issues/2539
https://github.com/jenkins-x/jx/issues/2561
https://github.com/jenkins-x/jx/issues/2544

The fixes involve upgrading to a newer version of Prow and Knative Build, the latter caused an issue when performing a traditional `jx upgrade addon` so we recommend uninstalling Knative Build first (removes Knative Build related Custom Resource Definitions) and install the latest release.  

The `jx upgrade addon prow` will now handle this for you but this means any existing builds or custom changes to `BuildTemplate` resources will be lost.

```
jx upgrade cli
jx upgrade addon prow
```

## 5 Jan 2019: environment git repository issue

There was a regression added a few weeks ago which led to new installations setting up invalid `exposecontroller` configuration in your `Staging/Production` git repositories. See the [issue and workaround](https://github.com/jenkins-x/jx/issues/2591#issuecomment-451516674)

Make sure that the `env/values.yaml` file for your environment git repository uses `expose:` as the key in the YAML and not `exposecontroller:` - if it uses `exposecontroller:` just edit it back to `expose:` and you should be good to go!

Also we have noticed a possible regression with helm where if you have multiple `expose:` sections in your environment `env/values.yaml` it can disable the `exposecontroller` post install helm hook which can break the creation of `Ingress` resources in your environment - if you have more than one `expose:` sections please combine them into a single entry

