---
title: How it works
linktitle: How it works
description: How Jenkins X 3.x works under the covers
weight: 130
---


## How it works

The GitOps repository templates contain the source code, scripts and docs to help you get your cloud resources created (e.g. a kubernetes cluster and maybe buckets and/or a secret manager).

Once you have created the GitOps repository from one of the [available templates and followed the instructions](/docs/v3/getting-started/) to set up your infrastructure you [install the git operator](/docs/v3/guides/operator/) via the [jx admin operator](https://github.com/jenkins-x/jx-admin/blob/master/docs/cmd/jx-admin_operator.md) command:


```bash
    jx admin operator
```


That command essentially installs the [git operator](https://github.com/jenkins-x/jx-git-operator) chart, passing in the git URL, username and token to run the boot process.


### Git Operator

The [git operator](https://github.com/jenkins-x/jx-git-operator) works by polling the git repository looking for changes and running a kubernetes Job on each change. The Job resource is defined inside the git repository at **.jx/git-operator/job.yaml**

You can view the boot Job log via the command:


```bash
    jx admin log
```


Or you can browse the log in the Octant UI in the operations tab.


### Boot Job

The boot job runs on startup and on any git commit to the GitOps repository you used to install the operator.

The boot job is defined in **.jx/git-operator/job.yaml** in git and essentially:


* Runs the generate step
* Runs the apply step


#### Generate step

This step is run in the following situations:


* On startup 
* After each commit in a Pull Request
* Whenever a commit is made to the main branch which isn’t a merge of a Pull Request merge


The generate step does the following:


* Resolves any missing values (cluster information, domain name) in the **jx-values.yaml** file
* Resolves any missing versions or helm values.yaml files the **helmfile.yaml** file
* Runs `helmfile template` to generate the kubernetes resources for all the charts
* Copy all the generated resources into a tree of files in **config-root/namespaces/myns/somechart/*.yaml** where 
    * **myns** is the namespace for the resources
    * **Somechart** is the name of the chart (or chart alias) 
* Any **Secret** resource is converted to an **ExternalSecret** so that it can be checked into git
* A few extra steps are run on the YAMLs to help deployments
    * Add a common label so that `kubectl apply --prune --selector` can be used
    * Add some hashes to resources so that changes to configurations causes a rolling upgrade
    * Add support for the [pusher wave](https://github.com/pusher/wave) operator so that changing of secret values (inside, say, vault or Amazon/Azure/Google secret manager) causes a rolling upgrade of pods.


#### Apply step

This step is run on any commit to the main branch(after the generate step has completed).

It essentially does `kubectl apply` of the resources in the **config-root** tree in git.

The apply step could be performed by other tools if need be (e.g. Google Anthos Config Sync or flux).


### Promotion

When you create a quickstart or import a new project a new release is created then promotion is triggered just like in Jenkins X 2.x.

One change from Jenkins X 2.x is we default to including the specific kubernetes resources in git; rather than, say, just the name of a helm chart and the version.

So what tends to happen is:

* the promote step in a pipeline creates a Pull Request on the cluster repository for the cluster to add or upgrade a helm chart and version
* The above [Generate](#generate-step) and [Apply step](#apply-step) runs to fill in more details to the Pull Request of the actual kubernetes resources that will be added, modified or removed
* a second git commit is added to the Pull Request with the title `chore: regenerated`
* the `updatebot` label is added to the Pull Request so that the Pull Request can be considered for automatic merging if all of the git checks are green (including the Pull Request pipelines)
* once the Pull Request merges to the main branch the `git operator` will trigger to apply the kubernetes resources to the cluster via the above apply step


So you will see 2 commits on a typical promotion pull request:

* the high level change of the helm chart(s) and versions. e.g. to change `myapp` to version `1.2.3` 
* the detail of the actual changes that will apply to kubernetes resources. e.g. a new `Deployment` or changes to the `image:` of an existing `Deployment` 


### Importing / Creating Quickstarts

Due to the new GitOps model this is a little more complex than in v2 since imports are done via GitOps and the changes in git result in a Job / Pipeline running in the cluster to effect change.

Here are the steps involved in [creating projects](/docs/v3/develop/create-project/) via importing / creating quickstarts:

* Run the `jx project quickstart` or `jx project import` command as [described here](/docs/v3/develop/create-project/)
* New git repository is created if:
  * you are creating a quickstart via `jx project quickstart`
  * you are running `jx project import` inside a directory which has never been pushed to a git repository before
* A Pull Request is created on your cluster repo that registers your app's repository to the cluster
  * this Pull Request will create or modify a file called `.jx/gitops/source-config.yaml`
* The `jx project` command now waits for: 
  * the Pull Request to merge
  * Lighthhouse configuration to be updated to include the new repository
  * a webhook to be setup for the new repository    
* The Pull Request on your cluster repo triggers a pipeline like the above [Promotion flow](#promotion) 
  * a second git commit is generated and pushed to the Pull Request with the title `chore: regenerated` to add the git repository to the Lighthouse configuration
* When the Pull Request merges the above [Apply step](#apply-step) runs
  * Lighthouse configuration is updated
  * a Webhook is registered for Lighthouse on the app's repository
* The `jx project` command now continues and pushes the new [tekton pipelines for your app](/docs/v3/develop/pipeline-catalog/) to the main branch of the git repository
  * this triggers a new pipeline to run on your app which creates a new release of your app 
  * once the release is complete a Pull Request is created to start the [Promotion flow](#promotion) of the new app version
  * when this Promote Pull Request merges your application will be running in `Staging` 


You can see an example of this in the [demo of Jenkins X V3](/blog/2020/09/16/jx-v3-alpha/)  

## Comparison to 2.x

From a high level Jenkins X 3.x similar to 2.x in that:

* We use GitOps to manage applications, configurations and versions; keeping everything but secret values in git

However we’ve made a few changes in 3.x:

* We have a [simpler UX now for setting up Jenkins X](/docs/v3/getting-started/) which uses a library of GitOps repository templates you can start from
    * This lets you choose the closest example to the kind of infrastructure, tools and secret store you want to use so it’s easier to get started if your requirements fit the common quickstarts
* The setup/install/upgrade process runs inside kubernetes rather than on a developers laptop
    * This avoids all kinds of issues with different installations of tools like git, kubectl, helm etc
* In 2.x we always had a git repository for Dev, Staging and Production. In 3.x if those environments are all inside the same cluster we use the same git repository for configuring cluster level resources and resources in any namespaces.
    * So by default there is 1 git repository with Jenkins X 3.x for the installation
    * Whenever you create separate clusters (e.g. for muticluster support and you want Staging / Production environments to be separate), then each cluster gets its own git repository.
