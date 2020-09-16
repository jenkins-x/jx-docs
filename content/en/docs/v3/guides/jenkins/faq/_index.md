---
title: FAQ
linktitle: FAQ
description: Questions on Jenkins interop
weight: 200
aliases:
  - /faq/
---


### Jenkins X used to install a Jenkins Server into Kubernetes for me. How do I install Jenkins now?

Jenkins is to Jenkins X as Java is to Javascript - all they share is a name. You don't need Jenkins installed to use Jenkins X. That said, you may want to install Jenkins in the same Kubernetes cluster as Jenkins X. Here's some links that explain how you can do it:


*   Jenkins Operator - [https://jenkinsci.github.io/kubernetes-operator/docs/installation/](https://jenkinsci.github.io/kubernetes-operator/docs/installation/)
*   Jenkins Helm Chart - [https://github.com/helm/charts/tree/master/stable/jenkins](https://github.com/helm/charts/tree/master/stable/jenkins)

As well as some commercial offerings:

*   CloudBees Core - [https://docs.cloudbees.com/docs/cloudbees-jenkins-distribution/latest/distro-install-guide/kubernetes](https://docs.cloudbees.com/docs/cloudbees-jenkins-distribution/latest/distro-install-guide/kubernetes)
*   Google Kubernetes Engine - [https://cloud.google.com/solutions/jenkins-on-kubernetes-engine-tutorial](https://cloud.google.com/solutions/jenkins-on-kubernetes-engine-tutorial)

## How can I connect to a remote Jenkins server?


See [how to add Jenkins into Jenkins X](/docs/v3/guides/jenkins/getting-started/#adding-jenkins-servers-into-jenkins-x) or [registering external Jenkins servers](/docs/v3/guides/jenkins/getting-started/#registering-external-jenkins-servers)
