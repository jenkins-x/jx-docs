---
title: Contribute to the API Documentation
linktitle: API Documentation
description: How to help improve the Jenkins X API documentation
weight: 10
---

Jenkins X has two types of API documentation: [Kubernetes Custom Resource Documentation](/apidocs) and [Godoc](https://godoc.org/github.com/jenkins-x/jx).
Both types are generated from the `codegen` binary which is part of the jx [repository](https://github.com/jenkins-x/jx).

## Setup your development environment

It's best to make changes to the Jenkins X code on your local machine. Follow the [development](../development) guide
to get set up.

## Writing custom resource documentation

The custom resource documentation is mostly generated from the comments on the [go structs](https://github.com/jenkins-x/jx/tree/master/pkg/apis/jenkins.io/v1) that define the custom resources, with the [introductory content](https://github.com/jenkins-x/jx/tree/master/docs/apidocs/static_includes) and [structure](https://github.com/jenkins-x/jx/blob/master/docs/apidocs/config.yaml) injected.

### Toolchain

The custom resource documentation is generated using the [same toolchain](https://kubernetes.io/docs/contribute/generate-ref-docs/kubernetes-api/) as Kubernetes, but wrapped up in a series of `codegen` commands so that you don't have to download and setup the different tools yourself.

The HTML docs are generated via an [OpenAPI specification](https://github.com/jenkins-x/jx/tree/master/docs/apidocs/openapi-spec) which in turn is generated from [Go Structs](https://github.com/jenkins-x/jx/tree/master/pkg/client/openapi) which are generated from the code comments.
To generate the structs and the OpenAPI specification run:

 ```sh
 make generate-openapi
 ```

 {{% alert %}}
 `make generate-openapi` is just a wrapper for `codegen openapi`, passing in package to generate from, generate to, and the group (`jenkins.io`) and version (`v1`) to generate for.
 You can run this command directly if you prefer.
 {{% /alert %}}

 and to generate the HTML run:

 ```sh
 make generate-docs
 ```

{{% alert %}}
`make generate-docs` is just a wrapper for `codegen docs`. You can run this command directly if you prefer.
{{% /alert %}}

You should run `make generate-openapi` whenever you change the custom resources, and check the generated changes into
 source control. This means that there is always a tagged version of the OpenAPI spec available for others to use.

{{% alert %}}
You can also run `make generate` which will do all the code generation needed by Jenkins X (mocks and client as well
as openapi)
{{% /alert %}}

 `make generate-docs` is run by the release build, and the changes are automatically uploaded to the Jenkins X
 website on every release. They'll be available a few minutes after the release build completes.

### Making changes to the documentation

Each file for which you want to generate docs must be located in the [jenkins.io/v1](https://github.com/jenkins-x/jx/tree/master/pkg/apis/jenkins.io/v1) directory, and must have a the

```go
// +k8s:openapi-gen=true
```

comment at the top of the file.

To exclude a type or member, add

```go
// +k8s:openapi-gen=false
```

to it.

Comments on types are ignored. Comments on struct fields are used as the description for each field.

The left hand menu is generated from the `resource_categories` in [config.yaml](https://github.com/jenkins-x/jx/blob/master/docs/apidocs/config.yaml). The introductory text for each category is authored as
[html](https://github.com/jenkins-x/jx/tree/master/docs/apidocs/static_includes).

The styles can [also be customized](https://github.com/jenkins-x/jx/blob/master/docs/apidocs/static/stylesheet.css).

### OpenAPI

The OpenAPI spec is generated from the code. The structure is generated from the structs and fields. The `json`
[tags](https://golang.org/pkg/encoding/json/#Marshal) are used to provide additional information including:

* `name` is generated from the `key`
* if `omitempty` is not set, the property will be `required`
* if the `key` is `-` the field will be skipped
* if `inline` is set, the properties will be inlined into the parent object


Additionally the

```go
// +optional
```

comment can be used to prevent a property being `required`. For example:

```go
  metav1.TypeMeta `json:",inline"
	// +optional
	metav1.ObjectMeta `json:"metadata,omitempty" protobuf:"bytes,1,opt,name=metadata"`
  Spec BuildPackSpec `json:"spec,omitempty" protobuf:"bytes,2,opt,name=spec"`
```

#### OpenAPI Extensions

OpenAPI spec can have extensions on types. To define one or more extensions on a type or its member
add `+k8s:openapi-gen=x-kubernetes-$NAME:$VALUE` to the comment lines before type/member. A type/member can
have multiple extensions. The rest of the line in the comment will be used as $VALUE so there is no need to
escape or quote the value string. Extensions can be used to pass more information to client generators or
documentation generators. For example a type might have a friendly name to be displayed in documentation or
being used in a client's fluent interface.

#### Custom OpenAPI type definitions

Custom types which otherwise don't map directly to OpenAPI can override their
OpenAPI definition by implementing a function named "OpenAPIDefinition" with
the following signature:

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

Alternatively, the type can avoid the "openapi" import by defining the following
methods. The following example produces the same OpenAPI definition as the
example above:

```go
    func (_ Time) OpenAPISchemaType() []string { return []string{"string"} }
    func (_ Time) OpenAPISchemaFormat() string { return "date-time" }
```

## Write Godoc

Jenkins X uses the standard approach to Godoc, and it is automatically generated by [godoc.org](http://godoc.org).
This [blog](https://blog.golang.org/godoc-documenting-go-code) provides a good introduction to writing Godoc.
