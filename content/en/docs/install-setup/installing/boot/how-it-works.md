---
title: How it works
linktitle: How it works
description: Install, configure or upgrade Jenkins X via GitOps and a Jenkins X Pipeline
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
weight: 100
aliases:
  - /docs/getting-started/setup/boot/how-it-works
  - /docs/getting-started/setup/boot/how-it-works/
toc_hide: true
---

## Source Repositories

Boot automatically sets up any source repositories which exist in the [repositories/templates](https://github.com/jenkins-x/jenkins-x-boot-config/tree/master/repositories/templates) folder as [SourceRepository](/docs/reference/components/custom-resources/#sourcerepository)  custom resources and uses any associated [Scheduler](/docs/reference/components/custom-resources/#scheduler) custom resources to regenerate the Prow configuration.

Boot also automatically creates or updates any required webhooks on the git provider for your [SourceRepository](/docs/reference/components/custom-resources/#sourcerepository) resources.

If you are using GitOps we hope to automate the population of the [repositories/templates](https://github.com/jenkins-x/jenkins-x-boot-config/tree/master/repositories/templates) folder as you import/create projects. Until then you can manually create a Pull Request on your boot git repository via [jx step create pullrequest repositories](/commands/jx_step_create_pullrequest_repositories/)

## Pipeline

The install/upgrade process is defined in a [Jenkins X Pipeline](/about/concepts/jenkins-x-pipelines/) in a file called [jenkins-x.yml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/jenkins-x.yml).

Typically you won't need to edit this file; though if you do see the [editing guide](/about/concepts/jenkins-x-pipelines/).

## Configuration

The boot process is configured using helm style configuration in `values.yaml` files. Though we support a few [extensions to helm](https://github.com/jenkins-x/jx/issues/4328).

### Parameters file

We define a [env/parameters.yaml](https://github.com/jenkins-x/environment-tekton-weasel-dev/blob/master/env/parameters.yaml) file which defines all the parameters either checked in or loaded from Vault or a local file system secrets location.

#### Injecting secrets into the parameters

If you look at the current [env/parameters.yaml](https://github.com/jenkins-x/environment-tekton-weasel-dev/blob/master/env/parameters.yaml) file you will see some values inlined and others use URIs of the form `local:my-cluster-folder/nameofSecret/key`. This currently supports 2 schemes:

* `vault:` to load from a path + key from Vault
* `local:` to load from a key in a YAML file at `~/.jx/localSecrets/$path.yml`

This means we can populate all the Parameters we need on startup then refer to them from `values.tmpl.yaml` to populate the tree of values to then inject those into Vault.

### Populating the `parameters.yaml` file

We can then use the new step to populate the `parameters.yaml` file in the Pipeline via this command in the `env` folder:

```sh
jx step create values --name parameters
```

This uses the [parameters.tmpl.schema.json](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/env/parameters.tmpl.schema.json) file which powers the UI.

### Improvements to values.yaml

#### Support a tree of values.yaml files

Rather than a huge huge deeply nested values.yaml file we can have a tree of files for each App only include the App specific configuration in each folder. e.g.

```sh
env/
  values.yaml   # top level configuration
  prow/
    values.yaml # prow specific config
  tekton/
    values.yaml  # tekton specific config
```

then you can omit the `prow:` indentation in the `env/prow/values.yaml` file to make the YAML you create/edit smaller and simpler. It also means longer term we can generate JSON schema files for each `env/$app/values.yaml` files so that we can support better editor/IDE integration

#### values.tmpl.yaml templates

When using `jx step helm apply` we now allow `values.tmpl.yaml` files to use go/helm templates just like `templates/foo.yaml` files support inside helm charts so that we can generate value/secret strings which can use templating to compose things from smaller secret values. e.g. creating a maven `settings.xml` file or docker `config.json` which includes many user/passwords for different registries.

We can then check in the `values.tmpl.yaml` file which does all of this composition and reference the actual secret values via URLs (or template functions) to access vault or local vault files

To do this we use expressions like: `{{ .Parameter.pipelineUser.token }}` somewhere in the `values.tmpl.yaml` values file. So this is like injecting values into the helm templates; but it happens up front to help generate the `values.yaml` files.
