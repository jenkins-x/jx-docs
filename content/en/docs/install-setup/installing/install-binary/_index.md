---
title: Install the jx binary
linktitle: Install the jx binary
description: How to install the jx binary on your machine?
weight: 20
keywords: [install]
aliases:
    - /getting-started/install
    - /docs/getting-started/setup/install/
    - /docs/getting-started/setup/install
---

Pick the most suitable instructions for your operating system:

## macOS

1. Download the `jx` binary

    On a Mac you can use [brew](https://brew.sh/):

    ```sh
    brew install jenkins-x/jx/jx
    ```

    Alternatively, download the `jx` binary archive using `curl` and pipe (`|`) the compressed archive to
    the `tar` command:

    ```sh
    curl -L "https://github.com/jenkins-x/jx/releases/download/$(curl --silent "https://github.com/jenkins-x/jx/releases/latest" | sed 's#.*tag/\(.*\)\".*#\1#')/jx-darwin-amd64.tar.gz" | tar xzv "jx"
    ```

1. Install the `jx` binary by moving it to a location in your executable path using using the `mv` command:

    ```sh
    sudo mv jx /usr/local/bin
    ```

1. Run `jx --version` to make sure you're on the latest stable version

   ```sh
   jx --version
   ```

## Linux

To install Jenkins X on Linux, download the `.tar` file, and unarchive it in a directory where you can run the `jx` command.

1. Download the `jx` binary archive using `curl` and pipe (`|`) the compressed archive to
    the `tar` command:

    ```sh
    curl -L "https://github.com/jenkins-x/jx/releases/download/$(curl --silent "https://github.com/jenkins-x/jx/releases/latest" | sed 's#.*tag/\(.*\)\".*#\1#')/jx-linux-amd64.tar.gz" | tar xzv "jx"
    ```

1. Install the `jx` binary by moving it to a location in your executable path using using the `mv` command:

    ```sh
    sudo mv jx /usr/local/bin
    ```

1. Run `jx --version` to make sure you're on the latest stable version

    ```sh
    jx --version
    ```

## Windows

You can install Jenkins X on Windows through Chocolatey, a third-party package management system that provides convenient one-step commands for local Jenkins X installations and upgrades.

Install the Chocolatey package management system using an Administrative
Shell:

1. Right-click menu:Start\[Command Prompt (Admin)\].

1. At the shell prompt, execute a `powershell.exe` command to download
    and install the `choco` binary and set the installation path so that
    the binary can be executed:

    ```shell
    @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
    ```

1. Install Jenkins X using Chocolatey:

    ```shell
    choco install jenkins-x
    ```

    You can update to the latest version of Jenkins X using Chocolatey:

    ```sh
    choco upgrade jenkins-x
    ```

1. If you use [scoop](https://scoop.sh), then there is a [manifest available](https://github.com/lukesampson/scoop/blob/master/bucket/jx.json).

    To install the `jx` binary run:

    ```sh
    scoop install jx
    ```

    To upgrade the `jx` binary run:

    ```sh
    scoop update jx
    ```

## Other platforms

[Download the binary](https://github.com/jenkins-x/jx/releases) for `jx` and add it to your `$PATH`

Or you can try [build it yourself](https://github.com/jenkins-x/jx/blob/master/docs/contributing/hacking.md). Though if build it yourself please be careful to remove any older `jx` binary so your local build is found first on the `$PATH` :)
