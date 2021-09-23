---
title: Install
linktitle: Install
type: docs
description: How to diagnose and fix issues with an install
weight: 110
---

# Commons problems with Installations

## Check you are using a cluster Git URL

If using Terraform make sure the `values.auto.tfvars` file contains a `jx_git_url = ` value that points to a __cluster__ git repo that contains a helmfile.yaml and a folder ./helmfiles.  A common mistake is users set the `jx_git_url` to the infrastruture repo instead.
