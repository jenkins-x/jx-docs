---
title: Lighthouse WebUI
linktitle: Lighthouse WebUI
type: docs
description: How to install the Lighthouse WebUI in Jenkins X 3
weight: 120
aliases:
  - /v3/guides/lighthouse-webui
---

This guide will help you install and configure the [lighthouse-webui-plugin](https://github.com/jenkins-x-plugins/lighthouse-webui-plugin) in your Jenkins X cluster. You can see the [Lighthouse Web UI documentation](/v3/develop/ui/lighthouse/) for more details on why you might need to install this optional component.

## Installation

Please follow the usual [getting started guide for boot and helm 3](/v3/admin/platform/) first.

Then, open the `helmfiles/jx/helmfile.yaml` file located in your development environment git repository, and add the following content under the `releases` section:

```yaml 
- chart: jx3/lighthouse-webui-plugin
  name: jx3/lighthouse-webui-plugin
```

You should have something like:

```yaml
namespace: jx
repositories:
- ...
releases:
- chart: jx3/lighthouse-webui-plugin
  name: jx3/lighthouse-webui-plugin
- chart: ...
```

Don't worry if your new chart doesn't have a `version` field, or a list of `values` files: these fields will be automatically added later.

Commit and push these changes, and after a few minutes you should see a new `lighthouse-webui-plugin` pod running in the `jx` namespace:

```bash 
$ kubectl get pod -n jx
NAME                                           READY   STATUS    RESTARTS   AGE
lighthouse-webui-plugin-696b8c85f9-99hnn       1/1     Running   0          31m
```

## Usage

See the [Lighthouse Web UI documentation](/v3/develop/ui/lighthouse/) for how to access it and use it.

## Configuration

The configuration is defined in a ["values file" stored in the Jenkins X Version Stream](https://github.com/jenkins-x/jx3-versions/tree/master/charts/jx3/lighthouse-webui-plugin/values.yaml.gotmpl).

If you want to change anything from the default configuration, you can either:
- submit a Pull Request if you believe this change is beneficial for everybody
- or create a new values file in your development environment git repositor: `values/lighthouse-webui-plugin/values.yaml`

If you want to change the default basic auth to OAuth for example, you can read the [OAuth guide](/v3/admin/setup/ingress/oauth/).
