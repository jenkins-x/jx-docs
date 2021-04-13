---
title: jx tekton-to-actions convert
linktitle: convert
type: docs
description: "Converts tekton pipelines to github actions ***Aliases**: kill*"
aliases:
  - jx-tekton-to-actions_convert
---

## jx tekton to actions convert

Converts tekton pipelines to github actions

***Aliases**: kill*

### Usage

```
jx tekton to actions convert
```

### Synopsis

Converts tekton pipelines to github actions

### Examples

  ```bash
  # Converts the tekton pipelines to actions
  jx tekton-to-actions convert

  ```
### Options

```
  -d, --dir string                  The directory to look for the .lighthouse folder (default ".")
  -h, --help                        help for convert
      --main-branches stringArray   The main branches for releases (default [main,master])
  -o, --output-dir string           The directory to write output files
  -p, --path string                 The relative path to dir to look for lighthouse files
  -r, --recursive                   Recursively find all '.lighthouse' folders such as if linting a Pipeline Catalog
      --remove-steps stringArray    The steps to remove (default [git-clone,setup-builder-home,git-merge])
      --runs-on string              The machine this runs on (default "ubuntu-latest")
```

