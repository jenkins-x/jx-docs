---
title: Jenkins X infrastructure
linktitle: Jenkins X infrastructure
description: Internal infrastructure used for Jenkins X
weight: 300
type: docs
no_list: true
---

Jenkins X runs it's infrastructure in Google Cloud Platform (GCP).
We have 2 GCP projects

- jenkinsxio
- jenkins-x-bdd

### jenkinsxio

This is where the main infrastructure runs (the jobs triggered when a pull request is opened in any repository).
Some details about the infrastructure are shown below

- GKE kubernetes version 1.21
- Spot instances to keep costs low
  - n1-standard-2 with boot size 100 GB
- Cluster autoscaler scales the nodes between 1 and 5.
- We use terraform, an infrastructure as Code tool to manage the cluster using the [google-jx](https://github.com/jenkins-x/terraform-google-jx) module.

### jenkins-x-bdd

This project is only used for bdd testing.
Test clusters are created here when a pull request is opened in the [jx3-versions](https://github.com/jenkins-x/jx3-versions) repository.

Test clusters are supposed to be transient, and are regularly gc'ed.

- If a test passes, then a clean up is performed at the end of the test run to delete the test cluster
- For a failed test, we have a cloud function scheduled to run every hour which deletes any left over clusters and cloud resources (persistent volumes, service accounts and secrets)
