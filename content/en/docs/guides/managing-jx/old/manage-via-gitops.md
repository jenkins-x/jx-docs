---
title: Manage by GitOps
linktitle: Manage by GitOps
description: Use GitOps to configure and upgrade your Jenkins X installation
date: 2016-11-01
publishdate: 2016-11-01
lastmod: 2018-01-02
categories: [getting started]
keywords: [install,kubernetes]
weight: 150
aliases:
  - /docs/guides/managing-jx/common-tasks/manage-via-gitops/
---

We recommend you use GitOps to manage your installation of Jenkins X, to upgrade it, configure it and add or remove extension [Apps](/docs/contributing/addons/) so it’s easy to audit who changes what in your installation and to easily revert bad changes.

Currently this only works on AWS and Google cloud as it requires our vault operator (which needs cloud storage & KMS) to store secrets while all other configuration is stored in the development environment git repository.

## Using GitOps to manage Jenkins X

If you are creating a cluster or installing on an existing cluster there is a quick and handy way to use GitOps to manage Jenkins X itself - it’s `—ng` for the next generation of Jenkins X. We’ll make this feature flags options the default when we release 2.x of Jenkins X later this year.


The `—ng` flag is an alias for these flags: `—gitops —vault —no-tiller —tekton`. So it also comes with baked in support for [Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) - the modern cloud native pipeline engine based on Tekton.

If you still want to use a Jenkins server as the execution engine for the automated CI/CD pipelines in Jenkins X then you can use `—gitops —vault` instead. Though note that even if using `—ng` and using [Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) powered by tekton - you can still create your own [custom Jenkins servers](/docs/guides/managing-jx/common-tasks/custom-jenkins/) to run traditional Jenkins jobs and pipelines!

Once you have installed Jenkins X using GitOps to manage the dev environment- the install of Jenkins X and it’s additional Apps - you get an extra git repository for Dev, Staging and Production. It also means that if you use an upgrade command like [jx upgrade platform](/commands/deprecation/) or add, upgrade or delete Apps via [jx add app](/commands/jx_add_app/) then those commands will generate Pull Requests on the dev environment git repository - rather like how promotion works when you release new versions of your microservices.


## If things go bad

Generally speaking Jenkins X can upgrade itself quite easily when using tekton. However if an upgrade breaks Jenkins X from implementing CI/CD then the GitOps to revert the change won’t work ;)

if you hit any issues upgrading Jenkins X there is a manual way to apply the contents of the development environment’s git repository

```sh
git clone $MY_DEV_GIT_CLONE_URL jenkins-x-dev-env
cd jenkins-x-dev-env/env
jx step env apply
```
