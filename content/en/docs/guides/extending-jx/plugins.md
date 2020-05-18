---
title: Binary Plugins for the Jenkins X CLI
linktitle: Binary Plugins
description: Binary Plugins for the Jenkins X CLI
weight: 10
aliases:
    - /docs/contributing/addons/plugins/
---

This guide shows you how to write plugins for the `jx` CLI. Plugins extend the `jx` CLI with new sub-commands allowing for new
features not included in Jenkins X. `jx` plugins can be managed by Jenkins X meaning neither the plugin developer nor
the plugin user has to worry about how to install the plugin onto the user's computer.

You might want to write a plugin for the `jx` CLI if you developed some new functionality for Jenkins X and wanted to provide a
way for the user to easily interact with it via the `jx` CLI rather than make them install a new CLI. This could be particularly
useful inside a pipeline step.

## Before you begin

You need to have a working `jx` binary installed, one newer than around `v1.3.600`. You need to have Go installed.

## Writing Jenkins X CLI plugins

You can write a plugin in any programming language or script that allows you to write command-line commands.

There is no plugin installation or pre-loading required. Plugin executables receive the inherited environment from the
 `jx` binary.

### Example plugin

Here is a simple plugin that simply outputs a log statement.

```go
package main

import (
	"fmt"
	"os"
)

func main() {
	fmt.Println("Have some tasty brie.")
	os.Exit(0)
}
```

We strongly recommend using Go and the [Cobra CLI framework](https://github.com/spf13/cobra). This allows you to easily
build a well structured plugin with subcommands and argument handling.

We [plan](https://github.com/jenkins-x/jx/issues/2832) to build a quickstart and build pack that allows you to
quickly create a new Cobra based plugin.

### Using the plugin

1. Build a binary

```sh
go build -o jx-brie brie.go
```

2. Add it to your path
```sh
sudo mv ./jx-brie /usr/local/bin
```

3. You can now use the plugin

```sh
$ jx brie
Have some tasty brie
```

## Plugin Management

Whilst being able to run a plugin is useful you'll normally want to make it available to everyone who uses your Jenkins X cluster.

Jenkins X provides binary plugin management via the `plugin` custom resource.

TODO

## Distributing your plugin using Apps

Now that you've written your plugin you'll want to distribute it.

TODO
