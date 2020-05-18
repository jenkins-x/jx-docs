---
title: Dev Pods
linktitle: Dev Pods
description: Develop in a pod on your cloud
weight: 20
aliases:
  - /developing/devpods
---

The initial focus of Jenkins X is around automating and improving CI/CD for kubernetes. The use of [Preview Environments](/about/concepts/features/#preview-environments) really helps to validate and approve Pull Requests before they get merged to `master`; but how do you try things out before you are ready submit a Pull Request?

Jenkins X has a concept of `Dev Pods` which are pods for developers to use as a terminal/shell which are based on the exact same operating system, docker containers and tools installed as the [pod templates](/docs/resources/guides/managing-jx/common-tasks/pod-templates/) used in the Jenkins X CI/CD pipelines.

This lets build, run tests or redeploy apps before you commit to git safe in the knowledge you're using the exact same tools as the CI/CD pipelines!

## Creating a DevPod

To create your own `DevPod` use the command [jx create devpod](/commands/jx_create_devpod/).

For example if you want to create a `maven` based DevPod use:

```sh
jx create devpod -l maven
```

This will then create a new `DevPod` based on the maven based [pod template](/docs/resources/guides/managing-jx/common-tasks/pod-templates/) and open your terminal inside that pod. You are now free to use the various tools like `git, docker, maven, skaffold, jx` which will all be using the same exact configuration as the CI/CD pipelines will.


## Using web based VS Code

If you don't use `--sync` then the DevPod will embed the [web based version of VS Code](https://github.com/cdr/code-server) in your DevPod so that you can open the IDE in a browser and work on the source code inside your DevPod!

The source code is mounted into the workspace of the DevPod in the folder `/workspace`.

To get an incremental redeploy as you edit source inside VS Code then open a `Terminal` in VS Code and type:

`./watch.sh`

inside the shell of the DevPod.

Here's a [demo showing how to use web based VS Code in a DevPod](/images/developing/vscode-devpod.mp4):

<figure>
<embed src="https://jenkins-x.io/images/developing/vscode-devpod.mp4" autostart="false" height="400" width="600" />
<figcaption>
<h5>Use web based VS Code inside a DevPod</h5>
</figcaption>
</figure>



## Using Theia IDE

If you don't use `--sync` and you use `--theia` then the DevPod will embed the [Theia IDE](https://www.theia-ide.org/) so that you can open the IDE in a browser and work on the source code inside your DevPod!

The source code is mounted into the workspace of the DevPod in the folder `/workspace`.

To get an incremental redeploy as you edit source inside [Theia IDE](https://www.theia-ide.org/) then type:

`./watch.sh`

inside the shell of the DevPod.

## Using a desktop IDE

If you wish to use a desktop IDE then you need to sync your source code you can work on it there, using your preferred editor on your desktop. In this case the workflow is:

1. run `jx sync` once on your system
2. cd into your project dir, and run `jx create devpod --reuse --sync`
3. Once in the DevPod from step 2: run `./watch.sh`

This will open a shell (and create a DevPod, or re-use an existing one) and ensure the changes are synced up to the DevPod. Step 3: when  you run this then any changes you make locally will be pushed up to the DevPod, built, and then a temporary "edit" version of your application will be published.

When you run `jx get applications` you will see your "edit" application listed. You can open this in a browser, and edit away, and refresh, as if you were developing locally.

_if you are using the Visual Studio code extension to do this, you don't need to worry about this, it will be done automatically for you_



## Opening a DevPod shell

If you have other terminals that want to connect into an existing `DevPod` use [jx rsh -d](/commands/jx_rsh/)

```sh
jx rsh -d
```

If you have more than one `DevPod` active you will be prompted for the list of available `DevPod`s to pick from. Otherwise your shell will open in the `DevPod` directly.

If you use `jx create devpod --reuse` it will lazily create a devpod if one doesn't exist for the project  directory you are in.

### Viewing my DevPods

Use the [jx get devpod](/commands/jx_get_devpod/) command:


```sh
jx get devpod
```

### Deleting a DevPod

Use the [jx delete devpod](/commands/jx_delete_devpod/) command:


```sh
jx delete devpod
```

Then pick the devpod to delete and confirm. Or pass in the name of the devpod you want to delete as an argument.


## Synchronizing source code

If you are using one of our [IDE plugins](/docs/resources/guides/using-jx/developing/ide/) for your desktop IDE then synchronisation of local files to your DevPod will already be included.

Otherwise if you are using a desktop IDE you can synchronise your local source code into your DevPod via the [jx sync](/commands/jx_sync/) command.

This will allow you to edit source code in your preferred [IDE](/docs/resources/guides/using-jx/developing/ide/) like [VS Code](https://code.visualstudio.com/) or [IDEA](https://www.jetbrains.com/idea/).


```sh
jx sync
```

You just run this once on your system (if you are using the Visual Studio code extension to do this, you don't need to worry about this, it will be done automatically for you)

This command will download and install the excellent [ksync](https://github.com/vapor-ware/ksync) tool if its not already installed, run `ksync init` to add it to your cluster and then run `ksync watch` and then use `ksync create` to create a synchronisation spec.

Then by default the code with be bidirectionally synchronized between the current directory and the `/code` folder in the `DevPod`. You can now edit the code in your IDE and run build/test commands inside the `DevPod`!

e.g. you can build your code with whatever tools you are using (`maven, gradle, make` etc), perform `docker` builds or run `skaffold` in developer mode.

Over time we are hoping to polish this experience to make it super easy to edit code in your IDE and get fast reloading working inside the kubernetes cluster using the same kubernetes resources, manifests and services!

## Incremental building

One of the benefits of integrating with [skaffold](https://github.com/GoogleContainerTools/skaffold) for building docker images is that we can perform incremental rebuilds of docker images and redeploys of the associated helm charts.

So inside of your DevPod you can perform a regular build if your app is Java based. e.g. via maven:

```sh
mvn install
```

Then to trigger incremental rebuilding and deploying of the local code in the DevPod you can use:

```sh
./watch.sh
```

This will use the `dev` profile to generate a new docker image using the generated _digest_ then use it in the helm chart to deploy.

When you created your DevPod it was associated with an _Edit Environment_ for your _username_ so that any apps deployed in a DevPod will appear in your _Edit Environment_.

So once the `skaffold dev -p dev` (what `watch.sh` does) command has built the docker image and installed the helm chart, your app will show up via  [jx get applications](/commands/jx_get_applications/):

```sh
jx get applications
```

Now if you edit code and trigger a docker rebuild, which for most languages is just changing the source code; though for Java apps its whenever you rebuild the jar - the image is regenerated and the helm chart updated!

## Using an IDE

One of the easiest ways to get started with DevPods is via an IDE such as [VS Code](https://code.visualstudio.com/). Check out the [Jenkins X plugins for IDEs](/docs/resources/guides/using-jx/developing/ide/)

VS Code has support which automates all the above so you can run a shell/sync quite easily.


