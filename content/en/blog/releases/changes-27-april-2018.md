---
title: "Changes for April 27 2018"
date: 2018-04-27T15:30:44+01:00
description: "Now Skaffold, DevPods, Anchore, MiniShift and much more..."
categories: [blog]
keywords: []
slug: "changes-April-27-2018"
aliases: []
author: jenkins-x-bot
---

## Changes for April 27 2018

Its 16 days since our [last blog post](/blog/2018/04/11/changes-april-11-2018/) and we've been really busy again! 

Here's some of the main highlights:

* we have moved to using [skaffold](https://github.com/GoogleContainerTools/skaffold) for building docker images so that we can easily take advantage of things like Google Container Builder or [kaniko](https://github.com/GoogleContainerTools/kaniko)
* new [DevPods(/docs/using-jx/developing/devpods/) are a thing; making it easy to use your kubernetes cluster for building, testing and running apps
* new integration with [Anchore](https://anchore.com/) for security scanning via [jx get cve](/commands/jx_get_cve/) or in a pipeline you can use [jx step post build](/commands/jx_step_post_build/) - we'll blog separately about that next week
* thanks to the work of [@LinuxSuRen](https://github.com/LinuxSuRen) we now have the initial [Chinese translation of the Jenkins X documentation](https://jenkins-x.io/zh/)
* we now support [MiniShift](/getting-started/create-cluster/) as well as AKS, AWS, GKE and vanilla kubernetes clusters.
* we now have a much more flexible mechanism of handling Secrets/Credentials so dealing with other git providers is now much simpler
* we finally got lots more [architecture documentation](https://jenkins-x.io/architecture/) on how Jenkins X fits together.

The Jenkins X Futures page has been updated to give a better feel for where we are.   

Also if you are going to be at [KubeCon](https://kccnceu18.sched.com/) then please come to the session by [James Strachan on Jenkins X](https://kccnceu18.sched.com/event/Dquk?iframe=no) or pop by the CloudBees both and say hi! 

Here's the more detailed breakdown:

### Metrics Summary
 
This blog outlines the changes on the project from April 11 2018 to April 27 2018.

| Metrics     | Changes | Total |
| :---------- | -------:| -----:|
| Downloads | **6321** | **14766** |
| Stars | **238** | **868** |
| New Committers | **8** | **27** |
| New Contributors | **11** | **39** |
| #jenkins-x-dev members | **39** | **108** |
| #jenkins-x-user members | **77** | **210** |
| Issues Closed | **106** | **250** |
| Pull Requests Merged | **41** | **363** |
| Commits | **150** | **1313** |


[View Charts](#charts)



## New Committers

Welcome to our new committers!

* <a href='https://github.com/garethjevans' title=''><img class='avatar' src='https://avatars0.githubusercontent.com/u/158150?v=4' height='32' width='32'> garethjevans</a>
* <a href='https://github.com/hekonsek' title=''><img class='avatar' src='https://avatars3.githubusercontent.com/u/822903?v=4' height='32' width='32'> hekonsek</a>
* <a href='https://github.com/kzantow' title=''><img class='avatar' src='https://avatars2.githubusercontent.com/u/3009477?v=4' height='32' width='32'> kzantow</a>
* <a href='https://github.com/yahavi' title=''><img class='avatar' src='https://avatars1.githubusercontent.com/u/11367982?v=4' height='32' width='32'> yahavi</a>


## New Contributors

Welcome to our new contributors!

* <a href='https://github.com/derryx' title=''><img class='avatar' src='https://avatars3.githubusercontent.com/u/772060?v=4' height='32' width='32'> derryx</a>
* <a href='https://github.com/garethjevans' title=''><img class='avatar' src='https://avatars0.githubusercontent.com/u/158150?v=4' height='32' width='32'> garethjevans</a>
* <a href='https://github.com/hekonsek' title=''><img class='avatar' src='https://avatars3.githubusercontent.com/u/822903?v=4' height='32' width='32'> hekonsek</a>
* <a href='https://github.com/kzantow' title=''><img class='avatar' src='https://avatars2.githubusercontent.com/u/3009477?v=4' height='32' width='32'> kzantow</a>
* <a href='https://github.com/sauravdevops' title=''><img class='avatar' src='https://avatars2.githubusercontent.com/u/5648443?v=4' height='32' width='32'> sauravdevops</a>
* <a href='https://github.com/yahavi' title=''><img class='avatar' src='https://avatars1.githubusercontent.com/u/11367982?v=4' height='32' width='32'> yahavi</a>


### New Features

* jx delete devpod: add a CLI to delete DevPods (James Strachan)
* jx get devpod: add a CLI to query DevPods (James Strachan)
* jx sync: lets make it easy to sync a local folder to a pod (James Strachan) [#726](https://github.com/jenkins-x/jx/issues/726) 
* dev pods: lets make it super easy to open another shell (James Strachan)
* dev pods: first spike at a command to create dev pods (James Strachan)
* minishift: add jx create cluster minishift (James Strachan)
* create cluster minikube: Add kubernetes-version flag to minikube (yahavi)
* micro: lets add a `jx create micro` wizard (James Strachan) [#679](https://github.com/jenkins-x/jx/issues/679) 
* git: if adding a new server/token save the ConfigMap for jenkins (James Strachan)
* git: add support for adding bitbucket servers (James Strachan)
* git: add support for adding GHE servers (James Strachan)
* git: adding new git tokens should lazily update jenkins (James Strachan)
* addon: create addon for Ambassador (James Strachan) [#640](https://github.com/jenkins-x/jx/issues/640) 
* added gitlab provider test, updated gitlab client to fork (Will Refvem)

### Bug Fixes

* devpod: add an optional suffix to ensure the pod name is unique (James Strachan) [#718](https://github.com/jenkins-x/jx/issues/718) 
* crash: avoid core dump if there is an error querying git (James Strachan) [#715](https://github.com/jenkins-x/jx/issues/715) 
* windows: avoid possible exception (James Strachan)
* bitbucket: fix pull requests APIs (yahavi)
* bitbucket: increase timeout length and polling frequency for verifying newly created forks and PRs (Will Refvem)
* gitlab: various fixes for gitlab (James Strachan)
* gitlab: lets use a nicer URL for generating access tokens (James Strachan)
* create git token: prompt for API token on `tryFindAPITokenFromBrowser` failure (yahavi)
* minikube: lets speed up promotion if no webhooks are available (James Strachan) [#687](https://github.com/jenkins-x/jx/issues/687) 
* preview: lets only log a warning if commenting on a PR fails (James Strachan) [#696](https://github.com/jenkins-x/jx/issues/696) 
* minishift: add installer for minishift & oc binaries (James Strachan) [#689](https://github.com/jenkins-x/jx/issues/689) 
* default-environments: lets use a flag which is false by default (James Strachan) [#692](https://github.com/jenkins-x/jx/issues/692) 
* minikube: disable docker-machine-driver-hyperkit installer (James Strachan)
* minikube: use correct CLI for latest minikube (James Strachan)
* openshift: more fixes so jenkins can do builds on OpenShift (James Strachan)
* jx upgrade plaftform: allow helm values to be passed in (James Strachan)
* import: lets override old Jenkinsfiles by default (James Strachan) [#676](https://github.com/jenkins-x/jx/issues/676) 
* import: lets override old Jenkinsfiles by default (James Strachan)
* import: lets add a default slow poll if webhooks fail (James Strachan) [#674](https://github.com/jenkins-x/jx/issues/674) 
* openshift: improvements for OpenShift / MiniShift support (James Strachan) [#435](https://github.com/jenkins-x/jx/issues/435) 
* import: don't fail if we cannot draft create (James Strachan) [#492](https://github.com/jenkins-x/jx/issues/492) 
* create cluster minikube: avoid installing driver 'none' (yahavi)
* bitbucket: wait a reasonable amount of time for forks and PRs to be ready (Will Refvem)
* bitbucket: use a better branch pattern for bitbucket (James Strachan) [#668](https://github.com/jenkins-x/jx/issues/668) 
* bitbucket: use https clone URLs on created repos (James Strachan) [#663](https://github.com/jenkins-x/jx/issues/663) 
* bitbucket: better importing projects for bitbucket (James Strachan) [#662](https://github.com/jenkins-x/jx/issues/662) 
* create git token: lets properly update GitService if required (James Strachan) [#660](https://github.com/jenkins-x/jx/issues/660) 
* lile: lets prompt the user for a project name (James Strachan) [#657](https://github.com/jenkins-x/jx/issues/657) 
* create cluster gke: handle max nodes properly (James Strachan) [#656](https://github.com/jenkins-x/jx/issues/656) 
* lile: lets install lile if its not already (James Strachan) [#655](https://github.com/jenkins-x/jx/issues/655) 
* git: add a little sleep before we restart jenkins (James Strachan)
* git: for GHE ensure we use the API endpoint (James Strachan)
* import: allow gradle projects to be imported easier (James Strachan)
* import: lets patch helm so we can recreate charts (James Strachan)
* import: lets recreate the Jenkinsfile if its removed (James Strachan)
* AWS: lets add a retry around creating the cluster role (James Strachan)
* import: create the pipeline secret on install (James Strachan)
* import: create a credential if specified explicitly (James Strachan)
* jx step git credentials: we should create the parent directories (James Strachan)
* jx step credentials: handle http and https better (James Strachan)
* import: lets properly setup servers/auth/secrets on the fly (James Strachan) [#622](https://github.com/jenkins-x/jx/issues/622) 
* import: better error message (James Strachan) [#632](https://github.com/jenkins-x/jx/issues/632) 
* jx create spring: lets pass along a User Agent header (James Strachan)
* jx get token: lets add helper methods to view users with tokens (James Strachan)
* addons: add helper methods and CLI commands for addon auth (James Strachan)
* project history: fix the calculations on totals versus incrementals (James Strachan)
* issues: filter out PRs when searching for issues (James Strachan)
* issues: filter on closed status just in case (James Strachan)
* bitbucket: change name of test router (Will Refvem)

### Documentation

* add details on openshift (James Strachan)
* lile: add note on where to run this command (James Strachan)
* replace 'CI / CD' with 'CI/CD' (James Strachan)

### Reverts

* previous patch (James Strachan)

### Chores

* formatting (James Strachan)
* import: lets make the import tests work without k8s access (James Strachan)
* import: add an import test for java (James Strachan)
* formatting (James Strachan)
* vendoring (James Strachan)
* switched to our fork of helm for the mkdir bugfix (James Strachan)
* vendoring: upgrade to latest pack fork (James Strachan)
* vendoring: include the latest golang-jenkins fixes (James Strachan)
* refactor: to move more code into a git/helm specific file (James Strachan)
* moah tests for ProjectHistory (James Strachan)
* add more tests around ProjectHistory (James Strachan)
* vendoring (Will Refvem)

### Other Changes

These commits did not use [Conventional Commits](https://conventionalcommits.org/) formatted messages:

* GitHub is pointers all the way down (#736) (Keith Zantow)
* Merge pull request #733 from hekonsek/minikube-vm-driver-help2 (James Strachan)
* Merge branch 'master' into minikube-vm-driver-help2 (Henryk Konsek)
* Added missing VM drivers list to cmd help. (Henryk Konsek)
* Merge pull request #727 from hekonsek/kvm-install-info (James Rawlings)
* Merge branch 'master' into kvm-install-info (James Strachan)
* Merge pull request #729 from jstrachan/malarkey (James Strachan)
* Merge pull request #728 from kzantow/moar-defensive-author-info (James Rawlings)
* Fix preview author (Keith Zantow)
* Merge pull request #724 from hekonsek/git_detection (James Strachan)
* Merge branch 'master' into git_detection (James Strachan)
* "jx promote" should detect if current directory is Git repository. (Henryk Konsek)
* Merge pull request #719 from kzantow/github-fetch-user-npd (James Rawlings)
* GitHub fetch user NPD (Keith Zantow)
* Merge pull request #712 from kzantow/add-default-version-option (James Strachan)
* Add standard --version option to print the binary version (Keith Zantow)
* Merge branch 'master' into master (James Strachan)
* Merge pull request #706 from kzantow/fix-preview-author (James Strachan)
* More defensive, remove log (Keith Zantow)
* Fix preview author (Keith Zantow)
* Merge pull request #701 from jstrachan/malarkey (James Strachan)
* Merge pull request #700 from kzantow/add-preview-info (James Strachan)
* Add more information for preview environments (Keith Zantow)
* Merge pull request #697 from jstrachan/malarkey (James Strachan)
* Merge pull request #693 from jstrachan/malarkey (James Strachan)
* Merge pull request #686 from jstrachan/malarkey (James Strachan)
* Merge pull request #677 from jstrachan/malarkey (James Strachan)
* Merge pull request #661 from jstrachan/malarkey (James Strachan)
* Merge pull request #654 from jstrachan/malarkey (James Strachan)
* Merge pull request #649 from jstrachan/malarkey (James Strachan)
* Merge pull request #646 from jstrachan/malarkey (James Strachan)
* Merge pull request #637 from jstrachan/malarkey (James Strachan)
* Merge pull request #624 from jstrachan/malarkey (James Strachan)
* Merge pull request #708 from wbrefvem/master (James Strachan)
* Merge pull request #721 from garethjevans/smaller-nodes (James Strachan)
* Merge branch 'master' into smaller-nodes (James Strachan)
* Formatting (Gareth Evans)
* Added ability to use smaller nodes in GKE (Gareth Evans)
* Selecting KVM provider for minikube should not throw error. (Henryk Konsek)
* Merge pull request #732 from hekonsek/kvm2-support (James Strachan)
* Added KVM2 support to minikube. (Henryk Konsek)

### Issues

* [#718](https://github.com/jenkins-x/jx/issues/718) add a `jx dev go|maven|node` command ([rawlingsj](https://github.com/rawlingsj))
* [#726](https://github.com/jenkins-x/jx/issues/726) add a `jx sync` command to easily sync up a folder to a remote pod or DevPod ([jstrachan](https://github.com/jstrachan))
* [#715](https://github.com/jenkins-x/jx/issues/715) Panic during jx create spring ([tdcox](https://github.com/tdcox))
* [#687](https://github.com/jenkins-x/jx/issues/687) When no webhooks can we speed up promotion? ([jstrachan](https://github.com/jstrachan))
* [#696](https://github.com/jenkins-x/jx/issues/696) avoid failing a `jx preview` if the `BRANCH_NAME` does not contain text `PR-1234` ([jstrachan](https://github.com/jstrachan))
* [#689](https://github.com/jenkins-x/jx/issues/689) create command: jx create cluster minishift ([jstrachan](https://github.com/jstrachan))
* [#692](https://github.com/jenkins-x/jx/issues/692) --default-environments false gets ignored on AWS ([sauravdevops](https://github.com/sauravdevops))
* [#679](https://github.com/jenkins-x/jx/issues/679) add a wizard for creating new microservices via the micro framework ([jstrachan](https://github.com/jstrachan))
* [#676](https://github.com/jenkins-x/jx/issues/676) new imported projects should default to using the latest greatest Jenkinsfile ([jstrachan](https://github.com/jstrachan))
* [#674](https://github.com/jenkins-x/jx/issues/674) if webhooks are not enabled lets default to polling for branch events? ([jstrachan](https://github.com/jstrachan))
* [#435](https://github.com/jenkins-x/jx/issues/435) verify Jenkins X works on OpenShift ([jstrachan](https://github.com/jstrachan))
* [#492](https://github.com/jenkins-x/jx/issues/492) Don’t fail to import if no chart is found ([jstrachan](https://github.com/jstrachan))
* [#668](https://github.com/jenkins-x/jx/issues/668) bitbucket repos should use `.*` for branch pattern so that it can find PRs ([jstrachan](https://github.com/jstrachan))
* [#663](https://github.com/jenkins-x/jx/issues/663) bitbucket clone URL uses ssh rather than https ([jstrachan](https://github.com/jstrachan))
* [#662](https://github.com/jenkins-x/jx/issues/662) importing projects on bitbucket need better `config.xml` format ([jstrachan](https://github.com/jstrachan))
* [#660](https://github.com/jenkins-x/jx/issues/660) adding git tokens can fail if the `GitService` already exists ([jstrachan](https://github.com/jstrachan))
* [#657](https://github.com/jenkins-x/jx/issues/657) lile should default to prompting the user for a new name/folder to create the project inside ([jstrachan](https://github.com/jstrachan))
* [#656](https://github.com/jenkins-x/jx/issues/656) jx create cluster gke does not properly handle `--max-num-nodes` ([jstrachan](https://github.com/jstrachan))
* [#655](https://github.com/jenkins-x/jx/issues/655) lets automatically install `lile` if the user types `jx create lile` and its not already installed ([jstrachan](https://github.com/jstrachan))
* [#640](https://github.com/jenkins-x/jx/issues/640) create an addon for Ambassador ([jstrachan](https://github.com/jstrachan))
* [#622](https://github.com/jenkins-x/jx/issues/622) jx import should query the new pipeline git secrets to find the correct credential ([jstrachan](https://github.com/jstrachan))
* [#632](https://github.com/jenkins-x/jx/issues/632) jx create quickstart  -l go leads to error: services "jenkins" not found ([derryx](https://github.com/derryx))
* [#635](https://github.com/jenkins-x/jx/issues/635) golang quickstart fails as GIT_PROVIDER contains full git server URL ([rawlingsj](https://github.com/rawlingsj))

### Pull Requests

* [#736](https://github.com/jenkins-x/jx/pull/736) GitHub is pointers all the way down ([kzantow](https://github.com/kzantow))
* [#734](https://github.com/jenkins-x/jx/pull/734) fix:  select correct app server on import for liberty/spring boot pro… ([rajdavies](https://github.com/rajdavies))
* [#733](https://github.com/jenkins-x/jx/pull/733) Added missing VM drivers list to cmd help ([hekonsek](https://github.com/hekonsek))
* [#727](https://github.com/jenkins-x/jx/pull/727) Selecting KVM provider for minikube should not throw error ([hekonsek](https://github.com/hekonsek))
* [#729](https://github.com/jenkins-x/jx/pull/729) add support for DevPods and sync via ksync ([jstrachan](https://github.com/jstrachan))
* [#728](https://github.com/jenkins-x/jx/pull/728) More defensive pull request author checking ([kzantow](https://github.com/kzantow))
* [#724](https://github.com/jenkins-x/jx/pull/724) "jx promote" should detect if current directory is Git repository ([hekonsek](https://github.com/hekonsek))
* [#719](https://github.com/jenkins-x/jx/pull/719) GitHub fetch user NPD ([kzantow](https://github.com/kzantow))
* [#716](https://github.com/jenkins-x/jx/pull/716) fix:(crash) avoid core dump if there is an error querying git ([jstrachan](https://github.com/jstrachan))
* [#714](https://github.com/jenkins-x/jx/pull/714) fix:(windows) avoid possible exception ([jstrachan](https://github.com/jstrachan))
* [#713](https://github.com/jenkins-x/jx/pull/713) fix(create cluster aws): make sure wizard uses number of nodes if overridden during survey ([rawlingsj](https://github.com/rawlingsj))
* [#712](https://github.com/jenkins-x/jx/pull/712) Add standard --version option to print the binary version ([kzantow](https://github.com/kzantow))
* [#709](https://github.com/jenkins-x/jx/pull/709) fix:(bitbucket) fix pull requests APIs ([yahavi](https://github.com/yahavi))
* [#707](https://github.com/jenkins-x/jx/pull/707) Revert "fix:(minikube) lets speed up promotion if no webhooks are available" ([rawlingsj](https://github.com/rawlingsj))
* [#706](https://github.com/jenkins-x/jx/pull/706) Fix preview author ([kzantow](https://github.com/kzantow))
* [#702](https://github.com/jenkins-x/jx/pull/702) fix:(bitbucket) increase timeout length and polling frequency for ver… ([wbrefvem](https://github.com/wbrefvem))
* [#701](https://github.com/jenkins-x/jx/pull/701) gitlab fixes ([jstrachan](https://github.com/jstrachan))
* [#700](https://github.com/jenkins-x/jx/pull/700) Add more information for preview environments ([kzantow](https://github.com/kzantow))
* [#698](https://github.com/jenkins-x/jx/pull/698) fix:(create git token) prompt for API token on `tryFindAPITokenFromBr… ([yahavi](https://github.com/yahavi))
* [#697](https://github.com/jenkins-x/jx/pull/697) fixes for minikube and previews ([jstrachan](https://github.com/jstrachan))
* [#693](https://github.com/jenkins-x/jx/pull/693) fixes for minishift ([jstrachan](https://github.com/jstrachan))
* [#691](https://github.com/jenkins-x/jx/pull/691) feat:(create cluster minikube) Add kubernetes-version flag ([yahavi](https://github.com/yahavi))
* [#686](https://github.com/jenkins-x/jx/pull/686) added micro command and lots of OpenShift fixes ([jstrachan](https://github.com/jstrachan))
* [#677](https://github.com/jenkins-x/jx/pull/677) improve imports to use latest Jenkinsfile and work around lack of webhooks ([jstrachan](https://github.com/jstrachan))
* [#675](https://github.com/jenkins-x/jx/pull/675) fix:(create cluster minikube) avoid installing driver 'none' ([yahavi](https://github.com/yahavi))
* [#672](https://github.com/jenkins-x/jx/pull/672) feat: flags to define pack to use, list packs and detection of POM fl… ([rajdavies](https://github.com/rajdavies))
* [#671](https://github.com/jenkins-x/jx/pull/671) fix:(bitbucket) wait a reasonable amount of time for forks and PRs to be ready ([wbrefvem](https://github.com/wbrefvem))
* [#661](https://github.com/jenkins-x/jx/pull/661) various fixes ([jstrachan](https://github.com/jstrachan))
* [#654](https://github.com/jenkins-x/jx/pull/654) lets support dynamically adding git servers ([jstrachan](https://github.com/jstrachan))
* [#649](https://github.com/jenkins-x/jx/pull/649) fixes for import ([jstrachan](https://github.com/jstrachan))
* [#646](https://github.com/jenkins-x/jx/pull/646) use latest golang-jenkins ([jstrachan](https://github.com/jstrachan))
* [#641](https://github.com/jenkins-x/jx/pull/641) fix:(jx step git credentials) we should create the parent directories ([jstrachan](https://github.com/jstrachan))
* [#639](https://github.com/jenkins-x/jx/pull/639) fix:(import) lets properly setup servers/auth/secrets on the fly ([jstrachan](https://github.com/jstrachan))
* [#637](https://github.com/jenkins-x/jx/pull/637) add user agent for spring boot  ([jstrachan](https://github.com/jstrachan))
* [#636](https://github.com/jenkins-x/jx/pull/636) fix(quickstarts): use the git provider hostname rather than git serve… ([rawlingsj](https://github.com/rawlingsj))
* [#624](https://github.com/jenkins-x/jx/pull/624) add helpe methods & CLI for addon Auth ([jstrachan](https://github.com/jstrachan))
* [#708](https://github.com/jenkins-x/jx/pull/708) updates to gitlab tests, vendoring ([wbrefvem](https://github.com/wbrefvem))
* [#723](https://github.com/jenkins-x/jx/pull/723) feat(cve): first spike at integration with Anchore ([rawlingsj](https://github.com/rawlingsj))
* [#721](https://github.com/jenkins-x/jx/pull/721) Added ability to use g1-small nodes in GKE ([garethjevans](https://github.com/garethjevans))
* [#731](https://github.com/jenkins-x/jx/pull/731)  feat(cve): jx get cve --environment foo ([rawlingsj](https://github.com/rawlingsj))
* [#732](https://github.com/jenkins-x/jx/pull/732) Added KVM2 support to minikube ([hekonsek](https://github.com/hekonsek))

## Charts



## Downloads


<canvas id="downloadsChart" width="400" height="200"></canvas>
<script type="text/javascript" src="/news/changes-27-april-2018/downloads.js"></script>
</canvas>


This blog post was generated via the [jx step blog](/commands/jx_step_blog/) command from [Jenkins X](https://jenkins-x.io/).
