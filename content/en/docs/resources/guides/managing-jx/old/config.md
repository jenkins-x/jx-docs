---
title: Configuration
linktitle: Configuration
description: Customising your Jenkins X installation
date: 2016-11-01
publishdate: 2016-11-01
lastmod: 2018-01-02
categories: [getting started]
keywords: [install,kubernetes]
aliases:
  - /getting-started/config
  - /docs/resources/guides/managing-jx/common-tasks/config/
weight: 50
---

Jenkins X should work out of the box with smart defaults for your cloud provider. e.g. Jenkins X automatically uses ECR if you are using AWS or EKS.

However you can configure values in the underlying helm charts used by Jenkins X.

To do this you need to create a `myvalues.yaml` file in the current directory you are in when you run either [jx create cluster](/commands/jx_create_cluster/) or [jx install](/commands/deprecation/)

Then this YAML file can be used to override any of the underlying [`values.yaml`](https://github.com/jenkins-x/jenkins-x-platform/blob/master/jenkins-x-platform/values.yaml) in any of the [charts](https://github.com/jenkins-x/jenkins-x-platform/blob/master/jenkins-x-platform/requirements.yaml) in Jenkins X.

## Making changes after the install

Once you have installed you can make more changes via [jx upgrade platform](/commands/deprecation/) which will reuse your `myvalues.yaml` file.

Or if you use [GitOps management](/docs/resources/guides/managing-jx/common-tasks/manage-via-gitops/) you can just create a Pull Request on your Development environment git repository.

## Nexus

e.g. if you wish to disable Nexus being installed and instead service link to a separate nexus at a different host name you can use this `myvalues.yaml`:

```yaml
nexus:
  enabled: false
nexusServiceLink:
  enabled: true
  externalName: "nexus.jx.svc.cluster.local"
```

## ChartMuseum

To disable and service link chart museum add:

```yaml
chartmuseum:
  enabled: false
chartmuseumServiceLink:
  enabled: true
  externalName: "jenkins-x-chartmuseum.jx.svc.cluster.local"
```

## Jenkins Image

We ship with a default Jenkins docker image [jenkinsxio/jenkinsx](https://hub.docker.com/r/jenkinsxio/jenkinsx/) with Jenkins X which has all of our required plugins inside.

If you wish to add your own plugins you can create your own `Dockerfile` and image using our base image like this:

```dockerfile
# Dockerfile for adding plugins to Jenkins X
FROM jenkinsxio/jenkinsx:latest

COPY plugins.txt /usr/share/jenkins/ref/openshift-plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/openshift-plugins.txt
```

Then add your custom plugins to `plugins.txt` locally of the form:

```txt
myplugin:1.2.3
anotherplugin:4.5.6
```

Once you have built and released your image via CI/CD you can then use it in your Jenkins X installation.

To configure Jenkins X to use your custom image you can specify your own Jenkins image via a `myvalues.yaml` file:

```yaml
jenkins:
  Master:
    Image: "acme/my-jenkinsx"
    ImageTag: "1.2.3"
```

There is an example OSS project [jenkins-x/jenkins-x-openshift-image](https://github.com/jenkins-x/jenkins-x-openshift-image) you could use as a template which creates a new Jenkins image to add OpenShift specific plugins and configuration for using Jenkins X on OpenShift.

## Docker Registry

We try and use the best defaults for each platform for the Docker Registry; e.g. using ECR on AWS.

However you can also specify this via the `--docker-registry` option when running  [jx create cluster](/commands/jx_create_cluster/) or [jx install](/commands/deprecation/)

e.g.

```sh
jx create cluster gke --docker-registry eu.gcr.io
```

Though if you use a different Docker Registry you will probably need to [also modify the secret for connecting to docker](/docs/reference/components/docker-registry/#update-the-configjson-secret).
