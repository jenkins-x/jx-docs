---
title: Configuration
linktitle: Configuration
type: docs
description: Configuration of Environments and Promotion
weight: 200
---

In your development cluster the [jx-requirements.yml](https://github.com/jenkins-x/jx-api/blob/master/docs/config.md#requirements) file is used to define which are the default environments are used for promotion on your repositories.
       

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

        
## Multi cluster

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

## Custom environments per repository

If you wish to use different sets of environments for different microservices you can override the environments that are used for promotion by adding a `.jx/settings.yaml` with [this format](https://github.com/jenkins-x/jx-api/blob/master/docs/config.md#settings) which overrides settings found the development environments [jx-requirements.yml](https://github.com/jenkins-x/jx-api/blob/master/docs/config.md#requirements) file.

e.g. add something like this to your `.jx/settings.yaml` in a repository to override which environment repositories are promoted to:
           
```yaml 
apiVersion: core.jenkins-x.io/v4beta1
kind: Settings
spec:
  # lets replace the promote environments
  ignoreDevEnvironments: true
  promoteEnvironments:
  - key: my-staging
    owner: myowner
    repository: some-repo-name
  - key: my-prod
    owner: myowner
    repository: some-other-repo-name    
```


