---
title: jx preview get
linktitle: get
type: docs
description: "Display one or more Previews ***Aliases**: list*"
aliases:
  - jx-preview_get
---

### Usage

```
jx preview get
```

### Synopsis

Display one or more preview environments.

### Examples

  ```bash
  # List all preview environments
  jx-preview get
  
  # View the current preview environment URL
  # inside a CI pipeline
  jx-preview get --current

  ```
### Options

```
  -c, --current   Output the URL of the current Preview application the current pipeline just deployed
  -h, --help      help for get
```



### Source

[jenkins-x-plugins/jx-preview](https://github.com/jenkins-x-plugins/jx-preview)
