---
title: CLI
linktitle: CLI
type: docs
description: Upgrading the jx cli
weight: 10
aliases:
  - /v3/guides/upgrades/cli
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

{{< alert >}}
If you encounter this error:
```
ERROR: failed to load plugin <plugin-name>: can't find latest version of plugin: {"message":"Not Found","documentation_url":"https://docs.github.com/rest/reference/repos#get-the-latest-release"}
```
Then most probably it's an old plugin which is not maintained, and can be removed from `~/.jx3/plugins/bin` folder.
{{< /alert >}}

The `jx` CLI version used to upgrade to is derived from the Jenkins X [version stream](/about/concepts/version-stream/).  

If you have not installed Jenkins X or are not connected to a Kubernetes cluster with Jenkins X running then the `jx` CLI version defaults to the latest version stream git repository [here](https://github.com/jenkins-x/jxr-versions/blob/master/packages/jx.yml)

If you are running the `jx upgrade cli` command from within a cloned cluster git repository (one that has the helmfile.yaml and jx-requirements.yml files at the root folder) then the [version stream](/about/concepts/version-stream/) URL used to find the correct jx CLI version use comes from the local file `versionStream/Kptfile`.  The reason for this is when switching [version stream](/about/concepts/version-stream/) (like moving to LTS) you need to match the jx CLI version stored in that desired vesrion stream, as they may be different to you previous [version stream](/about/concepts/version-stream/).

If you want to find the `jx` CLI version that matches the [version stream](/about/concepts/version-stream/) used by your cluster git repository then pass this addional flag:

```bash
jx upgrade cli --from-environment
```
