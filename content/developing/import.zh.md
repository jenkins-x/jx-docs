---
title: 导入
linktitle: 导入
description: 如何把已经存在的项目导入 Jenkins X
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
menu:
  docs:
    parent: "developing"
    weight: 50
weight: 50
sections_weight: 50
draft: false
toc: true
---

                
If you already have some source code you wish to import into Jenkins X then you can use the [jx import](/commands/jx_import) command. e.g.

```shell
$ cd my-cool-app
$ jx import
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

```shell
    jx import --url https://github.com/jenkins-x/spring-boot-web-example.git
```

### Importing GitHub projects

If you wish to import projects from a github organisation you can use:
 
```shell
    jx import --github --org myname
```

You will be prompted for the repositories you wish to import. Use the cursor keys and space bar to select/deselect the repositories to import.

If you wish to default all repositories to be imported (then deselect any you don't want add `--all`:
   
```shell
    jx import --github --org myname --all
```

To filter the list you can add a `--filter`

```shell
    jx import --github --org myname --all --filter foo
```  
  