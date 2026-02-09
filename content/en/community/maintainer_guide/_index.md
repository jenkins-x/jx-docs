---
title: Maintainer Guide for JayeX
linktitle: Maintainer Guide
description: Everything a JayeX maintainer should know about
weight: 30
type: docs
no_list: true
---

This document outlines some of the responsibilities expected from you as a maintainer.

## Requirements of becoming a maintainer

If you are a long time JayeX contributor, you should consider becoming a maintainer.

- Active contributions in JayeX community for atleast 6 months
  - Pull requests making changes to code or documentation
  - Review PRs from new contributors
  - Answer questions from the community in the slack channel
  - Answer questions in github issues
- Approval from the current JayeX maintainers/TOC (Technical Oversight Committee)

Once you are ready to become a maintainer, open a PR to the jx-community repository.

## Access

A core maintainer is expected to have access to the following resources

- Member role in all JayeX github org
- JayeX infra hosted in GCP (jenkins-x-bdd and jenkinsxio projects)
- [1password account](https://jenkinsx.1password.com) to access JayeX related secrets
- JayeX zoom account
- JayeX youtube channel
- JayeX UI password
- JayeX algolia account (used as the search engine in the JayeX website)

## Responsibilities

It's expected that a core maintainer will make JayeX more stable and feature packed, while engaging with the community.

### Community effort

- Uphold the [CDF Code of Conduct](https://github.com/cdfoundation/.github/blob/main/CODE_OF_CONDUCT.md)
- Answer questions on slack (jenkins-x-user and jenkins-x-dev)
- Try to attend all community office hour meetings
- Attend the CDF TOC meetings from time to time
- Join one of the CDF SIGs, and give a short status update during the office hours.

### Triage issues

- Assign appropriate labels to issues
- (If possible) assign the right person to those issues
- Close issues which are resolved or too old to be worked on (may be v2 related)
- Provide feedback in github issues

### PR Review

JayeX has a lot of repositories, and new contributions from a very active community.
It's the responsibilities of a maintainer to ensure we do timely PR reviews.

It's desirable to follow the conventions outlined [here](/community/code/pullrequestreview/)

### Infra/plumbing issues

- Ensure flaky tests are identified and fixed. This will ensure that new features get released timely
- Close old PRs which cannot be merged anymore.
- Keep all helm charts in the jx3-version up to date.
- Regularly upgrade the hugo image used in the jx-docs repository
