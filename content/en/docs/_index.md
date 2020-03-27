---
title: Jenkins X Documentation
linkTitle: Docs

layout: home
weight: 20
menu:
  main:
    weight: 20
  docs:
    title: "Getting Started"
    weight: 1

aliases:
  - /getting-started

---


# Get started

  &nbsp;

## Step 1: Install the Jenkins X CLI

The first step in using Jenkins X is installing the Jenkins X binary (`jx`) for
your operating system.
<ul class="nav nav-tabs" id="install-jx-tabs">
  <li class="nav-item">
    <a class="nav-link active" data-toggle="tab" href="#osx">OS X</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" data-toggle="tab" href="#linux">Linux</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" data-toggle="tab" href="#windows">Windows</a>
  </li>
</ul>
<div class="tab-content" id="install-jx-tabs">
  <div class="tab-pane fade show active" id="osx">
  &nbsp;

  ### Install using [brew](https://brew.sh/):

  ```sh
    brew install jenkins-x/jx/jx
  ```
### Using Curl
Download the `.tar` file, unarchive it.

```sh
curl -L "https://github.com/jenkins-x/jx/releases/download/$(curl --silent https://api.github.com/repos/jenkins-x/jx/releases/latest | jq -r '.tag_name')/jx-darwin-amd64.tar.gz" | tar xzv "jx"
```


Add  `jx` to your path

```sh
  sudo mv jx /usr/local/bin
```

Check if all is good!

```sh
  jx --version
```
  </div>
  <div class="tab-pane fade" id="linux">
  
  &nbsp;  
  Download the `.tar` file, and unarchive it in a directory where you can run the `jx` command.

  ```sh
  curl -L "https://github.com/jenkins-x/jx/releases/download/$(curl --silent https://api.github.com/repos/jenkins-x/jx/releases/latest | jq -r '.tag_name')/jx-linux-amd64.tar.gz" | tar xzv "jx"
  ```

  or, if you don't have `jq` installed:

  ```sh
  curl -L "https://github.com/jenkins-x/jx/releases/download/$(curl --silent "https://github.com/jenkins-x/jx/releases/latest" | sed 's#.*tag/\(.*\)\".*#\1#')/jx-linux-amd64.tar.gz" | tar xzv "jx"
  ```

  Move binary to your path

```sh
  sudo mv jx /usr/local/bin
```

Test all is good

```sh
jx --version
```

  </div>
  <div class="tab-pane fade" id="windows">
  &nbsp;

  ### Install the Chocolatey using an Admin
  &nbsp;

1. Right-click menu:Start\[Command Prompt (Admin)\].

2. At the shell prompt, execute a `powershell.exe` command to download
    and install the `choco` binary and set the installation path so that
    the binary can be executed:
```sh
  @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
```
3.  Install Jenkins X using Chocolatey:

```sh
  choco install jenkins-x
```
  &nbsp;

Upgrading Jenkins X via Chocolatey

```sh
choco upgrade jenkins-x
```
  &nbsp;
### Install using Scoop

<div class="alert alert-dismissible alert-info">
  <button type="button" class="close" data-dismiss="alert">&times;</button>
  <strong>TIP:</strong> 
  If you use <a href="https://scoop.sh" class="alert-link">Scoop</a>, then there is a <a href="https://github.com/lukesampson/scoop/blob/master/bucket/jx.json" class="alert-link">manifest available</a>
</div>

  Install the `jx` binary

  ```sh
  scoop install jx
  ```

  Upgrade the `jx` binary

  ```sh
  scoop update jx
  ```
  </div>
</div>


  &nbsp;

## Step 2: Provision your Kubernetes Cluster

Once you have installed the binary on your workstation, next you want to provision your kubernetes cluster.  Choose your cloud provider.

<ul class="nav nav-tabs" id="provision-cluster-tabs">
  <li class="nav-item">
    <a class="nav-link active" data-toggle="tab" href="#gcp">GCP</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" data-toggle="tab" href="#aws">AWS</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" data-toggle="tab" href="#azure">Azure</a>
  </li>
  <li class="nav-item">
    <a class="nav-link disabled" href="#">OpenShift</a>
  </li>
</ul>
<div id="provision-cluster-tabs" class="tab-content">
  <div class="tab-pane fade show active" id="gcp">
    <div class="row">
      <div class="col-sm-4">
        <div class="card">
          <div class="card-body">
            <a href="/docs/getting-started/setup/create-cluster/google/"><img src="https://www.pulumi.com/logos/tech/gcp.svg"/></i></a>
          </div>
        </div>
      </div>
    </div>
    <p>Raw denim you probably haven't heard of them jean shorts Austin. Nesciunt tofu stumptown aliqua, retro synth master cleanse. Mustache cliche tempor, williamsburg carles vegan helvetica. Reprehenderit butcher retro keffiyeh dreamcatcher synth. Cosby sweater eu banh mi, qui irure terry richardson ex squid. Aliquip placeat salvia cillum iphone. Seitan aliquip quis cardigan american apparel, butcher voluptate nisi qui.</p>
  </div>
  <div class="tab-pane fade" id="aws">
  <div class="row">
    <div class="col-sm-4">
      <div class="card">
        <div class="card-body">
          <a href="/docs/getting-started/setup/create-cluster/amazon/"> <img src="https://www.pulumi.com/logos/tech/aws.svg" class="mx-auto d-block"/></i></a>
        </div>
      </div>
    </div>
  </div>
    <p>Food truck fixie locavore, accusamus mcsweeney's marfa nulla single-origin coffee squid. Exercitation +1 labore velit, blog sartorial PBR leggings next level wes anderson artisan four loko farm-to-table craft beer twee. Qui photo booth letterpress, commodo enim craft beer mlkshk aliquip jean shorts ullamco ad vinyl cillum PBR. Homo nostrud organic, assumenda labore aesthetic magna delectus mollit.</p>
  </div>
  <div class="tab-pane fade" id="azure">
  <div class="col-sm-4">
      <div class="card">
        <div class="card-body">
          <a href="/docs/getting-started/setup/create-cluster/azure/"><img src="https://www.pulumi.com/logos/tech/azure.svg"/></i></a>
        </div>
      </div>
    </div>
    <p>Food truck fixie locavore, accusamus mcsweeney's marfa nulla single-origin coffee squid. Exercitation +1 labore velit, blog sartorial PBR leggings next level wes anderson artisan four loko farm-to-table craft beer twee. Qui photo booth letterpress, commodo enim craft beer mlkshk aliquip jean shorts ullamco ad vinyl cillum PBR. Homo nostrud organic, assumenda labore aesthetic magna delectus mollit.</p>
  </div>
    <div class="tab-pane fade" id="openshift">
    <p>Coming soon!</p>
  </div>
</div>


  &nbsp;
## Step 3: Install Jenkins X on your cluster

Once you have configured your kubernetes environment, you can finally Install Jenkins X and start using it!

<div style="text-align:center">
<a class="btn btn-lg btn-info mr-3 mb-4" href="/docs/getting-started/setup/boot/">
		Install Jenkins X <i class="fas fa-arrow-alt-circle-right ml-2"></i>
	</a>
</div>