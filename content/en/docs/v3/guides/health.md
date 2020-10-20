---
title: Health
linktitle: Health
description: Check the health of a Jenkins X installation
weight: 92
---

Jenkins X v3.x now has a CLI plugin that works with [Kuberhealthy](https://github.com/Comcast/kuberhealthy) to check the health of a working Jenkins X.

The `jx health` plugin is self contained in the git repository https://github.com/jenkins-x-plugins/jx-health.  This provides a way to query teh result of health checks that run periodically in each Kubernetes namespace.

The plugin is also useful in a more locked down cluster for developers with reduced RBAC permissions.  A user only needs permissions to read the Kuberhealth state custom resources https://github.com/jenkins-x-plugins/jx-health#rbac-requirements.

Kuberhealthy provides an easy way to extend using custom health checks to report errors.  To see how to write your own check see the docs [here](https://github.com/Comcast/kuberhealthy/blob/master/docs/EXTERNAL_CHECK_CREATION.md).  Jenkins X already comes with a set of custom health checks that can be installed that report errors, for example with webhooks, missing secrets, a bad install or invalid bot token.  For more details take a look here https://github.com/jenkins-x-plugins/jx-kh-check/tree/master/cmd.

It is early days but we'd like to encourrage contributions to add extra checks as Jenkins X v3 matures.  If you have a check that you would like to add please reach out in the community channels or create an issue or pull request.

# Try it out

We havn't enabled Kuberhealthy by default yet as we'd like more feedback but to enable on your existing v3 installation:

Get the plugin by running
```
jx upgrade cli
jx upgrade plugins
```

You will also need to upgrade your clusters version stream which updates the cluster to the latest release
```
jx gitops upgrade
```
git commit / push then check the git operator job is successful
```
jx admin logs
```
Then to add the new server side checks (kuberhealthy ) again from a cloned copy of your cluster git repo, run
```
jx gitops helmfile add --chart kuberhealthy/kuberhealthy
jx gitops helmfile add --chart jx3/jx-kh-check
jx gitops helmfile add --chart jx3/jx-kh-check --name health-checks-jx
jx gitops helmfile add --chart jx3/jx-kh-check --name health-checks-install 
```
review the local changes, you should see four new charts added to your helmfile.yaml
git commit / push then check the git operator job is successful
```
jx admin logs
```
once completed you can use the new health CLI plugin to get health statuses that run periodically checking different things, our favorite is the watch for checks across all namespaces…
```
jx health get status --all-namespaces --watch
```