---
title: Ingress
linktitle: Ingress
type: docs
description: Changing your ingress
weight: 30
---

Jenkins X requires ingress so that webhooks from your git provider can trigger pipelines and so that you can use tools like the [Dashboard](/v3/develop/ui/dashboard/)
                                    
The ingress domain is defined in `ingress.domain` in the [jx-requirements.yml](https://github.com/jenkins-x/jx-api/blob/master/docs/config.md#requirements) file in your development git repository
