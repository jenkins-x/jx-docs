---
title: Apps
linktitle: Apps
type: docs
description: Adding or configuration apps and charts 
weight: 100
aliases:
  - /docs/v3/guides/apps/
  - /docs/v3/develop/apps
---


Jenkins X 3.x supports the `helmfile.yaml` file format from the [helmfile project](https://github.com/roboll/helmfile) that can be used to define the [Helm](https://helm.sh/) [charts](https://helm.sh/docs/topics/charts/) you wish to install and their namespace.


### Adding Charts

You can then add any charts you wish into the `helmfile.yaml` file in the `releases:` section as follows:

```yaml
releases:
- chart: jetstack/cert-manager 
- chart: flagger/flagger
``` 

The `namespace` and `version` properties of the charts get resolved during deployment via the [version stream](https://jenkins-x.io/about/concepts/version-stream/) or you can specify them explicitly.


The prefix of the chart name is the chart repository name. There are a few chart repository names already defined in the `helmfile.yaml` in the `repositories:` section. You can add any number of chart repositories to the `helmfile.yaml` that you need.

We are trying to increase consistency and use canonical names in `helmfile.yaml` files for chart repositories. You can see the default [chart repository names and URLs in this file](https://github.com/jenkins-x/jxr-versions/blob/master/charts/repositories.yml). Feel free to use any name and URL you like.

#### Using the CLI

There is also a simple CLI command [jx gitops helmfile add](https://github.com/jenkins-x/jx-gitops/blob/master/docs/cmd/jx-gitops_helmfile_add.md) to add charts into the `helmfile.yaml` but its just as easy to do by hand really.

### Adding resources

If you want to create one or more kubernetes resources that are not already packaged as a helm chart you can easily add these into your cluster git repository using the _local chart_ layout.

* create a directory called `charts/myname/templates`
* add whatever kubernetes resources you need into `charts/myname/templates/myresource.yaml`. 
  * Use as many files as you wish, just makes sure you use the `.yaml` extension
 * create a `charts/myname/Chart.yaml` file and populate the default helm metadata like [this example Chart.yaml](https://github.com/cdfoundation/tekton-helm-chart/blob/master/charts/tekton-pipeline/Chart.yaml)
* now reference the `charts/myname` directory in your `helmfile.yaml` file in the `releases:` section via...

```yaml 
releases:
- chart: ./charts/myname
```  

Create a Pull Request. You should see the effective kubernetes resources show up as a commit on your Pull Request
 
### Customising charts

You can add a custom `values.yaml` file to any chart and reference it in the `values:` section of the `helmfile.yaml` file.

e.g. to customise a chart such as `nginx-ingress` you can create a file at `charts/nginx-ingress/values.yaml`. You can then reference the file in the `helmfile.yaml` file:

```yaml 
releases:
...
- chart: stable/nginx-ingress
  version: 1.39.1
  name: nginx-ingress
  namespace: nginx
  values:
  - versionStream/charts/stable/nginx-ingress/values.yaml.gotmpl
  - charts/nginx-ingress/values.yaml
```  

In the above example we added `charts/nginx-ingress/values.yaml` after the version stream configuration thats automatically added for you.

  
You can also use a file called `values.yaml.gotmpl` if you wish to use go templating of the values file. For example this lets you reference properties from the `jx-requirements.yml` file via expressions like `{{ .Values.jxRequirements.ingress.domain }}`.

To see an example of this in action check out the [charts/jenkins-x/tekton/values.yaml.gotmpl](https://github.com/jenkins-x/jxr-versions/blob/master/charts/jenkins-x/tekton/values.yaml.gotmpl) file in the [version stream](https://jenkins-x.io/about/concepts/version-stream/).

Note that many apps are already configured to make use of the `jx-requirements.yml` settings via the [version stream](https://jenkins-x.io/about/concepts/version-stream/) - but you are free to add your own custom configuration. 


### Version Stream folder

You may have noticed there is a folder called `versionStream` inside your clusters git repository. The [version stream](/about/concepts/version-stream/) is used to provide shared configuration such as:

* the verified versions of charts, images and git repositories which have been tested to work together
* the default namespace and configuration of charts.

This means we can share canonical files and metadata across clusters and git repositories.


#### Keeping the version stream in sync

When you [upgrade your cluster](/docs/v3/guides/upgrade/#cluster) the local `versionStream` folder will be upgraded to the latest upstream version stream contents.

We mentioned [above how you can cusomize charts](#customising-charts). Please try keep as many of your customizations as you can outside of the `versionStream` folder as you can so that there's no risk of your configurations getting overridden or causing merge conflicts with upstream [version stream](/about/concepts/version-stream/) changes.

Any changes in the local `helmfile.yaml` or `charts` folder are excluded by the [upgrade mechanism](/docs/v3/guides/upgrade/#cluster) and so are totally safe.
