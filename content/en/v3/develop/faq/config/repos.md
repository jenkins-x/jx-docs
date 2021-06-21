---
title: Repositories
linktitle: Repositories
type: docs
description: Questions on configuring repositories differently
weight: 157
---

## How do I customise a Scheduler?

The [.jx/gitops/source-config.yaml](https://github.com/jenkins-x/jx-gitops/blob/master/docs/config.md#gitops.jenkins-x.io/v1alpha1.SourceConfig) file in your dev cluster git repository lets you configure the name of the `scheduler` to use for all repositories, for a group of repositories or for an individual repository.

The `schedular` name is then resolved to be either a file `versionStream/schedulers/$name.yaml`  or `schedulers/$name.yaml`. 

So if you want to create your own `Scheduler` you could copy the default in-repo based scheduler `versionStream/schedulers/in-repo.yaml` to `schedulers/myname.yaml` and then modify it to suit - then associate `myname` with whatever repositories you wish to use this scheduler for. 

Here is the [default in-repo scheduler](https://github.com/jenkins-x/jx3-versions/blob/master/schedulers/in-repo.yaml) used to define the labels and merge strategy etc.

Once you’ve made your changes to any `Scheduler` and merged changes into your dev cluster repository a [boot job should trigger](/v3/about/how-it-works/#boot-job).

You can watch the boot job run via `jx admin log -w`. Once that is complete you should be able to see the effect of the changes in the `config` and `plugins` `ConfigMap` resources in the `jx` namespace which are then used by [lighthouse](/v3/about/overview/#lighthouse)

```bash 
kubectl get cm config -n jx -oyaml
kubectl get cm plugins -n jx -oyaml
```

## How do I configure Slack notifications?


You can modify the [.jx/gitops/source-config.yaml](https://github.com/jenkins-x/jx-gitops/blob/master/docs/config.md#gitops.jenkins-x.io/v1alpha1.SourceConfig) file in your dev cluster git repository to use custom 

See the [slack configuration guide](/v3/develop/ui/slack/#configuring-slack-notifications)
