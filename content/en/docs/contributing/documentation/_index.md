---
title: Contribute to the Documentation
linktitle: Documentation
description: How to help improve the Jenkins X documentation
weight: 10
---

We welcome your contributions to Jenkins X documentation whether you are a developer, an end user of Jenkins X, or someone who can't stand seeing typos!

# Assumptions

This contribution guide takes a step-by-step approach in hopes of helping newcomers. Therefore, we only assume the following:

* You are new to Git or open-source projects in general
* You are a fan of Jenkins X and enthusiastic about contributing to the project

{{% alert %}}
If you're struggling at any point in this contribution guide, reach out to the Jenkins X community in [Jenkins X's Discussion forum](/community/).
{{% /alert %}}

## Getting Started

The first thing you'll need to do is get your local environment setup, so that you can add/change content and make sure it looks right before raising a Pull Request.

We'll go through each step below, but here's what you need to get started:

* [Git](https://git-scm.com) and a [GitHub](https://github.com) account
* A local working copy of the code
* A way to run the site locally to check your changes before submitting them

## Install Git on your system

Git is a [version control system](https://en.wikipedia.org/wiki/Version_control) to track the changes of source code.

You will need to have Git installed on your computer to contribute to Jenkins X development. Teaching Git is outside the scope of the Jenkins X docs, but if you're looking for an excellent reference to learn the basics of Git, we recommend the [Git book](https://git-scm.com/book/) if you are not sure where to begin.

Move back to the terminal and check if Git is already installed. Type `git version` and press enter. If the command returned a version number, you can skip the rest of this section.

Otherwise, [download](https://git-scm.com/downloads) the latest version and follow this [installation guide](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).

Finally, run `git version` again to check if Git was installed successfully.

### Git Graphical Front Ends

There are several [GUI clients](https://git-scm.com/downloads/guis) that help you to operate Git. Not all are available for all operating systems and maybe differ in their usage. Thus, we will use the command line since the commands are everywhere the same.

## Create a GitHub Account

If you're going to contribute to the docs, you'll need to have an account on GitHub. Go to [www.github.com/join](https://github.com/join) and set up a personal account.

## Set up your working copy

The working copy is set up locally on your computer. It's what you'll edit, compile, and end up pushing back to GitHub. The main steps are cloning the repository and creating your fork as a remote.

### Fork the repository

If you're not familiar with this term, GitHub's [help pages](https://help.github.com/articles/fork-a-repo/) provide a simple explanation:

> A fork is a copy of a repository. Forking a repository allows you to freely experiment with changes without affecting the original project.

Open the [Jenkins X docs repository](https://github.com/jenkins-x/jx-docs) on GitHub and click on the "Fork" button in the top right.

### Clone your fork locally

Now open your fork repository on GitHub and copy the remote url of your fork. You can choose between HTTPS and SSH as protocol that Git should use for the following operations. HTTPS works always [if you're not sure](https://help.github.com/articles/which-remote-url-should-i-use/).

![Copy remote url](/images/contribute/development/copy-remote-url.png)

Then go back to your terminal, `cd` to where you would like to place your local copy of the `jx-docs` repo, and then clone your fork.

```sh
git clone --recurse-submodules --depth 1 git@github.com:<YOUR_USERNAME>/jx-docs.git
cd jx-docs
```

{{% alert %}}
In case you already have a git clone locally (from before the theme change) then run the following to pull the Docsy theme and dependencies

```sh
git submodule update --init --recursive
```
{{% /alert %}}

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

## Local preview environment

The documentation (and the rest of the website) is generated using the static site generator [Hugo](https://gohugo.io), and you'll need a copy of that locally to be able to preview the site.

Although Jenkins X offers preview environments, and they're used as part of the process of contributing documentation, it's usually faster to run the site locally and check that everything looks good for you, before you push your changes.

There are two different ways that you can run the site locally: using a locally installed version of Hugo or using a pre-baked Docker image that includes what's normally needed. Which approach you choose is fully up to you.

### Docker/docker-compose method

If you haven't worked with Hugo before, or don't want to install it locally, this is your best option.

The first thing you'll need to make use of this approach is Docker installed on your local environment. How to install a Docker engine depends on your platform etc., so best to head over to [Docker](https://docs.docker.com/install/) to find the right one.

To make it as simple as possible, we've created and published Docker images installed with what's normally needed to run and work with Hugo, and have setup a `docker-compose.yml` file that will help you start up a preview server with a few helpful options.

In order to use this setup, first make sure you're in the folder with your local cloned copy of the `jx-docs` repo, then run the following command to download and start the Hugo server:

```sh
npm install
docker-compose up -d server
```

This will make the site available on http://localhost:1313/ and it will auto-update when you save changes to any of the files in the repo.

To be able to see what's going on, and know when the site is ready (can take a bit to process when you first start up), you can run this command (ctrl-c to stop watching the logs):

```sh
docker-compose logs -f server
```

You'll know the site is ready when you see something like:

```sh
server_1        | Watching for changes in /src/{assets,content,layouts,static,themes}
server_1        | Watching for config changes in /src/config.toml, /src/themes/docsy/config.toml
server_1        | Environment: "development"
server_1        | Serving pages from memory
server_1        | Running in Fast Render Mode. For full rebuilds on change: hugo server --disableFastRender
server_1        | Web Server is available at //localhost:1313/ (bind address 0.0.0.0)
server_1        | Press Ctrl+C to stop
```

As you're changing things and adding new content, your local Hugo server might get a bit wonky at times or you'll want to see what errors it's throwing. Here's a few simple commands to work with your local Hugo:

#### See the Hugo Logs

```sh
docker-compose logs -f server
```

Leave `-f` off if you don't want new log entries to show up in your console. (ctrl-c to escape when `-f` is on)

#### Restart the Hugo Server

```sh
docker-compose restart server
```

#### Stop the Hugo Server

```sh
docker-compose stop server
```

or

```sh
docker-compose down
```

### Install Hugo

You need a recent extended version (we recommend version 0.58 or later) of Hugo to do local builds and previews of the Jenkins X documentation site. If you install from the release page, make sure to get the extended Hugo version, which supports SCSS; you may need to scroll down the list of releases to see it.

[Install Hugo following the gohugo.io instructions](https://gohugo.io/getting-started/installing).

Check you're using `Hugo extended` and a version higher than `0.58.0` :

```sh
hugo version
```

The output should look something like `Hugo Static Site Generator v0.58.3/extended darwin/amd64 BuildDate: unknown`

#### Install PostCSS

To build or update your site’s CSS resources, you also need [PostCSS](https://postcss.org/) to create the final assets. If you need to install it, you must have a recent version of `NodeJS` installed on your machine so you can use `npm`, the Node package manager. By default `npm` installs tools under the directory where you run `npm install`:

```sh
sudo npm install -D --save autoprefixer
sudo npm install -D --save postcss-cli
```

Get local copies of the project submodules so you can build and run your site locally:

```sh
git submodule update --init --recursive
```

#### Starting the preview server

Build the site:

```sh
hugo server
```

It's ready when you see something like this:

```sh
Environment: "development"
Serving pages from memory
Running in Fast Render Mode. For full rebuilds on change: hugo server --disableFastRender
Web Server is available at //localhost:1313/ (bind address 127.0.0.1)
Press Ctrl+C to stop
```

Preview your site in your browser at: http://localhost:1313. You can use `Ctrl + c` to stop the Hugo server whenever you like.

It may be a good idea to run the server in a separate terminal so that you can keep it running while also using git or other commands.

#### Using spellchecker and linkchecker

In a later section we'll go over how to use other tools to check for spelling errors or typos, as well as checking that all links are working as expected. If you don't want to use the supplied docker approach, these tools will need to be installed locally as well:

```sh
npm i markdown-spellcheck -g
curl https://htmltest.wjdp.uk | sudo bash -s -- -b /usr/local/bin
```

See [markdown-spellcheck install](https://github.com/lukeapage/node-markdown-spellcheck#cli-usage) and [htmltest install](https://github.com/wjdp/htmltest#system-wide-install) pages for more details on other ways to install them.

{{% alert %}}
Note that at this point in time, htmltest installs as version 0.10.3, which does not include the option `IgnoreSSLVerify` which results in a lot of `x509` errors in the output. The docker option is based on a newer build that's not yet available as an official version
{{% /alert %}}

## Contribution Workflow

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

### Start the Hugo server

In case you don't already have it running, this is a good time to start your local Hugo server. See the previous sections on how to do this, as it depends on how you installed Hugo (locally, or using docker).

If you already have Hugo running, it's usually best to double check that the site looks as you'd expect it (basically the same as the live site) and if something's off, do a quick restart of Hugo.

### Make Changes

All pages are written in GitHub-flavored markdown (see [below](#markdown-syntax-reference) for details on syntax).

Some things, like the footer etc. are in the `/themes/docsy` structure, but most likely you'll just be adding/changing things in the various page structures. If you do make changes that involve the theme, remember to copy-paste the theme file to the appropriate folder in the `/layouts` structure, and make your changes there. If you make changes to files in the `/themes/docsy` structure, they will likely be deleted when we update the theme.

### Add new Content

The Jenkins X docs make heavy use of Jenkins X's archetypes feature. All content sections in Jenkins X documentation have an assigned archetype.

Adding new content to the Jenkins X docs follows the same pattern, regardless of the content section:

```sh
docker-compose run server new <DOCS-SECTION>/<new-content-lowercase>.md
```

### Commit and push your changes

When you've finished, and verified that everything looks good (using the Hugo server), you should run one last check to verify that you didn't break anything.

#### Checking References and Links

We're using a tool called [htmltest](https://github.com/wjdp/htmltest) to check that links are still valid etc. so you just need to run the following commands to build the site locally, and verify that everything looks good:

```sh
docker-compose run server sh -c "cd /src && hugo"
docker-compose up linkchecker
```

If using a locally installed Hugo/htmltest, use these commands instead:

```sh
hugo
htmltest -c .htmltest.yml
```

#### Checking Spelling

For spell checking, we're using [node-markdown-spellcheck](https://github.com/lukeapage/node-markdown-spellcheck) to run through all our markdown files and list any spelling issue or unknown word it can find.

To make this as simple as possible, just run the following command

```sh
docker-compose up spellchecker
```

If using a locally installed Hugo/markdown-spellcheck, use these commands instead:

```sh
mdspell --en-us --ignore-numbers --ignore-acronyms --report "content/**/*.md"
```

This will output any issue the spell checker have found.

It's likely that the report includes words that are spelled correctly, but that just means the spell checker is not aware of the correct spelling (happens a lot for technical terms, commands, etc.). Please edit the `.spelling` file and add the unknown word.
Also, please try and keep the list alphabetically sorted; makes it easier to navigate when you're looking for something

#### Commit & Push

If everything is good, you can commit your changes, and push them to your fork:

```sh
git push --set-upstream origin <BRANCH-NAME>
```

If you need to push more commits to the same branch, you can just use `git push` going forward; set-upstream is only needed once.

## Open a pull request 🎉

In this step, you'll open a pull request to submit your additions. Open either the [Jenkins X documentation master repository](https://github.com/jenkins-x/jx-docs) or your own fork of the respository on GitHub in your browser.

You should find a green button labeled with "New pull request". But GitHub is clever and probably suggests you a pull request like in the beige box below:

![Open a pull request](/images/contribute/development/open-pull-request.png)

Click on the green "Compare and pull request" button. A new page will open which summaries the most important information of your pull request. Scroll down and you'll find the additions of all your commits. Make sure everything looks as expected and click on "Create pull request".

There are a number of automated checks that will run on your PR:

* Semantic Pull Request - validates that your commit messages meet the [Conventional Commit format](https://github.com/probot/semantic-pull-requests#semantic-pull-requests).
  Additionally your PR must also have a conventional message. The UX for this bot is a little odd as it doesn't go red
  if the messages are NOT correct, instead it goes yellow. You need it to go to a green tick!
* tide - performs the merge when all the checks pass. Don't worry about the state of this one, it doesn't add much info.
  Clicking on the details link is very helpful as it will take you to the dashboard where you can navigate to the "Tide"
  screen and check the status of your PR in the merge queue.

### Review Process

The final part of all of this, is letting others review your work and provide feedback. As a rule of thumb, the conversation should happen on the PR, but sometimes things will be sorted out via Slack or a video call.

Sometimes it may take a few days for a review to happen. If you feel it's an urgent change, jump on the [community slack channel](https://jenkins-x.io/community/#slack) `#jenkins-x-user` and ask for someone to review your PR.

Once the review is done, your changes will be merged into the master branch, and the site will be updated.

{{% alert %}}
In case you need to update your PR/branch because js-docs/master have been updated since you submitted your PR, run the followin `git` command to pull all the changes to your local environment and then push them to your PR/branch:

```sh
git fetch upstream
git merge upstream/master
git push
```

If you experience Merge Conflicts, there's a good [article on GitHub](https://help.github.com/en/articles/resolving-a-merge-conflict-using-the-command-line) that helps explain what to do
{{% /alert %}}

## Reference

The following sections contains other information that's helpful when working with Hugo and the Jenkins X site; you don't necessary need to go through this if this is your first time.

### Search by Algolia/DocSearch

We're using [DocSearch](https://community.algolia.com/docsearch/) by Algolia to power the internal search.

* The script and local config are declared in `/layouts/partials/scripts.html`
* Styling is included via `/layouts/partials/head-css.html`
* The configuration of the search index is managed via [docsearch-configs](https://github.com/algolia/docsearch-configs/blob/master/configs/jenkins_x.json) which can be updated via a PR

### Markdown Syntax Reference

#### Code examples

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

#### Blockquotes

Blockquotes can be added to the Jenkins X documentation using [typical Markdown blockquote syntax][bqsyntax]:

```text
> Without the threat of punishment, there is no joy in flight.
```

The preceding blockquote will render as follows in the Jenkins X docs:

> Without the threat of punishment, there is no joy in flight.

However, you can add a quick and easy `<cite>` element (added on the client via JavaScript) by separating your main blockquote and the citation with a hyphen with a single space on each side:

```text
> Without the threat of punishment, there is no joy in flight. - [Kobo Abe](https://en.wikipedia.org/wiki/Kobo_Abe)
```

Which will render as follows in the Jenkins X docs:

> Without the threat of punishment, there is no joy in flight. - [Kobo Abe][abe]

[abe]: https://en.wikipedia.org/wiki/Kobo_Abe
[bqsyntax]: https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet#blockquotes
[charcount]: http://www.lettercount.com/
[`docs/static/images/showcase/`]: https://github.com/jenkins-x/jx/tree/master/docs/static/images/showcase/
[ghforking]: https://help.github.com/articles/fork-a-repo/
[hugodev]: /docs/contributing/code/
[shortcodeparams]: content-management/shortcodes/#shortcodes-without-markdown
[sourceforge]: http://docutils.sourceforge.net/docs/ref/rst/directives.html#admonitions
[templating function]: /functions/
