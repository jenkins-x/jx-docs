---
title: Docker Registry
linktitle: Docker Registry
description: Configuring your docker registry 
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
menu:
  docs:
    parent: "architecture"
    weight: 100
weight: 100
sections_weight: 100
draft: false
toc: true
---

To be able to create and publish docker images we need to use a Docker Registry.

By default Jenkins X ships with a Docker Registry which is included in the system namespace for Jenkins X along with Jenkins and Nexus. Since this docker registry is running inside your kubernetes cluster and is used internally inside your cluster its hard to expose it via HTTPS with self signed certificates - so we default to using insecure docker registries for the IP range of service IPs in your kubernetes cluster.

## Using a different Docker Registry

If you are using the public cloud you may wish to take advantage of your cloud providers docker registry; or reuse your own existing docker registry.

To specify the Docker Registry host/port you can use the Jenkins Console:

```
jx console
``` 

Then navigate to `Manage Jenkins -> Configure System` and change the `DOCKER_REGISTRY` environment variable to point to your docker registry of choice.

Another approach is to add the following to your `values.yaml` file for your customisation of the Jenkins X platform helm charts:

```yaml 
jenkins:
  Servers:
    Global:
      EnvVars:
        DOCKER_REGISTRY: "gcr.io"
```

### Update the config.json secret

Next you will need to update the `config.json` secret for docker. 

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

Then to update the `jenkins-docker-cfg` secret you can do:

```
kubectl delete secret jenkins-docker-cfg
kubectl create secret generic jenkins-docker-cfg --from-file=./config.json
```   

### Mount a Secret for your registry

Your docker registry will require a Secret to be mounted into the [Pod Templates](/architecture/pod-templates/).

