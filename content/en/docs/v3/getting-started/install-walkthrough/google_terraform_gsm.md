---
title: Terraform Cloud - GCP - Google Secrets Manager
linktitle: Terraform Cloud - GCP - Google Secrets Manager
description: Installation walkthrough using Terraform Cloud, Google Cloud Platform and Google Secrets manager
weight: 100
---

This walkthrough is still work in progress and needs to be smoothed out so contributions as always are welcome to help improve.

[Terraform Cloud](https://www.terraform.io/) provides a great way to manage your cloud resources needed for a Jenkins X installation, it provides a great UX and managed sevices for your cloud resources.

You can sign up for free and add 5 additional users.  Terraform Cloud is not a hard requirement but it does help.  This walkthough will show teh current alpha steps which are expected to evolve over the coming weeks and months.

---

# Prerequisits

- Sign up to Terraform Cloud for free https://www.terraform.io
- Create a GCP Service account, currently with Project Owner permissions and download a JSON key


# Create Infrastructure Git repository for Terraform

This repository is the source of truth for your cloud resources.  We will import this as a workspace into Terraform Cloud and any changes merged to the repo will applied.

*  <a href="https://github.com/jx3-gitops-repositories/jx3-terraform-gke" target="github" class="btn bg-primary text-light">Create Infrastructure Git Repository from this template</a> 

- edit the `values.auto.tfvars`  and add your GCP Project ID and change `gsm` value to `true`
- import the git repository as a new workspace in Terraform Cloud
- add a new sensitive Environment Variable `GOOGLE_CREDENTIALS` in Terraform Cloud with the value of the JSON key downloaded in the prerequisits above, be sure to remove all new lines.
- Click the `Queue Plan` button
- Review the plan and confirm in the Terraform Cloud UI.
- Copy the two export commands in the apply output from Terrafrom Cloud to set the GCP Project ID and Cluster Name in a terminal.
- <a href="https://github.com/jx3-gitops-repositories/jx3-gke-gsm" target="github" class="btn bg-primary text-light">Create Jenkins X cluster git Repository from this template</a>
- In your terminal clone the Jenkins X cluster git repository above
- cd into the cloned direcory
- run `./bin/configure.sh` to set environment specific configuration
- git add, commit and push local changes from the configure script
- set two environment variables for your pipeline user:
    -  `export GIT_USERNAME=foo`
    -  `export GIT_TOKEN=abc123`
- run the Jenkins X operator
    - `jx admin operator`