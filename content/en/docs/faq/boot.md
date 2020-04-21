---
title: Boot Questions
linktitle: Boot Questions
description: Questions on using 'jx boot'
weight: 20
autolink: false
aliases:
  - /faq/issues/
---

For more detail check out how to use [jx boot](/docs/getting-started/setup/boot/).

## How do I upgrade boot?

If you are using [jx boot](/docs/getting-started/setup/boot/) you can enable [automatic upgrades](/docs/getting-started/setup/boot/#auto-upgrades) or [manually trigger them yourself](/docs/getting-started/setup/boot/#manual-upgrades).

If anything ever goes wrong (e.g. your cluster, namespace or tekton gets deleted), you can always re-run [jx boot](/docs/getting-started/setup/boot/) on your laptop to restore your cluster.


## How do I add more resources?

Add more resources (e.g. `Ingress, ConfigMap, Secret`) to your development environment by adding YAML files to the boot `env/templates` directory.

## How do I add new Environments?

Add a new `SourceRepository` and `Environment` resource to the `env/templates` folder for each new environment you want tto create. We’ve only added `dev, staging, production` currently.

From your running cluster you can always grab the staging `SourceRepository` and `Environment` resource via the following (where XXX is the name of the staging repository returned via `kubectl get sr`):

```sh
kubectl get env staging -oyaml > env/templates/myenv.yaml
kubectl get sr XXX -oyaml > env/templates/myenv-sr.yaml
```

then modify the YAML to suit, changing the names of the resources to avoid clashing with your staging repository.

## How to to manage SourceRepository resources?

See how to update your [boot configuration with the latest SourceRepository resources](/docs/getting-started/setup/boot/how-it-works/#source-repositories)

## How do I map SourceRepository to a custom Scheduler

You need to map your `SourceRepository` to a `Scheduler` via either specifying `--scheduler` when you `jx create quickstart / jx import` your repository or modifying the `SourceRepository` CRD's `spec.scheduler.name` in your development git repository or specifying a different default scheduler on the `dev environment.spec.teamSettings.defaultScheduler.name` then the next time the prow configuration is generated (on `jx create quickstart / jx import / jx boot` it'll update the prow config to use your scheduler

See also [How do I add multiple parallel pipelines to a project?](/docs/guides/using-jx/faq/chatops/#how-do-i-add-multiple-parallel-pipelines-to-a-project)

## How do I add more charts to Jenkins X?

It depends on which namespace you want the charts to be installed.

If its in the development environment (the `jx` namespace by default) then `env/requirements.yaml` is where to add the chart and for a chart `foo` you can add `env/foo/values.yaml` to configure it. (or `env/foo/values.tmpl.yaml` if you want to use some [templating](/docs/getting-started/setup/boot/how-it-works/#improvements-to-valuesyaml) of the `values.yaml`)


Though if you want our chart to be in another namespace then we use the convention of adding a folder in the `system` directory in the boot configuration (e.g. like we do for ingress, cert manager, velero, service mesh etc). So make a new folder in `system` and add the `jx step helm apply` step in the pipeline in `jenkins-x.yml` like we do for `cert-manager`, `nginx`, `velero` etc.

## How do I disable the ingress controller?

If you already have your own ingress controller and do not want `jx boot` to install another one you can just delete the `install-nginx-controller` step in your dev environment git repository. e.g. [remove this step](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/jenkins-x.yml#L85-L99) from the `jenkins-x.yml` in your dev environment git repository

