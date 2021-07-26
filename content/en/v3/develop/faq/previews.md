---
title: Previews
linktitle: Previews
type: docs
description: Questions about using Preview Environments
weight: 210
---

## When do Preview Environments get removed?

We have a background garbage collection job which removes Preview Environments after the Pull Request is closed/merged. You can run it any time you like via the [jx preview gc](/v3/develop/reference/jx/preview/gc/) command

```sh
jx preview gc
```

You can also view the current previews via  [jx preview get](/v3/develop/reference/jx/preview/get/):

```sh
jx preview get
```


and delete a preview by choosing one to delete via [jx preview destroy](/v3/develop/reference/jx/preview/destroy/):

```sh
jx preview destroy
```

## How do I access the preview namespace or URL?
             
After the [jx preview create](/v3/develop/reference/jx/preview/create) step in a pull request pipeline you can access a number of [preview environment variables](/v3/develop/environments/preview/#environment-variables).

For details see [how to add additional preview steps](/v3/develop/environments/preview/#additional-preview-steps)


## How do I add other services into a Preview?

see [how to add resources to your previews](/v3/develop/environments/preview/#adding-more-resources)

## How do I inject the Preview URL into other services?

The preview namespace and URL are [available as environment variables](/v3/develop/environments/preview/#environment-variables) after the preview has been created.

However if you want to pass in the preview URL to [other charts included in your preview](/v3/develop/environments/preview/#adding-more-resources) via the `preview/helmfile.yaml` file you can:

* use the service URL rather than ingress which is much simpler and does not depend on the namespace or domain. e.g. just use `http://my-app-name`
* add a `values.yaml.gotmpl` file for the chart to [configure its values](/v3/develop/apps/#customising-charts) you wish to inject the URL into and pass in whatever yaml is required to configure the preview URL using the following expression. The example below uses `someValue` as the key to specify the URL but use whatever yaml keys your chart expects: 

```yaml 
someValue:  "{{ requiredEnv "APP_NAME" }}-pr{{ requiredEnv "PULL_NUMBER" }}.{{ .Values.jxRequirements.ingress.domain }}"
```
