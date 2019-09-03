---
title: "Changes for May 21 2018"
date: 2018-05-21T14:35:26+01:00
description: "Office hours, lots of new presentations, quickstarts and VS Code..."
categories: [blog]
keywords: []
slug: "changes-May-21-2018"
aliases: []
author: jenkins-x-bot
---

Its been a busy 24 days since our [last blog post](/news/changes-april-27-2018/).

We had our first [Jenkins X Office Hours](https://www.youtube.com/watch?v=bvStct7Cz5E) which was lots of fun. We meet every other Thursday at 5pm BST / 12pm US Eastern. Feel free to  [add your questions to the doc](https://docs.google.com/document/d/1wHdBlZAN-ndPELuBoM5HBnYiQLvcz92-euXne2mKOEI/edit) or hangout live and ask questions in person. More details on the [community page](/community/#office-hours). 

We also did a bunch of presentations:

* James Strachan presented [Jenkins X at DevOxx UK](https://youtu.be/BF3MhFjvBTU?list=PLRsbF2sD7JVpRvLpv_Cub94zsM1aHm-Op) with a live demo on GKE. [Slides are here](https://www.youtube.com/redirect?event=comments&redir_token=8Ho_5LeDnDKOo6D5oWgr_dKtmPl8MTUyNjk5NzM4M0AxNTI2OTEwOTgz&q=https%3A%2F%2Fdocs.google.com%2Fpresentation%2Fd%2F1hwt2lFh3cCeFdP4xoT_stMPs0nh2xVZUtze6o79WfXc%2Fedit%3Fusp%3Dsharing)
* James Rawlings presented [Jenkins X at Cloud Native Wales](https://blog.cloudnativewales.io/001_ourfirstmeetup/)
* James Strachan presented [Jenkins X at KubeCon](/news/jenkins-x-does-kubecon/) 

Finally we made it over [1000 stars on github](https://github.com/jenkins-x/jx) within 2 months of announcing the project. Please keep the stars coming if you've not yet given Jenkins X a star! 

We still found plenty of time to fix issues and add new features as you can see in the changelog below.

We've now [lots more quickstarts](quickstarts) such as rails and python support. There's a [great blog on that here](https://medium.com/@maniankara/ci-cd-with-jenkins-x-on-your-existing-gke-cluster-ruby-on-rails-application-785d8390a857).

One big change in the project is the new [VS Code Extension](/developing/ide/) which we'll blog about soon in detail to walk through all the capabilities we've got & how to get started using it.

<img src="/images/vscode.png">


## Metrics

This blog outlines the changes on the project from April 27 2018 to May 21 2018.

| Metrics     | Changes | Total |
| :---------- | -------:| -----:|
| Downloads | **6680** | **21446** |
| Stars | **183** | **1051** |
| New Committers | **8** | **35** |
| New Contributors | **10** | **49** |
| #jenkins-x-dev members | **45** | **153** |
| #jenkins-x-user members | **103** | **313** |
| Issues Closed | **44** | **294** |
| Pull Requests Merged | **33** | **396** |
| Commits | **123** | **1436** |


[View Charts](#charts)



## New Committers

Welcome to our new committers!

* <a href='https://github.com/andreabettich' title=''><img class='avatar' src='https://avatars1.githubusercontent.com/u/1693858?v=4' height='32' width='32'> andreabettich</a>
* <a href='https://github.com/bardec' title=''><img class='avatar' src='https://avatars1.githubusercontent.com/u/3066042?v=4' height='32' width='32'> bardec</a>


## New Contributors

Welcome to our new contributors!

* <a href='https://github.com/andreabettich' title=''><img class='avatar' src='https://avatars1.githubusercontent.com/u/1693858?v=4' height='32' width='32'> andreabettich</a>
* <a href='https://github.com/bardec' title=''><img class='avatar' src='https://avatars1.githubusercontent.com/u/3066042?v=4' height='32' width='32'> bardec</a>


### New Features

* jx stop pipeline: add a CLI to stop pipelines ([jstrachan](https://github.com/jstrachan))
* jx step split monorepo: add a command to split a monorepo ([jstrachan](https://github.com/jstrachan)) [#822](https://github.com/jenkins-x/jx/issues/822) 
* explicit build packs: allow a quickstart to specify build pack ([jstrachan](https://github.com/jstrachan)) [#798](https://github.com/jenkins-x/jx/issues/798) 
* edit environments: lets create an Edit environment ([jstrachan](https://github.com/jstrachan))
* DevPods: lets detect the devpod kind from the `Jenkinsfile` ([jstrachan](https://github.com/jstrachan)) [#767](https://github.com/jenkins-x/jx/issues/767) 

### Bug Fixes

* sync: lets try remove any stale ksync rules ([jstrachan](https://github.com/jstrachan))
* DevPod: lets allow devpods to be reused if they exist ([jstrachan](https://github.com/jstrachan))
* filter out deleting pods by default ([jstrachan](https://github.com/jstrachan))
* bitbucket: let's update a pull request's merge status (Will Refvem)
* bitbucket: MergePullRequest now passes correctly structure body (Will Refvem)
* jx get build log: allow a build number to be specified ([jstrachan](https://github.com/jstrachan))
* jx step split monorepo: use the same deploymemt.yaml file name ([jstrachan](https://github.com/jstrachan))
* quickstart: lets allow quickstarts to contain chart yaml ([jstrachan](https://github.com/jstrachan))
* bitbucket: PullRequestLastCommitStatus now returns the generic statuses expected by jx promote (#829) (Will Refvem 文仁) [#826](https://github.com/jenkins-x/jx/issues/826) 
* jx step split monorepo: better test ([jstrachan](https://github.com/jstrachan))
* jx step split monorepo: better handle incremental updates ([jstrachan](https://github.com/jstrachan))
* correct bitbucket webhook url (Andrea Bettich)
* spring: lets add more cloud awesome to the spring wizard ([jstrachan](https://github.com/jstrachan))
* logs: assume verbose mode when showing the logs ([jstrachan](https://github.com/jstrachan)) [#794](https://github.com/jenkins-x/jx/issues/794) 
* sync: ignore more files OOTB ([jstrachan](https://github.com/jstrachan))
* logs: lets allow an environment to be specified ([jstrachan](https://github.com/jstrachan))
* delete app: avoid confusing output if if the user types a bad name ([jstrachan](https://github.com/jstrachan))
* devpod: lets default to a bigger devpod ([jstrachan](https://github.com/jstrachan))
* get apps: polish the UI for edit environments ([jstrachan](https://github.com/jstrachan))
* sync: fix correct command ([jstrachan](https://github.com/jstrachan))
* sync: detect folders in GOPATH ([jstrachan](https://github.com/jstrachan))
* rsh -d: detect folders in GOPATH ([jstrachan](https://github.com/jstrachan))
* devpod: detect folders in GOPATH ([jstrachan](https://github.com/jstrachan))
* sync: lets only initialise ksync if no ksync damonset ([jstrachan](https://github.com/jstrachan))
* devpod: lets put the edit namespaces after home/dev ([jstrachan](https://github.com/jstrachan))
* edit environments: lets create an exposecontroller service ([jstrachan](https://github.com/jstrachan)) [#284](https://github.com/jenkins-x/jx/issues/284) 
* devpod: use a better default working directory ([jstrachan](https://github.com/jstrachan))
* pod status: properly detect terminating pods ([jstrachan](https://github.com/jstrachan))
* jx delete app: lets allow apps to be deleted from environments too ([jstrachan](https://github.com/jstrachan)) [#342](https://github.com/jenkins-x/jx/issues/342) 
* delete: allow filters and select all when deleting apps or contexts ([jstrachan](https://github.com/jstrachan))
* jx sync: init or upgrade ksync ([jstrachan](https://github.com/jstrachan))
* jx delete app: first spike at a `jx delete app` ([jstrachan](https://github.com/jstrachan))
* jx get activity: lets show the app URL ([jstrachan](https://github.com/jstrachan)) [#739](https://github.com/jenkins-x/jx/issues/739) 
* sync: lets lazily ignore .git folders ([jstrachan](https://github.com/jstrachan))
* rsh: lets default to bash for DevPods ([jstrachan](https://github.com/jstrachan))
* sync: lets delete any previous ksync spec first ([jstrachan](https://github.com/jstrachan))

### Code Refactoring

* bitbucket: let's do a simple GET in GetPullRequest (Will Refvem)

### Documentation

* devpods: lets improve the CLI docs ([jstrachan](https://github.com/jstrachan))

### Chores

* vendoring (Will Refvem)
* vendoring ([jstrachan](https://github.com/jstrachan))
* remove bad import ([jstrachan](https://github.com/jstrachan))
* vendoring ([jstrachan](https://github.com/jstrachan))
* migrated the bootstrap target to dep ([jstrachan](https://github.com/jstrachan))
* formatting ([jstrachan](https://github.com/jstrachan))
* rename cdx -> cloudbees ([jstrachan](https://github.com/jstrachan))
* devpod: lets tone down the default size of a devpod ([jstrachan](https://github.com/jstrachan))
* ignore vs code files ([jstrachan](https://github.com/jstrachan))
* vendoring (Will Refvem)
* remove debug logging ([jstrachan](https://github.com/jstrachan))
* create issue: lets add whitespace to avoid possible overlap of the issue URL and the input text ([jstrachan](https://github.com/jstrachan))
* formatting ([jstrachan](https://github.com/jstrachan))

### Other Changes

These commits did not use [Conventional Commits](https://conventionalcommits.org/) formatted messages:

* Merge pull request #848 from jstrachan/malarkey ([jstrachan](https://github.com/jstrachan))
* Merge pull request #846 from wbrefvem/master (James Rawlings)
* Merge pull request #842 from jstrachan/malarkey ([jstrachan](https://github.com/jstrachan))
* Merge pull request #831 from rawlingsj/master (James Rawlings)
* fix(expose) use the Jenkins X chart repo to find exposecontroller (rawlingsj)
* Merge pull request #828 from kzantow/add-user-details ([jstrachan](https://github.com/jstrachan)) [#818](https://github.com/jenkins-x/jx/issues/818) 
* More cleanup (Keith Zantow)
* add UserList (Keith Zantow)
* tweaks (Keith Zantow)
* Better error checking (Keith Zantow)
* Add Users to K8s resources with best-guess Email (Keith Zantow)
* Merge pull request #824 from jstrachan/malarkey ([jstrachan](https://github.com/jstrachan))
* Merge pull request #801 from hekonsek/kops_cluster_validation ([jstrachan](https://github.com/jstrachan))
* Merge branch 'master' into kops_cluster_validation ([jstrachan](https://github.com/jstrachan))
* Merge pull request #789 from hekonsek/minikube_cpu_memory ([jstrachan](https://github.com/jstrachan))
* Merge branch 'master' into minikube_cpu_memory ([jstrachan](https://github.com/jstrachan))
* Merge pull request #773 from hekonsek/helm_non_verbose_info ([jstrachan](https://github.com/jstrachan))
* Merge branch 'master' into helm_non_verbose_info ([jstrachan](https://github.com/jstrachan))
* Helm repository installation should provide basic information in non-verbose mode. (Henryk Konsek)
* Merge pull request #768 from hekonsek/verbose_false ([jstrachan](https://github.com/jstrachan))
* Merge branch 'master' into verbose_false ([jstrachan](https://github.com/jstrachan))
* Running commands should not be verbose by default. (Henryk Konsek)
* Refactoring too generic function argument name. (#746) (Henryk Konsek)
* Merge pull request #751 from jstrachan/malarkey ([jstrachan](https://github.com/jstrachan))
* Merge pull request #747 from jstrachan/malarkey ([jstrachan](https://github.com/jstrachan))
* Merge pull request #743 from jstrachan/malarkey ([jstrachan](https://github.com/jstrachan))
* Merge pull request #740 from jstrachan/malarkey ([jstrachan](https://github.com/jstrachan))
* Merge pull request #771 from bardec/default_to_blue ([jstrachan](https://github.com/jstrachan))
* Add description and UI for classic flag (Caleb Barde)
* Add new flag and default to blue ocean UI (Caleb Barde)
* Fixed broken merge. (Henryk Konsek)
* Merge branch 'master' into minikube_vm_selected (Henryk Konsek)
* Merge branch 'master' into minikube_vm_selected ([jstrachan](https://github.com/jstrachan))
* Minikube cpu/memory cmd options should not invoke prompt. (Henryk Konsek)
* Merge pull request #787 from hekonsek/common_commands_tests ([jstrachan](https://github.com/jstrachan))
* Merge branch 'master' into common_commands_tests ([jstrachan](https://github.com/jstrachan))
* Added common_commands tests. (Henryk Konsek)
* Typo ;) . (Henryk Konsek)
* Improved kops validation checking. (Henryk Konsek)
* Merge pull request #802 from hekonsek/aws-common-options ([jstrachan](https://github.com/jstrachan))
* Merge branch 'master' into aws-common-options ([jstrachan](https://github.com/jstrachan))
* 'jx create cluster aws' should include common options. (Henryk Konsek)

### Issues

* [#826](https://github.com/jenkins-x/jx/issues/826) `jx create cluster gke` fails when using bitbucket git provider  ([wbrefvem](https://github.com/wbrefvem))
* [#818](https://github.com/jenkins-x/jx/issues/818) Consistent user information across preview / issues / commits ([kzantow](https://github.com/kzantow))
* [#822](https://github.com/jenkins-x/jx/issues/822) add a CLI command to split a monorepo up into separate git repos ([jstrachan](https://github.com/jstrachan))
* [#798](https://github.com/jenkins-x/jx/issues/798) lets allow a build pack to be specified explicitly in source code ([jstrachan](https://github.com/jstrachan))
* [#794](https://github.com/jenkins-x/jx/issues/794) jx log appears to be broken ([tdcox](https://github.com/tdcox))
* [#284](https://github.com/jenkins-x/jx/issues/284) create Preview Environments for editing code? ([jstrachan](https://github.com/jstrachan))
* [#342](https://github.com/jenkins-x/jx/issues/342) add: jx delete app ([jstrachan](https://github.com/jstrachan))
* [#739](https://github.com/jenkins-x/jx/issues/739) jx get activity: should show where the app is running ([jstrachan](https://github.com/jstrachan))
* [#738](https://github.com/jenkins-x/jx/issues/738) `jx get build logs` doesn't return pull request logs ([rawlingsj](https://github.com/rawlingsj))
* [#767](https://github.com/jenkins-x/jx/issues/767) jx create devpod - should automatically detect the container type ([michaelneale](https://github.com/michaelneale))

### Pull Requests

* [#848](https://github.com/jenkins-x/jx/pull/848) devpod + sync improvements ([jstrachan](https://github.com/jstrachan))
* [#846](https://github.com/jenkins-x/jx/pull/846) some fixes to promotion on bitbucket ([wbrefvem](https://github.com/wbrefvem))
* [#842](https://github.com/jenkins-x/jx/pull/842) add command to stop pipeines ([jstrachan](https://github.com/jstrachan))
* [#830](https://github.com/jenkins-x/jx/pull/830) feat: moved to dep for dependency management ([rajdavies](https://github.com/rajdavies))
* [#831](https://github.com/jenkins-x/jx/pull/831) fix(expose) use the Jenkins X chart repo to find exposecontroller ([rawlingsj](https://github.com/rawlingsj))
* [#829](https://github.com/jenkins-x/jx/pull/829) fix:(bitbucket) PullRequestLastCommitStatus now returns the generic statuses expected by jx promote ([wbrefvem](https://github.com/wbrefvem))
* [#828](https://github.com/jenkins-x/jx/pull/828) [WIP] #818 Add Users to K8s resources with best-guess Email ([kzantow](https://github.com/kzantow))
* [#824](https://github.com/jenkins-x/jx/pull/824) add a `jx step split monorepo` command ([jstrachan](https://github.com/jstrachan))
* [#821](https://github.com/jenkins-x/jx/pull/821) fix: correct bitbucket webhook url ([andreabettich](https://github.com/andreabettich))
* [#811](https://github.com/jenkins-x/jx/pull/811) feat(next-version): add a next-version pipeline step  ([rawlingsj](https://github.com/rawlingsj))
* [#806](https://github.com/jenkins-x/jx/pull/806) refactor:(bitbucket) let's do a simple GET in GetPullRequest ([wbrefvem](https://github.com/wbrefvem))
* [#801](https://github.com/jenkins-x/jx/pull/801) Improved kops validation checking ([hekonsek](https://github.com/hekonsek))
* [#799](https://github.com/jenkins-x/jx/pull/799) feat:(explicit build packs) allow a quickstart to specify build pack ([jstrachan](https://github.com/jstrachan))
* [#797](https://github.com/jenkins-x/jx/pull/797) fix:(logs) assume verbose mode when showing the logs ([jstrachan](https://github.com/jstrachan))
* [#789](https://github.com/jenkins-x/jx/pull/789) Minikube cpu/memory cmd options should not invoke prompt ([hekonsek](https://github.com/hekonsek))
* [#773](https://github.com/jenkins-x/jx/pull/773) Helm repository installation should provide basic information in non-verbose mode. ([hekonsek](https://github.com/hekonsek))
* [#768](https://github.com/jenkins-x/jx/pull/768) Running commands should not be verbose by default ([hekonsek](https://github.com/hekonsek))
* [#766](https://github.com/jenkins-x/jx/pull/766) chore: vendoring ([wbrefvem](https://github.com/wbrefvem))
* [#746](https://github.com/jenkins-x/jx/pull/746) Refactoring too generic function argument name ([hekonsek](https://github.com/hekonsek))
* [#754](https://github.com/jenkins-x/jx/pull/754) fix:  status runs with no output on a valid cluster ([rajdavies](https://github.com/rajdavies))
* [#751](https://github.com/jenkins-x/jx/pull/751) more improvements for DevPods / sync ([jstrachan](https://github.com/jstrachan))
* [#748](https://github.com/jenkins-x/jx/pull/748) fix(cdx): latest cdx installation changes and addon now works with private chart repo ([rawlingsj](https://github.com/rawlingsj))
* [#747](https://github.com/jenkins-x/jx/pull/747) improvements for DevPods for go ([jstrachan](https://github.com/jstrachan))
* [#744](https://github.com/jenkins-x/jx/pull/744) fix:  return faster when cluster not ready ([rajdavies](https://github.com/rajdavies))
* [#743](https://github.com/jenkins-x/jx/pull/743) added support for edit environments ([jstrachan](https://github.com/jstrachan))
* [#742](https://github.com/jenkins-x/jx/pull/742) fix: jx delete app  ([jstrachan](https://github.com/jstrachan))
* [#740](https://github.com/jenkins-x/jx/pull/740) various improvements ([jstrachan](https://github.com/jstrachan))
* [#735](https://github.com/jenkins-x/jx/pull/735) fix(cve): skip adding image to anchore if no service is found for it ([rawlingsj](https://github.com/rawlingsj))
* [#771](https://github.com/jenkins-x/jx/pull/771) Default to BlueOcean ([bardec](https://github.com/bardec))
* [#777](https://github.com/jenkins-x/jx/pull/777) feat:(DevPods) lets detect the devpod kind from the `Jenkinsfile` ([jstrachan](https://github.com/jstrachan))
* [#772](https://github.com/jenkins-x/jx/pull/772) Minikube: Prompt for VM driver should not be invoked if driver option has been used ([hekonsek](https://github.com/hekonsek))
* [#787](https://github.com/jenkins-x/jx/pull/787) Added common_commands tests ([hekonsek](https://github.com/hekonsek))
* [#802](https://github.com/jenkins-x/jx/pull/802) 'jx create cluster aws' should include common options ([hekonsek](https://github.com/hekonsek))

## Charts



## Downloads


<canvas id="downloadsChart" width="400" height="200"></canvas>
<script type="text/javascript" src="/news/changes-21-may-2018/downloads.js"></script>
</canvas>


This blog post was generated via the [jx step blog](http://jenkins-x.io/commands/jx_step_blog/) command from [Jenkins X](http://jenkins-x.io/).
