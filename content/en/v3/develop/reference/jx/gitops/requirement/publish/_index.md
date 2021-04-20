---
title: jx gitops requirement publish
linktitle: publish
type: docs
description: "Publishes the current jx-requirements.yml to the dev Environment so it can be easily used in pipelines"
aliases:
  - jx-gitops_requirement_publish
---

### Usage

```
jx gitops requirement publish
```

### Synopsis

Publishes the current jx-requirements.yml to the dev Environment so it can be easily used in pipelines

### Examples

  ```bash
  jx-gitops requirements publish

  ```
### Options

```
  -d, --dir string         the directory to run the git push command from (default ".")
      --env-file string    the file name for the dev Environment. If not specified it defaults config-root/namespaces/jx/jxboot-helmfile-resources/dev-environment.yaml to within the directory
  -h, --help               help for publish
      --namespace string   the namespace used to find dev-environment.yaml (default "jx")
```



### Source

[jenkins-x-plugins/jx-gitops](https://github.com/jenkins-x-plugins/jx-gitops)
