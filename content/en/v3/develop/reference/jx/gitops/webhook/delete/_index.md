---
title: jx gitops webhook delete
linktitle: delete
type: docs
description: "deletes the webhooks for all the source repositories optionally filtering by owner and/or repository"
aliases:
  - jx-gitops_webhook_delete
---

### Usage

```
jx gitops webhook delete
```

### Synopsis

Deletes the webhooks for all the source repositories optionally filtering by owner and/or repository

### Examples

  ```bash
  # delete all the webhooks for all SourceRepository and Environment resource:
  jx-gitops delete --filter https://foo.bar
  
  # only delete the webhooks for a given owner
  jx-gitops delete --owner=mycorp --filter https://foo.bar
  
  # delete all webhooks within an organisation
  jx-gitops delete --owner=mycorp --all-webhooks

  ```
### Options

```
      --all-webhooks          WARNING: will delete all webhooks from your source repositories. Do not use lightly.
  -b, --batch-mode            Runs in batch mode without prompting for user input
      --dry-run               If enabled doesn't actually delete any webhooks, just tells you what it will delete (default true)
      --filter string         The filter to match the endpoints to delete
      --git-kind string       the kind of git server to connect to
      --git-server string     the git server URL to create the scm client
      --git-token string      the git token used to operate on the git repository. If not specified it's loaded from the git credentials file
      --git-username string   the git username used to operate on the git repository. If not specified it's loaded from the git credentials file
  -h, --help                  help for delete
      --log-level string      Sets the logging level. If not specified defaults to $JX_LOG_LEVEL
  -o, --owner string          The name of the git organisation or user to filter on
  -r, --repo string           The name of the repository to filter on
      --retries int           Specify the number of times the command should be reattempted on failure (default 3)
      --verbose               Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warn, info, debug, trace
      --warn-on-fail          If enabled lets just log a warning that we could not update the webhook
```



### Source

[jenkins-x-plugins/jx-gitops](https://github.com/jenkins-x-plugins/jx-gitops)
