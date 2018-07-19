---
title: Preview Environments
linktitle: Preview Environments
description: Preview pull requests before changes merge to master
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
menu:
  docs:
    parent: "developing"
    weight: 110
weight: 110
sections_weight: 110
draft: false
toc: true
---


We highly recommend the use of [Preview Environments](/about/features/#preview-environments) to get early feedback on changes to applications before the changes are merged into master.
  
Typically the creation of preview environments is automated inside the Pipelines created by Jenkins X.

However you can manually create a [Preview Environment](/about/features/#preview-environments) using [jx](/commands/jx) via the [jx preview](/commands/jx_preview) command.

```shell 
jx preview
```

### What happens when a Preview environment is created

* a new [Environment](/about/features/#environments) of kind `Preview` is created along with a [kubernetes namespace](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) which shows up in the [jx get environments](/commands/jx_get_environments/) command along with the [jx environment and jx namespace commands](/developing/kube-context) so you can see which preview environments are active and switch into them to look around
* the Pull Request is built as a preview docker image and chart and deployed into the preview environment
* a comment is added to the Pull Request to let your team know the preview application is ready for testing with a link to open the application. So in one click your team members can try out the preview!
 
<img src="/images/pr-comment.png" class="img-thumbnail">

### Post preview jobs

One of the extension points of Jenkins X lets you put a hook in after a preview job has been deployed. This hook applies to all apps in a team even existing ones, for all new pull requests/changes. (You don't have to add it to each pipeline by hand - it can be used to enforce best practices).

This means you can run a container Job against the preview app, validating it, before the CI pipeline completes. Should this Job fail, the pull request will be marked as a failure. 

Here is an example: 

```
jx create post preview job --name owasp --image owasp/zap2docker-weekly:latest -c "zap-baseline.py" -c "-I" -c "-t" -c "\$(JX_PREVIEW_URL)"
```

This creates a post preview job which runs the `zap-baseline.py` command inside the specified docker image (it will pull the image and run it, and then shut it down) which scans the running preview app for any problems. 

The `$JX_PREVIEW_URL` environment variable is made available in case the job needs to access the running preview app. Use `-c` to pass commands to the container. 

This job runs after the preview has been deployed. If it returns non zero, the PR will be marked as a failure. 

You can also run: 

```
jx get post preview
```

to see any configured post preview jobs, and: 

```
jx delete post preview job --name=NAME_HERE
```

And it will remove that post preview job (for the whole team).



