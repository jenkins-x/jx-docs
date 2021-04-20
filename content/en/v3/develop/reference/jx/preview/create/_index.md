---
title: jx preview create
linktitle: create
type: docs
description: "Creates a preview"
aliases:
  - jx-preview_create
---

### Usage

```
jx preview create
```

### Synopsis

Creates a preview

### Examples

  ```bash
  # creates a new preview environemnt
  jx-preview create

  ```
### Options

```
      --app string                     Name of the app or repository
      --debug                          Enables debug logging in helmfile
      --dir string                     the directory to search for the .git to discover the git source URL (default ".")
  -f, --file string                    Preview helmfile.yaml path to use. If not specified it is discovered in preview/helmfile.yaml and created from a template if needed
      --git-kind string                the kind of git server to connect to
      --git-server string              the git server URL to create the git provider client. If not specified its defaulted from the current source URL
      --git-token string               the git token used to operate on the git repository
      --git-user string                The user name to git clone the environment repository
  -h, --help                           help for create
      --no-comment                     Disables commenting on the Pull Request after preview is created
      --no-watch                       Disables watching the preview namespace as we deploy the preview
      --path string                    An optional path added to the Preview ingress URL. If not specified uses $JX_PREVIEW_PATH
      --pr int                         the Pull Request number. If not specified we detect it via $PULL_NUMBER or $BRANCH_NAME environment variables
      --preview-url-timeout duration   Time to wait for the preview URL to be available (default 1m0.000000005s)
```



### Source

[jenkins-x-plugins/jx-preview](https://github.com/jenkins-x-plugins/jx-preview)
