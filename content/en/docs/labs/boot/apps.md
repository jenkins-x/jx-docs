---
title: Apps framework
linktitle: Apps framework
description: Apps framework - coming soon!
weight: 100
---


The new [helmfile](https://github.com/roboll/helmfile) and helm 3 approach extends the app extension model in Jenkins X.

In essence that means if you are using helmfile you can use the usual Apps commands which create Pull Requests on the [jx-apps.yml](https://github.com/jenkins-x-labs/boot-helmfile-poc/blob/master/jx-apps.yml) file in your environments git repository rather than the traditional `env/requirements.yaml` file.

This also means you can have apps in different namespaces. e.g. its common to put some charts in different namespaces like `nginx-ingress`, `gloo`, `cert-mangager` etc.

### Viewing apps

You can view your apps across all namespaces via [jx get app](https://jenkins-x.io/commands/jx_get_apps/)

``` 
jxl get app
```

This will effectively display data from the [jx-apps.yml](https://github.com/jenkins-x-labs/boot-helmfile-poc/blob/master/jx-apps.yml). This data will be pretty close to using a regular `helm list` using helm 3.x or later; only it will show apps across all namespaces by default..

### Adding apps or charts

you can use [jxl add app](https://jenkins-x.io/commands/jx_add_app/) to add any helm chart to your installation using the usual helm style notation of `repositoryPrefix/chartName` such as:

```
jxl add app jetstack/cert-manager
jxl add app flagger/flagger

```

these commands will implicitly use the [version stream](https://jenkins-x.io/docs/concepts/version-stream/) configuration (via [charts/repositories.yml](https://github.com/jenkins-x/jenkins-x-versions/blob/master/charts/repositories.yml)) to determine the mapping of prefixes to repository URLs.

Then these commands will create Pull Requests on the [jx-apps.yml](https://github.com/jenkins-x-labs/boot-helmfile-poc/blob/master/jx-apps.yml) file in your environments git repository.

Note that usually the Pull Request will only add a simple line of the format to the `apps:` entry:

```
apps:
- name: jetstack/cert-manager 
- name: flagger/flagger
``` 

This keeps the configuration in the environment git repository nice and concise. The `version` of the chart is then resolved during deployment via the [version stream](https://jenkins-x.io/docs/concepts/version-stream/).

### Adding new kubernetes resources

Sometimes you just want to add one or more kubernetes resources such as an `Ingress` or `ConfigMap`.

Helmfile supports using helm charts in source code format; so its easy to add any kubernetes resources directly via YAML files.

e.g. if you look in the `repositories/templates` folder you will see at least one YAML resource. So you could just add more YAML files to that folder.

Though you may want to separate out your resources into their own chart; so you could add a new folder structure like the `resources` folder. e.g. add these files:

``` 
mythings/
  Chart.yaml
  templates/
     some-resource.yaml
```

Then to reference `mythings` add the following to your `jx-apps.yml` file:

```
- name: mythings
  repository: ".."
```

Then longer term if you want to turn your chart `mythings` into a released chart you could create a new git repository and move the folder there, then just remove the `repository:` entry in the `jx-apps.yml` to reference the released chart instead.

### Customising charts

You can add custom `values.yaml` files for a chart by adding the file to `apps/mychart/values.yaml`. This file will then be referenced in the generated `apps/helmfile.yaml` file and passed into `helm` when you next run `jxl boot run`.

e.g. to customise a chart such as `nginx-ingress` you can create a file at `apps/nginx-ingress/values.yaml`. (There's no need to include the chart repository prefix in the path).

You can also use a file called `values.yaml.gotmpl` if you wish to use go templating of the values file. For example this lets you reference properties from the `jx-requirements.yml` file via expressions like `{{ .Values.jxRequirements.ingress.domain }}`. You can also reference the shared secrets in your `values.yaml.gotmpl` file via `{{ .Values.secrets.pipelineUser.username }}`.

To see an example of this in action check out the [apps/jenkins-x/tekton/values.yaml.gotmpl](https://github.com/jenkins-x/jenkins-x-versions/tree/master/apps/jenkins-x/tekton/values.yaml.gotmpl) file in the [version stream](https://jenkins-x.io/docs/concepts/version-stream/).

Note that many apps are already configured to make use of the `jx-requirements.yml` settings via the [version stream](https://jenkins-x.io/docs/concepts/version-stream/) - but you are free to add your own custom configuration. 

### Removing apps

To remove an app use [jx delete app](https://jenkins-x.io/commands/jx_delete_app/):

```
jxl delete app jetstack/cert-manager
```