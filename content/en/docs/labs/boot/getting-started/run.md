---
title: Running Boot
linktitle: Running Boot
description: Running Boot to install / upgrade Jenkins X
weight: 50
---
{{% alert %}}
**NOTE: This current experiment is now closed. The work done and feedback we have received will be used to enhance Jenkins X in future versions**

**This code should not be used in production, or be adopted for usage.  It should only be used to provide feedback to the Labs team.**

Thank you for your participation,

-Labs


{{% /alert %}}

Once you have [created your git repository](/docs/labs/boot/getting-started/repository/) for your development environment via `jxl boot create` or `jxl boot upgrade` and populated the [secrets](/docs/labs/boot/getting-started/secrets/) as shown above you can run the boot `Job` via:

```
jxl boot run --git-url=https://github.com/myorg/env-mycluster-dev.git
```

If you are using a private git repository you can specify the user name and token to clone the git repository via `--git-username` and `--git-token` arguments or you can add them into the URL:

```
jxl boot run --git-url=https://myusername:mytoken@github.com/myorg/env-mycluster-dev.git
```

Once you have booted up once you can omit the `git-url` argument as it can be discovered from the `dev` `Environment` resource:

```
jxl boot run
```

This will use helm to install the boot Job and tail the log of the pod so you can see the boot job run. It looks like the boot process is running locally on your laptop but really it is all running inside a Pod inside Kubernetes.

Once this has finished you are ready to import or create a quicstart.

<nav>
  <ul class="pagination">
    <li class="page-item"><a class="page-link" href="../config">Previous</a></li>
    <li class="page-item"><a class="page-link" href="../../../wizard/overview/">Next</a></li>
  </ul>
</nav>

### Upgrading your cluster

Once you have the git repository for the upgrade you need to run the boot Job in a clean empty cluster.

To simplify things you may want to create a new cluster, connect to that and then boot from there. If you are happy with the results you can scale down/destroy the old one
