---
title: Apps
linktitle: Apps
type: docs
description: Adding or configuration apps and charts 
weight: 100
aliases:
  - /v3/guides/apps/
  - /v3/develop/apps
---


Jenkins X 3.x supports the `helmfile.yaml` file format from the [helmfile project](https://github.com/roboll/helmfile) that can be used to define the [Helm](https://helm.sh/) [charts](https://helm.sh/docs/topics/charts/) you wish to install and their namespace.


## Adding Charts
            
Jenkins X uses [helmfile](https://github.com/roboll/helmfile#configuration) to configure which versions of which helm charts are to be deployed in which namespace along with its configuration. 


### Using the CLI

The easiest way to add apps/charts to your cluster is via a CLI command [jx gitops helmfile add](/v3/develop/reference/jx/gitops/helmfile/add/) to add charts into the right`helmfile.yaml` for the namespace:

Make sure you are in a git clone of your cluster git repository then run:

```bash
# from inside a git clone of your cluster git repository
jx gitops helmfile add --chart somerepo/mychart --repository https://acme.com/myrepo --namespace foo --version 1.2.3
```

### Using the source code directly

Instead of using the above command line you can just modify the source code in git via your IDE.

If you need more help on how to edit the helmfiles files check out the [helmfile configuration guide](https://github.com/roboll/helmfile#configuration)  

There is a root `helmfile.yaml` file and then a tree of helmfiles for each namespace:

```bash 
helmfile.yaml
helmfiles/
  nginx/
    helmfile.yaml
  jx/
    helmfile.yaml
```

To add a new helm chart find the namespace you wish to add it to and add the chart to that file.

e.g. to add to the `jx` namespace modify the `helmfiles/jx/helmfile.yaml` file.

Then add any charts you like in the `releases:` section as follows:

```yaml
# file: helmfiles/jx/helmfile.yaml 
...
releases:
- chart: flagger/flagger
...
``` 

The `namespace` and `version` properties of the charts get resolved during deployment via the [version stream](https://jenkins-x.io/about/concepts/version-stream/) or you can specify them explicitly.


The prefix of the chart name is the chart repository name. There are a few chart repository names already defined in the `helmfile.yaml` in the `repositories:` section. You can add any number of chart repositories to the `helmfile.yaml` that you need.

We are trying to increase consistency and use canonical names in `helmfile.yaml` files for chart repositories. You can see the default [chart repository names and URLs in this file](https://github.com/jenkins-x/jxr-versions/blob/master/charts/repositories.yml). Feel free to use any name and URL you like.



## Adding resources

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
 
## Customising charts

You can add a custom `values.yaml` file to any chart and reference it in the `values:` section of the `helmfile.yaml` file.

e.g. to customise a chart such as `nginx-ingress` first find the `helmfile.yaml` file that is installing this chart. 

We tend to use a separate `helmfile.yaml` file for each namespace so for `nginx` we have   `helmfiles/nginx/helmfile.yaml`

So create a file `helmfiles/nginx/values.yaml`  and then modify the `helmfiles/nginx/helmfile.yaml` to reference it (see the last line):

```yaml 
releases:
...
- chart: stable/nginx-ingress
  version: 1.39.1
  name: nginx-ingress
  namespace: nginx
  values:
  - versionStream/charts/stable/nginx-ingress/values.yaml.gotmpl
  - values.yaml
```
  
You can also use a file called `values.yaml.gotmpl` if you wish to use go templating of the values file. For example this lets you reference properties from the `jx-requirements.yml` file via expressions like `{{ .Values.jxRequirements.ingress.domain }}`.

To see an example of this in action check out the [charts/jenkins-x/tekton/values.yaml.gotmpl](https://github.com/jenkins-x/jxr-versions/blob/master/charts/jenkins-x/tekton/values.yaml.gotmpl) file in the [version stream](https://jenkins-x.io/about/concepts/version-stream/).

Note that many apps are already configured to make use of the `jx-requirements.yml` settings via the [version stream](https://jenkins-x.io/about/concepts/version-stream/) - but you are free to add your own custom configuration. 
   
### Using requirements in charts

The `jx-requirements.yml` file gets converted to a namespace specific set of values, `jx-values.yaml` in each namespace so it can be easily consumed in the namespace specific helmfile in `helmfiles/$namespace/helmefile.yaml`.

If your chart wishes to reuse some of the configuration from the requirements, you can add a reference to the `jx-values.yaml` file in your chart in the `helmfiles/$namespace/helmefile.yaml` for your namespace:
       
```yaml
- chart: jenkins-x/bucketrepo
  version: 0.1.47
  name: bucketrepo
  values:
  # reuse the standard jx values for ingress domain and so forth:
  - jx-values.yaml
```

There is also a file called `jx-global-values.yaml` which can include various global values like `jx.imagePullSecrets`. You can add your own global values into that file if you wish; it will be replicated into the `helmfiles/*/jx-values.yaml` files so they can be easily consumed in a chart.

### Version Stream folder

You may have noticed there is a folder called `versionStream` inside your clusters git repository. The [version stream](/about/concepts/version-stream/) is used to provide shared configuration such as:

* the verified versions of charts, images and git repositories which have been tested to work together
* the default namespace and configuration of charts.

This means we can share canonical files and metadata across clusters and git repositories.


### Keeping the version stream in sync

When you [upgrade your cluster](/v3/guides/upgrade/#cluster) the local `versionStream` folder will be upgraded to the latest upstream version stream contents.

We mentioned [above how you can cusomize charts](#customising-charts). Please try keep as many of your customizations as you can outside of the `versionStream` folder as you can so that there's no risk of your configurations getting overridden or causing merge conflicts with upstream [version stream](/about/concepts/version-stream/) changes.

Any changes in the local `helmfile.yaml` or `charts` folder are excluded by the [upgrade mechanism](/v3/guides/upgrade/#cluster) and so are totally safe.
