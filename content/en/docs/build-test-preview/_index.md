---
title: "Build and test"
date: 2017-01-05
weight: 40
description: >
  This chapter helps you understand how to build, test and preview your app in various built-in **environments** in Jenkins X
aliases:
  - /docs/getting-started/build-test-preview/
---

Jenkins X developer environments should be familiar to anyone who has
developed in a Git environment, with added features that further
automates development processes, builds, and promotion.

## The traditional development environment


A common workflow in a Git development involves:

1. Forking - The developer creates a fork of the project repository into their personal repo.

2. Branching - The developer creates a branch of their fork, for various reasons:

  - Creating a new feature

  - Fixing a bug

  - Applying a security patch for a vulnerability

3. Committing - The developer commits the code and pushes it to their branch, creating a `diff` file.

4. Creating a pull request - The developer creates a pull request (PR) from their branch back to the main repository

5. Testing - A developer peer or quality assurance (QA) team member looks at the code and/or builds a test version for validating the feature or fix, finding bugs and suggesting changes if necessary.

6. Merging - The PR code, if accepted, is merged into the master or main project repo.

## Jenkins X and the developer process

Development with Jenkins X is similar to the traditional Git development
workflow, with the added benefits of continuous development via automation within a Git context, also known as *GitOps*.

Jenkins X goes one step further by offering a *preview environment* that allows developer peers and QA testers to validate new features and fixes using an evaluation build of the functionality within the Git PR.

Promotion is implemented with GitOps by generating a pull request on the Environment’s git repository so that all changes go through git for audit, approval and so that any change is easy to revert.

The CD Pipelines of Jenkins X automate the promotion of version changes through each Environment which is configured with a promotion strategy. By default the Staging environment uses automatic promotion and the Production environment uses manual promotion.
