---
title: Install Jenkins X
linktitle: Install Jenkins X
description: How to install the jx binary on your machine
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
categories: [getting started]
keywords: [install]
menu:
  docs:
    parent: "getting-started"
    weight: 10
weight: 10
sections_weight: 10
draft: false
aliases: [/overview/usage/,/extras/livereload/,/doc/usage/,/usage/]
toc: true
---

Pick the most suitable instructions for your operating system:

### macOS

On a Mac you can use [brew](https://brew.sh/):

```shell
brew tap jenkins-x/jx
brew install jx
```

To install Jenkins X on macOS without brew, download the `.tar` file, and unarchive it in a directory where you can run the `jx` command.

1.  Download the `jx` binary archive using `curl` (where
    the URL below is selecting the most current version of Jenkins X on the [releases](https://github.com/jenkins-x/jx/releases/) page) and pipe (`|`) the compressed archive to
    the `tar` command:

        curl -L https://github.com/jenkins-x/jx/releases/download/latest/jx-darwin-amd64.tar.gz | tar xzv

2.  Install the `jx` binary by moving it to a location which should be on your environments PATH, using
    the `mv` command:

        sudo mv jx /usr/local/bin


### Linux

To install Jenkins X on Linux, download the `.tar` file, and unarchive it in a directory where you can run the `jx` command.

1.  Download the `jx` binary archive using `curl` (where
    the URL below is selecting the most current version of Jenkins X on the [releases](https://github.com/jenkins-x/jx/releases/) page) and pipe (`|`) the compressed archive to
    the `tar` command:

        curl -L https://github.com/jenkins-x/jx/releases/download/latest/jx-linux-amd64.tar.gz | tar xzv

2.  Install the `jx` binary by moving it to a location which should be on your environments PATH, using
    the `mv` command:

        sudo mv jx /usr/local/bin


### Windows

You can install Jenkins X on Windows through Chocolatey, a third-party package management system that provides convenient one-step commands for local Jenkins X installations and upgrades.

Install the Chocolatey package management system using an Administrative
Shell:

1.  Right-click menu:Start\[Command Prompt (Admin)\].

2.  At the shell prompt, execute a `powershell.exe` command to download
    and install the `choco` binary and set the installation path so that
    the binary can be executed:

        @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

3.  Install Jenkins X using Chocolatey:

        choco install jenkins-x

You can update to the latest version of Jenkins X using Chocolatey:

    choco upgrade jenkins-x


- If you use [scoop](https://scoop.sh), then there is a [manifest available](https://github.com/lukesampson/scoop/blob/master/bucket/jx.json).

  To install the `jx` binary run:

  ```cmd
  scoop install jx
  ```

  To upgrade the `jx` binary run:

  ```cmd
  scoop update jx
  ```

### Google Cloud Platform (GCP)

To run `jx` commands from the GCP Cloud Shell, install the Jenkins X
binaries from the GitHub repository and install it via GCP shell
commands:

1.  Open the [GCP Cloud Shell](https://cloud.google.com/shell/docs/starting-cloud-shell),
    and choose your GCP project for Jenkins X.

    {{% note %}}
    It is highly recommended that you use Google Chrome browser with
    GCP Cloud Shell, as you may experience issues using other
    browsers.
    {{% /note %}}

2.  In GCP Cloud Shell, download the Jenkins X command-line binaries
    `latest` is the most current version of Jenkins X on the [releases](https://github.com/jenkins-x/jx/releases/) page):

        curl -L https://github.com/jenkins-x/jx/releases/download/latest/jx-linux-amd64.tar.gz | tar xzv

3.  Move the `jx` exectutable into the executable directory with this
    command:

        sudo mv jx /usr/local/bin

Once you have the `jx` binary installed you can then [configure a Jenkins X cluster on Google Kubernetes Engine](/getting-started/create-cluster/).


### Other platforms

[download the binary](https://github.com/jenkins-x/jx/releases) for `jx` and add it to your `$PATH`

Or you can try [build it yourself](https://github.com/jenkins-x/jx/blob/master/docs/contributing/hacking.md). Though if build it yourself please be careful to remove any older `jx` binary so your local build is found first on the `$PATH` :)

## Getting Help

To find out the available commands type:

    jx

Or to get help on a specific command, say, `create` then type:

    jx help create

You can also browse the [jx command reference documentation](/commands/jx)
