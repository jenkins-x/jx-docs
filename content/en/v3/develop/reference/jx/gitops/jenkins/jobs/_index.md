---
title: jx gitops jenkins jobs
linktitle: jobs
type: docs
description: "Generates the Jenkins Jobs helm files ***Aliases**: job*"
aliases:
  - jx-gitops_jenkins_jobs
---

### Usage

```
jx gitops jenkins jobs
```

### Synopsis

Generates the Jenkins Jobs helm files

### Examples

  ```bash
  # generate the jenkins job files
  jx-gitops jenkins jobs

  ```

### Options

```
  -c, --config string             the configuration file to load for the repository configurations. If not specified we look in ./.jx/gitops/source-config.yaml
      --default-template string   the default job template file if none is configured for a repository
  -d, --dir string                the current working directory (default ".")
  -h, --help                      help for jobs
      --no-create-helmfile        disables the creation of the helmfiles/jenkinsName/helmfile.yaml file if a jenkins server does not yet exist
  -o, --out string                the output directory for the generated config files. If not specified defaults to the jenkins dir in the current directory
```

### Source

[jenkins-x-plugins/jx-gitops](https://github.com/jenkins-x-plugins/jx-gitops)
