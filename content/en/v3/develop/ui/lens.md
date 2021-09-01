---
title: Lens
linktitle: Lens
type: docs
description: desktop Jenkins X Console based on Lens 
weight: 50
---
    
[Lens](https://k8slens.dev/) is a desktop console for Kubernetes which runs locally on your laptop as a desktop application.

![](/images/lens/lens.png)

## Install Lens

[Download the Lens distribution](https://k8slens.dev/#download) for your computer then run it or follow the [getting started guide](https://docs.k8slens.dev/main/getting-started/)

You can check out the [catalog documentation](https://docs.k8slens.dev/main/catalog/) for how to connect to a kubernetes cluster.

## Install the Jenkins X extension

[Lens](https://k8slens.dev/) supports [extensions](https://k8slens.dev/#extensions) to support custom UIs for different extensions to Kubernetes such as Jenkins X.

Follow the Lens documentation on [installing an extension](https://docs.k8slens.dev/main/extensions/usage/#installing-an-extension) using the following URL for the [Jenkins X Lens extension](https://github.com/jenkins-x-plugins/jx-lens)

* go to the **File** (or **Lens** on macOS) > **Extensions** in the application menu
* enter the following URL into the **Install Extension** input field
  * @jenkins-x-plugins/jx-lens
* make sure the extension is **Enabled**

## Using the Jenkins X extension

Once you have used the usual Lens way to connect to your cluster you can browse the usual Kubernetes resources like `Nodes`, `Workloads` and `Configuration`.

You should see the `Jenkins X` tab below the `Custom Resources` section. If you expand that you can then navigate to your `Pipelines` and `Preview` environments as well.
