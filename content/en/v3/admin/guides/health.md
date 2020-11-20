---
title: Health
linktitle: Health
type: docs
description: Check the health of a Jenkins X installation
weight: 92
aliases:
  - /docs/v3/guides/health
---

Jenkins X v3.x now has a CLI plugin that works with [Kuberhealthy](https://github.com/Comcast/kuberhealthy) to check the health of a working Jenkins X.

The `jx health` plugin is self contained in the git repository https://github.com/jenkins-x-plugins/jx-health.  This provides a way to query teh result of health checks that run periodically in each Kubernetes namespace.

The plugin is also useful in a more locked down cluster for developers with reduced RBAC permissions.  A user only needs permissions to read the Kuberhealth state custom resources https://github.com/jenkins-x-plugins/jx-health#rbac-requirements.

Kuberhealthy provides an easy way to extend using custom health checks to report errors.  To see how to write your own check see the docs [here](https://github.com/Comcast/kuberhealthy/blob/master/docs/EXTERNAL_CHECK_CREATION.md).  Jenkins X already comes with a set of custom health checks that can be installed that report errors, for example with webhooks, missing secrets, a bad install or invalid bot token.  For more details take a look here https://github.com/jenkins-x-plugins/jx-kh-check/tree/master/cmd.

We'd like to encourrage contributions to add extra checks as Jenkins X v3 matures.  If you have a check that you would like to add please reach out in the community channels or create an issue or pull request.

# Try it out

When using Terraform (the recommended approach) Kuberhealthy and health checks are installed by default.

You can use the new health CLI plugin to get health statuses that run periodically checking different things, our favorite is the watch for checks across all namespaces.

```
jx health get status --all-namespaces --watch
```