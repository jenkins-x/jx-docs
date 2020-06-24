---
title: Upgrade Jenkins X
linktitle: Upgrade Jenkins X
description:  Instructions on upgrading your Jenkins X installation
date: 2019-05-01
publishdate: 2019-05-01
lastmod: 2020-06-09
categories: [tutorials]
keywords: [usage,docs]
weight: 50
menu:
  docs:
    parent: "Install and Setup"
    title: "Upgrading Jenkins X"
aliases:
    - /docs/resources/guides/managing-jx/common-tasks/upgrade-jx/
---

Keeping your Jenkins X environment updated can be done by command line
using the `jx upgrade` command. When upgrading the version of Jenkins X
in your Kubernetes cluster we strongly recommend first updating your `jx`
cli to the version of Jenkins X that you are upgrading to.

{{% alert %}}
The following upgrade process is only applicable to Jenkins X clusters that
are managed via [jx boot](/docs/install-setup/boot/).
{{% /alert %}}

Upgrading the CLI binary
------------------------

Upgrade your Jenkins X command-line by opening a terminal and running
`jx` to upgrade the binary :

```sh
jx upgrade cli
```

Without options, the command upgrades to the latest version of the `jx`
binary released. If you want to install a certain version of the Jenkins
X command-line binaries, you can add an option specifying the particular
version of `jx`:

```sh
jx upgrade cli -v 2.0.46
```

 Alternately you can download the required release from the [Jenkins X GitHub releases page](https://github.com/jenkins-x/jx/releases).
 After extracting the binary and adding it to the start of your path you can verify the correct version is available by running:

```sh
jx version --short
```

Upgrading Jenkins X
----------------------

Upgrade the version of Jenkins X running in your cluster using `jx`:

```sh
jx upgrade boot
```

The upgrade command performs the following tasks:

* Clones the version stream repository from the URL referenced in your jx-requirements.yml to your local installation in ~/.jx/jenkins-x-versions overwriting the previous version.

* The version stream repository is inspected for newer tags than those referenced in your jx-requirements.yml

* If updates are available the version stream ref is updated in the jx-requirements.yml

* The version stream is checked for an updated [version](https://github.com/jenkins-x/jenkins-x-versions/blob/master/git/github.com/jenkins-x/jenkins-x-boot-config.yml) of [jenkins-x-boot-config](https://github.com/jenkins-x/jenkins-x-boot-config)

* Changes from the jenkins-x-boot-config repository are cherry picked in to your dev environment repository

* Updates pipeline agent golang builder images from gcr.io.

* A pull request is created in your development environment repository containing all the above changes. The upgrade program displays the URL to the pull request.

Merging the pull request created above will run the development master pipeline in your cluster to apply the upgrade.

The progress of the upgrade can be viewed by running:

```sh
jx get build logs
```

Upgrading apps
--------------

You can upgrade any Jenkins X apps installed into Jenkins X
by using the `jx` cli to check for upgrades with the command:

```sh
jx upgrade apps
```
The `apps` specified includes *all* installed apps in your kubernetes
cluster if upgrades are available. If you want to upgrade only specific
apps, you can use the `jx upgrade app` command and the specified app:

```sh
jx upgrade app cb-app-slack
```

Further information
--------------    
Details information on the upgrade commands are available at [the Jenkins X documentation site for the
command.](/commands/jx_upgrade/)    
