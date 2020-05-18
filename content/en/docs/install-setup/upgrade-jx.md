---
title: Upgrading Jenkins X
linktitle: Upgrading Jenkins X
description:  Instructions on upgrading your Jenkins X installation
date: 2019-05-01
publishdate: 2019-05-01
lastmod: 2019-05-01
categories: [tutorials]
keywords: [usage,docs]
weight: 20
menu:
  docs:
    parent: "Install and Setup"
    title: "Upgrading Jenkins X"
aliases:
    - /docs/resources/guides/managing-jx/common-tasks/upgrade-jx/
---

Keeping your Jenkins X environment updated can be done by command line
using the `jx upgrade` command. Here are the most common resources that
can be upgraded. A comprehensive list of upgradeable resources are
available at [the Jenkins X documentation site for the
command.](/commands/jx_upgrade/)

Upgrading the CLI binary
------------------------

Upgrade your Jenkins X command-line by opening a terminal and running
`jx` to upgrade the binary :

    $ jx upgrade cli

Without options, the command upgrades to the latest version of the `jx`
binary released. If you want to install a certain version of the Jenkins
X command-line binaries, you can add an option specifying the particular
version of `jx`:

    $ jx upgrade cli -v 2.0.46

Upgrading the platform
----------------------

Upgrade your Jenkins X platform and any associated packages by using
`jx` to upgrade the resource:

    $ jx upgrade platform

The `platform` specified in the command is Jenkins, the Helm package
manager and its associated ChartMuseum repository service, Nexus
artifact repository, and Monocular for browsing and searching chart
apps. Any ChartMuseum server associated with the cluster (such as the
[one hosted by the Jenkins X project](http://chartmuseum.jenkins-x.io))
is also referenced by the platform.

Upgrading apps
--------------

You can upgrade any Jenkins X apps installed during the Jenkins X
cluster creation process by using `jx` to upgrade the resource:

    $ jx upgrade apps

The `apps` specified includes *all* installed apps in your kubernetes
cluster if upgrades are available. If you want to upgrade only specific
apps, you can use the `jx upgrade app` command and the specified app:

    jx upgrade app cb-app-slack
