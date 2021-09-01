---
title: jx secret replicate
linktitle: replicate
type: docs
description: "Replicates the given ExternalSecret resources into other Environments or Namespaces"
aliases:
  - jx-secret_replicate
---

### Usage

```
jx secret replicate
```

### Synopsis

Replicates the given ExternalSecret resources into other Environments or Namespaces

### Examples

  ```bash
  # replicates the labeled ExternalSecret resources to the local permanent Environment namespaces (e.g. Staging and Production)
  jx-secret replicate --label secret.jenkins-x.io/replica-source=true
  
  # replicates the ExternalSecret resources to the local Environments
  jx-secret replicate --name=mysecretname --to jx-staging,jx-production

  ```

### Options

```
  -b, --batch-mode          Runs in batch mode without prompting for user input
  -f, --file string         the ExternalSecret to replicate (default "t")
      --from string         one or more Namespaces to replicate the ExternalSecret to
  -h, --help                help for replicate
      --log-level string    Sets the logging level. If not specified defaults to $JX_LOG_LEVEL
  -n, --name stringArray    specifies the names of the ExternalSecrets to replicate if not using a selector
  -o, --output-dir string   the output directory which defaults to 'config-root' in the directory
  -s, --selector string     defines the label selector to find the ExternalSecret resources to replicate
  -t, --to stringArray      one or more Namespaces to replicate the ExternalSecret to
      --verbose             Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warn, info, debug, trace
```

### Source

[jenkins-x-plugins/jx-secret](https://github.com/jenkins-x-plugins/jx-secret)
