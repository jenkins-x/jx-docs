---
title: "Migrate to Google Artifact Registry"
date: 2024-05-06T00:00:00-00:00
draft: false
description: Google will shut down container registry  
categories: [blog]
keywords: [Jenkins X,Community,2024]
slug: "migrating-artifact-registry"
aliases: []
author: Mårten Svantesson
---

Google has announced that [container registry will be shut down some time after March 18, 2025](https://cloud.google.com/artifact-registry/docs/transition/transition-from-gcr). For GKE clusters created with version 1.12.0 or later of [terraform-google-jx](https://github.com/jenkins-x/terraform-google-jx) it's unlikely that anything needs to be done, but for older clusters you should upgrade your cluster while considering [our advice regarding migration from container registry to artifact registry](https://github.com/jenkins-x/terraform-google-jx#migration-from-container-to-artifact-registry).

If you are using a Google Service Account to run terraform you need to add the role requirement roles/artifactregistry.admin. See our guide regarding [Google Service Account](https://jenkins-x.io/v3/admin/platforms/google/svc_acct/) for details.

