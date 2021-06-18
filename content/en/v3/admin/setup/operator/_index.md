---
title: Install the Operator
linktitle: Install the Operator
type: docs
description: Install the Git Operator to install/upgrade Jenkins X
weight: 20
aliases:
  - /v3/guides/operator
  - /v3/admin/guides/operator
---

Jenkins X 3.x uses a [git operator](https://github.com/jenkins-x/jx-git-operator) to manage installing + upgrading of Jenkins X and any other components in any environment. If you are interested you can read [how it works](/v3/about/how-it-works/).


## Using Terraform

*NOTE* if you are using one of the public clouds to install Jenkins X then Terraform will install the [git operator](https://github.com/jenkins-x/jx-git-operator) for you so that there is no need for you to do so manually.

So the following approaches automatically install the operator for you:

* [Amazon](/v3/admin/platform/eks/)
* [Azure](/v3/admin/platform/azure/)
* [Google Cloud](/v3/admin/platform/gke/)

## Git user and token

To install the [git operator](https://github.com/jenkins-x/jx-git-operator) you will need a pipeline user and token for the git repository.

This user and token needs read and write access to the git repository containing the installation configuration. Ideally the token will also have permissions to be able to create a webhook on the repository (to trigger CI/CD pipelines whenever someone creates a Pull Request on the git repository).

You can always setup webhooks by hand yourself whenever a git repository is [created or imported](/v3/develop/create-project/) or the domain name of your [lighthouse](https://github.com/jenkins-x/lighthouse) hook endpoint changes via the [jx verify webhooks](https://github.com/jenkins-x/jx-verify/blob/master/docs/cmd/jx-verify_webhooks.md) command. Though its easier to get Jenkins X to automate this for you as part of the CI/CD pipelines; it just requires the git user and token to have sufficient permissions to list, create and modify webhooks.

Note also that the same pipeline user and token is reused by default for all pipelines on [all repositories created or imported](/v3/develop/create-project/) which will need read, write and webhook permissions on all of those repositories too. Though if you really want you can change this later on by [editing the pipeline token](/v3/guides/secrets/#edit-secrets).

## Create a git token

To create a git token for passing into the operator use this button:

<a href="https://github.com/settings/tokens/new?scopes=repo,read:user,read:org,user:email,admin:repo_hook,write:packages,read:packages,write:discussion,workflow" target="github" class="btn bg-primary text-light">Create new GitHub Token</a> 

## Installing the operator

Run [jx admin operator](https://github.com/jenkins-x/jx-admin/blob/master/docs/cmd/jx-admin_operator.md) command inside the git clone of the [git repository](/v3/admin/platform/) you created previously:

```bash
jx admin operator --username mygituser --token mygittoken
```

If you don't specify the `username` or `token` parameters you will be prompted for them.

If you are not inside the git clone of the [git repository](/v3/admin/platform/) you will need to specify the `--url` parameter for the git URL:

```bash 
jx admin operator --url=https://github.com/myorg/env-mycluster-dev.git --username mygituser --token mygittoken
```

This command will use helm to install the [git operator](https://github.com/jenkins-x/jx-git-operator) which will trigger a Job to install Jenkins X (and re-trigger a Job whenever you commit to your git repository).

The terminal will display the logs as the boot `Job` runs. 

Jenkins X will now install itself.

## HTTP proxy settings

If you are behind a HTTP proxy and need to configure environment variables for HTTP proxy support then you can do this as follows.

For each environment variable you want to pass in use the `--set jxBootJobEnvVarSecrets.NAME=value` argument.

e.g. something like this:


```bash 
export HPROXY=http://my.proxy.com
export NPROXY=localhost\\,127.0.0.1\\,.local\\,0\\,1\\,2\\,3\\,4\\,5\\,6\\,7\\,8\\,9

jx admin operator --url=https://github.com/myorg/env-mycluster-dev.git \
  --username mygituser --token mygittoken \
  --set jxBootJobEnvVarSecrets.HTTP_PROXY=$HPROXY \
  --set jxBootJobEnvVarSecrets.HTTPS_PROXY=$HPROXY \
  --set jxBootJobEnvVarSecrets.http_proxy=$HPROXY \
  --set jxBootJobEnvVarSecrets.https_proxy=$HPROXY \
  --set jxBootJobEnvVarSecrets.NO_PROXY=$NPROXY \
  --set jxBootJobEnvVarSecrets.no_proxy=$NPROXY
```
      
This should result in a secret called `jx-boot-job-env-vars` being created in the `jx-git-operator` namespace. This secret should get replicated to the `jx` namespace during the [boot job]().


## Viewing the logs 

At any time you can tail the boot job logs via the [jx admin log](https://github.com/jenkins-x/jx-admin/blob/master/docs/cmd/jx-admin_log.md) command:

```bash 
jx admin log
```

If you know you have just done a git commit and are waiting for the boot job to start you can run:

```bash 
jx admin log --wait
```

Which will wait for a running Job to display.

## Insecure git repositories 

If you are using an on-premises git repository you may need to configure git in the git operator and boot job to support insecure git repositories via a `git config` command or two.

When installing the git operator you can pass in any git configuration commands via the `--setup` argument. You can supply multiple of these arguments if you need them.

e.g.


```bash
export GIT_USERNAME=someone
export GIT_TOKEN=mytoken      

git clone https://github.com/myorg/env-mycluster-dev.git
cd env-mycluster-dev.git

jx admin operator --setup "git config --global http.sslverify false"
```

<nav>
  <ul class="pagination">
    <li class="page-item"><a class="page-link" href="../config">Previous</a></li>
    <li class="page-item"><a class="page-link" href="../secrets">Next</a></li>
  </ul>
</nav>
