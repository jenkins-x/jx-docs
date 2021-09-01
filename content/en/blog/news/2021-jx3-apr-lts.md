---
title: "Jenkins X 3 - April 2021 LTS"
date: 2021-04-12
draft: false
description: April '21 LTS release for Jenkins X 3
categories: [blog]
keywords: [lts, jx3, 2021]
slug: "jx3-lts-apr-21"
aliases: []
author: James Rawlings
---
 
This is the second [LTS release](/v3/admin/setup/upgrades/lts/) for Jenkins X 3.x.

LTS is a slower cadence version stream which contains a verified set of releases and configurations that have been used by teams tracking the bleeding edge Jenkins X.

Initially when we decided to maintain an LTS version stream we thought we'd aim for monthly releases however this second release comes two months after the first.  This has given us more chances to run fixes and chart upgrades on Jenkins X own infrastructure to verify stability.

__Note__ This LTS release is intended to be the final one before Jenkins X 3 is made Generally Available so stay tuned for the exciting news coming very soon!  We will of course continue to develop and release LTS post GA.

Included in this release:

- General beta bug fixes and helm chart upgrades
- Enable [Observability](/v3/admin/guides/observability)
- Enable [Slack](/v3/develop/ui/slack) notifications
- Support for GitLab, Gitea, BitBucket Server and GitHub Enterprise

Please be aware of these changes

- [Breaking changes](/v3/about/changes)
- If using Vault move it outside of being managed by Jenkins X GitOps [important notes](/v3/develop/faq/config/vault/#after-an-upgrade-the-boot-job-is-waiting-for-vault-in-jx-vault)
