---
title: "Merry Jenkins X Mas!"
date: 2018-12-20T15:07:24Z
description: "Merry Jenkins X Mas!"
categories: [blog]
keywords: []
slug: "changes-20-december-2018"
aliases: []
author: jenkins-x-bot
---

As we head towards the holiday season I wanted to call out some recent events in the Jenkins X community. Its been an amazing year and we're looking forward to celebrating Jenkins X birthday in January!

## Webinar on Serverless Jenkins and Jenkins X

Yesterday [James Strachan](https://twitter.com/jstrachan) and [James Rawlings](https://twitter.com/jdrawlings/) gave a webinar on [Servlerless Jenkins with Jenkins X](https://www.cloudbees.com/resource/webinar-recording/serverless-jenkins-jenkins-x). You should be able to watch the recording (registration required).

We had hundreds of folks who asked some really great questions - thanks to all those who attended! A few of the highlighted questions:

*  Jenkins X has git support for multiple git providers like GitHub, GitHub Enterprise, BitBucket Cloud, BitBucket Server and GitLab when using static Jenkins masters - however currently [Serverless Jenkins](/news/serverless-jenkins/) only supports GitHub. We're [working on it](https://github.com/kubernetes/test-infra/issues/10146) and hope to add more git providers soon!
* Here is how you can [avoid Tiller when using helm with Jenkins X](/news/helm-without-tiller/) 
 
## KubeCon was awesome

A bunch of us from [CloudBees](https://www.cloudbees.com/) had a booth at [KubeCon Seattle](https://events.linuxfoundation.org/events/kubecon-cloudnativecon-north-america-2018/) where we spent lots of time chatting with folks on Jenkins X, Serverless Jenkins and the new [commercial support for Jenkins X](https://www.cloudbees.com/products/jenkins-x-support). 

There was a huge amount of excitement in both automating CI/CD for kubernetes and making Jenkins serverless. Thanks to all those who popped by for a chat!

<img src="/news/changes-20-december-2018/xmen.jpg">

Also [Carlos](https://twitter.com/csanchez) did a great talk and live demo on [Jenkins X: Continuous Delivery for Kubernetes](https://www.youtube.com/watch?v=IDEa8seAzVc&feature=youtu.be)  

<img src="/news/changes-20-december-2018/kubecon.jpg">

## Office Hours

We had an [Office Hours](/community/#office-hours) last week at [KubeCon Seattle](https://events.linuxfoundation.org/events/kubecon-cloudnativecon-north-america-2018/), you can check out the [notes here](https://docs.google.com/document/d/1wHdBlZAN-ndPELuBoM5HBnYiQLvcz92-euXne2mKOEI/edit#heading=h.21iu8gndhf9c) and [watch the video here](https://www.youtube.com/watch?v=TF_Mxq5sDsI)

Please join the next one in January! Or if you can't wait [just jump onto slack](/community/#slack)

## Metrics

This blog outlines the changes on the project from November 26 2018 to December 20 2018.

| Metrics     | Changes | Total |
| :---------- | -------:| -----:|
| Downloads | **20274** | **120123** |
| Stars | **95** | **1853** |
| New Committers | **26** | **210** |
| New Contributors | **29** | **260** |
| #jenkins-x-dev members | **47** | **498** |
| #jenkins-x-user members | **105** | **1051** |
| Issues Closed | **98** | **934** |
| Pull Requests Merged | **113** | **1953** |
| Commits | **515** | **7793** |


[View Charts](#charts)



## New Committers

Welcome to our new committers!

* <a href='https://github.com/aweis89' title=''><img class='avatar' src='https://avatars0.githubusercontent.com/u/5186956?v=4' height='32' width='32'> aweis89</a>
* <a href='https://github.com/martijnburger' title=''><img class='avatar' src='https://avatars0.githubusercontent.com/u/6529303?v=4' height='32' width='32'> martijnburger</a>
* <a href='https://github.com/runzexia' title=''><img class='avatar' src='https://avatars3.githubusercontent.com/u/31230341?v=4' height='32' width='32'> runzexia</a>
* <a href='https://github.com/salbertson' title=''><img class='avatar' src='https://avatars2.githubusercontent.com/u/154463?v=4' height='32' width='32'> salbertson</a>
* <a href='https://github.com/yuwzho' title=''><img class='avatar' src='https://avatars0.githubusercontent.com/u/14213176?v=4' height='32' width='32'> yuwzho</a>


## New Contributors

Welcome to our new contributors!

* <a href='https://github.com/aweis89' title=''><img class='avatar' src='https://avatars0.githubusercontent.com/u/5186956?v=4' height='32' width='32'> aweis89</a>
* <a href='https://github.com/g-foster' title=''><img class='avatar' src='https://avatars1.githubusercontent.com/u/24317078?v=4' height='32' width='32'> g-foster</a>
* <a href='https://github.com/martijnburger' title=''><img class='avatar' src='https://avatars0.githubusercontent.com/u/6529303?v=4' height='32' width='32'> martijnburger</a>
* <a href='https://github.com/onuryartasi' title=''><img class='avatar' src='https://avatars0.githubusercontent.com/u/16039143?v=4' height='32' width='32'> onuryartasi</a>
* <a href='https://github.com/runzexia' title=''><img class='avatar' src='https://avatars3.githubusercontent.com/u/31230341?v=4' height='32' width='32'> runzexia</a>
* <a href='https://github.com/salbertson' title=''><img class='avatar' src='https://avatars2.githubusercontent.com/u/154463?v=4' height='32' width='32'> salbertson</a>
* <a href='https://github.com/yuwzho' title=''><img class='avatar' src='https://avatars0.githubusercontent.com/u/14213176?v=4' height='32' width='32'> yuwzho</a>
* <a href='https://github.com/zrlay' title=''><img class='avatar' src='https://avatars3.githubusercontent.com/u/6275801?v=4' height='32' width='32'> zrlay</a>


### New Features

* add git provider user to User (Pete Muir)
* added the addon version to 'jx get addons' (Gareth Evans)
* Add an app CRD (Pete Muir)
* enable plugin validation & cleanup (Pete Muir)
* distribute plugins via apps (Pete Muir)
* add binary plugins (Pete Muir)
* store prow/serverless build logs in github pages (James Strachan)
* add `jx step helm delete` (James Strachan)
* use brew if available to install helm (Gareth Evans)
* initial support for chart repo username/password (Pete Muir)
* add a top level command to create new projects (James Strachan)
* add reviewers to pull request info (Pete Muir)

### Bug Fixes

* add verbose support to `jx create cluster aks` (James Strachan)
* handle creating a jenkins client inside pods (James Strachan)
* avoid creating CRDs in the gc job (James Strachan)
* `jx sync` now runs first time (Pete Muir)
* more aggressively push stuff to PipelineActivity (Pete Muir)
* removed additional 'Needs more' in jx status output (Gareth Evans)
* lets not fail if no secrets.yaml or no vault (James Strachan)
* lazily create the git credentials for build controller (James Strachan)
* for prow configuration and missing yaml files (James Strachan)
* add support or a 'default' classifier (James Strachan)
* lets use the teams StorageLocation settings in `jx step collect` (James Strachan)
* removed <>& from the list of allowed symbols in password generation (Gareth Evans)
* allow git credentials to be setup on the controller (James Strachan)
* disable jenkins if using prow and enable the build controller (James Strachan)
* Create API token on promote if needed (msvticket)
* Add validation to check if user is trying to configure DNS domain (mike cirioli)
* log message update (Gareth Evans)
* Making a few more commands possible to run w/o being cluster admin (msvticket)
* add a command to create knative build templates from the pipelines (James Strachan)
* gerrit: Remove some unnecessary logging in tests (Will Refvem)
* Import from non dev team namespace (msvticket)
* add a team setting for storage locations (James Strachan)
* team controller should only watch the admin namespace for new teams (James Strachan)
* pass the repo to fetch (Pete Muir)
* add retry around updating the PipelineActivity (James Strachan)
* avoid unnecessary warning if we have upper case branches (James Strachan)
* allow `jx step apply` to default the namespace i its not specified (James Strachan)
* don’t swallow errors on gitops (Pete Muir)
* register the plugin CRD (Pete Muir)
* lets use no tiller by default in the team controller (James Strachan)
* properly setup git in the build controller pod (James Strachan)
* if no options specified lets reuse the arguments (James Strachan)
* default build controller to batch mode (James Strachan)
* using correct env.Name when creating environments in prow (Gareth Evans)
* Provides a more reliable way to get the previous git tag sha, even if (mike cirioli)
* reduce the number of allowed symbols for passwords to be safer (Gareth Evans)
* validating git at the start of the create terraform command (Gareth Evans)
* regenerate the factory mocks after rebase (Cosmin Cojocar)
* properly use configured team storage git repo (James Strachan)
* silly boolean logic bug ;) (James Strachan)
* ensure git user + email is setup (James Strachan)
* lets ensure we detect termination of knative builds (James Strachan)
* correctly checking for error message after installing helm (Gareth Evans)
* `jx add app` error if no repo defined (Pete Muir)
* gitter: Add new mocks (Will Refvem)
* gitter: Move ToGitLabels out of Gitter interface (Will Refvem)
* gitter: Remove IsFork's dependency on abstract types (Will Refvem)
* git: Fold GitRepositoryInfo into GitRepository (Will Refvem)
* removed additional 'Needs more' in jx status output (Gareth Evans)
* if there is no team setting for classifier, don't use default, but create a new one instead (Vincent Latombe)
* handle BUILD_ID and BUILD_NUMBER (Pete Muir)
* hide the error about missing apt-get/yum (Pete Muir)
* only update the build logs URL if its not empty (James Strachan)
* only load managed plugins if CRD available (Pete Muir)
* ensure the namespace exists when creating the vault SA (James Strachan)

### Code Refactoring

* remove the jx from the option name and renamted the related variables and function (Cosmin Cojocar)
* extract the check for cluster role binding from create cluser role binding methods (Cosmin Cojocar)

### Documentation

* polish docs (James Strachan) [#2545](https://github.com/jenkins-x/jx/issues/2545) 
* improve help to mention 'default' classifier (James Strachan)
* polish (James Strachan)

### Chores

* improve the GitService CRD in `kubectl get` on k8s 1.11 or later (James Strachan)
* ignore some system & tmp build files. (Mark Wynn-Mackenzie)
* remove extraValues.yaml that got accidentally committed. (Mark Wynn-Mackenzie)
* refactor to use better name (James Strachan)
* add godoc comment to fix Hund warning (Cosmin Cojocar)
* fix up new PreviewOptions unit test for latest master refactoring. (Mark Wynn-Mackenzie)
* fmt (Gareth Evans)
* fixes for houndci (Gareth Evans)
* fix hound (James Strachan)
* migrate the `jx step create build` to reuse the knative module (James Strachan)
* Removed redundant code (Steve Arch)
* add DEBUG flag to Makefile (Pete Muir)
* expose results from `jx get app` in a better structure (James Strachan)
* fix typo (Cosmin Cojocar)
* wrap the error with a message (Cosmin Cojocar)
* remove the function which fetch the secrets from vault if the secrets.yaml do no exist (Cosmin Cojocar)
* lets use a more specific path in case we share the git repo (James Strachan)
* tone down logging (James Strachan)
* tone down the noise on description of PipelineActivity (James Strachan)
* fix hound (James Strachan)
* add -n alias to `jx step helm apply` to match `.. install` (James Strachan)
* add verbose logging mode (James Strachan)

### Other Changes

These commits did not use [Conventional Commits](https://conventionalcommits.org/) formatted messages:

* Merge pull request #2547 from jstrachan/fixes7 (jenkins-x-bot)
* Merge pull request #2540 from markawm/remove-extravalues-files (jenkins-x-bot)
* Merge pull request #2511 from hekonsek/eks_dead_stacks (jenkins-x-bot)
* Merge branch 'master' into eks_dead_stacks (Cosmin Cojocar)
* Merge branch 'master' into helm-init (Gareth Evans)
* Merge branch 'master' into helm-init (Cosmin Cojocar)
* Merge pull request #2497 from aweis89/master (jenkins-x-bot)
* Merge remote-tracking branch 'upstream/master' (Aharon Weisberg)
* Merge branch 'master' into users (Gareth Evans)
* Merge branch 'master' into compliance-improve-msg (Gareth Evans)
* Merge branch 'master' into master (Gareth Evans)
* Merge branch 'master' into status (Gareth Evans)
* Merge pull request #2463 from runzexia/fix-uninstall (jenkins-x-bot)
* Merge branch 'master' into fix-uninstall (runzexia)
* Merge branch 'master' into missing-newline (Gareth Evans)
* Merge pull request #2454 from agentgonzo/2446-followup (jenkins-x-bot)
* Merge remote-tracking branch 'origin/master' into password-fix (Gareth Evans)
* Merge pull request #2422 from jstrachan/fixes5 (jenkins-x-bot)
* Merge pull request #2418 from rawlingsj/master (jenkins-x-bot)
* workaround for promote getting stuck on prow installs see #2410 (rawlingsj)
* fix(#2381) Do not panic when creating teams (James Nord)
* Merge branch 'master' into brew-install-fail (Cosmin Cojocar)
* Merge pull request #2369 from hekonsek/helm-install-errors (jenkins-x-bot)
* Merge branch 'master' into helm-install-errors (Cosmin Cojocar)
* Fixed Helm installation error handling. (Henryk Konsek)
* Merge pull request #2359 from wenzlaff/bitbucket-pr-comment (jenkins-x-bot)
* Merge branch 'master' into bitbucket-pr-comment (wenzlaff)
* Merge pull request #2276 from agentgonzo/vault-install (jenkins-x-bot)
* Merge branch 'master' into vault-install (Cosmin Cojocar)
* Merge branch 'master' into fix-parallel-mocks (Steve Arch)
* Merge pull request #2347 from jenkins-x/DNS-records (jenkins-x-bot)
* Merge branch 'master' into DNS-records (Cosmin Cojocar)
* Use an A Record rather than CNAME (Steve Arch) [#2300](https://github.com/jenkins-x/jx/issues/2300) 
* Merge pull request #2345 from rawlingsj/login (jenkins-x-bot)
* fix(login) let's make sure users that haven't installed or created the cluster have the base set of binaries installed fixes #2300 (rawlingsj)
* Merge branch 'master' into fix-validate_domain_name (mikecirioli)
* Merge branch 'master' into fix-validate_domain_name (Cosmin Cojocar)
* Merge pull request #2337 from daveconde/openshift-fix-jenkins-username (jenkins-x-bot)
* Merge branch 'master' into openshift-fix-jenkins-username (David Conde)
* Use a service account based bearer token for a better Openshift experience (David Conde)
* Merge branch 'master' into git_api_token_promote (Cosmin Cojocar)
* Merge branch 'master' into passwords (Cosmin Cojocar)
* fix hound complaints (mike cirioli)
* fix wording (mike cirioli)
* fix type (mike cirioli)
* Moved validator && tests to util package, generified error message (mike cirioli)
* Merge pull request #2338 from garethjevans/deps (jenkins-x-bot)
* Merge remote-tracking branch 'origin/master' into deps (Gareth Evans)
* Merge pull request #2319 from markawm/PLAT-165 (jenkins-x-bot)
* Merge branch 'master' into PLAT-165 (Cosmin Cojocar)
* Merge remote-tracking branch 'upstream/master' into PLAT-165 (Mark Wynn-Mackenzie)
* Refactor for slightly more readable test. (Mark Wynn-Mackenzie)
* Merge branch 'refactor-helm' into PLAT-165 (Mark Wynn-Mackenzie)
* Tidy up the test, add some more validations. (Mark Wynn-Mackenzie)
* Use factory to create git provider (Mark Wynn-Mackenzie)
* remove commented out code. (Mark Wynn-Mackenzie)
* Merge branch 'refactor-helm' into PLAT-165 (Mark Wynn-Mackenzie)
* WIP (Mark Wynn-Mackenzie)
* Delete some generated crap i dont want. (Mark Wynn-Mackenzie)
* Get rid of duplicate helm_stuff impl. (Mark Wynn-Mackenzie)
* Merge branch 'refactor-helm' into PLAT-165 (Mark Wynn-Mackenzie)
* Fix helmbinary initialisation. (Mark Wynn-Mackenzie)
* Refactor Helmer creation out of CommonOptions. (Mark Wynn-Mackenzie)
* Add unit test for preview, regenerate mocks/matchers. (Mark Wynn-Mackenzie)
* Merge branch 'master' into deps (Cosmin Cojocar)
* feat(install) added command to install additional dependencies (Gareth Evans)
* Merge remote-tracking branch 'origin/master' into deps (Gareth Evans)
* Merge branch 'master' into skip_register_crds (Cosmin Cojocar)
* Merge branch 'master' into skip_register_crds (Mårten Svantesson)
* Merge branch 'master' into get-pipeline-prow (Antonio Muniz)
* Merge branch 'master' into get-pipeline-prow (Cosmin Cojocar)
* Merge branch 'master' into fix-parallel-mocks (Cosmin Cojocar)
* Merge branch 'master' into master (Cosmin Cojocar)
* Merge branch 'master' into vault-install (Cosmin Cojocar)
* Simplified naming (Steve Arch)
* refactored tests were erroneously reading gitAuth from the filesystem (Steve Arch)
* Save the config in the authConfigService after loading. (Steve Arch)
* Refactored AuthConfigService to allow for a new vault-based ConfigService (Steve Arch)
* extracted an interface for AuthConfigService (Steve Arch)
* Merge pull request #1958 from hekonsek/import-logging (jenkins-x-bot)
* Merge branch 'master' into import-logging (Cosmin Cojocar)
* Fixed broken integration test. (Henryk Konsek)
* Merge pull request #2336 from Vlatombe/update_webhook_single_repo (jenkins-x-bot)
* Merge branch 'master' into update_webhook_single_repo (Cosmin Cojocar)
* Merge branch 'master' into update_webhook_single_repo (Vincent Latombe)
* Fix hound review (Vincent Latombe)
* Add a parameter to update webhooks for a single repo in an org (Vincent Latombe)
* added Bitbucket Server PR comment support (wenzlaff)
* Merge pull request #2360 from salbertson/patch-1 (jenkins-x-bot)
* Add a "Reviewed by Hound" badge (Scott Albertson)
* Merge pull request #2368 from hekonsek/eksctl-0-1-11 (jenkins-x-bot)
* Merge branch 'master' into eksctl-0-1-11 (Cosmin Cojocar)
* Merge branch 'master' into upgrade-ingress-without-jx-installed (Cosmin Cojocar)
* Upgraded eksctl version. (Henryk Konsek)
* Merge pull request #2366 from davidcurrie/create-env-panic (jenkins-x-bot)
* Merge branch 'master' into create-env-panic (Cosmin Cojocar)
* Avoid panic on failed repo creation (David Currie)
* Merge pull request #2390 from runzexia/get-test-class (jenkins-x-bot)
* Merge pull request #2335 from yuwzho/yuwzho-aks (jenkins-x-bot)
* Merge branch 'master' into yuwzho-aks (Cosmin Cojocar)
* Update aks_test.go (Yuwei Zhou)
* Merge branch 'master' into yuwzho-aks (Cosmin Cojocar)
* remove quote (yuwzho)
* fix lint (yuwzho)
* Merge branch 'master' into yuwzho-aks (yuwzho)
* make cli as a struct (yuwzho)
* add test (yuwzho)
* change to util.Command (yuwzho)
* Merge branch 'master' into yuwzho-aks (yuwzho)
* add comment (yuwzho)
* Merge branch 'master' into yuwzho-aks (Yuwei Zhou)
* fix lint (yuwzho)
* support aks (yuwzho)
* assign acr (yuwzho)
* change typo (yuwzho)
* fix lint (yuwzho)
* Merge pull request #2363 from agentgonzo/vault-install-secrets-yaml (jenkins-x-bot)
* Installed vault CLI when calling `get vault-config` (Steve Arch)
* Merge pull request #2393 from jstrachan/fixes5 (jenkins-x-bot)
* Merge pull request #2446 from agentgonzo/2331-delete-app (jenkins-x-bot)
* Merge remote-tracking branch 'origin/master' into 2331-delete-app (Steve Arch)
* Merge pull request #2432 from agentgonzo/renameGetCLient (jenkins-x-bot)
* Merge remote-tracking branch 'origin/master' into git (Gareth Evans)
* Merge pull request #2439 from rawlingsj/master (jenkins-x-bot) [#2288](https://github.com/jenkins-x/jx/issues/2288) 
* fix(maven quickstarts) there is no prevoius commit on the first build so lets just skip the step fixes #2288 (rawlingsj) [#2438](https://github.com/jenkins-x/jx/issues/2438) 
* fix(build numbers) start pipeline should create prowjobs so we get next build numbers from tot fixes ##2438 (rawlingsj)
* Merge pull request #2453 from rawlingsj/master (jenkins-x-bot)
* Apparently missing newline in log message. (Jesse Glick)
* Merge pull request #2462 from jglick/yes-actually-implemented (jenkins-x-bot)
* Merge branch 'master' into yes-actually-implemented (Gareth Evans)
* Why would the help for `jx update webhooks` claim it is not implemented? (Jesse Glick)
* fix wrong code location (runzexia)
* To prevent redirect issues, use codeload.github.com api (Aharon Weisberg)
* Merge pull request #2476 from Vlatombe/fix_upgrade_extensions_repository (jenkins-x-bot)
* Fix jx upgrade extensions repository (Vincent Latombe)
* Changed istio outputDir to binDir for unzip method (Martijn Burger)
* Merge pull request #2478 from garethjevans/scopes (jenkins-x-bot)
* Merge branch 'master' into scopes (Gareth Evans)
* feat(gke) can now provide oauth scopes when creating gke cluster (Gareth Evans)
* Merge pull request #2487 from wbrefvem/master (jenkins-x-bot)
* Merge branch 'master' into master (Gareth Evans)
* format (Aharon Weisberg)
* adds apt-get support (Aharon Weisberg)
* Merge branch 'master' into fixes5 (Cosmin Cojocar)
* Merge pull request #2529 from hekonsek/create_env_batch_name (jenkins-x-bot)
* `jx create env` should not ask for name in batch mode. (Henryk Konsek)
* Merge pull request #2505 from hekonsek/eks_get_verbose (jenkins-x-bot)
* Merge branch 'master' into eks_get_verbose (Pete Muir)
* Merge branch 'master' into eks_get_verbose (Cosmin Cojocar)
* Added verbose flag to `eks get` command. (Henryk Konsek)
* Merge branch 'master' into no-lazy-crd (Gareth Evans)
* Merge branch 'master' into no-lazy-crd (Gareth Evans) [#2526](https://github.com/jenkins-x/jx/issues/2526) 
* Merge pull request #2518 from garethjevans/preemptible (jenkins-x-bot)
* Merge branch 'master' into preemptible (Gareth Evans)
* Merge branch 'master' into preemptible (Cosmin Cojocar)
* added ability to use preemptible vms in the node pool (Gareth Evans)
* Merge branch 'master' into eks_dead_stacks (Pete Muir)
* Merge branch 'master' into eks_dead_stacks (Cosmin Cojocar)
* EKS cluster creation should deal with rolled back stacks. (Henryk Konsek)
* Merge pull request #2538 from hekonsek/eks_1_1_12 (jenkins-x-bot)
* Upgraded eksctl version. (Henryk Konsek)
* Merge pull request #2533 from hekonsek/create_env_git_owner (jenkins-x-bot)
* Merge branch 'master' into create_env_git_owner (Gareth Evans)
* Added --git-owner flag to `create env` command. (Henryk Konsek)
* Merge pull request #2506 from pmuir/reviewers (jenkins-x-bot)
* Merge branch 'master' into reviewers (Pete Muir)
* Merge pull request #2536 from hekonsek/delete_eks_help_deletes (jenkins-x-bot)
* Changed "Delete" -> "Deletes" (Henryk Konsek)

### Issues

* [#2545](https://github.com/jenkins-x/jx/issues/2545) unknown flag: --verbose when used with `jx create cluster aks` ([zrlay](https://github.com/zrlay))
* [#2218](https://github.com/jenkins-x/jx/issues/2218) The jenkins-x-gc-activities pods start to fail and bring down Jenkins (still present) ([g-foster](https://github.com/g-foster))
* [#2496](https://github.com/jenkins-x/jx/issues/2496) Installation of bash completion fails on debian based images ([aweis89](https://github.com/aweis89))
* [#2410](https://github.com/jenkins-x/jx/issues/2410) prow quickstart release builds get stuck, auto promoting to staging  ([rawlingsj](https://github.com/rawlingsj))
* [#2381](https://github.com/jenkins-x/jx/issues/2381) error: Create a team problem ([onuryartasi](https://github.com/onuryartasi))
* [#2300](https://github.com/jenkins-x/jx/issues/2300) add a `--client` flag to `jx init` ([rawlingsj](https://github.com/rawlingsj))
* [#2288](https://github.com/jenkins-x/jx/issues/2288) First automated promotion to staging is failing  ([romainverduci](https://github.com/romainverduci))
* [#2438](https://github.com/jenkins-x/jx/issues/2438) `jx start pipeline` triggers builds that always have a BUILD_ID of 1 ([rawlingsj](https://github.com/rawlingsj))
* [#2427](https://github.com/jenkins-x/jx/issues/2427) `jx login` command should validate that `--url` contains a well formed url (scheme://host) ([mikecirioli](https://github.com/mikecirioli))
* [#2526](https://github.com/jenkins-x/jx/issues/2526) `jx start build` tries to lazily create a CRD which causes issues with reduced cluster roles ([rawlingsj](https://github.com/rawlingsj))

### Pull Requests

* [#2547](https://github.com/jenkins-x/jx/pull/2547) fixes for aks and git service ([jstrachan](https://github.com/jstrachan))
* [#2540](https://github.com/jenkins-x/jx/pull/2540) Remove extravalues files ([markawm](https://github.com/markawm))
* [#2541](https://github.com/jenkins-x/jx/pull/2541) fix: ensure the namespace exists when creating the vault SA ([jstrachan](https://github.com/jstrachan))
* [#2511](https://github.com/jenkins-x/jx/pull/2511) EKS cluster creation should deal with rolled back stacks ([hekonsek](https://github.com/hekonsek))
* [#2538](https://github.com/jenkins-x/jx/pull/2538) Upgraded eksctl version ([hekonsek](https://github.com/hekonsek))
* [#2537](https://github.com/jenkins-x/jx/pull/2537) fix: jenkins client creation inside pods ([jstrachan](https://github.com/jstrachan))
* [#2513](https://github.com/jenkins-x/jx/pull/2513) feat(install): store the amdin secrets in vault and to not print the admin password in logs if vault is enabled ([ccojocar](https://github.com/ccojocar))
* [#2505](https://github.com/jenkins-x/jx/pull/2505) Added verbose flag to `eks get` command ([hekonsek](https://github.com/hekonsek))
* [#2503](https://github.com/jenkins-x/jx/pull/2503) bug(delete team): Clear cached clients & namespaces when switching namespaces ([markawm](https://github.com/markawm))
* [#2529](https://github.com/jenkins-x/jx/pull/2529) `jx create env` should not ask for name in batch mode ([hekonsek](https://github.com/hekonsek))
* [#2525](https://github.com/jenkins-x/jx/pull/2525) bug(install): use client-only mode to install the Helm secrets plugin. ([markawm](https://github.com/markawm))
* [#2520](https://github.com/jenkins-x/jx/pull/2520) feat: add a top level command to create new projects ([jstrachan](https://github.com/jstrachan))
* [#2523](https://github.com/jenkins-x/jx/pull/2523) fix(Jenkinsfile): cleanup the old github credential from Jenkinsfile ([ccojocar](https://github.com/ccojocar))
* [#2510](https://github.com/jenkins-x/jx/pull/2510) Fix: `jx sync` now runs first time ([pmuir](https://github.com/pmuir))
* [#2508](https://github.com/jenkins-x/jx/pull/2508) fix: hide the error about missing apt-get/yum ([pmuir](https://github.com/pmuir))
* [#2502](https://github.com/jenkins-x/jx/pull/2502) fix(secrets): clean up the old jenkins-git-credentials secret ([ccojocar](https://github.com/ccojocar))
* [#2501](https://github.com/jenkins-x/jx/pull/2501) fix: handle BUILD_ID and BUILD_NUMBER ([pmuir](https://github.com/pmuir))
* [#2497](https://github.com/jenkins-x/jx/pull/2497) fixes(#2496) add support for bash completion on debian devpod images ([aweis89](https://github.com/aweis89))
* [#2499](https://github.com/jenkins-x/jx/pull/2499) fix: if there is no team setting for classifier, don't use default, b… ([Vlatombe](https://github.com/Vlatombe))
* [#2495](https://github.com/jenkins-x/jx/pull/2495) fix: more aggressively push stuff to PipelineActivity ([pmuir](https://github.com/pmuir))
* [#2493](https://github.com/jenkins-x/jx/pull/2493) feat: add git provider user to User ([pmuir](https://github.com/pmuir))
* [#2487](https://github.com/jenkins-x/jx/pull/2487) Some git provider refactoring ([wbrefvem](https://github.com/wbrefvem))
* [#2481](https://github.com/jenkins-x/jx/pull/2481) fix(compliance): print a more user friendly message in the status command when no compliance is found ([ccojocar](https://github.com/ccojocar))
* [#2486](https://github.com/jenkins-x/jx/pull/2486) fix(istio-addon): changed directory that istio is unziped in from outputDir to binDir. ([martijnburger](https://github.com/martijnburger))
* [#2475](https://github.com/jenkins-x/jx/pull/2475) fix(github archive api): prevent github archive url from redirecting ([aweis89](https://github.com/aweis89))
* [#2476](https://github.com/jenkins-x/jx/pull/2476) Fix jx upgrade extensions repository ([Vlatombe](https://github.com/Vlatombe))
* [#2472](https://github.com/jenkins-x/jx/pull/2472) fix: removed additional 'Needs more' in jx status output ([garethjevans](https://github.com/garethjevans))
* [#2471](https://github.com/jenkins-x/jx/pull/2471) feat: use brew if available to install helm ([garethjevans](https://github.com/garethjevans))
* [#2463](https://github.com/jenkins-x/jx/pull/2463) fix uninstall wrong code location ([runzexia](https://github.com/runzexia))
* [#2466](https://github.com/jenkins-x/jx/pull/2466) fix: lets ensure we detect termination of knative builds ([jstrachan](https://github.com/jstrachan))
* [#2459](https://github.com/jenkins-x/jx/pull/2459) fix: Apparently missing newline in log message ([jglick](https://github.com/jglick))
* [#2462](https://github.com/jenkins-x/jx/pull/2462) Why would the help for `jx update webhooks` claim it is not implemented? ([jglick](https://github.com/jglick))
* [#2458](https://github.com/jenkins-x/jx/pull/2458) fix: lets use the teams StorageLocation settings in `jx step collect` ([jstrachan](https://github.com/jstrachan))
* [#2460](https://github.com/jenkins-x/jx/pull/2460) fix(jenkins): use only the new API to generate tokens ([ccojocar](https://github.com/ccojocar))
* [#2453](https://github.com/jenkins-x/jx/pull/2453) add a new option to avoid waiting for merge build success as tide isn't updating status  #2410 ([rawlingsj](https://github.com/rawlingsj))
* [#2456](https://github.com/jenkins-x/jx/pull/2456) test(uninstall): make uninstall command test state independent ([ccojocar](https://github.com/ccojocar))
* [#2454](https://github.com/jenkins-x/jx/pull/2454) 2446-followup ([agentgonzo](https://github.com/agentgonzo))
* [#2450](https://github.com/jenkins-x/jx/pull/2450) fix(git): Handier error message if you get errors pushing to https ([agentgonzo](https://github.com/agentgonzo))
* [#2445](https://github.com/jenkins-x/jx/pull/2445) fix(applications): Don't try to name the charts dir to the same name ([agentgonzo](https://github.com/agentgonzo))
* [#2446](https://github.com/jenkins-x/jx/pull/2446) Disabled prow configuration for jx delete app ([agentgonzo](https://github.com/agentgonzo))
* [#2435](https://github.com/jenkins-x/jx/pull/2435) fix: removed <>& from the list of allowed symbols in password generation ([garethjevans](https://github.com/garethjevans))
* [#2434](https://github.com/jenkins-x/jx/pull/2434) fix: using correct env.Name when creating environments in prow ([garethjevans](https://github.com/garethjevans))
* [#2426](https://github.com/jenkins-x/jx/pull/2426) feat: added the addon version to 'jx get addons' ([garethjevans](https://github.com/garethjevans))
* [#2428](https://github.com/jenkins-x/jx/pull/2428) Fix: register the plugin CRD ([pmuir](https://github.com/pmuir))
* [#2422](https://github.com/jenkins-x/jx/pull/2422) fixes for build controller and prow ([jstrachan](https://github.com/jstrachan))
* [#2421](https://github.com/jenkins-x/jx/pull/2421) Fix: don’t swallow errors on gitops ([pmuir](https://github.com/pmuir))
* [#2418](https://github.com/jenkins-x/jx/pull/2418) workaround for promote getting stuck on prow installs see #2410 ([rawlingsj](https://github.com/rawlingsj))
* [#2404](https://github.com/jenkins-x/jx/pull/2404) fix(teamcontroller): Do not panic when creating teams ([jtnord](https://github.com/jtnord))
* [#2412](https://github.com/jenkins-x/jx/pull/2412) fix: add a team setting for storage locations ([jstrachan](https://github.com/jstrachan))
* [#2375](https://github.com/jenkins-x/jx/pull/2375) feat(vault): Store a flag in the jx-install-config to denote if secrets are to be stored in vault ([agentgonzo](https://github.com/agentgonzo))
* [#2382](https://github.com/jenkins-x/jx/pull/2382) bug(install): Fix 'Brew' pre-req installation. ([markawm](https://github.com/markawm))
* [#2390](https://github.com/jenkins-x/jx/pull/2390) get more test info ([runzexia](https://github.com/runzexia))
* [#2379](https://github.com/jenkins-x/jx/pull/2379) test(status): do not run the test in parallel ([ccojocar](https://github.com/ccojocar))
* [#2369](https://github.com/jenkins-x/jx/pull/2369) Fixed Helm installation error handling ([hekonsek](https://github.com/hekonsek))
* [#2368](https://github.com/jenkins-x/jx/pull/2368) Upgraded eksctl version ([hekonsek](https://github.com/hekonsek))
* [#2361](https://github.com/jenkins-x/jx/pull/2361) feat(vault): Added more error handling to vault ([agentgonzo](https://github.com/agentgonzo))
* [#2359](https://github.com/jenkins-x/jx/pull/2359) added Bitbucket Server PR comment support ([wenzlaff](https://github.com/wenzlaff))
* [#2360](https://github.com/jenkins-x/jx/pull/2360) Add a "Reviewed by Hound" badge ([salbertson](https://github.com/salbertson))
* [#2276](https://github.com/jenkins-x/jx/pull/2276) Save secrets to vault instead of local files ([agentgonzo](https://github.com/agentgonzo))
* [#1958](https://github.com/jenkins-x/jx/pull/1958) Improved import and BitBucket logging ([hekonsek](https://github.com/hekonsek))
* [#2341](https://github.com/jenkins-x/jx/pull/2341) test(gke): do not run in parallel the tests which mocks the same method ([ccojocar](https://github.com/ccojocar))
* [#2350](https://github.com/jenkins-x/jx/pull/2350) fix:(gerrit) Remove some unnecessary logging in tests ([wbrefvem](https://github.com/wbrefvem))
* [#2347](https://github.com/jenkins-x/jx/pull/2347) Use an A Record rather than CNAME ([agentgonzo](https://github.com/agentgonzo))
* [#2328](https://github.com/jenkins-x/jx/pull/2328) fix(get pipelines): don't ask for an API token ([amuniz](https://github.com/amuniz))
* [#2345](https://github.com/jenkins-x/jx/pull/2345) fix(login) let's make sure users that haven't installed or created the cluster have the base set of binaries installed fixes #2300 ([rawlingsj](https://github.com/rawlingsj))
* [#2334](https://github.com/jenkins-x/jx/pull/2334) fix:  Add domain name validation when configuring ingress to loadbalancer ([mikecirioli](https://github.com/mikecirioli))
* [#2338](https://github.com/jenkins-x/jx/pull/2338) feat(install) added command to install additional dependencies ([garethjevans](https://github.com/garethjevans))
* [#2337](https://github.com/jenkins-x/jx/pull/2337) Fix username is not set correctly for Openshift provider ([daveconde](https://github.com/daveconde))
* [#2332](https://github.com/jenkins-x/jx/pull/2332) Fix: Create API token on promote if needed ([msvticket](https://github.com/msvticket))
* [#2289](https://github.com/jenkins-x/jx/pull/2289) feat(vault): Create vault resources in GCP that are unique to the cluster ([agentgonzo](https://github.com/agentgonzo))
* [#2330](https://github.com/jenkins-x/jx/pull/2330) feat(install): Use more secure generated passwords ([agentgonzo](https://github.com/agentgonzo))
* [#2326](https://github.com/jenkins-x/jx/pull/2326) fix: lets use a more explicit label for the default workloads ([jstrachan](https://github.com/jstrachan))
* [#2325](https://github.com/jenkins-x/jx/pull/2325) fixes for prow and the new cloud native build packs ([jstrachan](https://github.com/jstrachan))
* [#2314](https://github.com/jenkins-x/jx/pull/2314) Fix: Making a few more commands possible to run w/o being cluster admin ([msvticket](https://github.com/msvticket))
* [#2319](https://github.com/jenkins-x/jx/pull/2319) Add a basic unit test for PreviewOptions ([markawm](https://github.com/markawm))
* [#2317](https://github.com/jenkins-x/jx/pull/2317) fix: ensure gcloud is installed before login ([garethjevans](https://github.com/garethjevans))
* [#2053](https://github.com/jenkins-x/jx/pull/2053) fix:(install) add promt for Jenkins installation type if prow or batch mode is not selected ([ccojocar](https://github.com/ccojocar))
* [#2282](https://github.com/jenkins-x/jx/pull/2282) bug(controller buildnumbers): Encode PipelineActivity names to avoid collisions ([markawm](https://github.com/markawm))
* [#2298](https://github.com/jenkins-x/jx/pull/2298) chore(tests): Refactored go-expect tests to support better error reporting ([agentgonzo](https://github.com/agentgonzo))
* [#2304](https://github.com/jenkins-x/jx/pull/2304) Feat: Add an app CRD ([pmuir](https://github.com/pmuir))
* [#2346](https://github.com/jenkins-x/jx/pull/2346) fix: add a command to create knative build templates from the pipelines ([jstrachan](https://github.com/jstrachan))
* [#2129](https://github.com/jenkins-x/jx/pull/2129) fix: broken tls in jx preview ([vbehar](https://github.com/vbehar))
* [#2354](https://github.com/jenkins-x/jx/pull/2354) fix: Import from non dev team namespace ([msvticket](https://github.com/msvticket))
* [#2336](https://github.com/jenkins-x/jx/pull/2336) Add a parameter to update webhooks for a single repo in an org ([Vlatombe](https://github.com/Vlatombe))
* [#2366](https://github.com/jenkins-x/jx/pull/2366) Avoid panic on failed repo creation ([davidcurrie](https://github.com/davidcurrie))
* [#2358](https://github.com/jenkins-x/jx/pull/2358) refactor(upgrade ingress): add a flag to skip the update of jx related resources ([ccojocar](https://github.com/ccojocar))
* [#2104](https://github.com/jenkins-x/jx/pull/2104) feat: add binary plugins ([pmuir](https://github.com/pmuir))
* [#2384](https://github.com/jenkins-x/jx/pull/2384) chore(tests): Windows tests fail ([agentgonzo](https://github.com/agentgonzo))
* [#2383](https://github.com/jenkins-x/jx/pull/2383) chore: expose results from `jx get app` in a better structure ([jstrachan](https://github.com/jstrachan))
* [#2378](https://github.com/jenkins-x/jx/pull/2378) fix(vault): ensure that the created vault has a service account and a proper role binding ([ccojocar](https://github.com/ccojocar))
* [#2335](https://github.com/jenkins-x/jx/pull/2335) Make ACR as the default registry for Azure ([yuwzho](https://github.com/yuwzho))
* [#2255](https://github.com/jenkins-x/jx/pull/2255) Copy editing on help ([jglick](https://github.com/jglick))
* [#2408](https://github.com/jenkins-x/jx/pull/2408) fix: pass the repo to fetch ([pmuir](https://github.com/pmuir))
* [#2363](https://github.com/jenkins-x/jx/pull/2363) Vault install secrets yaml ([agentgonzo](https://github.com/agentgonzo))
* [#2393](https://github.com/jenkins-x/jx/pull/2393) improve CLI for no-tiller ([jstrachan](https://github.com/jstrachan))
* [#2425](https://github.com/jenkins-x/jx/pull/2425) fix: if no options specified lets reuse the arguments ([jstrachan](https://github.com/jstrachan))
* [#2417](https://github.com/jenkins-x/jx/pull/2417) refactor(install): break the install command in smaller methods and make the cloud providers configuration more self contained ([ccojocar](https://github.com/ccojocar))
* [#2441](https://github.com/jenkins-x/jx/pull/2441) fix:  Provides a more reliable way to get the previous git tag sha ([mikecirioli](https://github.com/mikecirioli))
* [#2432](https://github.com/jenkins-x/jx/pull/2432) Rename CreateClient to CreateKubeClient ([agentgonzo](https://github.com/agentgonzo))
* [#2440](https://github.com/jenkins-x/jx/pull/2440) fix: reduce the number of allowed symbols for passwords to be safer ([garethjevans](https://github.com/garethjevans))
* [#2439](https://github.com/jenkins-x/jx/pull/2439) fix initial build of maven projects and fixed build numbers from `jx start pipeline` ([rawlingsj](https://github.com/rawlingsj))
* [#2437](https://github.com/jenkins-x/jx/pull/2437) fix: validating git at the start of the create terraform command ([garethjevans](https://github.com/garethjevans))
* [#2444](https://github.com/jenkins-x/jx/pull/2444) fix: ensure git user + email is setup ([jstrachan](https://github.com/jstrachan))
* [#2469](https://github.com/jenkins-x/jx/pull/2469) bug(create team): Update status on the Team CRD in the admin namespace ([markawm](https://github.com/markawm))
* [#2484](https://github.com/jenkins-x/jx/pull/2484) feat: initial support for chart repo username/password ([pmuir](https://github.com/pmuir))
* [#2478](https://github.com/jenkins-x/jx/pull/2478) feat(gke) can now provide oauth scopes when creating gke cluster ([garethjevans](https://github.com/garethjevans))
* [#2479](https://github.com/jenkins-x/jx/pull/2479) fix: `jx add app` error if no repo defined ([pmuir](https://github.com/pmuir))
* [#2474](https://github.com/jenkins-x/jx/pull/2474) refactor(install): revamp the git auth configuration and make the organization selectable for environment repositories ([ccojocar](https://github.com/ccojocar))
* [#2531](https://github.com/jenkins-x/jx/pull/2531) fix: only load managed plugins if CRD available ([pmuir](https://github.com/pmuir))
* [#2518](https://github.com/jenkins-x/jx/pull/2518) added ability to use preemptible vms in the node pool ([garethjevans](https://github.com/garethjevans))
* [#2533](https://github.com/jenkins-x/jx/pull/2533) Added --git-owner flag to `create env` command ([hekonsek](https://github.com/hekonsek))
* [#2506](https://github.com/jenkins-x/jx/pull/2506) Reviewers ([pmuir](https://github.com/pmuir))
* [#2536](https://github.com/jenkins-x/jx/pull/2536) Changed "Delete" -> "Deletes" in help for `jx delete eks` ([hekonsek](https://github.com/hekonsek))

## Charts



## Downloads


<canvas id="downloadsChart" width="400" height="200"></canvas>
<script type="text/javascript" src="/news/changes-20-december-2018/downloads.js"></script>
</canvas>


This blog post was generated via the [jx step blog](https://jenkins-x.io/commands/jx_step_blog/) command from [Jenkins X](https://jenkins-x.io/).
