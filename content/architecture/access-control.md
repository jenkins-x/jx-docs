---
title: Access Control
linktitle: Access Control
aliases: [/rbac/]
description: Managing Access Control
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

Jenkins X uses a Role Based Access Control (RBAC) policies to control access to its various resources.  The enforcement of the policies is provided by [Kubernetes' RBAC support](https://kubernetes.io/docs/reference/access-authn-authz/rbac/).

As a given [Team](/about/features/#teams) can have a number of [Environments](/about/features/#environments) (e.g. Dev, Staging, Production) along with dynamic [Preview Environments](/developing/preview/) it can be a challenge keeping all the [`Role`](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) and [`RoleBinding`](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) resources from [Kubernetes RBAC](https://kubernetes.io/docs/reference/access-authn-authz/rbac/) in sync with all the various namespaces and members of your team.

In order to make this management easier Jenkins X creates a new [Custom Resource](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) called [`EnvironmentRoleBinding`](architecture/custom-resources/#environmentrolebinding) which allows you to associate a `Role` labelled with `jenkins.io/kind=EnvironmentRole` with as many `Users` or `ServiceAccounts` as you like. Then as Environments are created or the `Role` or `EnvironmentRoleBinding` in the Dev environment is modified, the [`role controller`](/commands/jx_controller_role/#jx-controller-role) ensures that the configuration is replicated to all the environment namespaces by creating or updating all of the `Role` and `RoleBinding`s per namespace

Roles are per Team so it is possible to have special roles per team, or to use common names for roles but have them tweaked on a per team basis.

## Security Implications for the admin namespace

Jenkins X stores various configuration / settings (e.g. `Users`, `Teams`) in the main admin namespace (jx), therfore care should be taken when granting roles in the default `jx` team as allowing users to edit some of these files may allow them to escalate their permissions.
It is therefor not recommended to grant non admin users access to this namespace but to create teams and grant users access to those when using a shared cluster.

## Default Roles

Out of the box Jenkins X ships with a collection of default `Role` objects you can use in the `jenkins-x-platform` template.  You can of course create your own if you wish, but any edits may be lost when Jenkins X is upgraded.

[viewer](https://github.com/jenkins-x/jenkins-x-platform/blob/master/jenkins-x-platform/templates/viewer-role.yaml)
: The `viewer` role allows access to read projects, builds and logs.  It does not allow access to sensitive information

[committer](https://github.com/jenkins-x/jenkins-x-platform/blob/master/jenkins-x-platform/templates/committer-role.yaml)
: In addition to the `viewer` role `committer` allows the user to trigger builds and import new projects.

[owner](https://github.com/jenkins-x/jenkins-x-platform/blob/master/jenkins-x-platform/templates/owner-role.yaml)
: The owner role allows users to modify all team resources.

## Adding Users

To add users use the [jx create user](/commands/jx_create_user/) command:

```shell
jx create user --email "joe@example.com" --login joe --name "Joe Bloggs"
```

## Changing user roles

To modify the roles for a user use [jx edit userroles](/commands/jx_edit_userroles/):

```shell
jx edit userrole --login joe
```
 
If you omit the `--login` (`-l`) flag the command will prompt you to pick the user to edit.

e.g. to make a user `joe` have the `committer` Role (and remove any existing roles):

```shell
jx edit userrole --login joe --role committer
```

If you have fine grained roles and want to grant multiple roles to a user you can specify the roles as a comma separated list:
```shell
jx edit userrole --login joe --role committer,viewer
```


Once you modify the roles for a user this will modify the `EnvironmentRoleBinding` and then the [role controller](/commands/jx_controller_role/#jx-controller-role) will replicate these changes to all the underlying Environment namespaces.
