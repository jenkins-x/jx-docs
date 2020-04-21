---
title: Promotion and Environments
linktitle: Promotion and Environments
description: Promote new versions of your application to environments
weight: 4
aliases:
  - /developing/promote/
  - /about/features/#promotion
  - /about/features
---

The CD Pipelines of Jenkins X automate the [promotion](/about/concepts/features/#promotion) of version changes through each [Environment](/about/concepts/features/#environments) which is configured with a _promotion strategy_ property of `Auto`. By default the `Staging` environment uses automatic promotion and the `Production` environment uses `Manual` promotion.

To manually Promote a version of your application to an environment use the [jx promote](/commands/jx_promote/) command.

```sh
jx promote --app myapp --version 1.2.3 --env production
```

The command waits for the promotion to complete, logging details of its progress. You can specify the timeout to wait for the promotion to complete via the `--timeout` argument.

e.g. to wait for 5 hours


```sh
jx promote  --app myapp --version 1.2.3 --env production --timeout 5h
```

You can use terms like `20m` or `10h30m` for the various duration expressions.

<div class="row">
  <div class="col col-lg-9">
    <img src="/images/overview.png" class="img-thumbnail">
  </div>
</div>



## Feedback

If the commit comments reference issues (e.g. via the text `fixes #123`) then Jenkins X pipelines will generate release notes like those of [the jx releases](https://github.com/jenkins-x/jx/releases).

Also as the version with those new commits is promoted to `Staging` or `Production` you will get automated comments on each fixed issue that the issue is now available for review in the corresponding environment along with a link to the release notes and a link to the app running in that environment. e.g.

<div class="row">
  <div class="col col-lg-9">
    <img src="/images/issue-comment.png" class="img-thumbnail">
  </div>
</div>



## Promoting external apps

There may be apps that have already been released by other teams or companies who maybe don't yet use Jenkins X and the applications are not already in your helm chart repository.

If you wish to search your helm repositories for an application to promote you can use the `-f` for filter option to find a chart to promote.

e.g. to find a `redis` chart to promote to staging you could do:

```sh
jx promote -f redis --env staging
```

For databases you may want to alias (via `--alias`) the name of the chart to be a logical name for the kind of database you need. As you may need multiple databases in the same environment for different microservices. e.g.

```sh
jx promote -f postgres --alias salesdb --env staging
```

If you cannot find the particular application you are looking for you may need to add a helm chart repository to your helm installation via:

```sh
helm repo add myrepo https://something.acme.com/charts/
```

for example to add the stable community charts:

```sh
helm repo add stable https://kubernetes-charts.storage.googleapis.com/
"stable" has been added to your repositories
```

to add the incubator community charts:

```sh
helm repo add incubator https://kubernetes-charts-incubator.storage.googleapis.com/
"incubator" has been added to your repositories
```

There are huge numbers of [charts already created and maintained by the community](https://github.com/helm/charts/tree/master/stable) these days. If you want to add your own apps developed outside of Jenkins X you just need to package the YAML as a helm chart and install it in a chart repository.





