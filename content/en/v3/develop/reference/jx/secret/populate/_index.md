---
title: jx secret populate
linktitle: populate
type: docs
description: "Populates any missing secret values which can be automatically generated, generated using a template or that have default values"
aliases:
  - jx-secret_populate
---

### Usage

```
jx secret populate
```

### Synopsis

Populates any missing secret values which can be automatically generated or that have default values"

### Examples

  ```bash
  jx-secret populate

  ```

### Options

```
  -b, --batch-mode                     Runs in batch mode without prompting for user input
      --boot-secret-namespace string   the namespace to that contains the boot secret used to populate git secrets from
  -d, --dir string                     the directory to look for the .jx/secret/mapping/secret-mappings.yaml file (default ".")
  -f, --filter string                  the filter to filter on ExternalSecret names
      --helm-secrets-dir string        the directory where the helm secrets live with a folder per namespace and a file with a '.yaml' extension for each secret name. Defaults to $JX_HELM_SECRET_FOLDER
  -h, --help                           help for populate
      --log-level string               Sets the logging level. If not specified defaults to $JX_LOG_LEVEL
      --no-wait                        disables waiting for the secret store (e.g. vault) to be available
  -n, --ns string                      the namespace to filter the ExternalSecret resources
      --retries int                    Specify the number of times the command should be reattempted on failure (default 3)
      --secret-namespace string        the namespace in which secret infrastructure resides such as Hashicorp Vault (default "jx-vault")
  -s, --source string                  the source location for the ExternalSecrets, valid values include filesystem or kubernetes (default "kubernetes")
      --verbose                        Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warn, info, debug, trace
  -w, --wait duration                  the maximum time period to wait for the vault pod to be ready if using the vault backendType (default 2h0m0s)
```

### Source

[jenkins-x-plugins/jx-secret](https://github.com/jenkins-x-plugins/jx-secret)
