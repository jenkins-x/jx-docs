---
title: Amazon
linktitle: Amazon
type: docs
description: Setup Jenkins X on EKS on AWS
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2020-02-21
weight: 20
aliases:
  - /v3/admin/platform/eks
---

---

**NOTE**

- Ensure you are logged into GitHub else you will get a 404 error when clicking the links below
- ECR repository needs to be created before running the quickstart or importing existing projects.
- The quickstart guides are for users who want to get up and running quickly with JenkinsX.
  Refer to the [eks-jx terraform module readme](https://github.com/jenkins-x/terraform-aws-eks-jx/blob/master/README.md) for all the variables that can be customized.
  - Refer to this [page](/v3/admin/setup/secrets/vault/#external-vault) for setting up JenkinsX v3 with external/existing vault.
  - For installing JenkinsX in an existing EKS cluster, refer to this [section](https://github.com/jenkins-x/terraform-aws-eks-jx#existing-eks-cluster).
  - To use AWS secrets manager instead of vault, refer to this [section](https://github.com/jenkins-x/terraform-aws-eks-jx#secrets-management)
- Always use the latest module version for the eks-jx module.
  The list of versions can be found [here.](https://github.com/jenkins-x/terraform-aws-eks-jx/releases)
- Do not specify the last digit of the kubernetes version, so if you want to provision an EKS cluster with kubernetes `1.21.5`, just specify `1.21`. See [this issue](https://github.com/jx3-gitops-repositories/jx3-terraform-eks/issues/26#issuecomment-936055015) for more details.

---

### EKS + Terraform

This is our current recommended quickstart for EKS:

- <a href="https://github.com/jx3-gitops-repositories/jx3-terraform-eks/generate" target="github" class="btn bg-primary text-light">Create Git Repository</a> based on the [jx3-gitops-repositories/jx3-terraform-eks](https://github.com/jx3-gitops-repositories/jx3-terraform-eks)

  - if the above button does not work then please [Login to GitHub](https://github.com/login) first and then retry the button

- `git clone` the new repository via **HTTPS** and `cd` into the git clone directory

- <a href="https://github.com/jx3-gitops-repositories/jx3-terraform-eks/blob/master/README.md"
    target="github" class="btn bg-primary text-light" 
    title="use your new git repository to create your cloud infrastructure and install Jenkins X">
  Create your infrastructure
  </a>

- <a href="/v3/develop/create-project/" class="btn bg-primary text-light">Create or import projects</a>
