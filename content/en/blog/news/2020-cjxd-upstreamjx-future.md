---
title: "CJXD to upstream Jenkins X to the future"
date: 2020-07-29
draft: false
description: >
  
categories: [blog]
keywords: [Community, 2020]
slug: "cjxdtoupstreamjxtofuture"
aliases: []
author: James Rawlings
---

CJXD was first introduced at the end of July 2019 with the aim to provide a more stable version of Jenkins X that was under heavy development.  The release cadence was reduced to one per month, the upgrade process well tested and a large focus on stability issues was taken on.  It is fair to say that this was not only expected but absolutely needed by users of Jenkins X to service their own software delivery. A little over a year on we are now in a better place, following the improvements above means we are now able to focus all attention back towards the upstream Jenkins X and look towards where Jenkins X needs to go next.  There is still much to do, areas which require attention in design, upgrades related to other projects and innovation to explore.  With that, the need for CJXD over and above using upstream Jenkins X is reduced.  CloudBees will stop releasing CJXD builds and focus purely upstream and it’s engineering efforts towards working with the OSS community on JX3 Alpha, Beta, GA and beyond.

JX3 is in a relatively early stage, we have an enhancement issue [here](https://github.com/jenkins-x/enhancements/issues/36) and plan to start showing some initial developments and design docs to help people get involved in the next week or two.

While the OSS community works on getting JX3 to GA, users of CJXD have a few options.  Both option 1 and 2 below involve moving to the stable upstream JX2.  One important note here is you will need to remove the Jenkins X UI as this a CloudBees specific offering and will not continue in favour of the new extensible OSS UI powered by Octant.  This was demo’d at the [recent office hours](https://youtu.be/Njl247hjRuU) as well as discussing some next steps we are working through for JX3.

__Option 1:__ Upgrade your existing CJXD installation to upstream JX2.  There are some steps on how to do this below, there may be some edge cases in doing this but as in all the options here the OSS community in on hand to help https://jenkins-x.io/community/

_Notes:_
- You will continue to be able to apply JX2 upgrades.  
- No backwards compatible upgrade for Vault if you are using it.  The migration configuration steps below will omit Vault from this and future upgrades.  Note for JX3 we are working on using external secrets as an abstraction above lots of secret store implementations.  So for now we recommend keeping on the Vault Operator 0.4.16 release and manage the Vault upgrade along with the JX 3 external secrets work.

__Option 2:__ Create a brand new JX2 cluster and jx import your git repositories.

__Option 3:__ Stay on CJXD and wait to move to JX3 although the timelines for this are unknown it is the primary development focus going forward so lots more details on this coming soon.  Note you won’t be able to upgrade to obtain future JX 2 fixes.  

The Jenkins X OSS community is very active on Slack, we host regular open office hours zoom sessions and are building out a number of special interest groups in the coming weeks and months which we would love for you to be a part of.  Twitter is active and a good way to keep up to date with events, plus we are launching a new Discourse community forum.  There is no better time to be involved, if you are looking to contribute code, learn or share new things or help carve out the future direction of Jenkins X, we are eager for your involvement.

As a start please come and say hello on the slack channel or be brave and help kick off https://jenkinsx.discourse.group/ - you just need to sign up.

Looking forward to seeing you soon.

___

# Migration steps for CJXD to upstream Jenkins X

## Configuration changes

Get the latest jx CLI https://github.com/jenkins-x/jx/releases

Change version stream, boot config repos URL + tags, remove Jenkins X UI and remove the upgrade for Vault.

Change the git repository for your development environment, get the URL using:
```
> jx get environments
```
and apply these changes:
- remove the `env/jx-app-ui` folder and `jx-app-ui` from `env/requirements.yaml`
- remove the `jx step boot vault` boot pipeline step 
- switch from the CJXD version stream to the upstream Jenkins X one

The exact changes described above can be found in this commit:

https://github.com/cb-kubecd/environment-cjxdtest1-dev/commit/2596efdb51b812758ce847e16beb2035af4f61f1

Once these changes are merged into the mainline branch follow the boot pipeline using:
```
> jx get build logs
```
Once the boot pipeline has finished successfully you can upgrade to the very latest release (the git sha’s above are the latest at writing this blog)
```
> jx upgrade boot
```
Review and /approve the generated pull request, follow the boot pipeline logs to success.

If you run into problems, need any help or guidance please ask in the the Jenkins X community https://jenkins-x.io/community/