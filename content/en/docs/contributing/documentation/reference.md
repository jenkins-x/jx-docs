---
title: References
linktitle: References
description: Additional reference documentation when working on the Jenkins X site
weight: 30
---

The following sections contains other information that's helpful when working with Hugo and the Jenkins X site; you don't necessary need to go through this if this is your first time.

## Search by Algolia/DocSearch

We're using [DocSearch](https://community.algolia.com/docsearch/) by Algolia to power the internal search.

* The script and local config are declared in `/layouts/partials/scripts.html`
* Styling is included via `/layouts/partials/head-css.html`
* The configuration of the search index is managed via [docsearch-configs](https://github.com/algolia/docsearch-configs/blob/master/configs/jenkins_x.json) which can be updated via a PR

## Markdown Syntax Reference

### Code examples

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

### Blockquotes

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
