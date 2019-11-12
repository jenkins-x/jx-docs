---
title: 给 API 文档做贡献
linktitle: API 文档
description: 如何帮助改善 Jenkins X 的 API 文档
---

Jenkins X 有两种类型的 API 文档：[Kubernetes Custom Resource Documentation](/apidocs/) 和 [Godoc](https://godoc.org/github.com/jenkins-x/jx)。这两种类型都是由 [jx](https://github.com/jenkins-x/jx) 的代码生成。


## 设置你的开发环境

最好在你的本地电脑上对 Jenkinx X 的代码进行修改。按照 [开发](/development) 指导文档进行配置。

## 编写自定义资源文档

自定义资源的文档大部分是由 [go structs that define the custom
resources](https://github.com/jenkins-x/jx/tree/master/pkg/apis/jenkins.io/v1) 上的注释以及融合了 [introductory content](https://github.com/jenkins-x/jx/tree/master/docs/apidocs/static_includes) 和 [structure](https://github.com/jenkins-x/jx/blob/master/docs/apidocs/config.yaml) 而生成的。

### 工具链

自定义资源文档是由与 Kubernetes [同样的工具链](https://kubernetes.io/docs/contribute/generate-ref-docs/kubernetes-api/)而生成的，但是一系列的 `jx` 的命令将其包装了起来，因此你不需要下载以及配置这些不同的工具。

HTML 文档是由 [OpenAPI 说明](https://github.com/jenkins-x/jx/tree/master/docs/apidocs/openapi-spec) 生成的，依次的由 [Go 结构体](https://github.com/jenkins-x/jx/tree/master/pkg/client/openapi) 生成，而这些结构体是由代码的注释生成的。想要生成结构体和 OpenAPI 说明执行命令：
 ```sh
 make generate-openapi
 ```

 {{% alert %}}
 `make generate-openapi` 仅仅是对 `jx create client openapi` 进行了包装，通过传入参数：从哪个包来生成、生成的目标包的名称和组（`jenkins.io`）以及版本(`v1`)来生成最终的文件。如果你愿意的话，也可以直接运行这个命令。
 {{% /alert %}}

 生成 HTML 运行：

 ```sh
 make generate-docs
 ```

{{% alert %}}
`make generate-docs` 仅仅是对 `jx create client docs` 进行了包装。 Y如果你愿意的话，也可以直接运行这个命令。
{{% /alert %}}

当你对自定义资源进行了修改的话，应该运行 `make generate-openapi`，并确认将所生成的修改添加到版本控制当中。这意味着对于其他人，在任意时刻都会有标记了版本的 OpenAPI 说明可供使用。

{{% alert %}}
你也可以运行 `make generate` 它会进行所有 Jenins X（mocks、client 以及 OpenAPI）所需要的代码生成工作。
{{% /alert %}}

构建版本时会运行 `make generate-docs`，并且对于每一个版本，更新都会自动的上传到 Jenkins X 的网站上。在版本构建结束的几分钟后会生效。

### 对文档进行修改

对于每一个你想要生成文档的文件必须要在 [jenkins.io/v1](https://github.com/jenkins-x/jx/tree/master/pkg/apis/jenkins.io/v1) 目录中，并且在文件的头部必须有下面的注释：

```go
// +k8s:openapi-gen=true
```

想要移除一个类型或者成员的话，添加：

```go
// +k8s:openapi-gen=false
```

对类型的注释会被忽略。结构体中的字段的注释会被作为其描述信息。
左侧的菜单栏是由 [config.yaml](https://github.com/jenkins-x/jx/blob/master/docs/apidocs/config.yaml) 中的 `resource_categories` 而生成。对于每一个种类的介绍文本信息由 [html](https://github.com/jenkins-x/jx/tree/master/docs/apidocs/static_includes) 编写。

样式风格也可以 [定制化](https://github.com/jenkins-x/jx/blob/master/docs/apidocs/static/stylesheet.css)。

### OpenAPI

OpenAPI 说明是由代码生成的。其结构由结构体以及字段生成。`json` [tags](https://golang.org/pkg/encoding/json/#Marshal) 被用于提供额外的信息包括：

* `name` 由 `key` 生成
* 如果没有设置 `omitempty` 的话，那么这个属性将是 `必需的`
* 如果 `key` 是 `-` 的话，那么将会跳过这个字段
* 如果设置了 `inline` 的话，这些属性将会嵌入到父对象当中

此外，注释可以用于阻止某一属性被设置为 `必需项`

```go
// +optional
```

例如：

```go
  metav1.TypeMeta `json:",inline"
	// +optional
	metav1.ObjectMeta `json:"metadata,omitempty" protobuf:"bytes,1,opt,name=metadata"`
  Spec BuildPackSpec `json:"spec,omitempty" protobuf:"bytes,2,opt,name=spec"`
```

#### OpenAPI 扩展

在类型上， OpenAPI 说明也可以有扩展。想要在一个类型或者成员上添加一个或多个扩展的话，在类型/成员的注释行上添加 `+k8s:openapi-gen=x-kubernetes-$NAME:$VALUE`。一个类型/成员可以有多个扩展。在注释中的的其它的行会被作为 $VALUE 因此不需要躲避或者字符串加上引号。扩展可以用于向客户端或者文档生成器传入更多的信息。例如，一个类型在文档中可以有友好的名称用于展示或者用于客户端流畅的接口。

#### 自定义 OpenAPI 类型定义

自定义类型不会直接的映射到 OpenAPI 当中，而是会通过实现名为 "OpenAPIDefinition" 的方法如下面所示，来覆盖他们的 OpenAPI 说明：

```go
	import openapi "k8s.io/kube-openapi/pkg/common"

	// ...

	type Time struct {
		time.Time
	}

	func (_ Time) OpenAPIDefinition() openapi.OpenAPIDefinition {
		return openapi.OpenAPIDefinition{
			Schema: spec.Schema{
				SchemaProps: spec.SchemaProps{
					Type:   []string{"string"},
					Format: "date-time",
				},
			},
		}
	}
```
此外，类型可以通过定义下面的方法来避免引用 "openapi"。下面的例子会和上面的例子产生相同的 OpenAPI 说明：

```go
    func (_ Time) OpenAPISchemaType() []string { return []string{"string"} }
    func (_ Time) OpenAPISchemaFormat() string { return "date-time" }
```

## 编写 Godoc

Jenkins X 使用标准的方法来生成 Godoc，而且会由 [godoc.org](http://godoc.org) 自动生成。这一[博客](https://blog.golang.org/godoc-documenting-go-code) 为编写 Godoc 提供了很好的介绍。
