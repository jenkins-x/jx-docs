---
title: Installing the Operator
linktitle: Installing the Operator
description: Installing the Git Operator to install/upgrade Jenkins X
weight: 30
---

Jenkins X 3.x uses a [git operator](https://github.com/jenkins-x/jx-git-operator) to manage installing + upgrading of Jenkins X and any other components in any environment. If you are interested you can read [how it works](/docs/v3/about/how-it-works/).


## Using Terraform

*NOTE* if you are using one of the public clouds to install Jenkins X then Terraform will install the [git operator](https://github.com/jenkins-x/jx-git-operator) for you so that there is no need for you to do so manually.

So the following approaches automatically install the operator for you:

* [Amazon](/docs/v3/getting-started/eks/)
* [Azure](/docs/v3/getting-started/azure/)
* [Google Cloud](/docs/v3/getting-started/gke/)

## Git user and token

To install the [git operator](https://github.com/jenkins-x/jx-git-operator) you will need a pipeline user and token for the git repository.

This user and token needs read and write access to the git repository containing the installation configuration. Ideally the token will also have permissions to be able to create a webhook on the repository (to trigger CI/CD pipelines whenever someone creates a Pull Request on the git repository).

You can always setup webhooks by hand yourself whenever a git repository is [created or imported](/docs/v3/develop/create-project/) or the domain name of your [lighthouse](https://github.com/jenkins-x/lighthouse) hook endpoint changes via the [jx verify webhooks](https://github.com/jenkins-x/jx-verify/blob/master/docs/cmd/jx-verify_webhooks.md) command. Though its easier to get Jenkins X to automate this for you as part of the CI/CD pipelines; it just requires the git user and token to have sufficient permissions to list, create and modify webhooks.

Note also that the same pipeline user and token is reused by default for all pipelines on [all repositories created or imported](/docs/v3/develop/create-project/) which will need read, write and webhook permissions on all of those repositories too. Though if you really want you can change this later on by [editing the pipeline token](/docs/v3/guides/secrets/#edit-secrets).


## Create a git token

To create a git token for passing into the operator use this button:

<a href="https://github.com/settings/tokens/new?scopes=repo,read:user,read:org,user:email,admin:repo_hook,delete_repo,write:packages,read:packages,write:discussion,workflow" target="github" class="btn bg-primary text-light">Create new GitHub Token</a> 

## Installing the operator

Run [jx admin operator](https://github.com/jenkins-x/jx-admin/blob/master/docs/cmd/jx-admin_operator.md) command inside the git clone of the [git repository](/docs/v3/getting-started/) you created previously:

```bash
jx admin operator --username mygituser --token mygittoken
```

If you don't specify the `username` or `token` parameters you will be prompted for them.

If you are not inside the git clone of the [git repository](/docs/v3/getting-started/) you will need to specify the `--url` parameter for the git URL:

```bash 
jx admin operator --url=https://github.com/myorg/env-mycluster-dev.git --username mygituser --token mygittoken
```

This command will use helm to install the [git operator](https://github.com/jenkins-x/jx-git-operator) which will trigger a Job to install Jenkins X (and re-trigger a Job whenever you commit to your git repository).

The terminal will display the logs as the boot `Job` runs. 

At any time you can tail the boot job logs via the [jx admin log](https://github.com/jenkins-x/jx-admin/blob/master/docs/cmd/jx-admin_log.md) command:

```bash 
jx admin log
```

Jenkins X will now install itself.

If you want to, you can populate the [secrets](/docs/v3/guides/secrets/) once the `ExternalSecret` custom resources have been created. 

<nav>
  <ul class="pagination">
    <li class="page-item"><a class="page-link" href="../config">Previous</a></li>
    <li class="page-item"><a class="page-link" href="../secrets">Next</a></li>
  </ul>
</nav>
