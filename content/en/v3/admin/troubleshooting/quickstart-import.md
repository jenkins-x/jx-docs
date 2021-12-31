---
title: Quickstart/Import
linktitle: Quickstart-Import
type: docs
description: How to diagnose and fix issues with quickstart and/or import
weight: 500
---

After a successful installation of Jenkins X, the first thing to do is to either create a quickstart or import an existing repository into Jenkins X.
They are both very similar, so the steps mentioned here can be applied for both.

Import/Quickstart involves the following steps:

- Cloning of the dev/cluster git repository
- Selecting and copying catalog folder into imported repository
- Pull Request in the cluster git repository
- Webhook creation in the imported repository
- Addition of the repository name to the `config` configmap
- Source repository creation in the `jx` namespace

### Issues with cloning dev repository

If you encounter an issue of this form:

```
error: failed to clone dev env git repository: failed to clone dev environment git repository
```

it means that jx cli cannot find the correct git credentials.
Run it with log level debug (`JX_LOG_LEVEL=debug`), and it might shed some light into the issues.
jx looks at a few places for the credentials:

- `--git-token` and `--git-username`
- ~/.git-credentials
- [~/git/credentials](https://jenkins-x.io/v3/develop/faq/using/#how-do-i-stop-jx-asking-for-git-credentials)

Passing the args for every import is cumbersome and error prone, hence it's better to create the git credentials file.

The git credential file expects the username and token in the form:

```
https://<username>:<token>@<scm-provider>.<tld>
```

Verify that this token can be used to clone the dev repository.

### Issues with selecting and cloning catalog folder

During the import process, jx will ask which catalog folder to use, it will try to guess based on the language files it finds in the imported folder.
Once you have selected a catalog, jx will copy the catalog pack from the packs folder of [jx3-pipeline-catalog](https://github.com/jenkins-x/jx3-pipeline-catalog/tree/master/packs)

For example for go, you should expect the following files/folders:

- .lighthouse folder
- charts folder
- preview folder
- Dockerfile

Check [this](https://github.com/jenkins-x/jx3-pipeline-catalog/tree/master/packs/go) for the latest files or folders which are copied.

Apart from these files, it also creates OWNERS and OWNERS_ALIASES files which are used by lighthouse to determine which users can approve Pull Requests.

Verify that these folders/files are created.

There is a permission issue with some jx versions, check this [github issue](https://github.com/jenkins-x/jx/issues/8028) on how to mitigate the problem.

### Issue with pull request creation

jx project import command will open a pull request in the cluster git repository.
This PR will first have one commit which should modify the file `.jx/gitops/source-config.yaml`, which should be of the form:

```
apiVersion: gitops.jenkins-x.io/v1alpha1
kind: SourceConfig
metadata:
  creationTimestamp: null
spec:
  groups:
  - owner: <owner>
    provider: https://github.com
    providerKind: github
    repositories:
    - name: <repo-name>
    scheduler: in-repo
  slack:
    channel: '#jenkins-x-pipelines'
    kind: failureOrNextSuccess
    pipeline: release
```

In case `scheduler: in-repo` is missing in the changed file, it's most probably because `.lighthouse/jenkins-x/trigger` file was not created.
Either import was run with `--no-pack` or the catalog folder was not copied properly.

Few minutes after the PR is opened with one commit, a second commit is created with more changes.
The files that are changed include:

- config-root/namespaces/jx/lighthouse-config/config-cm.yaml
- config-root/namespaces/jx/lighthouse-config/plugins-cm.yaml
- config-root/namespaces/jx/lighthouse/lighthouse-foghorn-deploy.yaml
- config-root/namespaces/jx/lighthouse/lighthouse-keeper-deploy.yaml
- config-root/namespaces/jx/lighthouse/lighthouse-poller-deploy.yaml
- config-root/namespaces/jx/lighthouse/lighthouse-tekton-controller-deploy.yaml
- config-root/namespaces/jx/lighthouse/lighthouse-webhooks-deploy.yaml
- config-root/namespaces/jx/source-repositories/owner-repo.yaml

If the second commit is not created, it means the verify job failed (use the `dashboard` or `octant ui`).
Check the logs of the job which should give you some hints.

If you check the `.lighthouse/jenkins-x/pullrequest.yaml` file, you will see that the PR runs the command make-pr, which actually runs `jx gitops apply --pull-request` which invokes the `pr-regen` target in the `versionStream/src/Makefile.mk` of the cluster git repository.

The command will wait upto 20 minutes for the pull request to be merged, do not merge it on your own, as it may mean the verify job did not complete successfully.
Possible causes for the pull request to be not auto merged could be that the bot user does not have the right permissions to merge PRs for the cluster git repository.
if you have seen that both the commits have completed successfully, and the jx import command has timed out waiting for it to auto merge, it is safe to merge it manually.

if the pull request got automerged (or merged by hand because it timed out waiting), then the release pipeline will be run.

### Issues with Final set up (webhook creation and trigger)

Release pipeline executes the `.lighthouse/jenkins-x/release.yaml` file.
Once the job has succeeded (you can watch the progress in the UI or just run `jx admin log`), you should see

- a webhook in the imported repository
- an entry for the imported repository in the `config` configmap in the `jx` namespace

To check if the webhook has been created, navigate to `settings -> webhook`.
To check if the imported repository was added to the `config` configmap, run

```
kubectl get configmap config -n jx -oyaml
```

You should see something like this:

```
in_repo_config:
      enabled:
        owner/repo: true
        owner/cluster-git-repo: true
```

Finally, you should be able to see the source repository resource created for the imported repository:

```
kubectl get sr -n jx
NAME                   URL                                         DESCRIPTION
dev                    https://github.com/owner/cluster-git.git   the git repository for the Dev environment
owner-repo             https://github.com/owner/repo
```

If either the

- webhook is missing, which shows error of this form:

```
It looks like the boot job failed to setup the webhooks. It could be related to the git token permissions.
failed to find sourceRepository  in namespace jx for repository owner-repository
```

- repo is missing in the `config` config map, check the logs of the release pipeline, which shows errors of this form:

```
error: failed to wait for repository to be setup in lighthouse: failed to find trigger in the lighthouse configuration in ConfigMap config in namespace jx for repository: owner/repo within 20m0s
```

check the logs from the release pipeline to see what is the issue.

If everything works, then your repository has been successfully imported into Jenkins X!
