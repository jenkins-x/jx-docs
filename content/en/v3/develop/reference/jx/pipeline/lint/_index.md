---
title: jx pipeline lint
linktitle: lint
type: docs
description: "Lints the lighthouse trigger and tekton pipelines"
aliases:
  - jx-pipeline_lint
---

### Usage

```
jx pipeline lint
```

### Synopsis

Lints the lighthouse trigger and tekton pipelines

### Examples

  ```bash
  # Lints the lighthouse files and local pipeline files
  jx pipeline lint

  ```

### Options

```
  -a, --all                    Rather than looking for .lighthouse and triggers.yaml files it looks for all YAML files which are tekton kinds
      --catalog-owner string   The github owner for the default catalog (default "jenkins-x")
      --catalog-repo string    The github repository name for the default catalog (default "jx3-pipeline-catalog")
  -d, --dir string             The directory to look for the .lighthouse and/or .git folders (default ".")
      --format string          If specify 'tap' lets use the TAP output otherwise use simple text output
      --git-kind string        the kind of git server to connect to
      --git-server string      the git server URL to create the scm client
      --git-token string       the git token used to operate on the git repository. If not specified it's loaded from the git credentials file
      --git-username string    the git username used to operate on the git repository. If not specified it's loaded from the git credentials file
  -h, --help                   help for lint
  -o, --out string             The TAP format file to output with the results. If not specified the tap file is output to the terminal
  -r, --recursive              Recurisvely find all '.lighthouse' folders such as if linting a Pipeline Catalog
```

### Source

[jenkins-x-plugins/jx-pipeline](https://github.com/jenkins-x-plugins/jx-pipeline)
