---
title: "Reconcile with kpt live apply"
date: 2023-03-09T00:00:00-00:00
draft: false
description: >
  Using `kpt live apply` to apply manifests in your cluster repository to your cluster 
categories: [blog]
keywords: [Jenkins X,Community,2023]
slug: "kpt-live-apply"
aliases: []
author: Mårten Svantesson
---

Since the dawn of Jenkins X 3 the default last step of reconciling the state of the files in your cluster repository to 
your cluster has been to execute `kubectl apply`. You can find more details about this 
[here](https://jenkins-x.io/v3/about/how-it-works/#boot-job).

There are some drawbacks with `kubectl apply` though. The one that made me start looking for alternatives was that if 
you remove a resource from your cluster repository it may not be removed from your cluster. The way deletion works with 
`kubectl apply` is that it is handed the option `--prune` which will remove resources that are not in the manifests. 
Except that it doesn't always work as expected. It will only remove certain kinds of resources 
[defined in kubectl](https://github.com/kubernetes/kubernetes/blob/4e800983fb8da4a5960a58ad9b380484770647d1/staging/src/k8s.io/kubectl/pkg/util/prune/prune.go#L28-L44). 
In my case I removed an HorizontalPodAutoscaler from my cluster repository, but it wasn't removed from my cluster.

When trying to find a solution to this I first tried to override this default list in kubectl of things to prune, but 
this turned out to be difficult in the general case. I also tried the already existing alternative of using `kapp` to 
apply the manifests, but I couldn't get that to work. Looking for other options I settled for `kpt live apply`.

## Configuration

{{% alert color="warning" %}}
For all the functionality described here to work you need to have a cluster that is
[upgraded](https://jenkins-x.io/v3/admin/setup/upgrades/cluster/) later than January 24th 2023.
{{% /alert %}}

You enable the use of `kpt live apply` by adding 

```make
KUBEAPPLY = kpt-apply
```

to the `Makefile` of your cluster repository anywhere before `include versionStream/src/Makefile.mk`. This works both 
in a dev cluster and in a [remote cluster](https://jenkins-x.io/v3/admin/guides/multi-cluster/multi-cluster/). 
(With the caveat that all bets are off if you have done changes yourself to `versionStream/src/Makefile.mk`.)

After you have pushed this you can watch the log of the boot job using `jx admin log` as usual. When `kpt live 
apply` has been executed the first time you can optionally add let `kpt live apply --dry-run` be executed for 
pull requests, giving a better assurance that the content of a pull request will apply nicely. But this only work 
properly for pull requests to the dev cluster, since it's in the dev cluster the pull request pipeline will execute. 
So in a remote clusters this should not be enabled. That said this functionality can be enabled by adding

```make
PR_LINT = kpt-apply-dry-run
```

to the `Makefile` of your cluster repository.

## Waiting for resources to be reconciled

While the fact that I can be sure that removed resource actually are gone is the killer feature of `kpt live apply` 
for me the opposite is true as well. With this I mean that `kpt live apply`(and as a consequence) the boot job won't 
succeed unless all resources are verified to have been applied. This includes for example that the rollout of new 
applications versions with deployments have succeeded. 

This can be seen as  a problem though: the default is that `kpt live apply` tries for 15 minutes before timing out 
with an error. But since the boot job is normal k8s job the job controller will create new pods on failure up to 
the backoff limit, that is set to **4**. This can block the application of subsequent changes to the cluster repo.

## Tagging and release notes

When activating `kpt live apply` you will also see that tags are added to the cluster repository upon successful 
application of changes. These tags can have 3 prefixes:

* `crd` for custom resource definitions
* `cluster` for cluster wide resources
* `ns` for namespaced resources (the most common)

For `ns` tags release notes will also be generated and added to the git provider (for example GitHub). This means 
that you can see what has changed in your cluster by looking at the releases of the cluster repository.

One handy use of this is that you can get a notification from GitHub when changes has been successfully deployed by 
going to the **Watch** menu for the repo, select **Custom** and check **Releases**. If you get the notification by email or on the
GitHub site depends on the notification settings for your GitHub account.

This functionality can be further customized by adding scripts to the `extensions` directory of your cluster repository.

* `crd-reconciled` will be executed after a `crd` tag has been added
* `cluster-reconciled` will be executed after a `cluster` tag has been added
* `ns-reconciled` will be executed after a `ns` tag has been added

The default behaviour is equivalent to adding the following script as `ns-reconciled`:

```bash
#!/bin/sh

jx changelog create --tag-prefix ns-
```

Here is a somewhat hacky variety that sends out a mail with the release notes similarly to what you can 
subscribe to for yourself:

```bash
#!/bin/sh
set -xe

jx changelog create --tag-prefix ns-

token=$(kubectl get secret jx-boot -o jsonpath="{.data['password']}" | base64 -d)
repourl=$(kubectl get secret jx-boot -o jsonpath="{.data['url']}"    | base64 -d)
owner="$(echo $repourl | cut -d/ -f4)"
repo="$(echo $repourl | cut -d/ -f5 | cut -d. -f1)"
(
cat <<EOF
to: changelog@example.com
From: dev@example.com
MIME-Version: 1.0
Return-Path: <>
Precedence: Bulk
Content-Type: text/html; charset=utf-8
Subject: Deploy to kubernetes cluster

<html>
<body>
<h1>Deploy to kubernetes cluster</h1>
EOF
curl -s  -H "Authorization: Bearer $token" https://api.github.com/graphql -X POST -d '{"query":"query { repository(owner:\"'$owner'\", name:\"'$repo'\") { release(tagName: \"ns-'${TS}'\") { descriptionHTML }}}"}' | yq .data.repository.release.descriptionHTML
echo "</body></html>"
) | sendmail -t -S smtp.example.com
```

To adapt for your own use, the minimal changes would be to find and replace the smtp server and mail addresses now 
added for the domain **example.com**. Don't forget to make the script executable with `chmod +x ns-reconciled`.