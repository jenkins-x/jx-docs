---
title: "Creating projects"
date: 2017-01-05
weight: 30
description: >
  Now that you've setup the platform, let's create your first project.
---

To create or import projects you will need to get the [jx 3.x binary](/docs/v3/guides/jx3/) and put it on your `$PATH`


## Create a new project from a quickstart

To create a new project from a quickstart template use the [jx project quickstart](https://github.com/jenkins-x/jx-project/blob/master/docs/cmd/project_quickstart.md) command:

```bash 
jx project quickstart
``` 

Note that the old Jenkins X 2.x alias `jx quickstart` is still supported but will be deprecated eventually.

See the [quickstart documentation](/docs/create-project/creating/) for more information

## Import an existing project

To create a new project from a quickstart template use the [jx project import](https://github.com/jenkins-x/jx-project/blob/master/docs/cmd/project_import.md) command:

```bash 
jx project import
```        

See the [import documentation](/docs/create-project/import/) for more information

Note that the old Jenkins X 2.x alias `jx import` is still supported but will be deprecated eventually.

## Top level wizard

This gives you all of the above options in an interactive wizard via [jx project](https://github.com/jenkins-x/jx-project/blob/master/docs/cmd/project.md)




