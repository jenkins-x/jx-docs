---
title: Apps
linktitle: Apps
description: Working with apps 
weight: 100
---


Jenkins X 3.x supports the `helmfile.yaml` file format from the [helmfile project](https://github.com/roboll/helmfile) that can be used to define the helm charts you wish to install and their namespace.

You can then add any charts you wish:

```yaml
releases:
- chart: jetstack/cert-manager 
- chart: flagger/flagger
``` 

The `version` properties of the charts are resolved during deployment via the [version stream](https://jenkins-x.io/about/concepts/version-stream/).


### Customising charts

You can add custom `values.yaml` files for a chart by adding the file to `values/mychart/values.yaml`. This file will be used in the environments pipeline to generate the correct kubernetes resources.

e.g. to customise a chart such as `nginx-ingress` you can create a file at `values/nginx-ingress/values.yaml`. (There's no need to include the chart repository prefix in the path).

You can also use a file called `values.yaml.gotmpl` if you wish to use go templating of the values file. For example this lets you reference properties from the `jx-requirements.yml` file via expressions like `{{ .Values.jxRequirements.ingress.domain }}`. You can also reference the shared secrets in your `values.yaml.gotmpl` file via `{{ .Values.secrets.pipelineUser.username }}`.

To see an example of this in action check out the [apps/jenkins-x/tekton/values.yaml.gotmpl](https://github.com/jenkins-x/jxr-versions/tree/master/apps/jenkins-x/tekton/values.yaml.gotmpl) file in the [version stream](https://jenkins-x.io/about/concepts/version-stream/).

Note that many apps are already configured to make use of the `jx-requirements.yml` settings via the [version stream](https://jenkins-x.io/about/concepts/version-stream/) - but you are free to add your own custom configuration. 
