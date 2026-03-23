---
title: Custom Resources
linktitle: Custom Resources
description: Custom Resources defined by Jenkins X
parent: "components"
weight: 10
aliases:
  - /docs/resources/guides/managing-jx/common-tasks/custom-resources
---

Kubernetes provides an extension mechanism called [Custom Resources](https://kubernetes.io/docs/concepts/api-extension/custom-resources/) which allows microservices to extend the Kubernetes platform to solve higher order problems.

So in Jenkins X, we have added a number of Custom Resources to help extend Kubernetes to support CI/CD.

You can also [browse the Custom Resource API Reference](/apidocs/)

## Environments

Jenkins X natively supports [environments](/about/concepts/features/#environments) allowing them to be defined for your team and then queried via [jx get environments](/commands/jx_get_environments/):

```sh
jx get environments
```

Under the covers that command uses the custom Kubernetes resource `Environments`.

So you can also query the environments via [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) as well:


```sh
kubectl get environments
```

Or edit them via `YAML` directly if you want:

```sh
kubectl edit env staging
```

though you may prefer the easier to use [jx edit environment](/commands/jx_edit_environment/) command.

## Release

The Jenkins X pipelines generate a custom `Release` resource which we can use to keep track of:

* what version, Git tag and Git URL map to a release in Kubernetes/Helm
* what Jenkins pipeline URL and log was used to perform the release
* which commits, issues and Pull Requests were part of each release so that we can implement [feedback as issues are fixed in Staging/Production](/about/concepts/features/#feedback)

## SourceRepository

This stores information about source code repositories that Jenkins X is set to build.

It is created by `jx import` and `jx create quickstart` and removed whenever a `jx delete application` is invoked.

## Scheduler

This is used to define a configuration for one or more `SourceRepository` and is used by [jx boot]() to generate the Prow configuration.

This lets you setup a default `Scheduler` for a team and then you don't have to touch your prow configuration at all; all imported/created projects will inherit from the default `Scheduler`.

Or when you perform `jx import` or `jx create quickstart` you can pass in a `--scheduler` command line argument to use a specific scheduler.


## PipelineActivity

This resource stores the pipeline status in terms of Jenkins Pipeline stages plus the [promotion activity](/about/concepts/features/#promotion).

This resource is also used by the [jx get activities](/commands/jx_get_activities/) command.

## Team

The `Team` Custom Resource is created via the [jx create team](/commands/jx_create_team/) command and is used by the `team controller` to watch for new `Team` resources and then create an installation of Jenkins X in the `teams` namespace. For more background on teams see the [team feature](/about/concepts/features/#teams).

### User

The `User` Custom Resource is used to support RBAC across the various [environments](/about/concepts/features/#environments) and [preview environments](/about/concepts/features/#preview-environments) in teams.

It is also used by the [jx edit userroles](/commands/jx_edit_userroles/) to change user roles.

## EnvironmentRoleBinding

The `EnvironmentRoleBinding` resource is like the standard Kubernetes [RoleBinding](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#rolebinding-v1-rbac-authorization-k8s-io) resource, but it allows mapping of a `Role` to multiple [environments](/about/concepts/features/#environments) and [preview environments](/about/concepts/features/#preview-environments) in a team by using a selector of Environments on which to bind roles.

This makes it easy to bind a `Role` to either all environments, all preview environments or both or a given set of users.


