---
title: Common Problems
linktitle: Common Problems
description: Questions on common issues setting up Jenkins X.
date: 2018-02-10
categories: [faq]
menu:
  docs:
    parent: "faq"
keywords: [faqs]
weight: 20
toc: true
aliases: [/faq/]
---

We have tried to collate common issues here with work arounds. If your issue isn't listed here please [let us know](https://github.com/jenkins-x/jx/issues/new).


## http: server gave HTTP response to HTTPS client

If your pipeline fails with something like this:

```
The push refers to a repository [100.71.203.90:5000/lgil3/jx-test-app]
time="2018-07-09T21:18:31Z" level=fatal msg="build step: pushing [100.71.203.90:5000/lgil3/jx-test-app:0.0.2]: Get https://100.71.203.90:5000/v1/_ping: http: server gave HTTP response to HTTPS client"
```

Then this means that you are using the internal docker registry inside Jenkins X for your images but your kubernetes cluster's docker daemons has not been configured for `insecure-registries` so that you can use `http` to talk to the docker registry service `jenkins-x-docker-registry` in your cluster.

By default docker wants all docker registries to be exposed over `https` and to use TLS and certificates. This should be done for all public docker registries. However when using Jenkins X with an internal local docker registry this is hard since its not available at a public DNS name and doesn't have HTTPS or certificates; so we default to requiring `insecure-registry` be configured on all the docker daemons for your kubernetes worker nodes.

We try to automate this setting when using `jx create cluster`  e.g. on AWS we default this value to the IP range `100.64.0.0/10` to match most kubernetes service IP addresses.

On [EKS](https://jenkins-x.io/commands/jx_create_cluster_eks/) we default to using ECR to avoid this issue. Similarly we will soon default to GCR and ACR on GKE and AKS respectively.

So a workaround is to use a real [external docker registry](/architecture/docker-registry/) or enable `insecure-registry` on your docker daemons on your compute nodes on your Kubernetes cluster.


## Helm fails with Error: UPGRADE FAILED: incompatible versions client[...] server[...]'

This is a temporary issue we are hoping [to work around soon](https://github.com/jenkins-x/jx/issues/1304#issuecomment-405958831). 

Its basically a mismatch between the version of helm 2 installed on your laptop, the version of helm used in the build pods and the version of Tiller, the server side component in Helm 2 that is installed in the kubernetes cluster.

The issue goes away when we move to helm 3 as there's no Tiller component. Also we are looking at moving to use the [local plugin to avoid a server side Tiller component]().

Until the the local plugin or helm 3 the manual workaround is:

* [download the `2.10.0-rc1 version](https://github.com/helm/helm/releases) of helm and add it to your `PATH`
* run `helm init --upgrade`

## Invalid git token to scan a project

If you get an error in Jenkins when it tries to scan your repositories for branches something like:

``` 
hudson.AbortException: Invalid scan credentials *****/****** (API Token for acccessing https://github.com git service inside pipelines) to connect to https://api.github.com, skipping
```

Then your git API token was probably wrong or has expired.

To recreate it with a new API token value try the following (changing the git server name to match your git provider):

```
jx delete git token -n GitHub admin
jx create token -n GitHub admin
```

More details on [using git and Jenkins X here](/developing/git/)

## What are the credentials to access core services?

Authenticated core services of Jenkins X include Jenkins, Nexus, Chartmuseum.  The username is `admin` and the password by default is generated and printed out in the terminal after `jx create cluster` or `jx install`.  If you would like to set the default password yourself then you can set the flag `--default-admin-password=foo` to the two comamnds above.

If you don't have the terminal console output anymore you can look in the local file `~/.jx/jenkinsAuth.yaml` and find the password that matches your Jenkins server URL for the desired cluster.


## Cannot create cluster minikube
If you are using a Mac then `hyperkit` is the best VM driver to use - but does require you to install a recent [Docker for Mac](https://docs.docker.com/docker-for-mac/install/) first. Maybe try that then retry `jx create cluster minikube`?

If your minikube is failing to startup then you could try:

    minikube delete
    rm -rf ~/.minikube

If the `rm` fails you may need to do:

    sudo rm -rf ~/.minikube

Now try `jx create cluster minikube` again - did that help? Sometimes there are stale certs or files hanging around from old installations of minikube that can break things.

Sometimes a reboot can help in cases where virtualisation goes wrong ;)

Otherwise you could try follow the minikube instructions

* [install minikube](https://github.com/kubernetes/minikube#installation)
* [run minikube start](https://github.com/kubernetes/minikube#quickstart)

## Minkube and hyperkit: Could not find an IP address

If you are using minikube on a mac with hyperkit and find minikube fails to start with a log like:

```
Temporary Error: Could not find an IP address for 46:0:41:86:41:6e
Temporary Error: Could not find an IP address for 46:0:41:86:41:6e
Temporary Error: Could not find an IP address for 46:0:41:86:41:6e
Temporary Error: Could not find an IP address for 46:0:41:86:41:6e
```

It could be you have hit [this issue in minikube and hyperkit](https://github.com/kubernetes/minikube/issues/1926#issuecomment-356378525).

The work around is to try the following:

```
rm ~/.minikube/machines/minikube/hyperkit.pid
```

Then try again. Hopefully this time it will work!

## Cannot access services on minikube

When running minikube locally `jx` defaults to using [nip.io](http://nip.io/) as a way of using nice-isn DNS names for services and working around the fact that most laptops can't do wildcard DNS. However sometimes [nip.io](http://nip.io/) has issues and does not work.

To avoid using [nip.io](http://nip.io/) you can do the following:

Edit the file `~/.jx/cloud-environments/env-minikube/myvalues.yaml` and add the following content:

```yaml
expose:
  Args:
    - --exposer
    - NodePort
    - --http
    - "true"
```

Then re-run `jx install` and this will switch the services to be exposed on `node ports` instead of using ingress and DNS.

So if you type:

```
jx open
```

You'll see all the URs of the form `http://$(minikube ip):somePortNumber` which then avoids going through [nip.io](http://nip.io/) - it just means the URLs are a little more cryptic using magic port numbers rather than simple host names.




## Other issues

Please [let us know](https://github.com/jenkins-x/jx/issues/new) and see if we can help? Good luck!
