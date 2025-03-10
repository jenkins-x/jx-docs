---
title: jx gitops postprocess
linktitle: postprocess
type: docs
description: "Post processes kubernetes resources to enrich resources like ServiceAccounts with cloud specific sensitive data to enable IAM rles"
aliases:
  - jx-gitops_postprocess
---

### Usage

```
jx gitops postprocess
```

### Synopsis

Post processes kubernetes resources to enrich resources like ServiceAccounts with cloud specific sensitive data to enable IAM rles

### Examples

  ```bash
  # after applying the resources lets post process them
  jx-gitops postprocess
  
  # you can register some post processing commands, such as to annotate a ServiceAccount via:
  kubectl create secret generic jx-post-process -n default  --from-literal=commands="kubectl annotate sa tekton-bot hello=world"

  ```
### Options

```
  -h, --help               help for postprocess
  -n, --namespace string   the namespace to look for the post processing Secret (default "default")
  -s, --secret string      the name of the Secret with the post process scripts to apply (default "jx-post-process")
      --shell string       the location of the shell binary to execute (default "sh")
```



### Source

[jenkins-x-plugins/jx-gitops](https://github.com/jenkins-x-plugins/jx-gitops)
