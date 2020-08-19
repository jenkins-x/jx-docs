---
title: Upgrading
linktitle: Upgrading
description: Upgrading Jenkins X 3.x
weight: 150
---

To upgrade the jx CLI going forward run
```bash
jx upgrade cli
```

To upgrade jx subcommand plugins run
```bash
jx upgrade plugins
```

To upgrade the cluster via GitOps from the cloned cluster git repository run
```bash
jx gitops kpt update --strategy alpha-git-patch
```

It is possible that you will have merge conflicts.  You can follow the inline git helper messages to resolve conflicts and keep re-running `jx gitops kpt update --strategy alpha-git-patch` until there are no errors.  

Once ready, make a pull request onto your cluster repository, review changes and merge.  The [Jenkins X git operator](https://github.com/jenkins-x/jx-git-operator) will automatically apply the upgrades into your cluster.

If there are issues with the upgrade revert the upgrade pull request to restore services and allow for investigation.