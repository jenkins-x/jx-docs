---
title: Boot
linktitle: Run Jenkins X Boot
description: How to install, configure or upgrade Jenkins X via GitOps and a Jenkins X Pipeline
categories: [getting started]
keywords: [install, cluster]
weight: 40
aliases:
  - /getting-started/boot/
  - /docs/reference/boot/
  - /architecture/tls/
  - /docs/getting-started/setup/boot/
  - /docs/install-setup/boot/
  - /docs/install-setup/boot/
---

## Overview

_Jenkins X Boot_ uses the following approach:

- Create your Kubernetes cluster using [Terraform](/docs/install-setup/create-cluster/).
  Please check out our [Cloud Providers Guide](/docs/getting-started/setup/boot/clouds/) on our recommendations for your cloud provider.
  To verify you can communicate correctly with your Kubernetes cluster run:
  ``` sh
  kubectl get ns
  ```

- Run the [jx boot](/commands/jx_boot/) command:

    ```sh
    jx boot
    ```

You will now be prompted for any missing parameters required to install, such as your admin user/password, the Pipeline git user and token etc.

Then Jenkins X should be installed and set up on your Kubernetes cluster.

{{% alert %}}
If one of the steps in `jx boot` fails for some reason, instead of running all the steps, you can start boot from that 
particular step in two ways:
* Using environment variable `JX_BOOT_START_STEP`: `JX_BOOT_START_STEP=<name of the step> jx boot`
* Using the `--start-step` or it's shorthand `-s` flag: `jx boot -s=<name of the step>`

Alternatively, you can also end `jx boot` at a step by using the environment variable `JX_BOOT_END_STEP`. 
{{% /alert %}}

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

If you're looking for a UI check out [Octant the open source web UI for Jenkins X](/docs/reference/components/ui/)
