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

{{< k8s-versions >}}

**NOTE**

- Ensure you are logged into GitHub else you will get a 404 error when clicking the links below
- The quickstart guides are for users who want to get up and running quickly with Jenkins X.
  Refer to the [eks-jx terraform module readme](https://github.com/jenkins-x/terraform-aws-eks-jx/blob/master/README.md) for all the inputs that can be customized.
- Always use the latest module version for the eks-jx module.
  The list of versions can be found [here.](https://github.com/jenkins-x/terraform-aws-eks-jx/releases)
- Do not specify the last digit of the kubernetes version, so if you want to provision an EKS cluster with kubernetes `1.30.1`, just specify `1.30`.

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

- Install <a href="https://jenkins-x.io/v3/admin/setup/jx3/">jx CLI </a>

- For AWS SSO ensure you have installed AWSCLI version 2 - [see here](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html). You must then configure it to use Named Profiles - [see here](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure-profiles.html)

- You should use a dedicated git user account for the Bot user. Jenkins X will use this user to interact with git. After you are logged in with the Bot user account you may use the following link <a href="https://github.com/settings/tokens/new?scopes=repo,read:user,read:org,user:email,admin:repo_hook,write:packages,read:packages,write:discussion,workflow" target="github-token" class="btn bg-primary text-light">Create Git Token for the Bot user </a>

- Override the input defaults in the Infrastructure repository. (E.g, edit variables.tf, set TF*VAR* environment variables, or pass the values on the terraform command line.)

  - `cluster_version`: Kubernetes version for the EKS cluster. (should be 1.20 at the moment)
  - `region`: AWS region code for the AWS region to create the cluster in.
  - `jx_git_url`: URL of the Cluster repository.
  - `jx_bot_username`: The username of the git bot user

  If you want to use AWS secrets manager instead of vault you should also set the input `use_asm` to true.

- commit and push any changes to your Infrastructure git repository:

```bash
      git commit -a -m "fix: configure cluster repository and project"
      git push
```

- Define an environment variable to pass the bot token into Terraform:

```bash
      export TF_VAR_jx_bot_token=my-bot-token
```

- Now, initialise, plan and apply Terraform:

```bash
      terraform init
      terraform plan
      terraform apply
```

- Tail the Jenkins X installation logs

```bash
  jx admin log
```

- Once finished you can now move into the Jenkins X Developer namespace

```bash
  jx ns jx
```

- and create or import your applications

- <a href="https://jenkins-x.io/v3/develop/create-project/" class="btn bg-primary text-light">Create or import projects</a>

For more details on how to install Jenkins X on AWS EKS see [Github repository for Jenkins X Terraform module for EKS](https://github.com/jx3-gitops-repositories/jx3-terraform-eks#prerequisites)
