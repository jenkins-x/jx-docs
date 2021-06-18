---
title: jx gitops webhook update
linktitle: update
type: docs
description: "Updates the webhooks for all the source repositories optionally filtering by owner and/or repository"
aliases:
  - jx-gitops_webhook_update
---

### Usage

```
jx gitops webhook update
```

### Synopsis

Updates the webhooks for all the source repositories optionally filtering by owner and/or repository

### Examples

  ```bash
  # update all the webhooks for all SourceRepository and Environment resource:
  jx-gitops update
  
  # only update the webhooks for a given owner
  jx-gitops update --org=mycorp
  
  # use a custom hook webhook endpoint (e.g. if you are on-premises using node ports or something)
  jx-gitops update --endpoint http://mything.com

  ```
### Options

```
  -b, --batch-mode                 Runs in batch mode without prompting for user input
      --endpoint string            Don't use the endpoint from the cluster, use the provided endpoint
      --exact-hook-url-match       Whether to exactly match the hook based on the URL (default true)
      --git-kind string            the kind of git server to connect to
      --git-server string          the git server URL to create the scm client
      --git-token string           the git token used to operate on the git repository. If not specified it's loaded from the git credentials file
      --git-username string        the git username used to operate on the git repository. If not specified it's loaded from the git credentials file
  -h, --help                       help for update
      --hmac string                Don't use the HMAC token from the cluster, use the provided token
      --log-level string           Sets the logging level. If not specified defaults to $JX_LOG_LEVEL
  -o, --owner string               The name of the git organisation or user to filter on
      --previous-hook-url string   Whether to match based on an another URL
  -r, --repo string                The name of the repository to filter on
      --retries int                Specify the number of times the command should be reattempted on failure (default 3)
      --verbose                    Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warn, info, debug, trace
      --warn-on-fail               If enabled lets just log a warning that we could not update the webhook
```



### Source

[jenkins-x-plugins/jx-gitops](https://github.com/jenkins-x-plugins/jx-gitops)
