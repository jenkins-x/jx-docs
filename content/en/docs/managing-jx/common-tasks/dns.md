---
title: DNS
linktitle: DNS
description: Configuring DNS for external access to cluster services
weight: 80
---

To be able to access services hosted within your cluster we default to an [nip.io](https://nip.io/) domain. This makes it super easy to setup and manage DNS.

However, for users who want services in the cluster to be available on a personal domain, we use external-dns which is just as easy.

## external-dns
**NOTE**: *Currently only supported on GKE*

[ExternalDNS](https://github.com/kubernetes-incubator/external-dns) can be used to help expose Kubernetes Services and Ingresses by synchronizing with DNS providers.

If you are using [jx boot](/docs/getting-started/setup/boot/) to install and configure your setup then modify your `jx-requirements.yml` file to enable `ingress.externalDNS: true` as described in the [boot ingress documentation](/docs/getting-started/setup/boot/#ingress)


Otherwise to setup your cluster using ExternalDNS use:

```sh
jx install --provider gke --tekton --external-dns
```

*This will then prompt you for your domain.*

```sh
🙅 developer ~/go-workspace/jx(master)$ jx install --provider gke --tekton --external-dns
WARNING: When using tekton, only kaniko is supported as a builder
Context "gke_<your-project-id>_europe-west1-b_<your-cluster-name>" modified.
set exposeController Config URLTemplate "{{.Service}}-{{.Namespace}}.{{.Domain}}"
Git configured for user: **********  and email *********@****.***
helm installed and configured
? Provide the domain Jenkins X should be available at: your-domain.com
```

A CloudDNS managed zone is then created within your clusters GCP Project, the record-sets which expose your services will be created by ExternalDNS within this managed zone.

```sh
🙅 developer ~/go-workspace()$ gcloud dns managed-zones list
NAME                           DNS_NAME                   DESCRIPTION                       VISIBILITY
your-domain-com-zone           your-domain.com.           managed-zone utilised by jx       public
```

### delegation

Once the installation is complete, a list of name servers will be outputted to the terminal, please update your registrar using these name servers in order to delegate your domain onto Google CloudDNS.

```sh

        ********************************************************

            External DNS: Please delegate your-domain.com via
            your registrar onto the following name servers:
                ns-cloud-d1.googledomains.com.
                ns-cloud-d2.googledomains.com.
                ns-cloud-d3.googledomains.com.
                ns-cloud-d4.googledomains.com.

        ********************************************************

```

#### [Google domains](https://domains.google)

If you're using Google Domains as your domain registrar please see [here](https://support.google.com/domains/answer/3290309?hl=en-GB&ref_topic=9018335) for details on delegating to custom name servers.

### URL template

All services should be available on the same domain, of which is derived as follows:

```sh
<service>-<namespace>.<your-domain>
```
