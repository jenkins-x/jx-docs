---
title: Enable WebHooks
linktitle: Enable WebHooks
type: docs
description: How to enable webhooks if you are on-premises
weight: 100
aliases:
  - /v3/admin/platforms/on-premise/webhooks/
---

If your cluster is not accessible on the internet and you can't open a firewall to allow services like GitHub to access your ingress then you will need to enable webhooks as follows:
 

* [install and setup ngrok](https://ngrok.com/)

* setup a webhook tunnel to your laptop find your hook host name:

```bash
kubectl get ing
```

* copy the hook host name into...
 
```bash
ngrok http http://yourHookHost
```

* copy your personal ngrok domain name of the form `abcdef1234.ngrok.io` into the `charts/jenkins-x/jxboot-helmfile-resources/values.yaml` file in the `ingress.customHosts.hosts` file so that your file looks like this...

```yaml
ingress:
  customHosts:
    hook: "abcdef1234.ngrok.io"
...
```

