---
title: Secrets
linktitle: Secrets
type: docs
description: Questions on secrets and external secrets
weight: 200
---

## How do I add a new Secret?
 
 See [how to add a new Secret](/v3/admin/setup/secrets/#create-a-new-secret)

## How do I change the secret poll period in kubernetes external secrets?

Your cloud provider could charge per read of a secret and so a frequent poll of your secrets could cost $$$. You may want to tone down the poll period.

You can do this via the `POLLER_INTERVAL_MILLISECONDS` setting in the [kubernetes external secrets configuration](https://github.com/external-secrets/kubernetes-external-secrets/tree/master/charts/kubernetes-external-secrets#configuration)

For more details [see how to configure charts](https://jenkins-x.io/v3/develop/apps/#customising-charts)

