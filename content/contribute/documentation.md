---
title: Contribute to the Documentation
linktitle: Documentation
description: How to help improve the Jenkins X documentation
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2019-08-22
categories: [contribute]
keywords: [docs,documentation,community, contribute]
menu:
  docs:
    parent: "contribute"
    weight: 20
weight: 20
sections_weight: 20
draft: false
aliases: [/contribute/docs/]
toc: true
---

Contributing to the documentation is easy, and a great way to get involved. Plus, you don't have to contribute code to be able to contribute to the documentation.

## Getting Started

The first thing you'll need to do, is get your local environment setup so that you can add/change content and make sure it looks right, before raising a Pull Request.

We'll go through each step below, but here's what you need to get started:

* Install Docker
* Fork the `jx/jx-docs` repo
* Build a Hugo docker image to preview changes

### Install Docker

How to install a Docker engine depends on your platform etc., so best to head over to [Docker](https://docs.docker.com/install/) to find the right one.

### Fork the repo

To fork the `jx-docs` repo, simply go to [https://github.com/jenkins-x/jx-docs](https://github.com/jenkins-x/jx-docs) and click the "Fork" button in the top right-hand corner.
Make sure you're logged in to Github first.

You'll also need to create a git reference to the main `jx-docs` repo for when you're creating new branches:

```shell
$ git remote add upstream https://github.com/jenkins-x/jx-docs.git
```

If you want to know more about forking repos, see [GitHub's documentation on "forking"][ghforking]

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

### Code Block Shortcode

The Jenkins X documentation comes with a very robust shortcode for adding interactive code blocks.

{{% note %}}
With the `code` shortcodes, *you must include triple back ticks and a language declaration*. This was done by design so that the shortcode wrappers were easily added to legacy documentation and will be that much easier to remove if needed in future versions of the Jenkins X docs.
{{% /note %}}

### `code`

`code` is the Jenkins X docs shortcode you'll use most often. `code` requires has only one named parameter: `file`. Here is the pattern:

```
{{%/* code file="smart/file/name/with/path.html" download="download.html" copy="true" */%}}
```
A whole bunch of coding going on up in here!
```
{{%/* /code */%}}
```

The following are the arguments passed into `code`:

***`file`***
: the only *required* argument. `file` is needed for styling but also plays an important role in helping users create a mental model around Jenkins X's directory structure. Visually, this will be displayed as text in the top left of the code block.

`download`
: if omitted, this will have no effect on the rendered shortcode. When a value is added to `download`, it's used as the filename for a downloadable version of the code block.

`copy`
: a copy button is added automatically to all `code` shortcodes. If you want to keep the filename and styling of `code` but don't want to encourage readers to copy the code (e.g., a "Do not do" snippet in a tutorial), use `copy="false"`.

#### Example `code` Input

This example HTML code block tells Jenkins X users the following:

1. This file *could* live in `layouts/_default`, as demonstrated by `layouts/_default/single.html` as the value for `file`.
2. This snippet is complete enough to be downloaded and implemented in a Jenkins X project, as demonstrated by `download="single.html"`.

```
{{</* code file="layouts/_default/single.html" download="single.html" */>}}
{{ define "main" }}
<main>
    <article>
        <header>
            <h1>{{.Title}}</h1>
            {{with .Params.subtitle}}
            <span>{{.}}</span>
        </header>
        <div>
            {{.Content}}
        </div>
        <aside>
            {{.TableOfContents}}
        </aside>
    </article>
</main>
{{ end }}
{{</* /code */>}}
```

##### Example 'code' Display

The output of this example will render to the Jenkins X docs as follows:

{{< code file="layouts/_default/single.html" download="single.html" >}}
{{ define "main" }}
<main>
    <article>
        <header>
            <h1>{{.Title}}</h1>
            {{with .Params.subtitle}}
            <span>{{.}}</span>
        </header>
        <div>
            {{.Content}}
        </div>
        <aside>
            {{.TableOfContents}}
        </aside>
    </article>
</main>
{{ end }}
{{< /code >}}

<!-- #### Output Code Block

The `output` shortcode is almost identical to the `code` shortcode but only takes and requires `file`. The purpose of `output` is to show *rendered* HTML and therefore almost always follows another basic code block *or* and instance of the `code` shortcode:

```
{{%/* output file="post/my-first-post/index.html" */%}}
```
<h1>This is my First Jenkins X Blog Post</h1>
<p>I am excited to be using Jenkins X.</p>
```
{{%/* /output */%}}
```

The preceding `output` example will render as follows to the Jenkins X docs:

{{< output file="post/my-first-post/index.html" >}}
<h1>This is my First Jenkins X Blog Post</h1>
<p>I am excited to be using Jenkins X.</p>
{{< /output >}} -->

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

{{% note "Blockquotes `!=` Admonitions" %}}
Previous versions of Jenkins X documentation used blockquotes to draw attention to text. This is *not* the [intended semantic use of `<blockquote>`](http://html5doctor.com/cite-and-blockquote-reloaded/). Use blockquotes when quoting. To note or warn your user of specific information, use the admonition shortcodes that follow.
{{% /note %}}

## Admonitions

**Admonitions** are common in technical documentation. The most popular is that seen in [reStructuredText Directives][sourceforge]. From the SourceForge documentation:

> Admonitions are specially marked "topics" that can appear anywhere an ordinary body element can. They contain arbitrary body elements. Typically, an admonition is rendered as an offset block in a document, sometimes outlined or shaded, with a title matching the admonition type. - [SourceForge][sourceforge]

The Jenkins X docs contain three admonitions: `note`, `tip`, and `warning`.

### `note` Admonition

Use the `note` shortcode when you want to draw attention to information subtly. `note` is intended to be less of an interruption in content than is `warning`.

#### Example `note` Input

{{< code file="note-with-heading.md" >}}
{{%/* note */%}}
Here is a piece of information I would like to draw your **attention** to.
{{%/* /note */%}}
{{< /code >}}

#### Example `note` Output

{{< output file="note-with-heading.html" >}}
{{% note %}}
Here is a piece of information I would like to draw your **attention** to.
{{% /note %}}
{{< /output >}}

#### Example `note` Display

{{% note %}}
Here is a piece of information I would like to draw your **attention** to.
{{% /note %}}

### `tip` Admonition

Use the `tip` shortcode when you want to give the reader advice. `tip`, like `note`, is intended to be less of an interruption in content than is `warning`.

#### Example `tip` Input

{{< code file="using-tip.md" >}}
{{%/* tip */%}}
Here's a bit of advice to improve your productivity with Jenkins X.
{{%/* /tip */%}}
{{< /code >}}

#### Example `tip` Output

{{< output file="tip-output.html" >}}
{{% tip %}}
Here's a bit of advice to improve your productivity with Jenkins X.
{{% /tip %}}
{{< /output >}}

#### Example `tip` Display

{{% tip %}}
Here's a bit of advice to improve your productivity with Jenkins X.
{{% /tip %}}

### `warning` Admonition

Use the `warning` shortcode when you want to draw the user's attention to something important. A good usage example is for articulating breaking changes in Jenkins X versions, known bugs, or templating "gotchas."

#### Example `warning` Input

{{< code file="warning-admonition-input.md" >}}
{{%/* warning */%}}
This is a warning, which should be reserved for *important* information like breaking changes.
{{%/* /warning */%}}
{{< /code >}}

#### Example `warning` Output

{{< output file="warning-admonition-output.html" >}}
{{% warning %}}
This is a warning, which should be reserved for *important* information like breaking changes.
{{% /warning %}}
{{< /output >}}

#### Example `warning` Display

{{% warning %}}
This is a warning, which should be reserved for *important* information like breaking changes.
{{% /warning %}}

{{% note "Pull Requests and Branches" %}}
Similar to [contributing to Jenkins X development](/contribute/development/), the Jenkins X team expects you to create a separate branch/fork when you make your contributions to the Jenkins X docs.
{{% /note %}}

[abe]: https://en.wikipedia.org/wiki/Kobo_Abe
[archetypes]: /content-management/archetypes/
[bqsyntax]: https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet#blockquotes
[charcount]: http://www.lettercount.com/
[`docs/static/images/showcase/`]: https://github.com/jenkins-x/jx/tree/master/docs/static/images/showcase/
[ghforking]: https://help.github.com/articles/fork-a-repo/
[hugodev]: /contribute/development/
[shortcodeparams]: content-management/shortcodes/#shortcodes-without-markdown
[sourceforge]: http://docutils.sourceforge.net/docs/ref/rst/directives.html#admonitions
[templating function]: /functions/
