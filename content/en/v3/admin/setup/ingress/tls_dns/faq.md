---
title: FAQ
linktitle: FAQ 
type: docs
description: Frequently asked questions
weight: 300
---

## What if I have a chartmuseum with charts running using nip.io?

It is best to comment out your Jenkins X chartmuseum repository and charts from your helmfile until your new domain and ingress is working.  Then uncomment and make sure you update the chartmuseum URL to your new one.

## What if I use a subdomain with an apex domain in a different GCP project?

When using a subdomain Terraform will create a managed zone in GCP, add the recordsets to your parent / apex domain.

If the GCP managed zone for your apex domain is in a different GCP project than the project that your current installation the you will need to set in your infrastructure repository the terraform variable:

```
parent_domain_gcp_project: [your GCP project that is managing your apex domain]
```

If you do not have permission to update the recordset of the apex domain then you will need to manually update it after getting the nameservers created for your subdomain managed zone and disable the automatic way using:

```
apex_domain_integration_enabled: false
```

## How can I remove the namespace subdomain (e.g. -jx.) from my URLs?

In your cluster git repository find the `namespaceSubdomain` property in your jx-requirements.yml file and change its value to `namespaceSubdomain: "."`

Be aware that the same application deployed in multiple namespaces will end up with the same URL if you change `namespaceSubdomain` to be the same for all environments.

## How can I check if cert-manager has issued a certificate?

You can check the status of the certificate by running

```
kubectl get cert -n jx
```

```
kubectl describe cert -n jx
```

if `Ready` continues to be `false` after 10-15 mins you can check on the request using

```
kubectl get certificaterequest -n jx
```

```
kubectl describe certificaterequest -n jx
```

## How can I install the charts if not using terraform to autamatically enable them?

If you are not using the Jenkins X Terraform above then you can manually update your cluster git repository and add the charts needed.
