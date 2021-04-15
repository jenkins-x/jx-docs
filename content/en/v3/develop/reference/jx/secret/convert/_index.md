---
title: jx secret convert
linktitle: convert
type: docs
description: "Converts all Secret resources in the path to ExternalSecret resources so they can be checked into git ***Aliases**: secretmappings,sm,secretmapping*"
aliases:
  - jx-secret_convert
---

## jx secret convert

Converts all Secret resources in the path to ExternalSecret resources so they can be checked into git

***Aliases**: secretmappings,sm,secretmapping*

### Usage

```
jx secret convert
```

### Synopsis

Converts all Secret resources in the path to ExternalSecret resources so they can be checked into git

### Examples

  ```bash
  # converts all the Secret resources into ExternalSecret resources so they can be checked into git
  jx-secret convert --source-dir=config-root

  ```
### Options

```
  -b, --batch-mode                  Runs in batch mode without prompting for user input
      --default-namespace string    the default namespace if no namespace is specified in a Secret resource (default "jx")
  -d, --dir string                  the directory to look for the secret mapping files and version stream (default ".")
      --helm-secrets-dir string     the directory where the helm secrets live with a folder per namespace and a file with a '.yaml' extension for each secret name. Defaults to $JX_HELM_SECRET_FOLDER
  -h, --help                        help for convert
      --log-level string            Sets the logging level. If not specified defaults to $JX_LOG_LEVEL
      --source-dir string           the source directory to recursively look for the *.yaml or *.yml files to convert. If not specified defaults to 'config-root' in the dir
  -m, --vault-mount-point string    the vault authentication mount point (default "kubernetes")
  -r, --vault-role string           the vault role that will be used to fetch the secrets. This role will need to be bound to kubernetes-external-secret's ServiceAccount; see Vault's documentation: https://www.vaultproject.io/docs/auth/kubernetes.html (default "jx-vault")
      --verbose                     Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warn, info, debug, trace
      --version-stream-dir string   the directory containing the version stream. If not specified defaults to the 'versionStream' folder in the dir
```

