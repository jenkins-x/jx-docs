---
title: Troubleshooting
linktitle: Troubleshooting
type: docs
description: Questions on common issues folks hit using the cloud, kubernetes and Jenkins X
weight: 400
---

## Why did my quickstart / import not work?

If you are not able to create quickstarts or import projects its most probably webhooks not being setup correctly.

When the `jx project import` or `jx project quickstart` runs it creates a Pull Request on your dev cluster repository. This should [trigger a webhook](/v3/about/how-it-works/#importing--creating-quickstarts) on your git provider which should then trigger a Pipeline (via [lighthouse webhooks](/v3/about/overview/#lighthouse)). The pipeline should then  [create a second commit on the pull request](/v3/about/how-it-works/#importing--creating-quickstarts) to configure your repository which then should get labelled and auto-merge.

If this does not happen its usually your webhooks are not working. You can check on the health of your system and webhooks via the [Health guide](/v3/admin/setup/health/)

Check out the [webhooks troubleshooting guide](/v3/admin/troubleshooting/webhooks/)

If you manually merge the Pull Request by hand then you'll miss out the [create a second commit on the pull request](/v3/about/how-it-works/#importing--creating-quickstarts) which means your project won't properly import. To work around that you can do a dummy commit on your dev cluster repository which will trigger a regeneration.

If the `jx project import` or `jx project quickstart` times out before the pipeline triggers the [second commit on the pull request](/v3/about/how-it-works/#importing--creating-quickstarts) and it auto merges and triggers a boot job to setup webhooks for the new repository - you will have pipeline catalog files locally on your laptop which are not pushed to git. e.g. the `.lighthouse/*` files and maybe other files like `charts/*` and `Dockerfile`. You can always try add those files to git locally and push once you have got your webhooks working.

Also make sure that the boot Job that is triggered by the pull request merging has the necessary scopes on the git personal access token to be able to registry the webhooks on the new repository. You will see if the webhook registration has been successful in the boot log:

```bash
jx admin log 
```

## Why does my pipeline not start?

It could be your [YAML configuration](/v3/develop/reference/pipelines/) is invalid.

Try [linting your YAML configuration](/v3/develop/pipelines/editing/#linting) to verify things are setup correctly.

Also make sure you are in the git repository collaborators group and are in the `OWNERS` file in the main branch.

## Why is my pipeline pending?

If your pipeline shows pending in the [CLI](/v3/develop/ui/cli/), [Console](/v3/develop/ui/octant/) or [Dashboard](/v3/develop/ui/dashboard/) there could be various causes such as invalid images, pipeline configuration, missing secrets or insufficient cluster capacity to name but a few.

To diagnose why a pipeline pod can't run the simplest thing is to use the [Console](/v3/develop/ui/octant/)

```bash
jx ui
```

* on the **Pipelines** page pick the pipeline that is having trouble (see the links you can click on the **Build** column)
* on the **Pipeline** page there is then a **Pod** link in the navigation bar which takes you to the **Pod** view in [octant](https://octant.dev/) that lets you view the detail of the pod. From there you should be able to see any events/issues with the pod such as bad images, missing secrets or whatever.

e.g. see the **Pod** link to the left of the  **Steps** / **Logs** links in the nav bar

<iframe width="646" height="327" src="https://www.youtube.com/embed/2LCPHi0BnUg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Upgrading CLI fails

I run `jx upgrade cli` and get a failure:

```bash
$ jx upgrade cli   
using latest upstream versionstream URL https://github.com/jenkins-x/jxr-versions.git from Kptfile to resolve jx-cli version
error: failed to find jx cli version: invalid version requested: : Version string empty `
```

The issue is you are using an old alpha of the `jx` binary which no longer auto upgrades with the GA [jx releases](https://github.com/jenkins-x/jx/releases)

To fix please [download a new `jx` binary](/v3/admin/setup/jx3/).

## Releasing a chart fails with 500

If your release pipeline fails with a HTTP 500 error pushing a helm chart to chartmuseum it could be that the chart name and version has already been released before and chartmuseum won't let you re-publish the same version of the helm chart.

If you retrigger a release on your repository (e.g. merging a git commit to the main branch), you should see a new version being created and released?

If not try create a new git tag on your repository for the next version e.g. if 0.1.2 was the last release, create a git tag of `v0.1.3` then then next release will be `0.1.4`). Then trigger a new release via a commit to the main branch.

## My cluster is out of resources

If your cluster is out of resources and cannot deploy pods:

* try modify your terraform / cluster to add more nodes, increase the auto scaling or add bigger nodes to the node pool. You can also add an additional node pool with bigger nodes

* as a short term fix try scaling down some deployments - though note the next boot job will scale things back up again:

```bash
kubectl get deploy

# pick one to scale down
kubectl scale deploy someDeploymentName --replicas=0
```

* remove preview environments via:

```bash
jx delete preview 
```

* remove deployments you don't need by removing entries from the `releases:` section in `helmfiles/$namespace/helmfile.yaml`
  * e.g. e.g. to remove an application from the `jx-staging` namespace remove releases from  `helmfiles/jx-staging/helmfile.yaml`

## Diagnose pipeline failure via the CLI

To do this via the command line try

```bash
jx get build pod
```

if you know the repository name:

```bash
jx get build pod -r myrepo
```

Then you should be able to see the pod name for the pipeline in question. You can then use `kubectl` to destribe the issue:

```bash
kubectl describe pod the-actual-pod-name-for-your-pipeline```
```

## Why does Jenkins X fail to download plugins?

When I run a `jx` command I get an error like...

```Get https://github.com/jenkins-x/jx-..../releases/download/v..../jx-.....tar.gz: dial tcp: i/o timeout```

This sounds like a network problem; the code in `jx` is trying to download from `github.com` and your laptop is having trouble resolving the `github.com` domain.

* do you have a firewall / VPN / HTTP proxy blocking things?
* is your `/etc/resolv.conf` causing issues? e.g. if you have multiple entries for your company VPN?

## Failed calling webhook validate.nginx.ingress.kubernetes.io

This is often caused if you remove the `nginx` namespace after you installed nginx.

This is because admission webhooks are cluster scoped; not namespace scoped - so removing the nginx namespace does not remove these webhook resources - which then breaks any attempt to create `Ingress` resources until you remove them.

You can view the current tekton based hooks via:

```bash
kubectl get validatingwebhookconfigurations | grep nginx
 ```

You can remove the nginx one via:

```bash
kubectl delete validatingwebhookconfigurations ingress-nginx-admission
```

Then try do a dummy git commit in your git repository which will [trigger another boot job](/v3/about/how-it-works/#boot-job)

You can watch the boot job run via:

```bash
jx admin log -w
```

## Tekton failed calling webhook "config.webhook.pipeline.tekton.dev"

When you first install tekton your cluster can get in a bit of a mess if the kubernetes admission/mutation webhooks are registered but tekton didn't startup.

Another time folks hit this is if they delete the `tekton-pipelines` namespace thinking that gets rid of tekton and then they find they can't re-install tekton.

This is because admission/mutation webhooks are cluster scoped; not namespace scoped - so removing the tekton namespace does not remove these webhook resources - which then breaks any attempt to install tekton until you remove them.

You can view the current tekton based hooks via:

```bash
kubectl get mutatingwebhookconfigurations | grep tekton
kubectl get validatingwebhookconfigurations | grep tekton
 ```

Then find the tekton based ones and remove them. e.g. via:

```bash
kubectl delete mutatingwebhookconfigurations webhook.pipeline.tekton.dev
kubectl delete validatingwebhookconfigurations config.webhook.pipeline.tekton.dev
kubectl delete validatingwebhookconfigurations validation.webhook.pipeline.tekton.dev
```

Then try do a dummy git commit in your git repository which will [trigger another boot job](/v3/about/how-it-works/#boot-job)

You can watch the boot job run via:

```bash
jx admin log -w
```

## Tekton webhook certs have expired?

Delete the tekton `webhook-certs` tls secret. Then delete the `tekton-pipelines-webhook` pod and the cert should be recreated again.
