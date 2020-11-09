---
title: Cloud Configuration
linktitle: Cloud Configuration
description: How to configure cloud infrastructure
weight: 25
---

There are many configuration options of your cloud infrastructure for example cluster size, regions and resource names to name a few.  Depending on your cloud provider and what method you have used to create the cloud resources there are various ways to apply these configuration changes for cloud resources.

This section contains links to the various readmes that will help you configure __cloud infrastructure resources__, note this is different to Jenkins X own configuration changes which are detailed [here](/docs/v3/guides/config/).

# Terraform

Jenkins X cluster git repositories use cloud specific Terraform modules you can use to configure your cloud resources.

[GCP](https://github.com/jenkins-x/terraform-google-jx#inputs)

[AWS](https://github.com/jenkins-x/terraform-aws-eks-jx#inputs)

[Azure](https://github.com/jenkins-x/terraform-azurerm-jx#inputs)
