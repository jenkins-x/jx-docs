---
title: How it works
linktitle: How it works
description: How boot works under the covers
weight: 130
---


## How it works

The git repository for the (development) environment git repository looks like this...

```
jx-requirements.yml   # the configuration of cluster, environments, storage, ingress etc
helmfile.yaml           # the list of apps to be installed
jenkins-x.yml         # the Jenkins X Pipeline to boot up Jenkins X
apps/
system/
```
We use the [helmfile.yaml](https://github.com/jenkins-x-labs/boot-helmfile-poc/blob/master/helmfile.yaml) file as source to generate 2 `helmfile.yaml` files to perform the installation. This is done by the [jx step create helmfile](https://jenkins-x.io/commands/jx_step_create_helmfile/) command.

After this command is run the git repository file system looks like this...

```
apps/
  helmfile.yaml
system/
  helmfile.yaml
```

Then the pipeline is effectively this (slightly simplifying for clarity):

```
jx step verify preinstall
jx step create helmfile
cd system && helmfile sync
jx step verify ingress
cd apps && helmfile sync
jx step verify env
jx step verify install
```

So the pipeline is very similar to the traditional helm 2 boot pipeline. The main differences is the change to `helmfile sync` to apply all the helm charts at the `system` or `apps` phase. Also the helm 2 pipeline has lots of steps related to installing specific individual charts (nginx/velero/cert-manager/externaldns) - with the helmfile solution thats all done by the `helmfile.yaml` file so we don't need to touch the `jenkins-x.yml` pipeline at all if we want to add/remove any apps.

### How the helmfile.yaml generation works

This is all done by the [jx step create helmfile](https://jenkins-x.io/commands/jx_step_create_helmfile/) command if you want to look at the code. Essentially we take that YAML file and parse it and use it to generate one of the helmfiles: `system/helmfile.yaml` for system charts (installed before ingress, DNS, TLS and certs are setup and the domain is known) and any other charts in `apps/helmfile.yaml`.


#### Defaulting configuration

In an effort to try streamline the users boot configuration repository, we've tried to put as much common configuration into the [version stream](https://jenkins-x.io/about/concepts/version-stream/) as possible. 

For example the default `namespace` for a chart and the `phase` (whether its installed via the `system` helmfile or the default `apps` helmfile) can be specified in the `defaults.yml` file in the version stream. e.g. here's where we define the [apps/stable/nginx-ingress/defaults.yml](https://github.com/jenkins-x/jenkins-x-versions/blob/master/apps/stable/nginx-ingress/defaults.yml) for `nginx-ingress`. This keeps the actual `helmfile.yaml` nice and simple...

```yaml
apps:
- name: stable/nginx-ingress
...
```

Though if you really want you can be completely specific in your `helmfile.yaml` file:

```yaml
apps:
- name: stable/nginx-ingress
  repository: https://kubernetes-charts.storage.googleapis.com
  namespace: nginx
  phase: system
...
```

#### values.yaml* files

In boot with helm 2 you can specify custom `values.yaml` files or `values.tmpl.yaml` (using go templates) files in a folder named after the chart in the `env` folder in the git repository. e.g. here's the [env/tekton/values.tmpl.yaml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/env/tekton/values.tmpl.yaml) file to customise tekton to the Jenkins X requirements and secrets.

We use a similar approach of using `values.yaml` files or templates - which in helmfile are called `values.yaml.gotmpl` instead - which can be put in a folder named after the chart.

So to do something similar in helmfile and helm 3 you could create an `apps/tekton/values.yaml.gotmpl` file and it will be automatically picked up by [jx step create helmfile](https://jenkins-x.io/commands/jx_step_create_helmfile/) and referenced in the generated `apps/helmfile.yaml`.

However usually these `values.yaml*` files we write for each chart are bindings to the `jx-requirements.yml` and secrets and they usually don't change between cluster installations. 

So we've allowed these files to be stored in the [version stream](https://jenkins-x.io/about/concepts/version-stream/) instead. e.g. here's the [apps/jenkins-x/tekton/values.yaml.gotmpl](https://github.com/jenkins-x/jenkins-x-versions/tree/master/apps/jenkins-x/tekton/values.yaml.gotmpl) file to customise the `tekton` chart for use in Jenkins X with helmfile and helm 3.

This helps keep the git repository for your (dev) environment much smaller and easier to manage. You can still override the `values.yaml*` files for any app if you want inside your boot config git repository though..
 
                                      
### Passing in jx-requirements.yml and secrets

In boot with helm 2 we used [some custom values in the values.yaml.tmpl files](https://jenkins-x.io/docs/getting-started/setup/boot/how-it-works/#values-tmpl-yaml-templates) to inject values from the `jx-requirements.yml` and secrets.

To make it easier to use helmfile and helm 3 easily without any custom modifications we've used a slightly different approach:

* we turn the `jx-requirements.yml` file into a vanilla YAML file with the top level key `jxRequirements` - the file is generated by the boot pipeline called `jx-requirements.values.yaml.gotmpl` and referenced in the generated helmfiles. This means instead of expressions like `{{ .Requirements.cluster.provider }}` you can use the vanilla helm expression of `{{ .Values.jxRequirements.cluster.provider }}` in any `values.yaml.gotmpl` you use in helmfile like in the [tekton values.yaml.gotmpl](https://github.com/jenkins-x/jenkins-x-versions/blob/master/apps/jenkins-x/tekton/values.yaml.gotmpl#L8)
* we put all secrets in a file called `secrets.yaml` with a top level key of `secrets` referenced by `$JX_SECRETS_DIR/secrets.yaml`. This means we can change any old boot expressions of `{{ .Parameters.pipelineUser.token }}` to the canonical helm expression `{{ .Values.secrets.pipelineUser.token }}` like in this [tekton values.yaml.gotmpl](https://github.com/jenkins-x/jenkins-x-versions/blob/master/apps/jenkins-x/tekton/values.yaml.gotmpl#L7)