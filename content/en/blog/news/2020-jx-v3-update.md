---
title: "Jenkins X 3.x - beta is close!"
date: 2020-12-04
draft: false
description: Jenkins X 3.x - beta is close!
categories: [blog]
keywords: [Community, 2020]
slug: "jx-v3-update"
aliases: []
author: James Rawlings
---
 
It has been 'all hands on deck' in recent months with the focus on Jenkins X 3 alpha.  First off a huge thankyou to everyone involved.  The OSS community spirit has really shone through what has been a very difficult year for everyone.  Knowing that people from all over the world come and help each other, share banter and work at all hours of the day to help build out a true open source cloud native continuous delivery solution for developers - it's quite fantastic to see and amazing to be apart of.
 
As a result of all this hard work the Beta is iminent so this is a good opportunity to thank all involved so far and to outline what to expect in the coming days.
 
While we've been in the Alpha phase it has provided us with the opportunity to deprecate and remove APIs, commands and obsolete features that existed in v2.  This means we will not have any code dependency on the v2 codebase and so going forward v3 will be easier to maintain without the tech debt.
 
With that, we aim to make a big push and roll out a few last changes in preparation for Beta, here's a couple you will notice if you are already on the Alpha.  We recommend taking time to understand these, and avoid upgrading for a few days so that changes can be handled in one go, as there will be a constant stream of larger updates happening:
 
- jx requirements - this is the yaml file used to describe install needs for Jenkins X, until now there have been options available that were unsupported, confusing and in some cases did nothing.  These have now all been removed and the structure of the file has changed to be CRD like including an API version.  Upon upgrade `jx gitops upgrade` will migrate your `jx-requirements.yml` and push the changes back to the cluster gitops repository.  You should not see any errors however there are some pipeline steps that need to be updated in order to work with the new structure, this is covered next.
- pipeline catalog - currently Jenkins X 3.x defaults to in-repo pipelines where your Tekton resources are managed by kpt, these will need to be updated to work with the new or old requirements described above.  This means you will also need to run `jx gitops upgrade` in each your application git repos.  In the near future Jenkins X 3.x will make it easy to work with shared pipeline libraries / catalog repositories, referencing them via URL rather than in-repo.  This is so that users have the flexibility to choose which option is best for your use case.  In-repo pipelines and shared pipeline libraries have pros and cons for each, mainly about maintaining changes.  But for now, you will need to upgrade each application git repository.
- nested helmfiles - this is a great feature from Chris Mellard which will be merged very soon.  The idea is that your cluster git repository will have support for multiple helmfiles, ones that will contain core Jenkins X charts and maintained by kpt via the `jx gitops upgrade` process, and others where you can add your own charts rather than extending the single helmfile that is there today.
- nginx - for the alpha we have upgraded all the core helm charts we ship in a base Jenkins X installation, the last to land is Nginx thanks to Ankit!  This is not expected to cause issues however the change does involve moving to a different chart, there is a risk that there may be some very small window of downtime for the ingress controller so webhooks fired during the upgrade may fail to be delivered.
 
Balancing upgrades with continuous delivery brings many challenges.  However with Kubernetes, GitOps, Jenkins X version streams (including the monthly LTS coming soon) and other tools like kpt makes the process more transparent and provides a greater level of high availability. 
 
Jenkins X automatically upgrades its own infrastructure with every version stream release and we haven't experienced any disruption during the alpha period so far.  We aim to continue this, but when we know there will be disruption we endeavour to inform and explain why ahead of time.

Keep an eye out for announcements of the Beta and thanks again to all involved in the community and we are very much looking forward to welcoming new people too.  We are very excited for the Beta release and given the feedback so far we understand users are too.
 
For any questions and feedback please reach out on slack https://jenkins-x.io/community/#slack