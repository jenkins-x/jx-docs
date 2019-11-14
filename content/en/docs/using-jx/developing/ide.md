---
title: IDE
linktitle: IDE
description: Working with Jenkins X from your IDE
weight: 60
---

As developers we often spend lots of time in our IDE of choice working on code. Jenkins X is all about helping developers deliver business value faster through software; so we want to make Jenkins X super easy to work with from inside your IDE.

So we have IDE plugins for working with Jenkins X

## VS Code

[VS Code](https://code.visualstudio.com/) is a popular open source IDE from Microsoft.

We've created the [vscode-jx-tools](https://github.com/jenkins-x/vscode-jx-tools) extension for VS Code.

You can install this into VS Code via the `Extensions` window, searching for `jx` should find the extension.

After its installed hit `Reload` and you should be good to go.

If you then expand the `JENKINS X` navigation window you should see UI that updates in real time as you create projects, as Pull Requests are raised or code is merged to master.

<img src="/images/vscode.png">

### Features

* browse all the pipelines in your team with real time updates as release or pull request pipelines start/stop.
* open pipeline build logs inside the VS Code Terminal
* browse the Jenkins pipeline page, git repository, build logs or applications easily
  * right click on the Jenkins X explorer
  * start/stop pipelines too! 
* open [DevPods](/docs/reference/devpods/) with source code synchronisation in a single command in VS Code for developing inside the cloud with the same container images and pod templates as the CI/CD pipelines  

## IntelliJ

We have a plugin for [IntelliJ](https://www.jetbrains.com/idea/) and the associated IDEs like WebStorm, GoLand, PyCharm et al

You can find the [Jenkins X plugin for IntelliJ here](https://plugins.jetbrains.com/plugin/11099-jenkins-x)

<img src="/images/intellij.png">


## Web based IDE

To help you work in the cloud we also support a Web Based IDE using  the [Theia IDE](https://www.theia-ide.org/).

To get started with Theia see [how to create a DevPod with an embedded Web IDE](/docs/reference/devpods/#using-theia-ide) 


