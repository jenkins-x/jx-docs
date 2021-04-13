---
title: jx gitops ingress
linktitle: ingress
type: docs
description: "Updates Ingress resources with the current ingress domain"
aliases:
  - jx-gitops_ingress
---

## jx gitops ingress

Updates Ingress resources with the current ingress domain

### Usage

```
jx gitops ingress
```

### Synopsis

Updates Ingress resources with the current ingress domain

### Examples

  ```bash
  # updates any newly created Ingress resources to the new domain
  jx-gitops ingress

  ```
### Options

```
  -d, --dir string            the directory to look for a 'jx-apps.yml' file (default ".")
  -n, --domain string         the domain to replace with whats in jx-requirements.yml (default "cluster.local")
      --fail-on-parse-error   if enabled we fail if we cannot parse a yaml file as a kubernetes resource
  -h, --help                  help for ingress
```

