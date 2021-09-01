---
title: "Lighthouse Goes GA!"
date: 2020-06-08
draft: false
description: >
  Lighthouse is the default webhook handler for Jenkins X
categories: [blog]
keywords: [Jenkins X,2020]
slug: "lighthouse-goes-ga"
aliases: []
author: Andrew Bayer
---

In May of this year, Jenkins X switched from using [Prow](https://github.com/kubernetes/test-infra/tree/master/prow) as its default webhook handler to using [Lighthouse](https://github.com/jenkins-x/lighthouse). This is the result of almost a year of work, and provides some significant improvements for users of Jenkins X. You can find more information on the differences between Prow and Lighthouse [here](https://jenkins-x.io/docs/reference/components/lighthouse/#comparisons-to-prow).

Most notably, Jenkins X now properly supports GitHub Enterprise as well as github.com, with preview support for GitLab and BitBucket Server. Prow only supports github.com, so until now, Jenkins X users have had to jump through hoops or accept significant limitations to their workflows in order to use any other SCM (source control management) providers. Lighthouse is tested against every provider we list support for, including the preview support for GitLab and BitBucket Server. While some functionality may not behave exactly the same on all providers, the core functionality of [ChatOps](https://jenkins-x.io/docs/build-test-preview/chatops/) should work on all. Lighthouse also has a smaller footprint in terms of resources and pods used in your Kubernetes cluster than Prow.

If you're interested in Jenkins X and Lighthouse support for other SCM providers, please let us know and we'll see what we can do!

### What does "preview support" mean?

The primary difference between Lighthouse's support for GitHub and GitHub Enterprise, and its support for GitLab and BitBucket Server, is testing and usage. The Jenkins X project itself uses Lighthouse heavily, so we're very confident in its behavior and reliability with the GitHub API. Its GitLab and BitBucket Server support is tested with every change to the project, but until we've had reports of Lighthouse users on GitLab or BitBucket Server in real-world usage, we don't want to give the impression that support for those providers is known to be as stable as on GitHub.

So if you're using Jenkins X and Lighthouse with GitLab or BitBucket Server, we'd love to hear how your experience has been, [on our Slack channels or at our weekly office hours](https://jenkins-x.io/community/). If you run into in any problems with Lighthouse on any provider, whether it's in preview or otherwise, please [open an issue](https://github.com/jenkins-x/lighthouse/issues) and we'll look into it as soon as possible. Once we've gotten enough feedback to be confident that major changes will not be needed for GitLab or for BitBucket Server, we'll move those providers out of preview.

### Differences between providers

#### GitHub and GitHub Enterprise

There should be no functional differences between Lighthouse's behavior on github.com vs a GitHub Enterprise instance. The exact same APIs are used in both cases.

#### GitLab

Lighthouse with GitLab may be more likely to hit API rate limits, due to GitLab's GraphQL functionality not matching the particular capabilities of GitHub, but the overall functionality is the same. There is one significant difference with GitLab, however. Some of Lighthouse's ChatOps commands, such as `/approve` and `/assign`, overlap with [GitLab quick actions](https://docs.gitlab.com/ee/user/project/quick_actions.html), and currently, GitLab [does not trigger webhook events for quick actions](https://gitlab.com/gitlab-org/gitlab/-/issues/215934). If Lighthouse does not receive a webhook event, it doesn't have any way of knowing that a ChatOps command has been invoked. Therefore, we have added the ability to invoke [all Lighthouse ChatOps commands](https://jenkins-x.io/docs/build-test-preview/chatops/#chatops-commands) either with the traditional `/approve` etc command, or by adding a `lh-` prefix, like `/lh-approve`. When using Lighthouse with GitLab, you will want to use the `/lh-(whatever)` commands to ensure that your command is actually processed.

We believe that Lighthouse should work with gitlab.com and relatively current versions of GitLab Community Edition and GitLab Enterprise Edition, based on the API docs, but if you encounter any problems on GitLab CE or GitLab EE, please open an issue.

#### BitBucket Server

First, we should note that Lighthouse will not work properly with BitBucket Server versions earlier than 7.0. [A new webhook was added in 7.0](https://confluence.atlassian.com/bitbucketserver/bitbucket-server-7-0-release-notes-990546638.html#BitbucketServer7.0releasenotes-Anewwebhookforsourcebranchupdatesinapullrequest) to be sent when the source branch for a pull request has been updated, because of a new commit, rebase, or similar changes, and without that webhook, Lighthouse isn't informed in those cases and doesn't know to rebuild the pull request.

In addition, [due to BitBucket Server not having the concept of labels for pull requests](https://jira.atlassian.com/browse/BCLOUD-11976), Lighthouse emulates labels by creating a comment on pull requests containing a table of labels for the pull request in question. This comment needs to remain in the consistent format Lighthouse creates or it won't be able to detect the labels correctly. Comment formatting for BitBucket Server is also more limited than for GitHub or GitLab, so comments may be a bit awkward in their appearance at the moment.
