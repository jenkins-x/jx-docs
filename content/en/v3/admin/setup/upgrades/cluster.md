---
title: Cluster
linktitle: Cluster
type: docs
description: Upgrade the Jenkins X cluster managed by GitOps
weight: 20
aliases:
  - /v3/guides/upgrades/cluster
---

## Cluster 


### Automatic upgrades

To enable automatic upgrades of your cluster you need to modify your `jx-requirements.yml` file in your development git cluster repository:

```yaml 
apiVersion: core.jenkins-x.io/v4beta1
kind: Requirements
spec:
  autoUpdate:
    enabled: true
    schedule: "0 0 * * *"
    autoMerge: true
```
      
Once you commit and push that change and your [boot job has completed](/v3/about/how-it-works/#boot-job) you should have a `CronJob` running at the above schedule (every night at midnight) creating a Pull Request to upgrade your cluster's versions of charts and images.


If you set `autoMerge: true` then the upgrade Pull Requests will get auto merged if the CI/CD pipelines all succeed; otherwise you need to manually approve the Pull Requests when you are happy for the upgrade to be applied.

For more help on the Cron scheduler syntax check out [crontab.guru](https://crontab.guru/)
 

### Manual upgrades

The following demo walks through how to manually upgrade your cluster: 

<iframe width="700" height="315" src="https://www.youtube.com/embed/9ZaqdwD3cTs" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


### prerequisite
- make sure you have upgraded your [jx CLI](/v3/guides/upgrades/cli) to make sure you are using the correct version for the next steps.

---

You can upgrade your Jenkins X installation at any time by running the [jx gitops upgrade](/v3/develop/reference/jx/gitops/upgrade) command inside a git checkout of your cluster GitOps repository:

First make sure you have the latest git contents as the [boot job will push changes](/v3/about/how-it-works/#boot-job):

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
* make any changes in the version stream to the [boot job and its configuration](/v3/about/how-it-works/#boot-job)

After running this command you will usually have some changes in git you can review. If you are happy with the changes commit them and create a Pull Request so that they can get applied on your cluster.

```bash
git add *
git commit -a -m "fix: upgrade versions"
git push
```

The jx-git-operator will trigger a boot job in the `jx-git-operator` namespace, to track the progress of the upgrade you can run:

```bash
jx admin logs
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

If you are having merge conflicts trying to upgrade your installation you could just replace the `versionStream`  directory with the latest version stream folder. **NOTE** this will overwrite any local changes you have made inside the `verisonStream` folder. Though everything is versioned in git so you can always review the changes.

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

### Locking versions

To prevent manual changes from being overwritten during an upgrade,
add the `version.jenkins-x.io: lock` label to a chart in your _helmfile.yaml_:

```yaml
- chart: ingress-nginx/ingress-nginx
  version: 3.12.0
  name: nginx-ingress
  values:
    - ../../versionStream/charts/ingress-nginx/ingress-nginx/values.yaml.gotmpl
    - jx-values.yaml
  labels:
    version.jenkins-x.io: lock
```
