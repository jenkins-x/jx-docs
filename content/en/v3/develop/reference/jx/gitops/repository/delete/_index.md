---
title: jx gitops repository delete
linktitle: delete
type: docs
description: "Deletes a repository from the source configuration ***Aliases**: remove,rm,del*"
aliases:
  - jx-gitops_repository_delete
---

### Usage

```
jx gitops repository delete
```

### Synopsis

Add one or more repositories to the SourceConfig

### Examples

  ```bash
  # deletes a repository by name from the '.jx/gitops/source-config.yaml' file
  jx gitops repository delete --name myrepo
  
  # deletes a repository by name and owner from the '.jx/gitops/source-config.yaml' file
  jx gitops repository delete --name myrepo --owner myowner

  ```

### Options

```
  -c, --config string   the configuration file to load for the repository configurations. If not specified we look in .jx/gitops/source-repositories.yaml
  -d, --dir string      the directory look for the 'jx-requirements.yml` file (default ".")
  -h, --help            help for delete
  -n, --name string     the name of the repository to remove
  -o, --owner string    the owner of the repository to remove
```

### Source

[jenkins-x-plugins/jx-gitops](https://github.com/jenkins-x-plugins/jx-gitops)
