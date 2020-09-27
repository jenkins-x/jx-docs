---
title: Upgrade
linktitle: Upgrade
description: Upgrade the version of Jenkins X
weight: 90
---

## CLI

To upgrade the jx CLI run:
```bash
jx upgrade cli
```

To upgrade jx subcommand plugins run:
```bash
jx upgrade plugins
```


## Cluster 

You can upgrade your Jenkins X installation at any time by running the [jx gitops upgrade](https://github.com/jenkins-x/jx-gitops/blob/master/docs/cmd/jx-gitops_update.md) command inside a git checkout of your cluster GitOps repository:

```bash
jx gitops upgrade
```              

This will: 

* upgrade your local [version stream](/about/concepts/version-stream/) to the latest which has passed the latest tests
* make any changes in the version stream to the [boot job and its configuration](/docs/v3/about/how-it-works/#boot-job)

After running this command you will usually have some changes in git you can review. If you are happy with the changes commit them and create a Pull Request so that they can get applied on your cluster.

```bash
git add *
git commit -a -m "fix: ugprade versions"
git push
```               

It is possible that you will have merge conflicts.  You can follow the inline git helper messages to resolve conflicts - or use your IDE to help figure out the merge issues. Usually if there are conflicts its safest to use the upstream version; particularly from the `versionStream` dir.

Once ready, make a pull request onto your cluster repository, review changes and merge.  The [Jenkins X git operator](https://github.com/jenkins-x/jx-git-operator) will automatically apply the upgrades into your cluster.


