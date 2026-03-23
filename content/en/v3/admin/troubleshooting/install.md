---
title: Install
linktitle: Install
type: docs
description: How to diagnose and fix issues with an install
weight: 100
---

## Check you are using a cluster Git URL

If using Terraform make sure the `values.auto.tfvars` file contains a `jx_git_url = ` value that points to a **cluster** git repo that contains a helmfile.yaml and a folder ./helmfiles. A common mistake is users set the `jx_git_url` to the infrastructure repo instead.

After a successful bootjob, these are few things to look for:

- Secrets have been generated in the secret backend.
- A webhook has been created in the cluster git repo.

## Issues with secret generation

- In some cases, the webhook generation will fail with a message :

```bash
jx gitops webhook update --warn-on-fail
Error: failed to find hmac token from secret:
```

This is normally because the secret generation failed during the boot job.

- Look at the outputs from `jx secret verify` and `kubectl get es -A`
- If you see errors (`404 missing`), it most likely means that the secret generation step in the boot log did not work.
- One way to re-generate secrets is by making a direct push to the base branch of the cluster git repo.
- A direct push to the master (not by creating a pull request) branch will run `regen-phase-1`, `regen-phase-2` and `regen-phase-3`.
  Check the admin logs to verify these steps were executed without failing.
  `regen-phase-3` is where the secret generation happens.
  This step runs `jx secret populate`
- Errors can happen with different secret backends
  - External vault:
    - Ensure you have followed the instruction [here](https://github.com/jenkins-x/terraform-aws-eks-jx#secrets-management).
    - After terraform apply, a secret `jx-boot-job-env-vars` in the `jx-git-operator` namespace should be created with two variables defined - EXTERNAL_VAULT (set to `true`) and VAULT_ADDR (set to your external vault ip with port).
  - Wrong cluster git repo
    - If you are using backends other than vault, use the right cluster git repository for that secret backend.
      For example, use `jx3-eks-asm` template repository to generate the cluster git repository if you want to store secrets in AWS secrets manager.
    - Check [this github organization](https://github.com/jx3-gitops-repositories) for all the different public template repositories you can use with Jenkins X.

## Issues with webhook

To find if webhooks were created by Jenkins X, navigate to the settings page of your repository, and click on webhooks.
Check the [webhook troubleshooting guide](/v3/admin/troubleshooting/webhooks/) if they exist, and do not work.

The recent delivery tab should have good debugging information on why webhooks failed to deliver payload.
