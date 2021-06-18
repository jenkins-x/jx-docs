---
title: Storage
linktitle: Storage
type: docs
description: Changing your storage configuration
weight: 200
---


By storage we mean cloud storage (e.g. bucket storage for logs). Any [chart you add via helmfile](/v3/develop/apps/#adding-charts) which uses `Persistent Volumes` instead of cloud storage will be [up to you to backup and manage](/v3/devops/cloud-native/#try-avoid-persistent-volumes).
        
If you are using a [cloud platform](/v3/admin/platforms/) and terraform then your storage will be configured OOTB.

If you are [on-premises](/v3/admin/platforms/) and have installed something like [minio](https://min.io/) on your cluster then you can configure the `storage` section of your [jx-requirements.yml](https://github.com/jenkins-x/jx-api/blob/master/docs/config.md#requirements) file to map to minio bucket URLs
