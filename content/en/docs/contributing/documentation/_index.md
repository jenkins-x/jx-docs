---
title: Contribute to the Documentation
linktitle: Documentation
description: How to help improve the Jenkins X documentation
weight: 10
---

Contributing to the documentation is a great way to get involved, and we appreciate your help in improving the Jenkins X docs! You can choose an [open issue](https://github.com/jenkins-x/jx-docs/issues), or contribute to the documentation as you find areas to augment or fix.

# Assumptions

This contribution guide takes a step-by-step approach in hopes of helping newcomers. Therefore, we only assume the following:

* You are new to Git or open-source projects in general
* You are a fan of Jenkins X and enthusiastic about contributing to the project

{{% alert %}}
If you're struggling at any point in this contribution guide, reach out to the Jenkins X community in [Jenkins X's Discussion forum](/community/).
{{% /alert %}}

## Getting Started

The first thing you'll need to do, is get your local environment setup so that you can add/change content and make sure it looks right, before raising a Pull Request.

We'll go through each step below, but here's what you need to get started:

* [Git](https://git-scm.com) and a [GitHub](https://github.com) account
* Fork and clone the `jx/jx-docs` repo
* Install Docker
* Build a Hugo docker image to preview changes

## Install Git on your system

Git is a [version control system](https://en.wikipedia.org/wiki/Version_control) to track the changes of source code.

You will need to have Git installed on your computer to contribute to Jenkins X development. Teaching Git is outside the scope of the Jenkins X docs, but if you're looking for an excellent reference to learn the basics of Git, we recommend the [Git book](https://git-scm.com/book/) if you are not sure where to begin.

Move back to the terminal and check if Git is already installed. Type in `git version` and press enter. You can skip the rest of this section if the command returned a version number. Otherwise [download](https://git-scm.com/downloads) the latest version and follow this [installation guide](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).

Finally, check again with `git version` if Git was installed successfully.

### Git Graphical Front Ends

There are several [GUI clients](https://git-scm.com/downloads/guis) that help you to operate Git. Not all are available for all operating systems and maybe differ in their usage. Thus, we will use the command line since the commands are everywhere the same.

## Create a GitHub Account

If you're going to contribute code, you'll need to have an account on GitHub. Go to [www.github.com/join](https://github.com/join) and set up a personal account.

## Set up your working copy

The working copy is set up locally on your computer. It's what you'll edit, compile, and end up pushing back to GitHub. The main steps are cloning the repository and creating your fork as a remote.

### Fork the repository

If you're not familiar with this term, GitHub's [help pages](https://help.github.com/articles/fork-a-repo/) provide again a simple explanation:

> A fork is a copy of a repository. Forking a repository allows you to freely experiment with changes without affecting the original project.

Open the [Jenkins X docs repository](https://github.com/jenkins-x/jx-docs) on GitHub and click on the "Fork" button in the top right.

### Clone your fork locally

Now open your fork repository on GitHub and copy the remote url of your fork. You can choose between HTTPS and SSH as protocol that Git should use for the following operations. HTTPS works always [if you're not sure](https://help.github.com/articles/which-remote-url-should-i-use/).

![Copy remote url](/images/contribute/development/copy-remote-url.png)

Then go back to your terminal, `cd` to where you would like to place your local copy of the `jx-docs` repo, and then clone your fork.

```shell
$ git clone git@github.com:<username>/jx-docs.git
$ cd jx-docs
```

Add the conventional upstream `git` remote in order to fetch changes from `jx-docs` main master
branch and to create pull requests:

```shell
$ git remote add upstream https://github.com/jenkins-x/jx-docs.git
```

Let's check if everything went right by listing all known remotes:

```shell
$ git remote -v
```

The output should look similar to:

```
origin    git@github.com:<username>/jx-docs.git (fetch)
origin    git@github.com:<username>/jx-docs.git (push)
upstream  https://github.com/jenkins-x/jx-docs (fetch)
upstream  https://github.com/jenkins-x/jx-docs (push)
```

### Install Docker

How to install a Docker engine depends on your platform etc., so best to head over to [Docker](https://docs.docker.com/install/) to find the right one.

## Typical Workflow

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

### Create a new branch

You should generally create a branch for each "chunk of work" that you take on. If you wanted to update two completely different parts of the site, you should create two separate branches instead of one (unless it's the same change across a bunch of files...there are always exceptions to the rule).

The reason for the separate branches is to make it easier to get each change merged into the main repo. If one of your changes required no changes, but your second change required a lot of changes, having two branches instead of one would allow your first change to be merged separately from your second.

Naming is also important when creating branches ("blabla 24" is not as meaningful as "minor grammatical fixes") and so is the process of creating a branch. You'd want to start off on at the right spot, so that your changes don't get mixed up. Here's how to do that:

```
$ git fetch upstream
$ git checkout master
$ git merge upstream/master
```

This ensures that you're starting from where ever the live website is, so you avoid including other commits you might have added since the last update of the site.

Now create your branch with a meaningful name:

```bash
$ git checkout -b <BRANCH-NAME>
```

### Start the Hugo server

The documentation (and the rest of the website) is generated using the static site generator [Hugo](https://gohugo.io), and you'll need a copy of that locally to be able to preview the site.

To make this as easy as possible, we've created a Dockerfile and a docker-compose.yml file that you can use spin up a preview server without having to install a bunch of other software.

First make sure you're in the folder with the cloned repo (if you haven't done anything in your terminal since cloning the repo, just run `cd jx-docs`), then run the following command to build and start the Hugo server:

```bash
$ docker-compose up -d server
```

This will make the site available on http://localhost:1313/ and it will auto-update when you save changes to any of the files in the repo.

**Note**: if you want to stop the server or if it stops auto-rebuilding and you want to restart it, simply run `docker-compose down server` and wait for it to finish. This will shut down the server and kill the container as well.

### Make Changes

All pages are written in GitHub-flavored markdown (see [below](#syntax-reference) for details on syntax).

Some things, like the footer etc. are in the `/themes/gohugoioTheme` structure, but most likely you'll just be adding/changing things in the various page structures.


### Add new Content

The Jenkins X docs make heavy use of Jenkins X's [archetypes][] feature. All content sections in Jenkins X documentation have an assigned archetype.

Adding new content to the Jenkins X docs follows the same pattern, regardless of the content section:

```
$ docker-compose run server new <DOCS-SECTION>/<new-content-lowercase>.md
```

### Commit and push your changes

When you've finished, and verified that everything looks good (using the Hugo server), you should run one last check to verify that you didn't break anything.

**Checking References and Links**

We're using a tool called [htmltest](https://github.com/wjdp/htmltest) to check that links are still valid etc. so you just need to run the following commands to build the site locally, and verify that everything looks good:

```bash
$ docker-compose run server hugo
$ docker-compose up linkchecker
```

**Checking Spelling**

For spell checking, we're using [node-markdown-spellcheck](https://github.com/lukeapage/node-markdown-spellcheck) to run through all our markdown files and list any spelling issue or unknown word it can find.

To make this as simple as possible, just run the following command

```bash
$ docker-compose up spellchecker
```

This will output any issue the spell checker have found.

It's likely that the report includes words that are spelled correctly, but that just means the spell checker is not aware of the correct spelling (happens a lot for technical terms, commands, etc.). Please edit the `.spelling` file and add the unknown word.
Also, please try and keep the list alphabetically sorted; makes it easier to navigate when you're looking for something

**Commit & Push**

If everything is good, you can commit your changes, and push them to your fork:

```bash
$ git push --set-upstream origin <BRANCH-NAME>
```

If you need to push more commits to the same branch, you can just use `git push` going forward; set-upstream is only needed once.

### Raise a Pull Request

Github is generally very helpful in letting you raise a pull request from your fork to the main `jx-docs` repo. You'll need to add a few labels etc. though, so make sure your PR is seen and reviewed:

* assign the PR to yourself
* add the PR to the `Jenkins X Documentation` project

You can leave the rest blank; reviewers and labels will be added automatically.

### Review Process

The final part of all of this, is letting others review your work and provide feedback. As a rule of thumb, the conversation should happen on the PR, but sometimes things will be sorted out via Slack or a video call.

Sometimes it may take a few days for a review to happen (depends on how many are monitoring the [Jenkins X Documentation]() project). If you feel it's an urgent change, jump on the community slack channel `#jenkins-x-user` and ask for someone to review your PR.

Once the review is done, your changes will be merged into the master branch, and the site will be updated.

## Working With The Local Hugo Server

As you're changing things and adding new content, your local Hugo server might get a bit wonky at times or you'll want to see what errors it's throwing. Here's a few simple commands to work with your local Hugo:

### See the Hugo Logs

```cmd
$ docker-compose logs -f server
```

Leave `-f` off if you don't want new log entries to show up in your console. (ctrl-c to escape when `-f` is on)

### Restart the Hugo Server

```cmd
$ docker-compose restart server
```

### Stop the Hugo Server

```cmd
$ docker-compose stop server
```

or

```cmd
$ docker-compose down
```

to shut down everything started by docker-compose

## Syntax Reference

### Standard Syntax

Across all pages on the Jenkins X docs, the typical triple-back-tick markdown syntax is used. If you do not want to take the extra time to implement the following code block shortcodes, please use standard GitHub-flavored markdown. The Jenkins X docs use a version of [highlight.js](https://highlightjs.org/) with a specific set of languages.

Your options for languages are `xml`/`html`, `go`/`golang`, `md`/`markdown`/`mkd`, `handlebars`, `apache`, `toml`, `yaml`, `json`, `css`, `asciidoc`, `ruby`, `powershell`/`ps`, `scss`, `sh`/`zsh`/`bash`/`git`, `http`/`https`, and `javascript`/`js`.
````md
```go
// CommandInterface defines the interface for a Command
//go:generate pegomock generate github.com/jenkins-x/jx/pkg/util CommandInterface -o mocks/command_interface.go
type CommandInterface interface {
	DidError() bool
	DidFail() bool
	Error() error
	Run() (string, error)
	RunWithoutRetry() (string, error)
	SetName(string)
	SetDir(string)
	SetArgs(\[]string)
	SetTimeout(time.Duration)
	SetExponentialBackOff(\*backoff.ExponentialBackOff)
}
```
````
becomes

```go
// CommandInterface defines the interface for a Command
//go:generate pegomock generate github.com/jenkins-x/jx/pkg/util CommandInterface -o mocks/command_interface.go
type CommandInterface interface {
	DidError() bool
	DidFail() bool
	Error() error
	Run() (string, error)
	RunWithoutRetry() (string, error)
	SetName(string)
	SetDir(string)
	SetArgs(\[]string)
	SetTimeout(time.Duration)
	SetExponentialBackOff(\*backoff.ExponentialBackOff)
}
```

## Blockquotes

Blockquotes can be added to the Jenkins X documentation using [typical Markdown blockquote syntax][bqsyntax]:

```
> Without the threat of punishment, there is no joy in flight.
```

The preceding blockquote will render as follows in the Jenkins X docs:

> Without the threat of punishment, there is no joy in flight.

However, you can add a quick and easy `<cite>` element (added on the client via JavaScript) by separating your main blockquote and the citation with a hyphen with a single space on each side:

```
> Without the threat of punishment, there is no joy in flight. - [Kobo Abe](https://en.wikipedia.org/wiki/Kobo_Abe)
```

Which will render as follows in the Jenkins X docs:

> Without the threat of punishment, there is no joy in flight. - [Kobo Abe][abe]

[abe]: https://en.wikipedia.org/wiki/Kobo_Abe
[archetypes]: /content-management/archetypes/
[bqsyntax]: https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet#blockquotes
[charcount]: http://www.lettercount.com/
[`docs/static/images/showcase/`]: https://github.com/jenkins-x/jx/tree/master/docs/static/images/showcase/
[ghforking]: https://help.github.com/articles/fork-a-repo/
[hugodev]: /docs/contributing/code/
[shortcodeparams]: content-management/shortcodes/#shortcodes-without-markdown
[sourceforge]: http://docutils.sourceforge.net/docs/ref/rst/directives.html#admonitions
[templating function]: /functions/
