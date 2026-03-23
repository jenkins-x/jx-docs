---
title: Version Stream
linktitle: Version Stream
description: How we improve stability of Jenkins X and its Apps
weight: 60
---

Jenkins X is made up of a large number of command line _packages_, _images_ and helm _charts_, some of which are released by the Jenkins X community and others come from the wider open source ecosystem.

To improve the stability of Jenkins X when lots of packages and charts are changing all the time we have introduced the Jenkins X `Version Stream`

<figure>
<img src="/images/jx-version-stream-v1.png"/>
<figcaption>
<h5>Diagram depicts how a new JX version will be propagated through the components.</h5>
</figcaption>
</figure>

## How it works

The version stream is stored in the [jenkins-x/jenkins-x-versions](https://github.com/jenkins-x/jenkins-x-versions) git repository and stores the stable version of all packages and charts used by Jenkins X.

When you run a command, such as to [create a cluster](/docs/getting-started/setup/create-cluster/), [install on an existing cluster](/docs/resources/guides/managing-jx/common-tasks/install-on-cluster/) or run a [jx upgrade](/commands/jx_upgrade/) command the `jx` command will ensure you have a local clone of the  [jenkins-x/jenkins-x-versions](https://github.com/jenkins-x/jenkins-x-versions) git repository and it will then pull the stable version of any chart or package from that source - or log a warning if a version is not yet being maintained.

The [jx](https://github.com/jenkins-x/jx) release now defaults to being released as a [prerelease](https://help.github.com/en/articles/creating-releases). Each release of jx is only updated to a full release so long as that released version successfully makes its way to the jenkins-x-versions repository where it also needs to pass another round of BDD tests (_see diagram above for more information_).

## How we upgrade the Version Stream

We use GitOps and CI/CD to manage the Version Stream.

As new packages or charts are released we generate Pull Requests on the [jenkins-x/jenkins-x-versions](https://github.com/jenkins-x/jenkins-x-versions) git repository. We then trigger our [BDD tests](https://github.com/jenkins-x/bdd-jx) via [jx step bdd](/commands/jx_step_bdd/) and verify the new chart/package version works before merging changes. Currently we manually trigger the BDD tests via a comment of `/test this` - but we hope to move to periodic triggering of the BDD tests (e.g. once per day).

Pull Request approvers can also choose to run their own manual tests on Pull Requests if they want.

Upon the successful completion of all BDD tests executed on the PR it will merge the change and execute an update to all jx dependencies (homebrew-jx, jx-docs, jx-tutorial and dev-env-base).

## Creating Pull Requests

We have a simple CLI command [jx step create pullrequest versions](/commands/jx_step_create_pullrequest_versions/) which can be used to automatically generate Pull Requests on the [jenkins-x/jenkins-x-versions](https://github.com/jenkins-x/jenkins-x-versions) git repository.

If you are the maintainer of an upstream chart that is used by Jenkins X it would be awesome to add this command at the end of your release pipeline to generate a Pull Request for us to upgrade Jenkins X to use your new release (after the BDD tests have run to verify things still work):

```sh
jx step create pullrequest versions -n mychartName -v 1.2.3
```

where `mychartName` is the fully qualified chart name using the remote repository prefix. e.g. `jenkins-x/prow` is the name of the `prow` chart maintained in the `jenkins-x` chart repository.

### Periodic updates

Its not always easy/possible to update upstream pipelines to push version changes to Jenkins X via a Pull Request. So you can setup a periodic job to check for version upgrades for all charts or charts matching some kind of wildcard.

e.g. to upgrade the versions of all the `jenkins-x` maintained charts you can run this command:


```sh
jx step create version pr -f "jenkins-x/*"
```

## Running the BDD tests

From a git clone of master or a Pull Request you can run the BDD tests against the Pull Requests version combination by using the [jx step bdd](/commands/jx_step_bdd/) command and specifying `--dir .` for the directory of the clone.

e.g. you can run the BDD tests yourself via...

```sh
git clone https://github.com/jenkins-x/jenkins-x-versions.git

# env vars for the git / jenkins secrets
export GIT_PROVIDER=github
export GIT_PROVIDER_URL=https://github.com
export BUILD_NUMBER=10
export JENKINS_CREDS_PSW=mypassword
export GIT_CREDS_PSW=XXXXXXX
export GIT_USER=YYYYY

jx step bdd --dir . --config jx/bdd/staticjenkins.yaml --gopath /tmp --git-provider=$GIT_PROVIDER --git-provider-url=$GIT_PROVIDER_URL --git-username $GIT_USER --git-owner $GIT_USER --git-api-token $GIT_CREDS_PSW --default-admin-password $JENKINS_CREDS_PSW --no-delete-app --no-delete-repo --tests test-create-spring
```

The various YAML files in the [jx/bdd folder](https://github.com/jenkins-x/jenkins-x-versions/tree/master/jx/bdd) contains a selection of different cluster configurations that can be used

