---
title: Boot
linktitle: Run Jenkins X Boot
description: How to install, configure or upgrade Jenkins X via GitOps and a Jenkins X Pipeline
categories: [getting started]
keywords: [install, cluster]
weight: 10
aliases:
  - /getting-started/boot/
  - /docs/reference/boot/
  - /architecture/tls/
  - /docs/getting-started/setup/boot
  - /docs/getting-started/setup/boot/
  - /docs/install-setup/boot
  - docs/install-setup/boot/
---

## Overview

_Jenkins X Boot_ uses the following approach:

- Create your Kubernetes cluster:
    - use [Terraform](/docs/install-setup/installing/create-cluster/) to create your Kubernetes clusters + the associated cloud resources
    - use `jx create cluster --skip-installation` e.g. for Google Cloud use `jx create cluster gke --skip-installation`.
      To see all the different providers see [jx create cluster](/commands/jx_create_cluster/)  

    Please check out our [Cloud Providers Guide](/docs/getting-started/setup/boot/clouds/) on our recommendations for your cloud provider.

    You can verify you can communicate correctly with your Kubernetes cluster via:

    ``` sh
    kubectl get ns
    ```

- Run the [jx boot](/commands/jx_boot/) command:

    ```sh
    jx boot
    ```

You will now be prompted for any missing parameters required to install, such as your admin user/password, the Pipeline git user and token etc.

Then Jenkins X should be installed and set up on your Kubernetes cluster.

## About `jx boot`

The [jx boot](/commands/jx_boot/) interprets the boot pipeline using your local `jx` binary.
The underlying pipeline for booting Jenkins X can later be run inside Kubernetes via Tekton.
If ever something goes wrong with Tekton you can always `jx boot` again to get things back up and running (e.g., if someone accidentally deletes your cluster).

## Pre and Post Validation

Before any installation is attempted, Boot runs the [jx step verify preinstall](/commands/jx_step_verify_preinstall/) command to check everything looks OK.
It will also check whether your installed package versions are within the upper and lower version limits.

Once the installation has completed the [jx step verify install](/commands/jx_step_verify_install/) command is run to verify your installation is valid.

## Changing your installation

At any time you can re-run [jx boot](/commands/jx_boot/) to re-apply any changes in your configuration.
To do this git clone your development environment git repository, change directory into the git clone and run `jx boot`. e.g.

```sh
git clone https://github.com/myuser/environment-mycluster-dev.git
cd environment-mycluster-dev
jx boot
```

So just edit anything in the configuration you like and re-run [jx boot](/commands/jx_boot/) - whether that's to add or remove apps, to change parameters or configuration, or upgrade or downgrade versions of dependencies.

Note that you can also just submit a Pull Request on your development git repository which if merged, will trigger a pipeline to run the above commands to apply the changes.

## Requirements

There is a file called [jx-requirements.yml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/jx-requirements.yml) which is used to specify the logical requirements of your installation; such as:

- what Kubernetes provider to use
- whether to store secrets in the local file system or vault
- if you are using Terraform to manage your cloud resources
- if you wish to use kaniko for container image builds

This is the main configuration file for `jx boot` where you make most of your changes.
You may want to review the  [jx-requirements.yml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/jx-requirements.yml) file and make any changes you need.

## User Interface

If you're looking for a UI, there is one available for the [CloudBees Jenkins X Distribution](https://www.cloudbees.com/products/cloudbees-jenkins-x-distribution/overview).
It should normally work on OSS Jenkins X as well, though CloudBees won't support it unless you're also using their distribution.
You can read more about it here: [Using the CloudBees Jenkins X Distribution user interface](https://docs.cloudbees.com/docs/cloudbees-jenkins-x-distribution/latest/user-interface/)
