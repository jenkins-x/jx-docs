---
title: Step by Step setup
linktitle: Git step by step
description: Step by step instructions to setup Git
type: docs
weight: 20
aliases:
    - /docs/contributing/documentation/step-by-step/
---

We'll go through each step below, but here's what you need to get started with Git:

* The [`git`](https://git-scm.com) command line interface installed locally
* a [GitHub](https://github.com) account
* a local working copy of the code

## Install Git on your system

Git is a [version control system](https://en.wikipedia.org/wiki/Version_control) to track the changes of source code.

You will need to have Git installed on your computer to contribute to Jenkins X development.
Teaching Git is outside the scope of the Jenkins X docs, but if you're looking for an excellent reference to learn the basics of Git, we recommend the [Git book](https://git-scm.com/book/) if you are not sure where to begin.

Move back to the terminal and check if Git is already installed.
Type `git version` and press enter.
If the command returned a version number, you can skip the rest of this section.

Otherwise, [download](https://git-scm.com/downloads) the latest version and follow this [installation guide](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).

Finally, run `git version` again to check if Git was installed successfully.

### Git Graphical Front Ends

There are several [GUI clients](https://git-scm.com/downloads/guis) that help you to operate Git. Not all are available for all operating systems and maybe differ in their usage. Thus, we will use the command line since the commands are everywhere the same.

## Create a GitHub Account

If you're going to contribute to the docs, you'll need to have an account on GitHub.
Go to [www.github.com/join](https://github.com/join) and set up a personal account.

## Set up your working copy

The working copy is set up locally on your computer.
It's what you'll edit, compile, and end up pushing back to GitHub.
The main steps are cloning the repository and creating your fork as a remote.

### Fork the repository

If you're not familiar with this term, GitHub's [help pages](https://help.github.com/articles/fork-a-repo/) provide a simple explanation:

> A fork is a copy of a repository. Forking a repository allows you to freely experiment with changes without affecting the original project.

Open the [Jenkins X docs repository](https://github.com/jenkins-x/jx-docs) on GitHub and click on the "Fork" button in the top right.

### Clone your fork locally

Now open your fork repository on GitHub and copy the remote url of your fork.
You can choose between HTTPS and SSH as protocol that Git should use for the following operations.
HTTPS works always [if you're not sure](https://help.github.com/articles/which-remote-url-should-i-use/).

![Copy remote url](/images/contribute/development/copy-remote-url.png)

Then go back to your terminal, `cd` to where you would like to place your local copy of the `jx-docs` repo, and then clone your fork.

```sh
git clone --recurse-submodules --depth 1 git@github.com:<YOUR_USERNAME>/jx-docs.git
cd jx-docs
```

{{< alert >}}
In case you already have a git clone locally (from before the theme change) then run the following to pull the Docsy theme and dependencies

```sh
git submodule update --init --recursive
```

{{< /alert >}}

Add the conventional upstream `git` remote in order to fetch changes from the `jx-docs` master
branch and to create pull requests:

```sh
git remote add upstream https://github.com/jenkins-x/jx-docs.git
```

Let's check if everything went right by listing all known remotes:

```sh
git remote -v
```

The output should look similar to:

```sh
origin    git@github.com:<YOUR_USERNAME>/jx-docs.git (fetch)
origin    git@github.com:<YOUR_USERNAME>/jx-docs.git (push)
upstream  https://github.com/jenkins-x/jx-docs.git (fetch)
upstream  https://github.com/jenkins-x/jx-docs.git (push)
```
