---
title: 文档贡献
linktitle: 文档
description: 如何完善 Jenkins X 文档
---

## 创建派生库

最好在你本地的机器上修改 Jenkins X 文档，检查视觉风格一致。确保你已经在 GitHub 上派生了 [jx-docs](https://github.com/jenkins-x/jx-docs)，并在你的机器上克隆了这个库。更多信息，你可以查看 [GitHub 的"派生"文档][ghforking] 或者按照 [Jenkins X 开发贡献指导][hugodev]。

然后，你可以创建一个独立的分支。一定要选择符合内容类型的描述性分支名称。下面的一个示例分支的名称，你可以用于添加一个新的网站用于展示：

```sh
git checkout -b jon-doe-showcase-addition
```

## 添加新的内容

Jenkins X 文档重用 Jenkins X 的[骨架][archetypes]特点。在 Jenkins X 文档中所有内容章节都分配了骨架。

向 Jenkins X 中添加新的内容遵循下面相似的模式，不用考虑内容章节：

```sh
hugo new <DOCS-SECTION>/<new-content-lowercase>.md
```

### 语法标准

Jenkins X 文档中所有的页面，使用典型的三个反引号这样的语法。如果你不想花额外的时间来遵循下面的代码块简码，请使用标准的 GitHub 风格的 markdown。Jenkins X 使用 [highlight.js](https://highlightjs.org/) 的一组语言。

你可选的语言是 `xml`/`html`, `go`/`golang`, `md`/`markdown`/`mkd`, `handlebars`, `apache`, `toml`, `yaml`, `json`, `css`, `asciidoc`, `ruby`, `powershell`/`ps`, `scss`, `sh`/`zsh`/`bash`/`git`, `http`/`https`, 和 `javascript`/`js`.

```html
<h1>Hello world!</h1>
```

## 块引用

块引用可以通过 [典型的 Markdown 块引用语法][bqsyntax] 添加到 Jenkins X 文档中：

```txt
> Without the threat of punishment, there is no joy in flight.
```

上面的块引用会在 Jenkins X 文档中渲染为：

> Without the threat of punishment, there is no joy in flight.

然而，你可以简单快速地添加一个 `<cite>` 元素（通过 JavaScript 在客户端添加），通过在连字符两边添加空格来区分你的块引用和参考。

```txt
> Without the threat of punishment, there is no joy in flight. - [Kobo Abe](https://en.wikipedia.org/wiki/Kobo_Abe)
```

这样会在 Jenkins X 文档中渲染为：

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
