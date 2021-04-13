---
title: jx gitops helm stream
linktitle: stream
type: docs
description: "Generate the kubernetes resources for all helm charts in a version stream"
aliases:
  - jx-gitops_helm_stream
---

## jx gitops helm stream

Generate the kubernetes resources for all helm charts in a version stream

### Usage

```
jx gitops helm stream
```

### Synopsis

Generate the kubernetes resources for all helm charts in a version stream

### Examples

  ```bash
  jx-gitops step helm stream

  ```
### Options

```
      --commit-message string   the git commit message used
  -d, --dir string              the directory to look for the version stream git clone
      --domain string           the default domain name in the generated ingress (default "cluster.local")
      --git-commit              if set then the template command will git commit any changed files
  -h, --help                    help for stream
      --include-crds            if CRDs should be included in the output (default true)
      --no-external-secrets     if set then disable converting Secret resources to ExternalSecrets
      --no-split                if set then disable splitting of multiple resources into separate files
      --optional                check if there is a charts dir and if not do nothing if it does not exist
  -o, --output-dir string       the output directory to generate the templates to (default ".")
  -c, --ref string              the git ref (branch, tag, revision) to git clone (default "master")
  -n, --url string              the git clone URL of the version stream
```

