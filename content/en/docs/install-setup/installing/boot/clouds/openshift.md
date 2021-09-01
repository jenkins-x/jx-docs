---
title: OpenShift
linktitle: OpenShift
description: Using Boot On OpenShift
date: 2020-05-06
publishdate: 2020-05-06
lastmod: 2020-05-06
weight: 200
---

{{% alert title="Warning" color="warning" %}}
This documentation will help you getting Jenkins X installed on OpenShift with minimum supported features as it's still a work in progress.

Features like Vault integration and Long Term Storage for logs and artifacts are still not supported.
{{% /alert %}}

The OpenShift installation documentation will be split in two categories:

- Installing OpenShift with admin permissions.
- Installing OpenShift with restricted permissions.

Here are some recommendations to hopefully get you started. If you hit any issues please [join our community](/community/) we can hopefully help you.

## Common configuration

Please set your provider to `openshift` via this in your `jx-requirements.yml`:

```yaml
clusterConfig:
    provider: openshift
```

### Routes

With OpenShift, during the installation with Ansible, you are asked to provide an existing domain, the management of Routes is done directly by the cluster.

This means that, even if `nginx-ingress-controller` is installed, it will not be taken into account when managing routes.

To make Jenkins X work with your `Routes` and your defined cluster `Domain`, you will need to modify the `jx-requirements.yml` file like this:

```yaml
ingress:
  domain: <your_openshift_domain>
  exposer: Route
```

`ExposeController` will be configured to use Routes with the domain that you provided.

### TLS

As the domain will be created and managed by the cluster before Jenkins X is installed, the domain will need to be secured independently.

This means that the usual Jenkins X `cert-manager` integration will do nothing on OpenShift.

If you need your OpenShift domain to be secured, you will need to manage `cert-manager` and your `Issuer` and `Certificate` yourself.

### External Docker Registry

Right now, the supported way to store your docker images is using an external Docker registry like Docker Hub.

To configure it, you'll need to modify `jx-requirements.yml` like:

```yaml
clusterConfig:
  registry: docker.io
```

During the boot process, you will be asked `Do you want to configure non default Docker Registry?`. You'll need to answer yes and provide extra information to connect to Docker Hub.

```console
? Docker Registry Url https://index.docker.io/v1/
? Docker Registry username <your_dockerhub_username>
? Docker Registry password [? for help] <your_dockerhub_password>
? Docker Registry email <your_dockerhub_email>
```

## General advice

We recommend starting with the most simple possible installation and get that working, then gradually try to be more complex. e.g. start off by ignoring these features:

- vault
- cloud storage for artifacts

Then once you have something working, incrementally try enabling each of those in turn.

## Installing Jenkins X with admin rights

If you have admin rights in your OpenShift cluster and no restrictions to use cluster-wide permissions on services, this will be the preferred way to proceed.

You'll simply need to modify the `jx-requirements.yml` file with the recommended configuration explained above and run `jx boot`.

## Installing Jenkins X with restricted permissions

While the preferred way to install Jenkins X is with admin rights, OpenShift is aimed for the enterprise user.

This usually means having very limited permissions like not being able to create namespaces, not being able to use cluster-wide permissions etc.

In this case, the installation will need to be split in two phases:

- Cluster admin phase
- Restricted permissions phase

Your user may have admin rights and still want to install Jenkins X with limited permissions, so there will just be a phase in this case, but it will need to be configured to let Jenkins X know how to install itself.

### Basic configuration

In order to let Jenkins X know that it should install all of its resources with limited permissions, you'll need to edit `jx-requirements.yml` like:

```yaml
clusterConfig:
  strictPermissions: true
```

What this flag will do is the following:

- It will default to `Roles` and `RoleBindings` instead of `ClusterRoles` and `ClusterRoleBindings`.

- It will avoid creating any resource that needs to have cluster level permissions.

- It will create additional `Roles` in configured namespaces so certain controllers can work on different namespaces like `jx`, `jx-staging` and `jx-production`.

- It will use the `ControllerRole` and `EnvironmentRoleBindings` to copy the `tekton-bot` role to configured namespaces.

For now, it also comes with a limitation: Previews will not work on this kind of cluster. We are working on enabling them using a different mechanism.

### Cluster Admin phase

This phase will need to be executed by an user with cluster-admin role or with enough permissions to install `CustomResourceDefinitions`, `SecurityContextConstraints`, `ClusterRoles`, `ClusterRoleBindings` etc.

#### Jenkins X CRDS

The admin will need to install Jenkins X `CustomResourceDefinitions` by executing:

```console
jx upgrade crd
```

#### Manifests

These manifest files will need to be executed in order:

- Tekton CRDS:

```console
kubectl apply --wait -f https://raw.githubusercontent.com/jenkins-x/jenkins-x-boot-config/master/kubeProviders/openshift/templates/tekton-crds.yaml
```

- Namespaces:

```console
kubectl apply --wait -f https://raw.githubusercontent.com/jenkins-x/jenkins-x-boot-config/master/kubeProviders/openshift/templates/namespaces.yaml
```

- Service Accounts

```console
kubectl apply --wait -f https://raw.githubusercontent.com/jenkins-x/jenkins-x-boot-config/master/kubeProviders/openshift/templates/service-accounts.yaml
```

- JX Admin Role

```console
kubectl apply --wait -f https://raw.githubusercontent.com/jenkins-x/jenkins-x-boot-config/master/kubeProviders/openshift/templates/jx-admin-role.yaml
```

- ControllerBuild SecurityContextConstraint

```console
kubectl apply --wait -f https://raw.githubusercontent.com/jenkins-x/jenkins-x-boot-config/master/kubeProviders/openshift/templates/controller-build-scc.yaml
```

After running these manifests, the admin will need to provide an user with the `jx-admin` role in different namespaces:

```console
oc adm policy add-role-to-user jx-admin <username> --role-namespace jx --namespace jx
oc adm policy add-role-to-user jx-admin <username> --role-namespace jx-staging --namespace jx-staging
oc adm policy add-role-to-user jx-admin <username> --role-namespace jx-production --namespace jx-production
```

### Restricted permissions phase

After the cluster admin has created all the necessary resources, the restricted permissions phase can begin.

This can now be executed by the user that was assigned the `jx-admin` role in the Cluster Admin phase.

#### Preparation

Just one more small change is needed.

There are certain steps within `jenkins-x.yaml` that will fail to execute in this phase. Right now, there's no way to conditionally skip steps so these steps will need to be manually removed from the file.

These steps are:

- install-jx-crds
- install-velero
- install-velero-backups
- install-nginx-controller
- install-external-dns
- install-cert-manager-crds
- install-cert-manager
- install-acme-issuer-and-certificate

Once this is done, the installation can proceed as usual, by executing:

```console
jx boot
```
