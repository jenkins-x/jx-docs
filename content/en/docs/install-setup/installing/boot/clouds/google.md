---
title: Google
linktitle: Google
description: Using Boot on Google Cloud (GCP)
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
weight: 20
---

## Configuration

On GCP we default to using GCR as the container registry (using `gcr.io`).

Please set your provider to `gke` via this in your `jx-requirements.yml` to indicate you are using GCP:

```yaml
clusterConfig:
    provider: gke
```

We also recommend using [Jenkins X Pipelines](/architecture/jenkins-x-pipelines/) as this works out of the box with kaniko for creating container images without needing a docker daemon and works well with GCR.

## Configuring DNS and TLS

For a secure Jenkins X installation, you must enable TLS when interacting with the vault service.
To configure TLS, you must first configure Zone DNS settings within Google Cloud Platform, and then configure external DNS settings for Ingress and TLS in the `jx-requirements.yml` configuration file.

### Configuring Google Cloud DNS

You should have a domain name registered with a name registrar, for example `www.acmecorp.example` before configuring DNS Zone settings.
For more information, refer to [Creating a managed public zone](https://cloud.google.com/dns/docs/quickstart#create_a_managed_public_zone) from the Google documentation.

1. Navigate via browser to the [Project
Selector](https://console.cloud.google.com/projectselector2/home/dashboard)
page. and choose your Google Cloud Platform project.

1. [Create a DNS
zone](https://console.cloud.google.com/networking/dns/zones/~new)

    1. Choose Public as your *Zone Type*.

    1. Type a *Zone Name* for your zone.

    1. Input a DNS suffix in *DNS name*, for example `acmecorp.example`.

    1. Choose your *DNSSEC* or DNS Security state, which should be set to `Off` for this configuration.

1. (Optional) Input a *Description* for your DNS zone.

1. Click `Create`.

Once created, the *Zone Details* page loads.
*NS* (Name server) and *SOA* (Start of authority) records are automatically created for your domain (for example `acmecorp.example`)

### Configuring External DNS in Jenkins X

Once you have configured Google Cloud DNS, you can use browse the [Zones](https://console.cloud.google.com/net-services/dns/zones) page in your Google Cloud Platform project to setup your external domain.

{{< alert >}}
NOTE: External DNS will automatically update DNS records if you reuse the domain name, so if you delete an old cluster and create a new one it will preserve the same domain configuration for the new cluster.
{{< /alert >}}

To setup External DNS:

1. Choose a unique DNS name; you can use nested domains (for example, `cluster1.acmecorp.example`). Enter the name in the `DNS Name` field

2. Run the `jx create domain` command against your domain name, for example:

    ```sh
    jx create domain gke --domain cluster1.acmecorp.example
    ```

    You will be prompted for information as needed during the setup:

    1. Choose your Google Cloud Platform project from the available list.

    1. Update your existing managed servers to use the displayed list of Cloud DNS nameservers. Copy the list for use in the next steps.

Next up is configuring GCP:

1. From the Google Cloud Platform [Zones](https://console.cloud.google.com/net-services/dns/zones) page, change the *Resource Record Type* to `NS`) and use the default values for your domain for for *TTL* (`5`) and *TTL Unit* (`minutes`).

1. Add the first nameserver to the *Name server* field

1. Click `Add item` and add any subsequent nameservers.

1. Click `Create`.

Finally, configure Jenkins X for the new domain names:

1. Edit the `jx-requirements.yml` file and update the `domain` field (in `ingress`) to your domain name, for example `cluster1.acmecorp.example`

1. In the *tls* setting, enable TLS with `enabled: true`

   The resulting `jx-requirements.yml` entries for these settings should look similar to the example below:

   ```yaml
    gitops: true
    ingress:
      domain: cluster1.acmecorp.example
      externalDNS: true
      namespaceSubDomain: -jx.
      tls:
        email: certifiable@acmecorp.example
        enabled: true
        production: true
    secretStorage: vault
   ```

{{< alert >}}
Remember to run `jx boot` for the changes to take effect in your environment.
{{< /alert >}}
