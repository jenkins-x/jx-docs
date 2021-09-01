---
title: jx gitops image
linktitle: image
type: docs
description: "Updates images in the kubernetes resources from the version stream"
aliases:
  - jx-gitops_image
---

### Usage

```
jx gitops image
```

### Synopsis

Updates images in the kubernetes resources from the version stream

### Examples

  ```bash
  # modify the images in the content-root folder using the current version stream
  jx-gitops image
  # modify the images in the ./src dir using the current dir to find the version stream
  jx-gitops image --source-dir ./src --dir .

  ```

### Options

```
  -b, --batch-mode                  Runs in batch mode without prompting for user input
  -d, --dir string                  the directory that contains the jx-requirements.yml (default ".")
  -h, --help                        help for image
      --invert-selector             inverts the effect of selector to exclude resources matched by selector
  -k, --kind stringArray            adds Kubernetes resource kinds to filter on. For kind expressions see: https://github.com/jenkins-x/jx-helpers/v3/tree/master/docs/kind_filters.md
      --kind-ignore stringArray     adds Kubernetes resource kinds to exclude. For kind expressions see: https://github.com/jenkins-x/jx-helpers/v3/tree/master/docs/kind_filters.md
      --log-level string            Sets the logging level. If not specified defaults to $JX_LOG_LEVEL
      --selector stringToString     adds Kubernetes label selector to filter on, e.g. -s app=pusher-wave,heritage=Helm (default [])
  -s, --source-dir string           the directory to recursively look for the *.yaml files to modify (default "content-root")
      --verbose                     Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warn, info, debug, trace
      --version-stream-dir string   the directory for the version stream. Defaults to 'versionStream' in the current --dir
```

### Source

[jenkins-x-plugins/jx-gitops](https://github.com/jenkins-x-plugins/jx-gitops)
