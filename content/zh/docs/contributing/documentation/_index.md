---
title: 文档贡献
linktitle: 文档
description: 如何完善 Jenkins X 文档
---

## 创建派生库

最好在你本地的机器上修改 Jenkins X 文档，检查视觉风格一致。确保你已经在 GitHub 上派生了 [jx-docs](https://github.com/jenkins-x/jx-docs)，并在你的机器上克隆了这个库。更多信息，你可以查看 [GitHub 的"派生"文档][ghforking] 或者按照 [Jenkins X 开发贡献指导][hugodev]。

然后，你可以创建一个独立的分支。一定要选择符合内容类型的描述性分支名称。下面的一个示例分支的名称，你可以用于添加一个新的网站用于展示：

```
git checkout -b jon-doe-showcase-addition
```

## 添加新的内容

Jenkins X 文档重用 Jenkins X 的[骨架][archetypes]特点。在 Jenkins X 文档中所有内容章节都分配了骨架。

向 Jenkins X 中添加新的内容遵循下面相似的模式，不用考虑内容章节：

```
hugo new <DOCS-SECTION>/<new-content-lowercase>.md
```

### 语法标准

Jenkins X 文档中所有的页面，使用典型的三个反引号这样的语法。如果你不想花额外的时间来遵循下面的代码块简码，请使用标准的 GitHub 风格的 markdown。Jenkins X 使用 [highlight.js](https://highlightjs.org/) 的一组语言。

你可选的语言是 `xml`/`html`, `go`/`golang`, `md`/`markdown`/`mkd`, `handlebars`, `apache`, `toml`, `yaml`, `json`, `css`, `asciidoc`, `ruby`, `powershell`/`ps`, `scss`, `sh`/`zsh`/`bash`/`git`, `http`/`https`, 和 `javascript`/`js`.

```
<h1>Hello world!</h1>
```

## 块引用

块引用可以通过 [典型的 Markdown 块引用语法][bqsyntax] 添加到 Jenkins X 文档中：

```
> Without the threat of punishment, there is no joy in flight.
```

上面的块引用会在 Jenkins X 文档中渲染为：

> Without the threat of punishment, there is no joy in flight.

然而，你可以简单快速地添加一个 `<cite>` 元素（通过 JavaScript 在客户端添加），通过在连字符两边添加空格来区分你的块引用和参考。

```
> Without the threat of punishment, there is no joy in flight. - [Kobo Abe](https://en.wikipedia.org/wiki/Kobo_Abe)
```

这样会在 Jenkins X 文档中渲染为：

> Without the threat of punishment, there is no joy in flight. - [Kobo Abe][abe]

{{% note "Blockquotes `!=` Admonitions" %}}
Previous versions of Jenkins X documentation used blockquotes to draw attention to text. This is *not* the [intended semantic use of `<blockquote>`](http://html5doctor.com/cite-and-blockquote-reloaded/). Use blockquotes when quoting. To note or warn your user of specific information, use the admonition shortcodes that follow.
{{% /note %}}

## 警告

**警告** 在技术性文档中是常见的。最常见的是在 [reStructuredText Directives][sourceforge]。从 SourceForge 的文档中摘录：

> Admonitions are specially marked "topics" that can appear anywhere an ordinary body element can. They contain arbitrary body elements. Typically, an admonition is rendered as an offset block in a document, sometimes outlined or shaded, with a title matching the admonition type. - [SourceForge][sourceforge]

Jenkins X 文档包含三种警告：`note`, `tip`, and `warning`。

### `note` 警告

当你想要巧妙地提示信息是，可以使用简码 `note` 。`note` 不像 `warning` 那样会打断内容。

#### 示例 `note` 输出

```
{{% note %}}
Here is a piece of information I would like to draw your **attention** to.
{{% /note %}}
```

#### 示例 `note` 显示

{{% note %}}
Here is a piece of information I would like to draw your **attention** to.
{{% /note %}}

### `tip` 警告

当你想要给读者建议时，使用简码 `tip` 。`tip`， 有点像 `note`，不像 `warning` 那样会打断内容。

#### 示例 `tip` 输出

```
{{% tip %}}
Here's a bit of advice to improve your productivity with Jenkins X.
{{% /tip %}}
```

#### 示例 `tip` 显示

{{% tip %}}
Here's a bit of advice to improve your productivity with Jenkins X.
{{% /tip %}}

### `warning` 警告

当你想要使用户引起注意时，使用 `warning` 简码。一个好的例子就是，当在 Jenkins X 版本中会引起阻断变更时，已知问题，或者模板“陷阱”。

#### 示例 `warning` 输出

```
{{% warning %}}
This is a warning, which should be reserved for *important* information like breaking changes.
{{% /warning %}}
```

#### 示例 `warning` 显示

{{% warning %}}
这是一个警告，用于 *重要的* 信息，例如破坏性改变。
{{% /warning %}}

{{% note "Pull Requests and Branches" %}}
和 [给 Jenkins X 贡献开发](/zh/docs/contributing/code/)相似，当你想要给 Jenkins X 文档贡献时 Jenkins X 团队期望你创建一个独立的分支（派生）。
{{% /note %}}

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
