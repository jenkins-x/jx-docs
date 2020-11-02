---
title: UI
linktitle: UI
description: User interfaces for Jenkins X
weight: 10
aliases:
  - /docs/v3/guides/ui/
---


## CLI

For those who like command lines you can view and watch most things via the [jx](/docs/v3/guides/jx3/) command line.

You can download 3.x of jx from here: https://github.com/jenkins-x/jx-cli/releases

Browse the [command line commands](https://github.com/jenkins-x/jx-cli/blob/master/docs/cmd/jx.md) along with the [plugin commands](https://github.com/jenkins-x/jx-cli#plugins) 

Many things in Jenkins X are exposed as [custom resources](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) so that you can also use [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) to interact with the Jenkins X.

* to view environments

```bash
kubectl get env
```

* to view preview environments

```bash
kubectl get preview
```



## Octant

As a general purpose UI for working with Kubernetes, Jenkins X, Tekton and more resources we highly recommend [Octant](https://octant.dev/)

Please check out the [documentation on using Octant and Jenkins X](/docs/reference/components/ui/) to get started.

* [why we love Octant](/blog/2020/08/06/octant-jx/) 

* [demo of using octant](/blog/2020/08/06/octant-jx/#demo)

## Pipeline Visualizer

Its a common requirement to want to be able to click on a Pull Request on your git provider and view the pipeline log for that commit on that Pull Request.

To implement this we include the [jx-pipelines-visualizer](https://github.com/jenkins-x/jx-pipelines-visualizer) application inside Jenkins X.

This provides a simple read only web UI for viewing pipelines and pipeline logs and its linked automatically with any Pull Request you create on repositories managed by Jenkins X.

### Accessing the Pipelines Visualizer

If you create a Pull Request on a git repository you have [created or imported]() in Jenkins X you should see a link on the Pull Request. Here's an example - see the **Details** link on the right of the Pull Request pipeline:

<img src="/images/quickstart/pr-link.png" class="img-thumbnail">

If you click the **Details** link that should open the [jx-pipelines-visualizer](https://github.com/jenkins-x/jx-pipelines-visualizer) UI for this pipeline build.

### Logging in to the Pipelines Visualizer

Unless you [customize the chart](/docs/v3/develop/apps/#customising-charts) to change the `Ingress` the default will use _basic authentication_ to access the web UI to avoid your pipeline logs being visible on the internet.

The default username is `admin`. 

To find the generated random password to access the UI type:

```bash 
jx ns jx
kubectl get secret jx-basic-auth-user-password -o jsonpath="{.data.password}" | base64 --decode
```

That should display the randomly generated password.

If you type the username and password into your browser it should open the dashboard.


