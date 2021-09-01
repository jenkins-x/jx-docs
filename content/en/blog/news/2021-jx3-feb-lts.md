---
title: "Jenkins X 3 - February 2021 LTS"
date: 2021-02-01
draft: false
description: February '21 LTS release for Jenkins X 3
categories: [blog]
keywords: [lts, jx3, 2021]
slug: "jx3-lts-feb-21"
aliases: []
author: James Rawlings
---

This is the first [LTS release](/v3/admin/setup/upgrades/lts/) for Jenkins X 3.x.  We are  still in the Beta release and the leadup to GA includes ensuring the process for LTS monthly releases is validated and working well.
This first releases focuses on:

- community feedback following the Beta release
- general helm chart upgrades
- improved developer UX when editing Tekton pipelines [here](/v3/develop/pipelines/editing)
- support for in-repo and shared Tekton pipeline libraries including git URI support,
e.g.

```bash
uses:jenkins-x/jx3-pipeline-catalog/packs/javascript/.lighthouse/jenkins-x/pullrequest.yaml@v1.2.3`
```

more documentation and examples can be found [here](https://github.com/jenkins-x/lighthouse/blob/master/docs/pipelines.md#configuring-pipelines)

## What's the difference?

Because Jenkins X uses GitOps we can see the git diff of changes that will be brought in with a cluster upgrade.   Here is the Pull Request that has been verified for February LTS release.
<https://github.com/jenkins-x/jx3-lts-versions/pull/209/files>

## Anything else to be aware of?

Included in the release is a switch of the NGINX Helm chart from the old Helm stable registry.  It was discussed on the community slack that some users on EKS and not using a custom domain had to change the domain in their cluster jx-requirements.yml file.

The change of Chart repository meant the old resources were removed and new ones added, resulting in a new Kubernetes LoadBalancer service was created, resulting in a new external IP address.  You may need to update the domain in your `jx-requirements.yml`.  To get the external IP run:

```bash
kubectl get service -n nginx
```

Note the external ip address and update your cluster git repository, `jx-requirements.yml`:

```bash
domain: $EXTERNAL_IP_FROM_ABOVE.nip.io
```

```bash
git commit
git push
jx admin logs
```

And you should see the new ingress rules created when the boot job finishes:

```bash
kubectl get ing -n jx
```

# What's next?

March LTS release aims to switch the incluster boot jobs to use <https://carvel.dev/kapp/> rather than using `kubectl` to apply and prune Kubernetes resources.  `kapp` is a dependency aware approach to installing Kubernetes resources, this aims to help avoid timing issues when installing resources before certain services like cert-manager are fully up and running.
