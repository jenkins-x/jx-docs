---
title: "Build, test and preview an app"
date: 2017-01-05
weight: 3
description: >
  This walkthrough helps you understand how to build, test and preview your app in various built-in **environments** in Jenkins X
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

### Generating a preview environment

In a typical Jenkins X development scenario, users make changes to an
application that has been imported or created via one of the various
supported methods, such as
[Quickstarts](/docs/getting-started/first-project/create-quickstart/), [imported projects](/docs/using-jx/creating/import/), and [Spring
Boot](/docs/using-jx/creating/create-spring/) applications.

When the developer makes the change to their branch, with the ultimate
goal of merging those branch changes into the `master` branch for
deployment to production, they save their changes from within their
integrated development environment (IDE) and commit it to the source
repository, such as GitHub. The process to generate a preview
environment is typically like committing code in a traditional
development environment:

1. A developer makes a branch to their local cloned source repository to create a new feature:

```sh
git branch acme-feature1
```

2.  The developer makes changes to the source code in their branch and adds the affected files to the commit queue:

```sh
git add index.html server.js
```


3. The developer commits the files adding a comment about what has changed:

```sh
    git commit -m "nifty new image added to the index file"
```

4. The developer runs `git push` to send the code back to the remote  repository and create a pull request:

```sh
    git push origin acme-feature1
```
5. The program displays a link to a pull request. The developer can highlight the URL, right-click and choose *Open URL* to see the GitHub page in their browser.

6. Jenkins X creates a preview environment in the PR for the application changes and displays a link to evaluate the new feature:

<img src="/images/pr-comment.png" class="img-thumbnail">

The preview environment is created whenever a change is made to the
repository, allowing any relevant user to validate or evaluate features,
bugfixes, or security hotfix.

### Testing the preview environment

The development bot created during the installation process sends a notification email to the developer as well as the designated repository approver that a PR is ready for review. During the approval process, the approver can click on the preview application with the code changes for testing and validation.

When the approver confirms the code and functionality changes, they can
approve the with a simple comment that merges the code changes back to
the master branch and initiate a production build with the new feature:

```sh
    /approve
```

The code is merged to the `master` branch, and the release is pushed to
staging/production or a release created and available from the GitHub
staging environment in the `Releases` tab.
