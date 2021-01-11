---
title: Configuration
linktitle: Configuration
type: docs
description: Configuration of Environments and Promotion
weight: 200
---

In your development cluster the `jx-requirements.yml` file is used to define which environments are used for promotion.

The [default configuration](https://github.com/jx3-gitops-repositories/jx3-kubernetes/blob/master/jx-requirements.yml#L18) for environments looks something like this:

```yaml
apiVersion: core.jenkins-x.io/v4beta1
kind: Requirements
spec:
  ...
  environments:
  - key: dev
  - key: staging
  - key: production
```

which defaults to meaning that `Staging` and `Production` are namespaces (`jx-staging` and `jx-production`) in the local cluster. `Staging` will use `Auto` promotion and `Production` will use `Manual` (more on that later).


When you setup a [Remote Cluster](/v3/admin/guides/multi-cluster/) for `Staging` or `Production`  you can remove the above entries for those environments.

Then when you import the remote cluster repository into the development environment (to setup the CI/CD on pull requests and enable promotion) the generated Pull Request will modify your `jx-requirements.yml` to add remote entries for the remote cluster.

e.g. after importing the remote `production` environment via [jx project import](https://github.com/jenkins-x/jx-project/blob/master/docs/cmd/project_import.md) and the pull request merging it should look like: 

```yaml 
apiVersion: core.jenkins-x.io/v4beta1
kind: Requirements
spec:
  ...
  environments:
    - key: dev
      repository: my-dev-environment
    - key: staging
    - key: production
      owner: myowner
      repository: my-prod-repo
      remoteCluster: true
``` 


