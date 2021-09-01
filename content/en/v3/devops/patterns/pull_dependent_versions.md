---
title: Pull Dependent Versions
linktitle: Pull Dependent Versions
description: Pull dependent versions into your git repository
type: docs
weight: 30
---

When you [Version Everything](/v3/devops/patterns/version_everything) you need a way to pull dependent versions into your git repositories.

Using the **pull** model means that you periodically create Pull Requests on your git repositories to upgrade dependencies.

One solution is to use a tool tool like [dependabot](https://dependabot.com/).

Or you can run periodic jobs via the [updatebot plugin](https://github.com/jenkins-x-plugins/jx-updatebot) to create pull requests.

e.g. we automatically pull upgrades of chart versions into our Version Stream via [this github action](https://github.com/jenkins-x/jx3-versions/blob/master/.github/workflows/update-charts.yml)

Creating Pull Requests to modify versions means the team looking after the repository can decide when and how to merge the Pull Request; e.g. periodically or in quiet times when there are no serious production issues to resolve.
