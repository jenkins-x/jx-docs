---
title: Contribution workflow
linktitle: Workflow
description: Description of the contribution workflow for the documentation
type: docs
weight: 30
aliases:
    - /docs/contributing/documentation/workflow/
---

Once you've completed the initial steps to get started, you can begin to make changes and add new content.

At a high level, your workflow will likely look something like this:

* Create a new branch for you work
* Start the Hugo server to preview your changes (updates the site live)
* Make changes/add new content
* Commit and push your changes to your fork of `jx-docs`
* Raise a Pull Request (PR) to have your changes merged into the main `jx-docs` repo
* Wait for and then participate in a review of your changes
  * might involve making adjustments or adding a bit more
* See your changes go live on the [Jenkins X site](https://jenkins-x.io)

We'll go though each of the steps below in more detail

## Create a new branch

First, ensure that your local repository is up-to-date with the latest version of `jx-docs`. More details on [GitHub help](https://help.github.com/articles/syncing-a-fork/)

```sh
git fetch upstream
git checkout master
git merge upstream/master
```

You've now updated your local copy of the repository. To update your fork on GitHub, push your changes:

```sh
git push origin master
```

Create a new branch for the changes you'd like to make:

```sh
git checkout -b <BRANCH-NAME>
```

You can check on which branch your are with `git branch`. You should see a list of all local branches. The current branch is indicated with a little asterisk.

## Start the Hugo server

In case you don't already have it running, this is a good time to [start](/community/documentation/#local-preview-environment) your local Hugo server.

If you already have Hugo running, it's usually best to double check that the site looks as you'd expect it (basically the same as the live site) and if something's off, do a quick restart of Hugo.

## Make Changes

All pages are written in GitHub-flavored Markdown (see [Markdown reference](/community/documentation/reference/#markdown-syntax-reference) for details on syntax).

Some things, like the footer etc. are in the `/themes/docsy` structure, but most likely you'll just be adding/changing things in the various page structures. If you do make changes that involve the theme, remember to copy-paste the theme file to the appropriate folder in the `/layouts` structure, and make your changes there. If you make changes to files in the `/themes/docsy` structure, they will likely be deleted when we update the theme.

## Add new Content

The Jenkins X docs make heavy use of Jenkins X's archetypes feature. All content sections in Jenkins X documentation have an assigned archetype.

Adding new content to the Jenkins X docs follows the same pattern, regardless of the content section:

```sh
docker-compose run server new <DOCS-SECTION>/<new-content-lowercase>.md
```

## Commit and push your changes

When you've finished, and verified that everything looks good (using the Hugo server), you should run one last check to verify that you didn't break anything.

### Checking References and Links

We're using a tool called [htmlproofer](https://github.com/chabad360/htmlproofer) to check that links are still valid etc. so you just need to run the following commands to build the site locally, and verify that everything looks good:

```sh
docker-compose run server sh -c "cd /src && hugo"
docker-compose up linkchecker
```

### Checking Spelling

For spell checking, we're using [node-markdown-spellcheck](https://github.com/lukeapage/node-markdown-spellcheck) to run through all our markdown files and list any spelling issue or unknown word it can find.

To make this as simple as possible, just run the following command

```sh
docker-compose up spellchecker
```

This will output any issue the spell checker have found.

It's likely that the report includes words that are spelled correctly, but that just means the spell checker is not aware of the correct spelling (happens a lot for technical terms, commands, etc.). Please edit the `.spelling` file and add the unknown word.
Also, please try and keep the list alphabetically sorted; makes it easier to navigate when you're looking for something

### Commit & Push

If everything is good, you can commit your changes, and push them to your fork:

```sh
git push --set-upstream origin <BRANCH-NAME>
```

If you need to push more commits to the same branch, you can just use `git push` going forward; set-upstream is only needed once.

### Open a pull request 🎉

In this step, you'll open a pull request to submit your additions. Open either the [Jenkins X documentation master repository](https://github.com/jenkins-x/jx-docs) or your own fork of the respository on GitHub in your browser.

You should find a green button labeled with "New pull request". But GitHub is clever and probably suggests you a pull request like in the beige box below:

![Open a pull request](/images/contribute/development/open-pull-request.png)

Click on the green "Compare and pull request" button. A new page will open which summaries the most important information of your pull request. Scroll down and you'll find the additions of all your commits. Make sure everything looks as expected and click on "Create pull request".

There are a number of automated checks that will run on your PR:

* Semantic Pull Request - validates that your commit messages meet the [Conventional Commit format](https://github.com/probot/semantic-pull-requests#semantic-pull-requests).
  Additionally your PR must also have a conventional message. The UX for this bot is a little odd as it doesn't go red
  if the messages are NOT correct, instead it goes yellow. You need it to go to a green tick!
* Tide - performs the merge when all the checks pass. Don't worry about the state of this one, it doesn't add much info.
  Clicking on the details link is very helpful as it will take you to the dashboard where you can navigate to the "Tide"
  screen and check the status of your PR in the merge queue.

### Review Process

The final part of all of this, is letting others review your work and provide feedback. As a rule of thumb, the conversation should happen on the PR, but sometimes things will be sorted out via Slack or a video call.

Sometimes it may take a few days for a review to happen. If you feel it's an urgent change, jump on the [community slack channel](https://jenkins-x.io/community/#slack) `#jenkins-x-user` and ask for someone to review your PR.

Once the review is done, your changes will be merged into the master branch, and the site will be updated.

{{< alert >}}
In case you need to update your PR/branch because js-docs/master have been updated since you submitted your PR, run the followin `git` command to pull all the changes to your local environment and then push them to your PR/branch:

```sh
git fetch upstream
git rebase upstream/master
git push
```

If you experience Merge Conflicts, there's a good [article on GitHub](https://help.github.com/en/articles/resolving-a-merge-conflict-using-the-command-line) that helps explain what to do
{{< /alert >}}
