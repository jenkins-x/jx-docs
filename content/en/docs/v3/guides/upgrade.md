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

First make sure you have the latest git contents as the [boot job will push changes](/docs/v3/about/how-it-works/#boot-job):

```bash
git pull
```              

Make sure you have no pending git commits....

```bash
git status
```              

Now if your git clone is clean run the following:

```bash
jx gitops upgrade
```              

This will: 

* upgrade your local [version stream](/about/concepts/version-stream/) to the latest which has passed the latest tests
* make any changes in the version stream to the [boot job and its configuration](/docs/v3/about/how-it-works/#boot-job)

After running this command you will usually have some changes in git you can review. If you are happy with the changes commit them and create a Pull Request so that they can get applied on your cluster.

```bash
git add *
git commit -a -m "fix: upgrade versions"
git push
```               

### Merge conflicts 

It is possible that you will have merge conflicts.  You can follow the inline git helper messages to resolve conflicts - or use your IDE to help figure out the merge issues. Usually if there are conflicts its safest to use the upstream version; particularly from the `versionStream` dir.

Under the hood Kpt is used to fetch changes from the upstream defined in each Kptfile.  
By default the `versionStream` directory has a Kpt strategy of `force-delete-replace` which removes all your changes in that folder. In order to merge your changes with the ones coming from upstream, add a file: `.jx/gitops/kpt-strategy.yaml` with the following content:
```yaml
config:
  - relativePath: versionStream
    strategy: resource-merge
```

Once ready, make a pull request onto your cluster repository, review changes and merge.  The [Jenkins X git operator](https://github.com/jenkins-x/jx-git-operator) will automatically apply the upgrades into your cluster.


### Replacing your local versionStream

If you are having merge conflicts trying to upgrade your installation you could just replace the `versionStream`  directory with the latest version stream folder. **NOTE* this will overwrite any local changes you have made inside the `verisonStream` folder. Though everything is versioned in git so you can always review the changes.

Inside your cluster git repository run this command:

```bash
kpt pkg update --strategy force-delete-replace versionStream
```

That will update your `versionStream` directory to be in line with the latest version stream. You can always then review the changes before committing them.

### Configure merge strategy

You can configure the `kpt` strategy used to apply changes from the version stream into your `versionStream` folder via a custom configuration file.

Create a file called `.jx/gitops/kpt-strategy.yaml` in your dev cluster git repository that looks like this:

```yaml 
config:
- relativePath: versionStream
  strategy: alpha-git-patch
```

this will configure that the `alpha-git-patch` strategy will be used whenever you try `jx gitops upgrade` which should preserve any local changes; though you may have to resolve some git conflicts in your IDE (as described above).

To avoid any possible git merge issues its a good idea to try keep local source changes out of the `versionStream` folder if you can.
