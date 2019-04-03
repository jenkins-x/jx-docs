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
weight: 4
toc: true
aliases: [/faq/]
---

We have tried to collate common issues here with work arounds. If your issue isn't listed here please [let us know](https://github.com/jenkins-x/jx/issues/new).

## Jenkins X does not startup

If your install fails to start there could be a few different reasons why the Jenkins X pods don't start.

Your cluster could be out of resources. You can check the spare resources on your cluster via [jx status](/commands/jx_status/):

    jx status
    
A common issue for pods not starting is if your cluster does not have a [default storage class](https://kubernetes.io/docs/concepts/storage/storage-classes/) setup so that `Persistent Volume Claims` can be bound to `Persistent Volumes` as described in the [install instructions](/getting-started/install-on-cluster/).

You can check your storage class and persistent volume setup via:

``` 
kubectl get pvc
```    

If things are working you should see something like:

``` 
$ kubectl get pvc
NAME                        STATUS    VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
jenkins                     Bound     pvc-680b39b5-94f1-11e8-b93d-42010a840238   30Gi       RWO            standard       12h
jenkins-x-chartmuseum       Bound     pvc-6808fb5e-94f1-11e8-b93d-42010a840238   8Gi        RWO            standard       12h
jenkins-x-docker-registry   Bound     pvc-680a415c-94f1-11e8-b93d-42010a840238   100Gi      RWO            standard       12h
jenkins-x-mongodb           Bound     pvc-680d6fd9-94f1-11e8-b93d-42010a840238   8Gi        RWO            standard       12h
jenkins-x-nexus             Bound     pvc-680fc692-94f1-11e8-b93d-42010a840238   8Gi        RWO            standard       12h
```    

If you see `status` of `Pending` then this indicates that you have no [default storage class](https://kubernetes.io/docs/concepts/storage/storage-classes/) setup on your kubnernetes cluster or you have ran out of persistent volume space.

Please try create a [default storage class](https://kubernetes.io/docs/concepts/storage/storage-classes/) for your cluster or contact your operations team or cloud provider.

If the `Persistent Volume Claims` are all `Bound` and things still have not started then try

```
kubectl get pod
```

If a pod cannot start try

```
kubectl describe pod some-pod-name
```

Maybe that gives you a clue. Is it RBAC related maybe?

If you are still stuck try [create an issue](https://github.com/jenkins-x/jx/issues/new)

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

Generally speaking this happens when your laptop has a different version of helm to the version used in our build pack docker images and/or the version of tiller thats running in your server.

The simplest fix for this is to just [not use tiller at all](https://jenkins-x.io/news/helm-without-tiller/) - which actually helps avoid this problem ever happening and solves a raft of security issues too.

However switching from using Tiller to No Tiller does require a re-install of Jenkins X (though you could try do that in separate set of namespaces then move projects across incrementally?).

The manual workaround is to install the [exact same version of helm as used on the server](https://github.com/helm/helm/releases) 

Or you can try switch tiller to match your client version:

* run `helm init --upgrade`

Though as soon as a pipeline runs it'll switch the tiller version again so you'll have to keep repeating the above.


## error creating jenkins credential jenkins-x-chartmuseum 500 Server Error

This is a [pending issue](https://github.com/jenkins-x/jx/issues/1234) which we will hopefully fix soon.

It basically happens if you have an old API token in `~/.jx/jenkinsAuth.yaml` for your jenkins server URL. You can either:

* remove it from that file by hand
* run the following command [jx delete jenkins token](https://jenkins-x.io/commands/jx_delete_jenkins_user/):

    jx delete jenkins token admin

## git errors: POST 401 Bad credentials

This indicates your git API token either was input incorrectly or has been regenerated and is now incorrect.

To recreate it with a new API token value try the following (changing the git server name to match your git provider):

```
jx delete git token -n GitHub admin
jx create git token -n GitHub admin
```

More details on [using git and Jenkins X here](/developing/git/)


## Invalid git token to scan a project

If you get an error in Jenkins when it tries to scan your repositories for branches something like:

``` 
hudson.AbortException: Invalid scan credentials *****/****** (API Token for acccessing https://github.com git service inside pipelines) to connect to https://api.github.com, skipping
```

Then your git API token was probably wrong or has expired.

To recreate it with a new API token value try the following (changing the git server name to match your git provider):

```
jx delete git token -n GitHub admin
jx create git token -n GitHub admin
```

More details on [using git and Jenkins X here](/developing/git/)

## What are the credentials to access core services?

Authenticated core services of Jenkins X include Jenkins, Nexus, ChartMuseum.  The default username is `admin`and the password by default is generated and printed out in the terminal after `jx create cluster` or `jx install`.  

### Set Admin Username and Password values for Core Services
You can also set the admin username via the `--default-admin-username=username` flag.

{{% note %}}
Perhaps you are using the  Active Directory security realm in Jenkins.  It is in this scenario that setting the Admin Username via the `--default-admin-username` based on your existing service accounts makes sense.

You may also pass this value via the `myvalues.yaml`.
{{% /note %}}

If you would like to set the default password yourself then you can set the flag `--default-admin-password=foo` to the two comamnds above.

If you don't have the terminal console output anymore you can look in the local file `~/.jx/jenkinsAuth.yaml` and find the password that matches your Jenkins server URL for the desired cluster.

## Persistent Volume Claims do not bind

If you notice that the persistent volume claims created when installing Jenkins X don't bind with

    kubectl get pvc

The you should check that you have a cluster default storage class for dynamic persistent volume provisioning.  See [here](https://kubernetes.io/docs/concepts/storage/dynamic-provisioning/) for more details.


## How can I diagnose exposecontroller issues?

When you [promote a new version of your application to an environment](/faq/develop/#how-does-promotion-actually-work), such as the Staging Environment a Pull Request is raised on the environment repository.

When the master pipeline runs on an environment a Kubernetes `Job` is created for [exposecontroller](https://github.com/jenkins-x/exposecontroller) which runs a pod until it terminates.

It can be tricky finding the log for temporary jobs since the pod is removed.

One way to diagnose logs in your, say, Staging environment is to [download and install kail](https://github.com/boz/kail) and add it to your `PATH`.

Then run this command:

```shell 
kail -l job-name=expose -n jx-staging
```

If you then promote to the Staging environment or retrigger the pipeline on the `master` branch of your Staging git repository (e.g. via [jx start pipeline](/commands/jx_start_pipeline/)) then you should see the output of the [exposecontroller](https://github.com/jenkins-x/exposecontroller) pod.


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

## How do I get the Password and Username for Jenkins?

Install [KSD](https://github.com/mfuentesg/ksd) by running `go get github.com/mfuentesg/ksd` and then run `kubectl get secret jenkins -o yaml | ksd`


## Other issues

Please [let us know](https://github.com/jenkins-x/jx/issues/new) and see if we can help? Good luck!
