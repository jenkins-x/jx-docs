---
title: jx application get
linktitle: get
type: docs
description: "Display one or more Applications and their versions ***Aliases**: applications,apps*"
aliases:
  - jx-application_get
---

### Usage

```
jx application get application
```

### Synopsis

Display applications across environments.

### Examples

  ```bash
  # List applications, their URL and pod counts for all environments
  jx get applications
  # List applications only in the Staging environment
  jx get applications -e staging
  # List applications only in the Production environment
  jx get applications -e production
  # List applications only in a specific namespace
  jx get applications -n jx-staging
  # List applications hiding the URLs
  jx get applications -u
  # List applications just showing the versions (hiding urls and pod counts)
  jx get applications -u -p

  ```

### Options

```
  -e, --env string         Filter applications in the given environment
  -h, --help               help for get
  -n, --namespace string   Filter applications in the given namespace
  -p, --pod                Hide the pod counts
  -u, --url                Hide the URLs
```

### Source

[jenkins-x-plugins/jx-application](https://github.com/jenkins-x-plugins/jx-application)
