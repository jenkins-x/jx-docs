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
kubectl get ing -n jx
```

* copy the hook host name into...

```bash
ngrok http http://yourHookHost
```

* copy the following YAML to a file: **helmfiles/jx/jxboot-helmfile-resources-values.yaml**

```yaml
ingress:
  customHosts:
    hook: "abcdef1234.ngrok.io"
```

* modify the `hook:` line in your **helmfiles/jx/jxboot-helmfile-resources-values.yaml** file to use your personal ngrok domain name of the form `abcdef1234.ngrok.io`

* add the **jxboot-helmfile-resources-values.yaml** file name to the `values:` entry in the `helmfiles/jx/helmfile.yaml` file for the `jxgh/jxboot-helmfile-resources` chart like this: (see the last line)

```yaml
releases:
- chart: jxgh/jxboot-helmfile-resources
  name: jxboot-helmfile-resources
  values:
  - ../../versionStream/charts/jx3/jxboot-helmfile-resources/values.yaml.gotmpl
  - jx-values.yaml
  - jxboot-helmfile-resources-values.yaml
...  
```

* now git commit the changed files....

```bash
git add helmfiles 
git commit -a -m "fix: add ngrok webhook"
git push


echo "now lets watch the boot job complete"
jx admin log -w
```
