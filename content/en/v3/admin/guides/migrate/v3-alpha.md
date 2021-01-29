---
title: From 3.0 Alpha
linktitle: From 3.0 Alpha
type: docs
description: Migrate to the 3.0 Beta from 3.0 Alpha
weight: 50
---


The [3.0 beta is almost ready](/blog/2020/12/04/jx-v3-update/), so we've rolled out the new `jx-requirements.yml` file format which uses API versioning and removes lots of old deprecated content.
  
Your cluster git repository will be upgraded automatically when you [upgrade your cluster](/v3/admin/guides/upgrade/#cluster) via the `jx gitops upgrade` command inside a git clone of your cluster git repository.
  
**NOTE** once you upgrade your cluster you will also need to make sure all the quickstarts and imported projects are using the latest pipelines from the catalog to ensure the container images are at least at 3.0 beta level. 


## Upgrading pipelines in your repositories

You can create Pull Requests on all the repositories you've imported or created via quickstarts via:

```bash 
jx updatebot pipeline
```

This will use the default [kpt](https://googlecontainertools.github.io/kpt/) strategy of `resource-merge` which will try merge any local changes with those changes in the [pipeline catalog](/v3/develop/pipelines/)

You can use the `--strategy` to change this default if you wish. See `jx updatebot pipeline --help` for more detail.


### If you lose some pipeline changes

To be totally sure you don't miss any local changes to pipelines you can use the  `--strategy alpha-git-patch` argument.
            
Though you can get [merge conflicts](/v3/admin/guides/upgrade/#merge-conflicts) which you then need to resolve in your IDE so its probably easier if you do those changes by hand in each repository via `jx gitops upgrade`

The other option is to allow the above `resource-merge` to create a PR and merge; then if you have lost some changes use your IDE to see the differences and bring things back you need.
             

### If you hit issues on your alpha cluster 

If you are not yet ready to migrate to the beta and hit some issues these tips may help.

If you have pipelines on your alpha that start to fail with issues around requirements parsing (missing fields or encoding of storage or whatever) then edit your pipeline files to replace any `latest` images for `jx-cli` with `jx-cli:3.0.766` instead.

You may find new quickstarts / imports created on your cluster start to fail too. 

To avoid that modify your pipeline catalog to use the `alpha` tag rather than `master`. e.g. if you edit your [extensions/pipeline-catalog.yaml](https://github.com/jx3-gitops-repositories/jx3-kubernetes/blob/master/extensions/pipeline-catalog.yaml#L7) file just make sure it has the `alpha` reference like this:


```yaml
apiVersion: project.jenkins-x.io/v1alpha1
kind: PipelineCatalog
spec:
  repositories:
  - label: JX3 Pipeline Catalog
    gitUrl: https://github.com/jenkins-x/jx3-pipeline-catalog
    gitRef: alpha
```
