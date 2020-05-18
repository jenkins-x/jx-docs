---
title: Access Control
linktitle: Access Control
aliases: [/rbac/]
description: Managing Access Control
weight: 10
---

Jenkins X uses Role-Based Access Control (RBAC) policies to control access to its various resources.  The enforcement of the policies is provided by [Kubernetes' RBAC support](https://kubernetes.io/docs/reference/access-authn-authz/rbac/).

[Teams](/about/concepts/features/#teams) can have a number of [Environments](/about/concepts/features/#environments) (e.g., Dev, Staging, Production) along with dynamic [Preview Environments](/docs/reference/preview/); keeping  the [`Role`](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) and [`RoleBinding`](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) resources from [Kubernetes RBAC](https://kubernetes.io/docs/reference/access-authn-authz/rbac/) in sync with all the various namespaces and members of your team can be challenging.

To make this management easier, Jenkins X creates a new [Custom Resource](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) called [`EnvironmentRoleBinding`](/docs/reference/components/custom-resources/#environmentrolebinding) which allows you to associate a `Role` labeled with `jenkins.io/kind=EnvironmentRole` with as many `Users` or `ServiceAccounts` as you like. As Environments are created or the `Role` or `EnvironmentRoleBinding` in the Dev environment is modified, the [`role controller`](/commands/jx_controller_role/#jx-controller-role) ensures that the configuration is replicated to all the environment namespaces by creating or updating all of the `Role` and `RoleBinding`s per namespace.

Roles are per Team so it is possible to have special roles per team, or to use common names for roles but have them customized for each team.

## Security Implications for the admin namespace

Jenkins X stores various configuration and settings (e.g., `Users`, `Teams`) in the main admin namespace (`jx`). Be careful when granting roles in the default `jx` team as allowing users to edit some of these files may allow them to escalate their permissions.
Instead of granting non-admin users access to the `jx` namespace, create teams and grant users access to those when using a shared cluster.

## Default Roles

Jenkins X ships with a collection of default `Role` objects you can use in the `jenkins-x-platform` template.  You can create your own if you wish, but any edits may be lost when Jenkins X is upgraded.

[viewer](https://github.com/jenkins-x/jenkins-x-platform/blob/master/jenkins-x-platform/templates/viewer-role.yaml)
: The `viewer` role allows access to read projects, builds, and logs. It does not allow access to sensitive information

[committer](https://github.com/jenkins-x/jenkins-x-platform/blob/master/jenkins-x-platform/templates/committer-role.yaml)
: The `committer` role provides the same permissions as `viewer` and allows the user to trigger builds and import new projects.

[owner](https://github.com/jenkins-x/jenkins-x-platform/blob/master/jenkins-x-platform/templates/owner-role.yaml)
: The owner role allows users to modify all team resources.

## Adding Users

To add users use the [jx create user](/commands/jx_create_user/) command:

```sh
jx create user --email "joe@example.com" --login joe --name "Joe Bloggs"
```

## Changing User Roles

To modify the roles for a user, use [jx edit userroles](/commands/jx_edit_userroles/):

```sh
jx edit userrole --login joe
```

If you omit the `--login` (`-l`) flag, you will be prompted to pick the user to edit.

For example, to make a user `joe` have the `committer` Role (and remove any existing roles):

```sh
jx edit userrole --login joe --role committer
```

If you have fine-grained roles and want to grant multiple roles to a user, you can specify the roles as a comma-separated list:
```sh
jx edit userrole --login joe --role committer,viewer
```


Modifying a user's roles changes the `EnvironmentRoleBinding`. The [role controller](/commands/jx_controller_role/#jx-controller-role) will replicate these changes to all the underlying Environment namespaces.
