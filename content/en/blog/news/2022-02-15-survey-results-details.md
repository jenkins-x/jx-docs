---
title: "Jenkins X Survey Result Details"
date: 2022-02-15
draft: false
description: Some specific answers
categories: [other]
keywords: [Community, 2022]
slug: "survey-1-result-details-2022"
toc_hide: true
hide_summary: true 
aliases: []
author: Christoffer Vig
---

For more information on the Jenkins X survey see [Survey results](/blog/2022/02/15/survey-1-results-2022/)
Some highlights from the free text answers. 


### What do you enjoy the most with Jenkins X?

 
#### KUBERNETES 

- Cloud-native feel, "you know Kubernetes, you know how to use JX", plugins-based architecture 
- Complete CI/CD platform in a k8s cluster 


#### GIT/CHAT/OPS/CONFIGURABILITY  

- Configuration as code, auto generation of k8s files, flexibility 
-  easy to create preview/dev/staging/prod environments. 
-  modularity and ease to extend/change

#### EASY 
- Everything works out of the box. 
- Very intuitive 
- Lightweight and easy to manage.
 
 

#### COMMUNITY 
- The community is incredible. I really like how everything works together.  
- love the community.
   

 
#### VARIOUS 
- scalability and how fast it is! 
- Integration with different secret backends is easy. Also love the community. 
- It's opinionated 
- No vendor lock in
 


### What do you believe should be improved with Jenkins X? 

 

#### ON PREMISE 

-  run it against a local running cluster to test changes to Jenkins-X before updated in GitHub. 
- Integration with on-premise (Gitlab) as a lot of organizations are not using public cloud due to security policies, 

 
- Proper guide on installing into existing cluster without using terraform. Give us back something like `jx compliance`, `jx boot`. 
- Would be nice to not be tied to terraform to boot jenkins-x. Just like kubernetes, it would be great to have a jenkins-x the hard way where everything needs to be installed manually. 
 
 

#### DOCS 
- it's very difficult to just dive in without previous knowledge of the system 
 - extreme lack of quality documentation. 
 - Many conversations take place in slack and users cannot find information that somebody had the same problem beforehand and how it was solved
- More documentation and guides, making sure quickstart guides work without hassle 
- Making it easier to get started
- Very hard to find any information on how people solve a similar problem before
- I very much enjoy your documentation, but it is very hard to find anything on google that is a huge disadvantage. 
- Documents need to be clear about what works, and what does not work (kubernetes versions for example, bitbucket etc ..) 
 
- Could also be nice with an arcitecture illustration or video that could compare jenkins with jenkins X 
 - I find that when I'm looking for information I get a lot of mixed results (v3 vs v2).  
 

 
#### DEBUGGING 
- Debugging the integration 
- Error handing and reporting 

 
#### MULTI 
- HA, multi-tenant
- multi cluster setup 
 - Remote clusters  


#### GOVERNANCE 
- Needs focus on following up on K8s versions. 
- Needs a larger body of people governing it 
- PRs are being ignored for months at a time. The first PRs I've opened have been ignored to this day. I started getting some response after connecting with some devs in Slack.
- A public Roadmap and prioritizing tasks by community demand would be the way to go. 
-  who will be providing development leadership and direction. 

 
 

#### SECURITY 
- permission management within Terraform repos (default settings are too wide for orgs) 
 - separate JX permissions from per-project permissions - current pipelines gives a cluster admin scope to everyone as development teams can override steps and execute with any service account 

 

#### UI 
- pipelines dashboard needs Re-Run button. 
- A fully functional UI would be nice. 
 

#### VARIOUS 

- The install process 
- deploy speed 
- The parallel PR building causes issues. 
-  Support for Bitbucket Server 
- providing the capabilities to match CircleCI. lots of missing features or very difficult  to set up 
- Performance


 

#### VARIOUS FEEDBACK 
 
- Integration with vault is confused. Why install vault in docker in k3s environment? 
 
- I strongly believe in this project! 
- I use Jenkins X as a learning tool.  It gives me the ability to build K8S clusters using different cloud providers and helps me to understand the mechanics of GitOps, helm charts, etc. 
- Better error handling when pipelines fail would be good (tekton pipeline fail, but jx pipelines dont update their status). 
- I'm excited to see how the product has grown in the short time I've used it.