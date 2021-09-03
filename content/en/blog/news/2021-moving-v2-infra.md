---
title: "Moving Jenkins X v2 artifacts"
date: 2021-08-26
draft: false
description: Moving v2 artifacts
categories: [blog]
keywords: [moving, v2]
slug: "moving-v2-artifacts"
aliases: []
author: James Rawlings
---
 
# __ACTION REQUIRED__
 
TL;DR - Jenkins X specific helm repositories and container registries hosted on GCP have been moved to GitHub.  This will mainly affect jx v2 users but there is expected to be a small impact on v3 users too.  Below describes the steps we believe are needed to keep Jenkins X installations working as normal but there will be some action needed.
 
## Why the disruption?
 
When Jenkins X first started we made heavy use of GCP's services for hosting the cloud infrastructure needed by users to install and run Jenkins X.  This was great as we could use the same IAM to push and maintain content from our own hosted build infrastructure and ensure we were validating the same experience of using cloud provider hosted services wherever possible.  As Jenkins X grew in popularity the cloud costs began to increase with the [pricing model from GCP](https://cloud.google.com/container-registry/pricing), specifically the networking costs of cross continent egress.
 
Given this, for jx3 we decided to see if switching to [GitHub packages for container images](https://github.com/orgs/jenkins-x/packages) and [GitHub pages](https://jenkins-x-charts.github.io/repo/) for helm repositories would be better, the result was it is better.  In fact we have made it super easy for users to switch to using GitHub pages for releasing [helm charts](https://jenkins-x.io/v3/develop/faq/config/registries/#how-do-i-switch-to-github-pages-for-charts) and using GitHub packages.
 
Now that we have validated GitHub is more cost effective for hosting public images and helm charts for the Jenkins X project, we want to switch to using GitHub for all v2 plus v3 users, then shutdown the GCP services which are causing unnecessary cost.
 
It is expected that v3 users will need a small change and v2 slightly more.  Details for both will be described below but it is worth noting that there hasn't been a v2 release in 9 months and v3 was [GA in April](https://jenkins-x.io/blog/2021/04/15/jx-v3-ga/) earlier this year, so we aren't expecting too many folks on v2.  We are aiming to limit any disruption and help provide easy steps to handle the move.

We apologise for any extra work caused however, this is required to preserve the long running hosting of Jenkins X artifacts both past and present.  If you experience issues that are not covered by the steps below please reach out to the [community slack channel](https://jenkins-x.io/community/#slack) and we can help address and update this blog with details.
 
## What is changing?
 
We will be shutting down a number of GCP projects that contain old helm charts plus container images and moving them to be hosted by GitHub packages and pages.
 
#### Helm
 
```
https://chartmuseum.build.cd.jenkins-x.io
http://chartmuseum.jenkins-x.io
https://storage.googleapis.com/chartmuseum.jenkins-x.io
``` 
have been moved to 
```
https://jenkins-x-charts.github.io/v2
```
 
AND

```
https://storage.googleapis.com/jenkinsxio/charts
``` 
has been moved to 
``
https://jenkins-x-charts.github.io/repo
```

#### Images
 
The most recently versioned images from [gcr.io/jenkinsxio](https://console.cloud.google.com/gcr/images/jenkinsxio/GLOBAL) have been moved to [ghcr.io/jenkins-x](https://github.com/orgs/jenkins-x/packages)
 
#### Labs
 
There are some old labs images and helm charts which should not be in use as they are either deprecated or replaced with GA versions in the v3 [helm repo](https://jenkins-x-charts.github.io/repo/) or [container registry](https://github.com/orgs/jenkins-x/packages).
 
### v2 users
 
1. The Jenkins X own v2 build infrastructure was retired at the start of the year as no more releases were planned and to reduce costs.  With that we are unable to perform a new release that automatically switches references to images from `gcr.io/jenkinsxio` to `ghcr.io/jenkins-x`.  If you are still using v2 then please update your references to this container registry.  An alternative __which has not yet been verified__ is to use a [image swap Kubernetes mutaing admission controller](https://github.com/phenixblue/imageswap-webhook) which takes configuration to switch the registry on the fly.  [We have asked on slack](https://github.com/phenixblue/imageswap-webhook) for help validating the approach so if you do try it please share feedback and config used to help others in the channel, we can then update docs.
 
2. In your boot git repository, run a search for references of `http://chartmuseum.jenkins-x.io` and `https://storage.googleapis.com/chartmuseum.jenkins-x.io` replace with `https://jenkins-x-charts.github.io/v2`

3. Environment controller (can be skipped if not using)
   i) change the environment controller image to be `ghcr.io/jenkins-x/builder-maven:0.1.803`
   i) change the image used in the pipline, needs to be changed in the jenkins-x.yaml of the enviromnet repo:
   ```
   agent:
    container: ghcr.io/jenkins-x/builder-go:2.1.155-779
   ```
   ii) add this environment variable in the deployment of the environment-controller
   ```
    - name: BUILDER_JX_IMAGE
      value: ghcr.io/jenkins-x/builder-jx:2.1.155-779
   ```
 
Have we missed anything?  Please contribute to this blog or feedback on the slack channel.
 
### v3 users

There is not expected to be significant disruption to v3 users but if there is anything needed beyond the steps below then we are asking users to reach out asap and we can update this blog.


1. Run `jx upgrade gitops` to ensure you upgrade to the latest version stream with the old helm repository removed. If you are tracking the LTS version stream please delay until Wednesday 1st September to run this.
 
2. In your cluster git repository, run a search for references of `https://storage.googleapis.com/jenkinsxio/charts` replace with `https://jenkins-x-charts.github.io/repo`
 
3. In your cluster git repository, run a search for references of `http://chartmuseum.jenkins-x.io` and `https://storage.googleapis.com/chartmuseum.jenkins-x.io` replace with `https://jenkins-x-charts.github.io/v2`
 
4. Switch `jx-verify` helm chart repository for any application you have which is built by Jenkins X 3.  This is under your applications git repository `./charts/preview/helmfile.yaml` change `https://storage.googleapis.com/jenkinsxio/charts` to `https://jenkins-x-charts.github.io/repo` .  [Here](https://github.com/jenkins-x/jx3-pipeline-catalog/commit/ed01d636b94b2ea51b878d9b5331bc4c88f6e8b1) is an example that changes the main pipeline catalog packs which are used when first creating or importing applications.

Have we missed anything?  Please contribute to this blog or feedback on the slack channel.
 
## When will all this take place?
 
1. This blog is the initial notice which we will socialise, please help to raise awareness.
 
2. Friday 27th August - the labs project will be scheduled to shutdown, short notice because we believe no services should be used, if they are it is an easy switch to upgrade to GA versions.  Labs efforts are never intended to be production grade and are used at risk.
 
3. Monday 6th September - make the GCP container registry and helm repository bucket private, during which time any image versions that have not been transferred to GitHub can be requested via the community slack channel.  All helm versions have been moved to https://jenkins-x-charts.github.io/v2 as described above.
 
4. Monday 13th September - schedule for shutdown the two GCP projects hosting the container registry and helm repository.
 
## Why are only the most recent versions v2 images copied to GitHub packages and not all versions?
 
There are 14 Terabytes of data that make up the jenkinsxio container registry on GCP, it would be costly and wasteful to transfer all this to GitHub so we picked the last known version of each image that was released last year.  If there are specific images that you wish to use either pull / push them yourself to a container registry of your own or reach out and on a case by case effort, we can look to move them to GitHub while the read permissions are made private and before the project is shut down.
