---
title: Vault
linktitle: Vault
description: Manage your secrets
date: 2019-01-08
publishdate: 2019-01-08
lastmod: 2019-01-08
weight: 200
aliases:
  - /docs/resources/guides/managing-jx/common-tasks/vault
  - /architecture/vault
---

{{< pageinfo >}}
Note that currently Vault only works on Google Cloud Platform (GCP) with Google Kubernetes Engine (GKE). We're working on expanding support to other cloud providers.

In addition, we don't currently support pointing to an existing Vault instance, but there is an open issue to address this.
{{< /pageinfo >}}

# What is Vault?

[Vault](https://www.vaultproject.io) is an open source project for securely managing secrets and is our preferred way to manage secrets across your environments in Jenkins X.

In traditional computing infrastructures, all of the resources and
components (hardware, networking, availability, security and deployment)
as well as associated labor costs are locally managed. Third-party
computing environments such as cloud service providers and Git hosts
offer decentralized solutions with distinct advantages in service
reliability and costs over the traditional solutions.

However, one issue with using cloud services, distributed storage, and
remote repositories is the lack of trusted networks, vetted hardware,
and other closely observed security measures practiced in locally-hosted
infrastructure. For the sake of convenience, users often store sensitive
information like authentication credentials in open, public
repositories, exposed to potential malicious activity.

[Hashicorp *Vault*](https://www.vaultproject.io/) is one tool that
centralizes the management of *secrets*: resources that provide
authentication to your computing environment such as tokens, keys,
passwords, and certificates.

Jenkins X handles security and authentication
resources through the integration of Vault. Users can deploy Vault to
securely store and manage all aspects of their development platform.

Jenkins X installs and configures Vault for your
cluster by default through the cluster creation process.

## Vault features

Vault is a tool for accessing and storing user secrets. It manages the
complexity of secure resource access:

- Storing secrets - Vault places secrets in an encrypted format in a
remote storage bucket.

- Secret creation and deletion - Vault creates secrets for dynamic
access to storage buckets, ephemeral access that are
created/destroyed as needed for temporary data access, and
generating keys for database authentication.

- Encrypting data - Vault stores secrets in a remote storage bucket in
secure directories using strong encryption.

Jenkins X interacts with Vault via the `jx`
command line program. There are commands for creating, deleting, and
managing secrets and vaults.

Jenkins X uses Vault to store all Jenkins X
secrets, such as the GitHub personal access token generated for the
pipeline bot when [creating a Jenkins X
cluster](/docs/getting-started/setup/boot/). It also stores
any GitOps secrets, such as passwords for storage buckets, and keys for
secure server access.

Secrets can be retrieved by the pipeline or via command-line if logged
into the account associated with the kubernetes service as well as any
secrets stored in the `jx` namespace for the pipeline.

Vaults are provisioned in kubernetes using `vault-operator`, an
open-source Kubernetes controller installed when Vault is configured
during cluster creation and Jenkins X installation on the cluster.

# Using Vault on the CLI

First you need to download an install the [safe](https://github.com/starkandwayne/safe) CLI for Vault.

Once you have installed [safe](https://github.com/starkandwayne/safe) you can run:

```
eval `jx get vault-config`
```

you should now be able to use the [safe](https://github.com/starkandwayne/safe) CLI to  access your vault.

You can then get a secret via:


```
safe get /secret/my-cluster-name/creds/my-secret
```

or you can update a secret via:

```
safe set /secret/my-cluster-name/creds/my-secret username=myname password=mytoken
```

If you have a blob of JSON to encode as a secret, such as a service account key then convert the file to base64 first then set it...

```sh
cat my-service-account.json | base64 > myfile.txt
safe set /secret/my-cluster-name/creds/my-secret json=@myfile.txt
```


# Configuring DNS and TLS settings for Vault

For a secure Jenkins X installation, you must
enable TLS when interacting with the vault service. To configure TLS,
you must first configure Zone DNS settings within Google Cloud Platform,
and then configure external DNS settings for Ingress and TLS in the
`jx-requirements.yml` configuration file.

## Configuring Google Cloud DNS

In order to configure Vault for the proper DNS and TLS access, you must
configure Google Cloud DNS settings appropriately.

You should have a domain name registered with a name
registrar, for example `www.acmecorp.example` before configuring DNS
Zone settings. For more information, refer to [Creating a managed public
zone](https://cloud.google.com/dns/docs/quickstart#create_a_managed_public_zone)
from the Google documentation.

1.  Navigate via browser to the [Project
Selector](https://console.cloud.google.com/projectselector2/home/dashboard)
page. and choose your Google Cloud Platform project.

2.  [Create a DNS
zone](https://console.cloud.google.com/networking/dns/zones/~new)

1.  Choose Public as your *Zone Type*.

2.  Type a *Zone Name* for your zone.

3.  Input a DNS suffix in *DNS name*, for example
`acmecorp.example`.

4.  Choose your *DNSSEC* or DNS Security state, which should be set
to `Off` for this configuration.

5.  (Optional) Input a *Description* for your DNS zone.

6.  Click `Create`.

Once created, the *Zone Details* page loads. *NS* (Name server) and
*SOA* (Start of autority) records are automatically created for your
domain (for example `acmecorp.example`)


## Configuring External DNS in Jenkins X

Once you have configured Google Cloud DNS, you can use browse the
[Zones](https://console.cloud.google.com/net-services/dns/zones) page in
your Google Cloud Platform project to setup your external domain.

{{< alert >}}
NOTE: External DNS will automatically updates DNS records if you reuse the
domain name, so if you delete an old cluster and create a new one it
will preserve the same domain configuration for the new cluster.
{{< /alert >}}

To setup External DNS:

1.  Choose a unique DNS name; you can use nested domains (for example,
 `cluster1.acmecorp.example`). Enter the name in the `DNS Name`
field

2.  Run the `jx create domain` command against your domain name, for example:

```
jx create domain gke --domain cluster1.acmecorp.example
```

    You will be prompted for information as needed during the setup:

    1.  Choose your Google Cloud Platform project from the available list.

    2.  Update your existing managed servers to use the displayed list of Cloud DNS nameservers. Copy the list for use in the next steps.

Next up is configuring GCP:

1.  From the Google Cloud Platform [Zones](https://console.cloud.google.com/net-services/dns/zones) page, change the *Resource Record Type* to `NS`) and use the default values for your domain for for *TTL* (`5`) and *TTL Unit* (`minutes`).

4.  Add the first nameserver to the *Name server* field

5.  Click `Add item` and add any subsequent nameservers.

6.  Click `Create`.

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
Remember to run `jx boot` for the changes to take effect in your
environment.
{{< /alert >}}

# Creating a Vault

A vault is created by default using [jx boot](/getting-started/boot/) to create your cluster, unless you specified during the cluster configuration not to create the vault. In this case, you can create one post-installation
with the `jx create` command-line interface:

jx create vault

1.  The program will ask you the name you want for your vault (for
example, `acmevault`)

2.  The program will ask you for your Google Cloud Zone of choice. Refer
to [Regions and
Zones](https://cloud.google.com/compute/docs/regions-zones/) in the
Google Cloud documentation for more information. In this example,
`us-east1-c` is chosen for proximity to Acme Headquarters.

3.  If you have a storage bucket account configured from creating a
cluster with `jx boot`, then the `jx create vault` command will scan
your installation for Vault-related storage buckets and, if found,
prompt you to approve deleting and recreating the Vault from
scratch.

4.  The program will ask you the *Expose type* for your vault in order
to create rules and routes for cluster load balancer and other
services. Default is `Ingress`.

5.  The program will ask for a cluster domain. Default is the one
created in [the Cluster creation
process](/docs/getting-started/setup/boot/) such as
`192.168.1.100.nip.io`.

6.  The program will ask for an `URLTemplate`. Press `Enter` to
use the default value.

7.  The program will verify your answers to the previous questions in
summary and prompt you to approve the Vault creation (default is
`Yes`).
