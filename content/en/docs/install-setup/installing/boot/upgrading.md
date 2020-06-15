---
title: Upgrading
linktitle: Upgrading
description: Upgrading Jenkins X using Boot
weight: 90
---

## Upgrading

With `jx boot` all of the versions and configuration is in Git so it's easy to manage change via GitOps either automatically or manually.

### Auto Upgrades

You can enable auto upgrades in the `jx-requirements.yml` via the following (where `schedule` is a cron expression).

```yaml
autoUpdate:
  enabled: true
  schedule: "0 12 */5 * *"
```

When auto upgrades are enabled a `CronJob` is run which periodically checks for changes in the [version stream](/about/concepts/version-stream/) or [boot configuration](https://github.com/jenkins-x/jenkins-x-boot-config).
If changes are detected the [jx upgrade boot](/commands/jx_upgrade_boot/) will create a pull request on your development Git repository.
Once that merges the boot configuration is upgraded and boot will be re-run inside a tekton pipeline to upgrade your installation.

### Manual upgrades

You can manually run the [jx upgrade boot](/commands/jx_upgrade_boot/) command at any time which if there have been changes in [version stream](/about/concepts/version-stream/) or [boot configuration](https://github.com/jenkins-x/jenkins-x-boot-config) will create a Pull Request on your development git repository.

Once that merges the boot configuration is upgraded and boot will be re-run inside a Tekton pipeline to upgrade your installation.

### Recovering

If anything ever goes wrong (e.g. your cluster, namespace or tekton gets deleted) and your installation is incabable of running tekton pipelines you can always re-run [jx boot](/docs/getting-started/setup/boot/) on your laptop to restore your cluster.

## Backups

Jenkins X is integrated with [Velero](https://velero.io) to support backing up the state of Jenkins X (the Kubernetes and custom resources together with persistent volumes).

To enable Velero add the following to your `jx-requirements.yml`:

```yaml
storage:
  backup:
    enabled: true
    url: gs://my-backup-bucket
velero:
  namespace: velero
```

Using whatever your cloud providers bucket URLs are.
For more background, check out the [storage guide](/docs/resources/guides/managing-jx/common-tasks/storage/).
