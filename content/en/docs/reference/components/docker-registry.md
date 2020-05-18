---
title: Docker Registry
linktitle: Docker Registry
description: Configuring your docker registry
weight: 90
aliases:
  - /docs/resources/guides/managing-jx/common-tasks/docker-registry
---

To be able to create and publish docker images we need to use a Docker Registry.

By default Jenkins X ships with a Docker Registry which is included in the system namespace for Jenkins X along with Jenkins and Nexus. Since this docker registry is running inside your kubernetes cluster and is used internally inside your cluster its hard to expose it via HTTPS with self signed certificates - so we default to using insecure docker registries for the IP range of service IPs in your kubernetes cluster.

## Using a different Docker Registry

If you are using the public cloud you may wish to take advantage of your cloud providers docker registry; or reuse your own existing docker registry.

### If you are using Static Jenkins Master
To specify the Docker Registry host/port you can use the Jenkins Console:

```sh
jx console
```

Then navigate to `Manage Jenkins -> Configure System` and change the `DOCKER_REGISTRY` environment variable to point to your docker registry of choice.

Another approach is to add the following to your `values.yaml` file for your customization of the Jenkins X platform helm charts:

```yaml
jenkins:
  Servers:
    Global:
      EnvVars:
        DOCKER_REGISTRY: "gcr.io"
```

## Update the config.json secret

Next you will need to update the `config.json` secret for docker.

You can do this via the [jx create docker auth](/commands/jx_create_docker/) command line tool:

```
jx create docker auth --host "foo.private.docker.registry" --user "foo" --secret "FooDockerHubToken" --email "fakeemail@gmail.com"

```

If you create a `config.json` file for your docker registry provider. e.g. for GCR on Google Cloud its probably something like:


```json
{
    "credHelpers": {
        "gcr.io": "gcloud",
        "us.gcr.io": "gcloud",
        "eu.gcr.io": "gcloud",
        "asia.gcr.io": "gcloud",
        "staging-k8s.gcr.io": "gcloud"
    }
}
```

For AWS its more like

```json
{
	"credsStore": "ecr-login"
}
```

Then to update the `jenkins-docker-cfg` secret you can do the following:

```
kubectl delete secret jenkins-docker-cfg
kubectl create secret generic jenkins-docker-cfg --from-file=./config.json
```

**NOTE** that the file must be called `config.json` as the file name is used in the key of the underlying `Secret` in kubernetes

## Using Docker Hub

If you want to publish images to docker hub then you need to modify your `config.json` as described above to something like:

```json
{
    "auths": {
        "https://index.docker.io/v1/": {
            "auth": "MyDockerHubToken",
            "email": "myemail@acme.com"
        }
    }
}
```

## Using jFrog BinTray (Artifactory)
Using the jFrog BinTray as a private registry is possible.  This has only been tested when creating a new cluster and passing the `--docker-registry=private-reg.bintray.io`.  After creating your cluster, you will want to do the following:

1. Delete the existing `Secret` called `jenkins-docker-cfg` by executing

```sh
kubectl delete secret jenkins-docker-cfg
```
2. Create a local file called `config.json` and its value should be in this format (update values based on your registry user account and FQDN).

```json
{
    "auths": {
        "https://private-reg.bintray.io": {
            "auth": "username:password (base64 encoded)",
            "email": "myemail@acme.com"
        }
    }
}
```
2. Create the new `jenkins-docker-cfg` `Secret` with the contents of the `config.json` as follows:

```sh
kubectl create secret generic jenkins-docker-cfg --from-file=./config.json
```

That should do it, you should now be able to run pipelines and store images in the jFrog BinTray Registry.


### Mount a Secret for your registry

Your docker registry will require a Secret to be mounted into the [Pod Templates](/docs/resources/guides/managing-jx/common-tasks/pod-templates/).

