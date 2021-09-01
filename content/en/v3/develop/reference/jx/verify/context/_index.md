---
title: jx verify context
linktitle: context
type: docs
description: "Verifies the current kubernetes context matches a given name ***Aliases**: ctx*"
aliases:
  - jx-verify_context
---

### Usage

```
jx verify context
```

### Synopsis

Verifies the current kubernetes context matches a given name

### Examples

  ```bash
  # populate the pods don't have missing images
  jx verify context -c "gke_$PROJECT_ID-bdd_$REGION_$CLUSTER_NAME"%!(EXTRA string=jx-verify)

  ```

### Options

```
  -c, --context string   The kubernetes context to match against
  -h, --help             help for context
```

### Source

[jenkins-x-plugins/jx-verify](https://github.com/jenkins-x-plugins/jx-verify)
