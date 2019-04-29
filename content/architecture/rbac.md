---
title: RBAC
linktitle: RBAC
description: Managing Role Based Access Control
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
menu:
  docs:
    parent: "architecture"
    weight: 101
weight: 110
sections_weight: 101
draft: false
toc: true
---

By default Jenkins X defers to [Kubernetes for its RBAC support](https://kubernetes.io/docs/reference/access-authn-authz/rbac/).

However given a Team has a number of [Environments](/about/features/#environments) (e.g. Dev, Staging, Production) along with dynamic [Preview Environments](/developing/preview/) it can be a challenge keeping all the `Role` and `RoleBinding` resources from [Kubernetes RBAC](https://kubernetes.io/docs/reference/access-authn-authz/rbac/) in sync with all the various namespaces and members of your team.

So Jenkins X creates a new [Custom Resource](/architecture/custom-resources/) called `EnvironmentRoleBinding` which allows you to associate a `Role` labelled with `jenkins.io/kind=EnvironmentRole` with as many `Users` or `ServiceAccounts` as you like and a selection of Environments. Then as Environments are created or the `Role` or `EnvironmentRoleBinding` in the Dev environment is modified, the `role controller` ensures that the `EnvironmentRole` is replicated to all the environment namespaces as a `Role` and `RoleBinding` per namespace

The `role controller` is included by default inside Jenkins X or you can run it by hand via [jx controller role](/commands/jx_controller_role/#jx-controller-role)


## Default Roles

Jenkins X ships with a bunch of default `Role` objects you can use in the `jenkins-x-platform` template. You can disable any of these roles via [configuration](/getting-started/config/) and and create your own if you wish.

* [viewer](https://github.com/jenkins-x/jenkins-x-platform/blob/master/templates/viewer-role.yaml)
* [committer](https://github.com/jenkins-x/jenkins-x-platform/blob/master/templates/committer-role.yaml)
* [owner](https://github.com/jenkins-x/jenkins-x-platform/blob/master/templates/owner-role.yaml)

## Adding Users

To add users use the [jx create user](/commands/jx_create_user/) command:

```shell
jx create user -e "user@email.com" --login username --name "User Name" 
```

## Changing user roles

To modify the roles for a user use [jx edit userroles](/commands/jx_edit_userroles/):

```shell
jx edit userrole --l mylogin
```
 
If you omit the `-l` the command will prompt you to pick the user to edit.

e.g. to make a user `mylogin` have the `committer` Role:

```shell
jx edit userrole --l mylogin -r committer 
```

Once you modify the roles for a user this will modify the `EnvironmentRoleBinding` and then the [role controller](/commands/jx_controller_role/#jx-controller-role) will replicate these changes to all the underlying Environment namespaces.
