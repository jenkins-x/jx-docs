---
title: Version Stream
linktitle: Version Stream
description: How we improve stability of Jenkins X and its Apps
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
menu:
  docs:
    parent: "architecture"
    weight: 79
weight: 79
sections_weight: 79
draft: false
toc: true
---

Jenkins X is made up of a large number of command line _packages_ and helm _charts_, some of which are released by the Jenkins X community and others come from the wider open source ecosystem.

To improve the stability of Jenkins X when lots of packages and charts are changing all the time we have introduced the Jenkins X `Version Stream`


## How it works

The value stream is stored in the [jenkins-x/jenkins-x-versions](https://github.com/jenkins-x/jenkins-x-versions) git repository and stores the stable version of all packages and charts used by Jenkins X.

When you run a command, such as to [create a cluster](/getting-started/create-cluster/), [install on an existing cluster](/getting-started/install-on-cluster/) or run a [jx upgrade](/commands/jx_upgrade/) command the `jx` command will ensure you have a local clone of the  [jenkins-x/jenkins-x-versions](https://github.com/jenkins-x/jenkins-x-versions) git repository and it will then pull the stable version of any chart or package from that source - or log a warning if a version is not yet being maintained.

## How we upgrade the Value Stream

We use GitOps and CI/CD to manage the Value Stream.

As new packages or charts are released we generate Pull Requests on the [jenkins-x/jenkins-x-versions](https://github.com/jenkins-x/jenkins-x-versions) git repository which will then trigger our [BDD tests](https://github.com/jenkins-x/bdd-jx) via [jx step bdd](/commands/jx_step_bdd/) and verify the new chart/package version works.

Pull Request approvers cam also choose to run their own manual tests on Pull Requests if they want. 

## Running the BDD tests

Note from a git clone of master or a Pull Request you can run the BDD tests against the Pull Requests version combination by using the [jx step bdd](/commands/jx_step_bdd/) and passing in `--dir .` for the directory of the clone.

e.g. you can run the BDD tests yourself via...

```shell 
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
