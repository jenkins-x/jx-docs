---
title: Kubernetes Context
linktitle: Kubernetes Context
description: How to switch between different Kubernetes clusters, environments and namespaces
aliases:
  - /developing/kube-context
weight: 90
---

The kubernetes CLI tool [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) keeps track of the kubernetes cluster and namespace you are using via a local file `~/.kube/config` (or a file at `$KUBECONFIG`).

If you want to change the namespace using the kubectl command line you can use:

```sh
kubectl config set-context `kubectl config current-context` --namespace=foo
```

However [jx](/commands/jx/) provides lots of helper commands for changing clusters, namespaces or environments:

### Changing Environments

Use [jx environment](/commands/jx_environment/) to switch [environments](/about/concepts/features/#environments)

```sh
jx environment
```

You will be presented with a list of the environments for the current team. Use the cursor keys and enter to select the one you wish to switch to. Or press `Ctrl+C` to terminate and not change the environment.

Or if you know the environment you wish to switch to just type it as an argument:

```sh
jx env staging
```

### Changing Namespace

Use [jx namespace](/commands/jx_namespace/) to switch between different kubernetes namespaces.


```sh
jx namespace
```

You will be presented with a list of all the namespaces in the kubernetes cluster. Use the cursor keys and enter to select the one you wish to switch to. Or press `Ctrl+C` to terminate and not change the namespace.

Or if you know the kubernetes namespace you wish to switch to just type it as an argument:

```sh
jx ns jx-production
```

### Changing Cluster

Use [jx context](/commands/jx_context/) to switch between different kubernetes clusters (or contexts).


```sh
jx context
```

You will be presented with a list of all the contexts that you have used on your machine. Use the cursor keys and enter to select the one you wish to switch to. Or press `Ctrl+C` to terminate and not change the namespace.

Or if you know the kubernetes namespace you wish to switch to just type it as an argument:

```sh
jx ctx gke_jenkinsx-dev_europe-west2-a_myuserid-foo
jx ctx minikube
```

### Local changes

When you change namespace or context in kubernetes via [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) or the commands above then the kubernetes context and namespace is changed for **all of your terminals** as it updates the shared file (`~/.kube/config` or `$KUBECONFIG`).

This can be handy - but is sometimes dangerous. e.g. if you want to do something on a production cluster; but forget and then re-run a command in another terminal to delete all the pods in your development namespace - but forget you just switched to the production namespace!

 So its sometimes useful to be able to change the kubernetes context and/or namespace locally in a single shell only. For example if you ever want to look at a production cluster, only use that cluster in one shell only to minimise accidents.

 You can do that with the [jx shell](/commands/jx_shell/) command which prompts you to pick a different kubernetes context like the  [jx context](/commands/jx_context/) command. However changes to the namespace and/or cluster made in this shell only affect the current shell only!

[jx shell](/commands/jx_shell/) also automatically updates your command prompt using [jx prompt](/commands/jx_prompt/)
so that it is clear your shell has changed the context and/or namespace,
and adds bash completion via [jx prompt](/commands/jx_prompt/).

### Customize your shell

You can use [jx prompt](/commands/jx_prompt/)  to add the current kubernetes cluster and namespace to your terminals prompt.

To add bash completion to your shell for [jx commands](/commands/jx/) then try the  [jx completion](/commands/jx_completion/).



