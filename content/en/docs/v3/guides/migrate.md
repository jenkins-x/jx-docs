---
title: Migrate
linktitle: Migrate
description: Migrate to v3 from older Jenkins X installations
weight: 95
---

If you wish to migrate from older versions of Jenkins X to v3 we recommend [spinning up a new cluster for v3](/docs/v3/getting-started/) and then incrementally moving projects from the old cluster to the new cluster.

This might sound heavy handed but the issue with working with multiple versions of a number of charts like `lighthouse` and `tekton` is that they use cluster scoped resources (CRDs and `clusterrole` resources for example) which can compete with each other. e.g. installing a new version of a chart may well break an old installation.

So its safer to [spin up a new cluster and install v3 there](/docs/v3/getting-started/).

Once you have a new cluster you can just [import projects](/docs/v3/develop/create-project/#import-an-existing-project) into the new cluster via [jx project import](/docs/v3/develop/create-project/#import-an-existing-project)


You can then test the projects work fine in the new v3 cluster. If they do you can remove them from the old cluster via `jx delete application`.

## Batch importing

To batch import lots of projects from the old cluster:

* git clone the new cluster's git repository (with the `helmfile.yaml` file inside) and `cd` into the directory
* verify you are in the correct git clone by running this command

```bash 
ls -al helmfile.yaml
```

* you should see the `helmfile.yaml` file from the v3 installation

* now connect to your old Jenkins X cluster. Using jx v2 you can use `jx ctx` to switch contexts or refer to your cloud providers documentation on how to switch `kubectl` to point to different clusters

* verify you can see the old source repositories via:

```bash 
kubectl get sourcerepository
```

* now run the [jx gitops repository export]() command

* the local file `.jx/gitops/source-config.yaml` should have been modified with the exported repositories
* review the changes to this file - remove any projects you don't want to import
* now git commit this file:

```bash
git add .jx
git commit -a -m "fix: import repositories"
git push 
```

* connect to your new cluster
* you can watch the setup pipeline run via `jx admin log`
* once complete you should see the imported projects:
     
```bash 
kubectl get sourcerepository
```

