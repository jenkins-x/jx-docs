---
title: Configuration
linktitle: Configuration
type: docs
description: Configuration of Environments and Promotion
weight: 200
---

In your development cluster git repository the [jx-requirements.yml](https://github.com/jenkins-x/jx-api/blob/master/docs/config.md#requirements) file is used to define which are the default environments are used for promotion on your repositories.
       

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

## Custom environments per group of repositories

If you have different teams sharing the same Jenkins X installation you may wish to organise the repositories into _groups_ (e.g. a group of repositories per team).
 
The simplest way to do this is to use a separate git organisation (owner) per team and then you already get separate configurations per group/owner in the `.jx/gitops/source-config.yaml` file in your development cluster git repository.
                                                    
The added benefit of using separate git organisations is that already the [dashboard](/v3/develop/ui/dashboard/) supports filtering all pipelines by owner; so each team will get effectively their own separate UI for viewing pipelines. You can easily bookmark the dashboards view for a single owner / repository.

e.g. here's an example `.jx/gitops/source-config.yaml in the development cluster git repository:

```yaml 
apiVersion: gitops.jenkins-x.io/v1alpha1
kind: SourceConfig
metadata:
  creationTimestamp: null
spec:
  groups:
  - owner: team1
    provider: https://github.com
    providerKind: github
    repositories:
    - name: cheese-frontend
    - name: cheese-backend
    scheduler: in-repo
    settings:
      destination:
        chartRepository: https://github.com/team1/charts.git
        chartKind: pages
      # lets replace the promote environments
      ignoreDevEnvironments: true
      promoteEnvironments:
      - key: my-staging
        owner: team1
        repository: some-repo-name
      - key: my-prod
        owner: team1
        repository: some-other-repo-name    
  - owner: team2
    provider: https://github.com
    providerKind: github
    repositories:
    - name: another
    - name: somerepo
    scheduler: in-repo
    settings:
      destination:
        chartRepository: https://github.com/team2/charts.git
        chartKind: pages
      # lets replace the promote environments
      ignoreDevEnvironments: true
      promoteEnvironments:
      - key: my-staging
        owner: team2
        repository: some-repo-name
      - key: my-prod
        owner: team2
        repository: some-other-repo-name    
```

If using different git organisations isn't practical you can at least get some of the benefits by just creating multiple groups in the `.jx/gitops/source-config.yaml` and associating different `settings:` to each group.

Note that any settings in a local repository `.jx/settings.yaml` file will be used; putting shared settings in the development git repository is used if there is no `.jx/settings.yaml` file.

          

