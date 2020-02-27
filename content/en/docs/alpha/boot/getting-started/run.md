---
title: Running Boot
linktitle: Running Boot
description: Running Boot to install / upgrade Jenkins X
weight: 50
---


Once you have [created your git repository](/docs/alpha/boot/getting-started/repository/) for your development environment via `jxl boot create` or `jxl boot upgrade` and populated the [secrets](/docs/alpha/boot/getting-started/secrets/) as shown above you can run the boot `Job` via:

```
jxl boot run --git-url=https://github.com/myorg/env-mycluster-dev.git
```

Once you have booted up once you can omit the `git-url` argument as it can be discovered from the `dev` `Environment` resource:

```
jxl boot run
```

This will use helm to install the boot Job and tail the log of the pod so you can see the boot job run. It looks like the boot process is running locally on your laptop but really it is all running inside a Pod inside Kubernetes.


### Upgrading your cluster

Once you have the git repository for the upgrade you need to run the boot Job in a clean empty cluster.

To simplify things you may want to create a new cluster, connect to that and then boot from there. If you are happy with the results you can scale down/destroy the old one
