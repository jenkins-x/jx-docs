---
title: jx verify tls
linktitle: tls
type: docs
description: "Verifies TLS for a Cluster ***Aliases**: cert*"
aliases:
  - jx-verify_tls
---

## jx verify tls

Verifies TLS for a Cluster

***Aliases**: cert*

### Usage

```
jx verify tls [url]
```

### Synopsis

Verifies a TLS certificate, useful to ensure a HTTPS endpoint is using a certificate issued by a specific issuer like LetsEncrypt

### Examples

  ```bash
  # verifies a TLS certificate issuer and subject
  jx-verify step verify tls hook.foo.bar.com --insecure --issuer 'CN=Fake LE Intermediate X1' --subject 'CN=*.foo.bar.com'

  ```
### Options

```
  -h, --help               help for tls
      --issuer string      override the default issuer to match the TLS certificate to
      --production         override the detection of whether to verify TLS is using Production or Staging LetsEncrypt service (default true)
  -t, --timeout duration   timeout (default 10m0s)
```

