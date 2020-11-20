---
title: Configure Google Cloud DNS to manage my domain
linktitle: Cloud DNS
type: docs
weight: 100
aliases:
  - /docs/v3/guides/infra/google_cloud_dns/
---

This guide will describe how to purchase a domain and configure GCP to manage it with [Cloud DNS](https://cloud.google.com/dns)


Setup below is a cut down version of the original docs located [here](https://github.com/kubernetes-sigs/external-dns/blob/master/docs/tutorials/gke.md#gke-node-scopes)

Go to [Google Domains](https://domains.google.com/registrar) and purchase a domain.

Create a DNS zone which will contain the managed DNS records.

```bash
gcloud dns managed-zones create "foo-io" \
    --dns-name "foo.io." \
    --description "Automatically managed zone by kubernetes.io/external-dns" \
    --project foo
```

Make a note of the nameservers that were assigned to your new zone.
```bash
gcloud dns record-sets list \
    --zone "foo-io" \
    --name "foo.io." \
    --type NS \
    --project foo
```

In this case it's ns-cloud-{e1-e4}.googledomains.com. but your's could slightly differ, e.g. {a1-a4}, {b1-b4} etc.

Update google domains DNS settings and update the nameservers with the list of nameservers from the above step making sure to remove the last dot.
e.g. in google domains enter the nameservers without the "." suffix
`ns-cloud-e1.googledomains.com`
not
`ns-cloud-e1.googledomains.com.`

![Edit Nameservers GCP](/images/v3/google_domains.png)