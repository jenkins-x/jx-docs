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
- The quickstart guides are for users who want to get up and running quickly with Jenkins X.
  Refer to the [eks-jx terraform module readme](https://github.com/jenkins-x/terraform-aws-eks-jx/blob/master/README.md) for all the variables that can be customized.
  - Refer to this [page](/v3/admin/setup/secrets/vault/#external-vault) for setting up Jenkins X v3 with external/existing vault.
  - For installing Jenkins X in an existing EKS cluster, refer to this [section](https://github.com/jenkins-x/terraform-aws-eks-jx#existing-eks-cluster).
  - To use AWS secrets manager instead of vault, refer to this [section](https://github.com/jenkins-x/terraform-aws-eks-jx#secrets-management)
- Always use the latest module version for the eks-jx module.
  The list of versions can be found [here.](https://github.com/jenkins-x/terraform-aws-eks-jx/releases)
- Do not specify the last digit of the kubernetes version, so if you want to provision an EKS cluster with kubernetes `1.21.5`, just specify `1.21`. See [this issue](https://github.com/jx3-gitops-repositories/jx3-terraform-eks/issues/26#issuecomment-936055015) for more details.

---

### EKS + Terraform + Vault/ASM + Github

This is our current recommended quickstart for EKS:

Note: remember to create the Git repositories below in your Git Organization rather than your personal Git account else this will lead to issues with ChatOps and automated registering of webhooks.

- <a href="https://github.com/jx3-gitops-repositories/jx3-terraform-eks/generate" target="github" class="btn bg-primary text-light">Create Git Repository for <b>Infrastructure</b></a> based on the [jx3-gitops-repositories/jx3-terraform-eks](https://github.com/jx3-gitops-repositories/jx3-terraform-eks)

  - if the above button does not work then please [Login to GitHub](https://github.com/login) first and then retry the button

- Choose the cluster git repository based on the secrets backend

  - <a href="https://github.com/jx3-gitops-repositories/jx3-eks-vault/generate"  target="github-cluster" class="btn bg-primary text-light">Create Git Repository for Jenkins X <b>Cluster</b></a> based on the [jx3-gitops-repositories/jx3-eks-vault](https://github.com/jx3-gitops-repositories/jx3-eks-vault)

  - <a href="https://github.com/jx3-gitops-repositories/jx3-eks-asm/generate"  target="github-cluster" class="btn bg-primary text-light">Create Git Repository for Jenkins X <b>Cluster</b></a> based on the [jx3-gitops-repositories/jx3-eks-asm](https://github.com/jx3-gitops-repositories/jx3-eks-asm)

- Install <a href="https://learn.hashicorp.com/tutorials/terraform/install-cli#install-terraform">terraform CLI</a>

- Install <a href="https://github.com/jenkins-x/jx-cli/releases">jx CLI </a>

- For AWS SSO ensure you have installed AWSCLI version 2 - [see here](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html). You must then configure it to use Named Profiles - [see here](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)

- <a href="https://github.com/settings/tokens/new?scopes=repo,read:user,read:org,user:email,admin:repo_hook,write:packages,read:packages,write:discussion,workflow" target="github-token" class="btn bg-primary text-light">Create Git Token for the Bot user </a>

- Override the variable defaults in the Infrastructure repository. (E.g, edit variables.tf, set TF*VAR* environment variables, or pass the values on the terraform command line.)

  - cluster_version: Kubernetes version for the EKS cluster. (should be 1.20 at the moment)
  - region: AWS region code for the AWS region to create the cluster in.
  - jx_git_url: URL of the Cluster repository.
  - jx_bot_username: The username of the git bot user

- commit and push any changes to your Infrastructure git repository:

      git commit -a -m "fix: configure cluster repository and project"
      git push

- Define an environment variable to pass the bot token into Terraform:

      export TF_VAR_jx_bot_token=my-bot-token

- Now, initialise, plan and apply Terraform:

      terraform init
      terraform plan
      terraform apply

- Tail the Jenkins X installation logs

  $(terraform output follow_install_logs)

- Once finished you can now move into the Jenkins X Developer namespace

  jx ns jx

- and create or import your applications

- <a href="/v3/develop/create-project/" class="btn bg-primary text-light">Create or import projects</a>

For more details on how to install Jenkins X on AWS EKS see [Github repository for Jenkins X Terraform module for EKS](https://github.com/jx3-gitops-repositories/jx3-terraform-eks#prerequisites)
