---
title: "Consolidate the use of Apps / Addons - Coding Phase 1"
date: 2020-07-12
draft: false
description: >
  Share Jenkins X GSoC coding phase 1 work
categories: [blog]
keywords: [Jenkins,Community,2020]
slug: "GSoC2020"
aliases: []
author: Zixuan Liu
---

The coding phase 1 of Google Summer of Code ended last week, I'm working on [Consolidate the use of Apps / Addons](https://www.jenkins.io/projects/gsoc/2020/projects/jenkins-x-apps-consolidation/), so I'd like to share my coding phase 1 work.

In the project, I mainly migrate addons to apps, the way is easier for improve jx apps and addons.

During the time, I've migrated all addons to apps via Helm chart way.

The following is my make apps:

- https://github.com/nodece/jx-app-kubeless
- https://github.com/nodece/jx-app-owasp-zap
- https://github.com/nodece/jx-app-flagger
- https://github.com/nodece/jx-app-gloo
- https://github.com/nodece/jx-app-istio
- https://github.com/nodece/jx-app-ingress

Current, we only move to jx-app-kubeless to the [jenkins-x-apps](https://github.com/jenkins-x-apps) repository, other apps haven't been moved to the [jenkins-x-apps](https://github.com/jenkins-x-apps) repository.

You can visit [here](https://docs.google.com/spreadsheets/d/1k2KEMdk5-9HrU-IUuataYD63Kl-JEsuy5aXus7Dcitc/edit?usp=sharing) for more details.

#### Next phase work

The next phase is to add `jx delete app` command to jx, but it has been implemented by Jenkins X contributor, so I made a new plan for next phase.

The following is my plan for the next phase:

- Improve `jx add app` - It will support to fetch any git repository to install app. I also consider migrate application to apps.

- Perfect the work of phase 1, these apps haven't moved to jenkins-x-apps repository yet.

- Follow up on jx issues to improve jx.

### Demo for coding phase 1 

I presentation my coding phase 1 demo on YouTube lase week. 

> Notes: the video language is Chinese.
<iframe width="560" height="315" src="https://www.youtube.com/embed/Ka2Uor_oTWc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Last week, Jenkins hold a meeting for Jenkins GSoC students to present their phase 1 work, I also present my coding phase 1 work on the meeting. 

<iframe width="560" height="315" src="https://www.youtube.com/embed/HQLhakpx5mk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

#### Feedback

If you are interested in the project, or to guide me. Welcome to join #jenkins-x-gsoc channel on [CDF Slack](https://cdeliveryfdn.slack.com/join/shared_invite/enQtODM2NDI1NDc0MzIxLTA1MDcxMzUyMGU2NWVlNmQwN2M1N2M4MWJjOWFkM2UzMDY0OWNkNjAzNzM0NzVkNjQ5M2NkMmY2MTRkMWY4MWY#/). 🙌 
