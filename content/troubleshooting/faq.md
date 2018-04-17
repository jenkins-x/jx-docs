---
title: Frequently Asked Questions
linktitle: FAQ
description: Solutions to some common Jenkins X problems.
date: 2018-02-10
categories: [troubleshooting]
menu:
  docs:
    parent: "troubleshooting"
keywords: [faqs]
weight: 2
toc: true
aliases: [/faq/]
---

We have tried to collate common issues here with work arounds. If your issue isn't listed here please [let us know](https://github.com/jenkins-x/jx/issues/new).


### Is Jenkins X Open Source?

Yes! All of Jenkins X source code and artifacts are open source; either Apache or MIT and will always remain so!


### Is Jenkins X a fork of Jenkins?

No! Jenkins X will always reuse whatever is in Jenkins Core and configure it to be as kubernetes native as possible.

Initially Jenkins X is a distribution of the core Jenkins with a custom kubernetes configuration with some additional built in plugins (e.g. the kubernetes plugin and jx pipelines plugin) packaged as a Helm chart.

Over time we hope the Jenkins X project can drive some changes in the Jenkins Core to help make Jenkins more Cloud Native. e.g. using a database or Kubernetes resources to store Jobs, Runs and Credentials so its easier to support things like multi-master or one shot masters. Though those changes will happen first through Jenkins Core then get reused by Jenkins X

### Why create a sub project?

We are huge fans of <a href="https://kubernetes.io/">Kubernetes</a> &amp; the cloud and think its
the long term future approach for running software for many folks.

However lots of folks will still want to run Jenkins in the regular jenkins way via: <code>java
-jar jenkins.war</code>


So the idea of the Jenkins X sub project is to focus 100% on the Kubernetes and Cloud Native use
case and let the core Jenkins project focus on the classic java approach.

One of Jenkins big strengths has always been its flexibility and huge ecosystem of different
plugins and capabilities. The separate Jenkins X sub project helps the community iterate and go fast
improving both the Cloud Native and the classic distributions of Jenkins in parallel.                   

### Cannot create cluster minikube
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

### Minkube and hyperkit: Could not find an IP address

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

### Cannot access services on minikube

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




### Other issues

Please [let us know](https://github.com/jenkins-x/jx/issues/new) and see if we can help? Good luck!
