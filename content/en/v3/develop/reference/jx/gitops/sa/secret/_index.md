---
title: jx gitops sa secret
linktitle: secret
type: docs
description: "Adds one or more secrets to the given ServiceAccount files"
aliases:
  - jx-gitops_sa_secret
---

## jx gitops sa secret

Adds one or more secrets to the given ServiceAccount files

### Usage

```
jx gitops sa secret
```

### Synopsis

Adds one or more secrets to the given ServiceAccount files

### Examples

  ```bash
  # ensures that the given service account resource has the secret associated
  jx-gitops sa secret -f config-root/namespaces/jx/mychart/my-sa.yaml --secret my-secret-name%!(EXTRA string=jx-gitops)

  ```
### Options

```
  -f, --file string               the ServiceAccount file to modify
  -h, --help                      help for secret
      --invert-selector           inverts the effect of selector to exclude resources matched by selector
  -k, --kind stringArray          adds Kubernetes resource kinds to filter on. For kind expressions see: https://github.com/jenkins-x/jx-helpers/v3/tree/master/docs/kind_filters.md
      --kind-ignore stringArray   adds Kubernetes resource kinds to exclude. For kind expressions see: https://github.com/jenkins-x/jx-helpers/v3/tree/master/docs/kind_filters.md
  -s, --secret stringArray        the Secret names to add to the ServiceAccount
      --selector stringToString   adds Kubernetes label selector to filter on, e.g. -s app=pusher-wave,heritage=Helm (default [])
```

