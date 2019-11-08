---
title: Import
linktitle: Import
description: How to import existing projects into Jenkins X
weight: 70
---

If you already have some source code you wish to import into Jenkins X then you can use the [jx import](/commands/jx_import/) command. e.g.

```sh
cd my-cool-app
jx import
```

Import will perform the following actions (prompting you along the way):

* add your source code into a git repository if it isn't already
* create a remote git repository on a git service, such as [GitHub](https://github.com)
* push your code to the remote git service
* add any required files to your project if they do not exist:
  * `Dockerfile` to build your application as a docker image
  * `Jenkinsfile` to implement the CI / CD pipeline
  * helm chart to run your application inside Kubernetes
* register a webhook on the remote git repository to your teams Jenkins
* add the git repository to your teams Jenkins
* trigger the first pipeline

### Avoiding docker + helm

If you are importing a repository that does not create a docker image you can use the `--no-draft` command line argument which will not use Draft to default the Dockerfile and helm chart.


### Importing via URL

If you wish to import a project which is already in a remote git repository then you can use the `--url`  argument:

```sh
jx import --url https://github.com/jenkins-x/spring-boot-web-example.git
```

### Importing GitHub projects

If you wish to import projects from a github organisation you can use:

```sh
jx import --github --org myname
```

You will be prompted for the repositories you wish to import. Use the cursor keys and space bar to select/deselect the repositories to import.

If you wish to default all repositories to be imported (then deselect any you don't want add `--all`:

```sh
jx import --github --org myname --all
```

To filter the list you can add a `--filter`

```sh
jx import --github --org myname --all --filter foo
```

## Branch patterns

When importing projects into Jenkins X we use git branch patterns to determine which branch names are automatically setup for CI/CD.

Typically that may default to something like `master|PR-.*|feature.*`. That means that the `master` branch, any branch starting with `PR-` or `feature` will be scanned to look for a `Jenkinsfile` to setup the CI/CD pipelines.

If you use another branch name than `master` such as `develop` or whatever you can change this pattern to be whatever you you like via the `--branches` argument whenever you run [jx import](/commands/jx_import/), [jx create spring](/commands/jx_create_spring/) or [jx create quickstart](/commands/jx_create_quickstart/).


```sh
jx import --branches "develop|PR-.*|feature.*"
```

You may wish to set this to just `.*` to work with all branches,.

```sh
jx import --branches ".*"
```

## Configuring your teams branch patterns

Usually a team uses the same naming conventions for branches so you may wish to configure the branch patterns at a team level so that they will be used by default if anyone in your team runs [jx import](/commands/jx_import/), [jx create spring](/commands/jx_create_spring/) or [jx create quickstart](/commands/jx_create_quickstart/).

These settings are stored in the [Environment Custom Resource](/docs/reference/components/custom-resources/) in Kubernetes.

To set the branch patterns for your team  [jx edit branchpattern](/commands/jx_edit_branchpattern/) command.

```sh
jx edit branchpattern  "develop|PR-.*|feature.*"
```
You can then view the current branch patterns for your team via the [jx get branchpattern](/commands/jx_get_branchpattern/) command:

```sh
jx get branchpattern
```
