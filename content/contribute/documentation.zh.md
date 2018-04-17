---
title: Contribute to the Documentation
linktitle: Documentation
description: How to help improve the Jenkins X documentation
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
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

## Create Your Fork

It's best to make changes to the Jenkins X docs on your local machine to check for consistent visual styling. Make sure you've created a fork of [jx-docs](https://github.com/jenkins-x/jx-docs) on GitHub and cloned the repository locally on your machine. For more information, you can see [GitHub's documentation on "forking"][ghforking] or follow along with [Jenkins X's development contribution guide][hugodev].

You can then create a separate branch for your additions. Be sure to choose a descriptive branch name that best fits the type of content. The following is an example of a branch name you might use for adding a new website to the showcase:

```
git checkout -b jon-doe-showcase-addition
```

## Add New Content

The Jenkins X docs make heavy use of Jenkins X's [archetypes][] feature. All content sections in Jenkins X documentation have an assigned archetype.

Adding new content to the Jenkins X docs follows the same pattern, regardless of the content section:

```
hugo new <DOCS-SECTION>/<new-content-lowercase>.md
```

### Standard Syntax

Across all pages on the Jenkins X docs, the typical triple-back-tick markdown syntax is used. If you do not want to take the extra time to implement the following code block shortcodes, please use standard GitHub-flavored markdown. The Jenkins X docs use a version of [highlight.js](https://highlightjs.org/) with a specific set of languages.

Your options for languages are `xml`/`html`, `go`/`golang`, `md`/`markdown`/`mkd`, `handlebars`, `apache`, `toml`, `yaml`, `json`, `css`, `asciidoc`, `ruby`, `powershell`/`ps`, `scss`, `sh`/`zsh`/`bash`/`git`, `http`/`https`, and `javascript`/`js`.

```
```
<h1>Hello world!</h1>
```
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
