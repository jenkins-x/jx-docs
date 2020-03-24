---
title: Install jx
linktitle: Install jx
description: How to install the jx binary on your machine?
weight: 5
keywords: [install]
aliases:
  - /getting-started/install
---

Pick the most suitable instructions for your operating system:

## macOS

1. Download the `jx` binary

    On a Mac you can use [brew](https://brew.sh/):

    ```sh
    brew install jenkins-x/jx/jx
    ```

    Alternatively, to install Jenkins X on macOS without brew, download the `.tar`
    file, and unarchive it in a directory where you can run the `jx` command.

    Download the `jx` binary archive using `curl` and pipe (`|`) the compressed
    archive to the `tar` command:

    ```sh
    curl -L "https://github.com/jenkins-x/jx/releases/download/$(curl --silent https://api.github.com/repos/jenkins-x/jx/releases/latest | jq -r '.tag_name')/jx-darwin-amd64.tar.gz" | tar xzv "jx"
    ```

    or, if you don't have `jq` installed:

    ```sh
    curl -L "https://github.com/jenkins-x/jx/releases/download/$(curl --silent "https://github.com/jenkins-x/jx/releases/latest" | sed 's#.*tag/\(.*\)\".*#\1#')/jx-darwin-amd64.tar.gz" | tar xzv "jx"
    ```


2.  Install the `jx` binary by moving it to a location in your executable path
    using using the `mv` command:

    ```sh
    sudo mv jx /usr/local/bin
    ```

3. Run `jx --version` to make sure you're on the latest stable version

    ```sh
    jx --version
    ```

4. Now, you're ready to [Create your cluster](/docs/getting-started/setup/create-cluster/)

## Linux

To install Jenkins X on Linux, download the `.tar` file, and unarchive it in a directory where you can run the `jx` command.

1.  Download the `jx` binary archive using `curl` and pipe (`|`) the compressed archive to
    the `tar` command:

    ```sh
    curl -L "https://github.com/jenkins-x/jx/releases/download/$(curl --silent https://api.github.com/repos/jenkins-x/jx/releases/latest | jq -r '.tag_name')/jx-linux-amd64.tar.gz" | tar xzv "jx"
    ```

    or, if you don't have `jq` installed:

    ```sh
    curl -L "https://github.com/jenkins-x/jx/releases/download/$(curl --silent "https://github.com/jenkins-x/jx/releases/latest" | sed 's#.*tag/\(.*\)\".*#\1#')/jx-linux-amd64.tar.gz" | tar xzv "jx"
    ```

2.  Install the `jx` binary by moving it to a location in your executable path using using the `mv` command:

    ```sh
    sudo mv jx /usr/local/bin
    ```

3. Run `jx --version` to make sure you're on the latest stable version

    ```sh
    jx --version
    ```

4. Now, you're ready to [Create your cluster](/docs/getting-started/setup/create-cluster/)


## Windows

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

```sh
choco upgrade jenkins-x
```

- If you use [scoop](https://scoop.sh), then there is a [manifest available](https://github.com/lukesampson/scoop/blob/master/bucket/jx.json).

  To install the `jx` binary run:

  ```sh
  scoop install jx
  ```

  To upgrade the `jx` binary run:

  ```sh
  scoop update jx
  ```

4. Now, you're ready to [Create your cluster](/docs/getting-started/setup/create-cluster/)

<!-- ## Google Cloud Platform (GCP)

{{< alert >}}
It is highly recommended that you use Google Chrome browser with
GCP Cloud Shell, as you may experience issues using other
browsers.
{{< /alert >}}

To run `jx` commands from the GCP Cloud Shell, install the Jenkins X
binaries from the GitHub repository and install it via GCP shell
commands:

1.  Open the [GCP Cloud Shell](https://cloud.google.com/shell/docs/starting-cloud-shell),
    and choose your GCP project for Jenkins X.

2.  In GCP Cloud Shell, download the `jx` binary archive using `curl` and pipe (`|`) the compressed archive to
    the `tar` command:

```sh
curl -L "https://github.com/jenkins-x/jx/releases/download/$(curl --silent https://api.github.com/repos/jenkins-x/jx/releases/latest | jq -r '.tag_name')/jx-linux-amd64.tar.gz" | tar xzv "jx"
```

3.  Move the `jx` exectutable into the executable directory with this
    command:

```sh
sudo mv jx /usr/local/bin
```

4. Run `jx --version` to make sure you're on the latest stable version

```sh
jx --version
```

Once you have the `jx` binary installed you can then [configure a Jenkins X cluster on Google Kubernetes Engine](/getting-started/create-cluster/). -->

## Other platforms

[Download the binary](https://github.com/jenkins-x/jx/releases) for `jx` and add it to your `$PATH`

Or you can try [build it yourself](https://github.com/jenkins-x/jx/blob/master/docs/contributing/hacking.md). Though if build it yourself please be careful to remove any older `jx` binary so your local build is found first on the `$PATH` :)

## Getting Help

To find out the available commands type:

```sh
jx
```

Or to get help on a specific command, say, `create` then type:

```sh
jx help create
```

You can also browse the [jx command reference documentation](/commands/jx/)
