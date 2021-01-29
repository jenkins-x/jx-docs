---
title: Upgrading
linktitle: Upgrading
type: docs
description: Upgrading and converting pipelines
weight: 500
---


## Converting older pipelines

If you have older pipelines in your git repository created with an older version of Jenkins X you can convert them to the new concise `image: uses:sourceURI` syntax via the [jx pipeline convert](https://github.com/jenkins-x/jx-pipeline/blob/master/docs/cmd/jx-pipeline_convert.md#jx-pipeline-convert) command:

```bash
jx pipeline convert 
```        

The pipelines should be modified and if you have a `Kptfile` it will be removed.
   
## Upgrading pipelines and helm charts via kpt

You can upgrade any git repository in the same way you upgrade your [clusters git repository](/v3/guides/upgrade/#cluster) by running the [jx gitops upgrade](https://github.com/jenkins-x/jx-gitops/blob/master/docs/cmd/jx-gitops_update.md) command inside a git checkout of your repository:

```bash
cd my-quickstart-thingy
jx gitops upgrade
```              

This will then upgrade any helm charts or pipeline catalogs you are using in your git repository with the latest versions.

After running this command you will usually have some changes in `git` you can review. If you are happy with the changes commit them and create a Pull Request so that they can get applied on your cluster.

```bash
git add *
git commit -a -m "fix: upgrade pipeline catalog"
git push
```               

It is possible that you can have merge conflicts.  

You can follow the inline git helper messages to resolve conflicts - or use your IDE to help figure out the merge issues more easily. 

### Converting all repositories

You can now perform a batch of Pull Requests if you need to upgrade your pipelines on your repositories if the upstream pipeline catalogs have upgraded.

See: [generate pull requests to upgrade pipelines](/v3/admin/guides/migrate/v3-alpha/#upgrading-pipelines-in-your-repositories)

Here is an example of [an automated Pull Request](https://github.com/jenkins-x/jx-gitops/pull/551) that was used to migrate one of our pipelines on [jx-gitops](https://github.com/jenkins-x/jx-gitops) - as you can see the resulting file is much simpler and easier to maintain.