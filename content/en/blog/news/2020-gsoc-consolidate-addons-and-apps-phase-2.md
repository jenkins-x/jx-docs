---
title: "Consolidate the use of Apps / Addons - Coding Phase 2"
date: 2020-07-27
draft: false
description: >
  Share Jenkins X GSoC coding phase 2 work
categories: [blog]
keywords: [Jenkins,Community,2020]
slug: "GSoC2020"
aliases: []
author: Zixuan Liu
---

The coding phase 2 of Google Summer of Code will end this week, so I'd like to share my coding phase 2 work.

The addons have been migrated to apps on coding phase 1, but these apps have not been hosted to OSS, so during the coding phase 2, Jenkins X team build OSS cluster to host my apps: 

- [jx-app-flagger](https://github.com/jenkins-x-apps/jx-app-flagger)

- [jx-app-ingress](https://github.com/jenkins-x-apps/jx-app-ingress)

- [jx-app-gloo](https://github.com/jenkins-x-apps/jx-app-gloo)

- [jx-app-kubeless](https://github.com/jenkins-x-apps/jx-app-ingress)

you can use `jx add app` command to install the above apps, I also made a number of PR:

- https://github.com/jenkins-x/jx/pull/7472 - fix `jx add app` command

- https://github.com/jenkins-x/jx/pull/7441 - fix skip dir when looping Helm templates

- https://github.com/jenkins-x/jx/pull/7440 - deprecate create addon kubeless

- https://github.com/jenkins-x/jx/pull/7436 - support `jx add app` from git repository

My work is inseparable from my mentors and Jenkins X team, in particular, my mentor -  Kara de la Marck took good care of me in every way (such as language, English is my second language), so thank you for your time ❤️

#### Next phase work

In the next phase I will write these apps document and add deprecate note to jx, and continue to explore apps. I will also follow up about apps/addons issues on jx then try to solve the issues. Jenkins X team is going to be releasing 3.x of Jenkins X, I also need to get familiar with it - https://github.com/jenkins-x/octant-jx. 

#### Feedback

If you are interested in the project, or to guide me. Welcome to join #jenkins-x-gsoc channel on [CDF Slack](https://cdeliveryfdn.slack.com/join/shared_invite/enQtODM2NDI1NDc0MzIxLTA1MDcxMzUyMGU2NWVlNmQwN2M1N2M4MWJjOWFkM2UzMDY0OWNkNjAzNzM0NzVkNjQ5M2NkMmY2MTRkMWY4MWY#/) 🙌 
