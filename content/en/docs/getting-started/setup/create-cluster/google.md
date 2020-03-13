---
title: Google
linktitle: Google
description: How to create a kubernetes cluster on the Google Cloud Platform (GCP)?
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
weight: 50
---

Google Cloud Platform (GCP) offers a powerful service for creating
robust, highly-available clusters using the Kubernetes automated
deployment platform. Google Kubernetes Engine (GKE) is a
highly-available and secure kubernetes implementation that leverages the
scalability of Google Cloud to provide a comprehensive solution when
combined with the cloud-native development power and stability of
Jenkins X.

Cluster installation and configuration in Jenkins X is possible through
*Jenkins X Boot*, a command that allows users to create Kubernetes
clusters without running through various commands for configuring
storage, pipeline, GitOps, and other resources.

# Cluster prerequisites

In order to create a cluster in Jenkins X, you must have the following
configured:

-   A Google Cloud Platform (GCP) account for creating kubernetes
    clusters

-   The Kubernetes command-line tool, which can be installed to your
    local installation using the `jx install` command:

        jx install dependencies -d kubectl

-   Access to the [GitHub](https://www.github.com) remote Git provider,
    which allows users to create organizations and multiple user
    accounts:

    -   An *Organization* from which you invite existing users (in this
        example, the organization is called `acmecorp`). Create an
        organization by clicking the **+** button at the top right
        of the GitHub project page or through the [Create an
        organization](https://github.com/organizations/new) page.

    -   A GitHub user account for creating and managing development
        repositories (for example `acmeuser`). Invite the user to your
        organization.

    -   A *bot* user that automates pull request notifications and
        creates preview environments for quick validation and acceptance
        for code merging. The bot account must have a token created by
        your organization that authenticates the bot and allows it to
        perform various tasks on the repositories within your
        organization. In the examples, a GitHub account named `acmebot`
        is used.

# Creating a Kubernetes cluster

The cluster creation process on Jenkins X(run via the command `jx boot`)
requires performing a pre-configuration procedure to successfully
complete the cluster installation process:

1.  Run `jx create cluster` at the command-line to initialize the
    cluster on your Google Kubernetes Engine (GKE) account with a
    specified name, for example `acmecluster1`:

        jx create cluster gke --skip-installation -n acmecluster1

    1.  The program opens a web browser to choose the email address
        associated with your GCP account, then prompts you to allow the
        Google Cloud SDK to access your account.

    2.  Back at the command-line, the `jx create cluster` program
        prompts you to choose your project from the available list.

    3.  The program prompts you to choose the Zone nearest to where you
        would like to install your cluster. For example, if you want
        your cluster to serve users primarily in the east coast of the
        United states, you choose `us-east1-b` from the available list.

    4.  The program runs automatically through default questions and
        begins creating the cluster in your specified zone.

# Configuring Google Cloud DNS

In order to configure Vault for the proper DNS and TLS access, you must
configure Google Cloud DNS settings appropriately.

Using the fictional *Acme* organization used when you created the GKE cluster,
an administrator should have the following a domain name registered with a name
registrar, for example `www.acmecorp.example` before configuring DNS Zone
settings. For more information, refer to [Creating a managed public
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
        to **Off** for this configuration.

    5.  (Optional) Input a *Description* for your DNS zone.

    6.  Click **Create**.

Once created, the *Zone Details* page loads. *NS* (Name server) and
*SOA* (Start of autority) records are automatically created for your
domain (for example `acmecorp.example`)

# Configuring External DNS in Jenkins X

Once you have configured Google Cloud DNS, you can use browse the
[Zones](https://console.cloud.google.com/net-services/dns/zones) page in
your Google Cloud Platform project to setup your external domain.

> **Note**
>
>External DNS will automatically updates DNS records if you reuse the domain
>name, so if you delete an old cluster and create a new one it will preserve the
>same domain configuration for the new cluster.

1.  Choose a unique DNS name; you can use nested domains (for example,
     `cluster1.acmecorp.example`). Enter the name in the `DNS Name`
    field

2.  Run the `jx create domain` command against
    `jx create domain gke --domain cluster1.acmecorp.example`.

    1.  The program prompts you to choose your Google Cloud Platform
        project from the available list.

    2.  The program prompts you to update your existing managed servers
        to use the displayed list of Cloud DNS nameservers. Copy the
        list for use in the next steps.

3.  From the Google Cloud Platform
    [Zones](https://console.cloud.google.com/net-services/dns/zones)
    page, change the *Resource Record Type* to `NS`) and use the default
    values for your domain for for *TTL* (`5`) and *TTL Unit*
    (`minutes`).

4.  Add the first nameserver to the *Name server* field

5.  Click **Add item** and add any subsequent nameservers.

6.  Click **Create**.

7.  Configure Jenkins X for the new domain names:

    -   From the directory where you extracted the Jenkins X tarball
        archive open the `jx-requirements-gke.yml` file in a text editor
        (such as TextEdit for macOS or gedit for Linux) and edit the
        ingress section at the root level.

            ingress:
              domain: cluster1.acmecorp.example
              externalDNS: true
              namespaceSubDomain: -jx.
              tls:
                email: certifiable@acmecorp.example
                enabled: true
                production: true

# Installing Jenkins X on your GKE cluster

You are now ready to install Jenkins X to your cluster. From your
command-line, change to the directory containing the pre-configured
`jx-requirements-gke.yml` requirements file that was unarchived with
your `jx` program binary. For example, macOS defaults to the `Downloads`
directory:

    cd /Users/acmeuser/Downloads/

Run Jenkins X Boot at the command-line `jx` and include the
pre-configured `jx-requirements-gke.yml` file:

    jx boot -r jx-requirements-gke.yml

The interactive command-line tool guides you through the process of
configuring and installing the resources needed to complete your GitOps
development environment:

1.  The program prompts you to choose your Google Cloud Project from the
    available list

2.  The program prompts you for the Cluster Name, which you previously
    chosen (in this example, `acmecluster1`).

3.  The program prompts you for a `Git Owner` or your GitHub account (in
    this example, `acmecorp`).

4.  The program prompts you to enter a Storage Bucket URLs for saving
    various storage resources:

    1.  Logs: You can use an existing storage bucket URL or press
        **Enter** and a bucket will be created for you.

    2.  Reports: You can use an existing storage bucket URL or press
        **Enter** and a bucket will be created for you.

    3.  Repository: You can use an existing storage bucket URL or press
        **Enter** and a bucket will be created for you.

5.  If you are prompted to upgrade your Jenkins X binaries or Platform
    at this stage of installation, press **N** to refuse the
    upgrade.

6.  The program prompts you to enter a Jenkins X administrator Username.
    You can use your current GitHub account for consistency (in this
    example, `acmecorp`).

    1.  The program prompts you to enter a password for the Jenkins X
        administrator

7.  The program asks you for a Pipeline Bot Git username (for example
    `acmebot`). This creates a bot for automating your GitOps process by
    promoting code from your development environment to your staging
    and/or production environments.

    1.  Create a new GitHub account strictly for the build control bot

    2.  Invite the bot account to your organization

    3.  Create a Git token for the Pipeline Bot with the correct permissions via
        this [GitHub
        Link](https://github.com/settings/tokens/new?scopes=repo,read:user,read:org,user:email,write:repo_hook,delete_repo)
        and **copy the 40 character token**. 
        
    > **Warning**: The 40 character token generated by GitHub is only
    >shown once so you must copy this immediately before you close the
    >browser tab or window, as the token cannot be retrieved once it is
    >displayed.

    1.  Paste the copied GitHub token created for the Pipeline Bot when
        prompted

8.  The program prompts you to provide a hash-based message
    authentication code (`HMAC`) token for authenticating incoming
    webhooks from your Git provider and accept PR data and other
    payloads to your cluster. Press **Enter** to create a token or
    copy and paste one into the command line if you have an existing
    token.

9.  The program asks if you would like to configure an external Docker
    Registry. Press **Enter** for `No`, and your docker images will
    be privately stored on the [Google Container
    Registry](https://gcr.io) by default.


<!--- This is the former GKE article. -->
<!--- 
To create a Google cluster you can either do so using the `jx` command line,
[Google Cloud Console](#using-the-google-cloud-console) or
[gcloud](#using-gcloud),
be aware though that the smallest possible machine
to host Jenkins X is the `n1-standard-2` machine-type.

**NOTE:** . Google requires you to setup a [billing account](https://cloud.google.com/billing/docs/how-to/manage-billing-account#create_a_new_billing_account) as well, this is standard setup on GCP.

Furthermore, to be able to use `jx` storage features like log storage or backups,
your cluster needs additional permissions, see [GKE Storage Permissions](https://jenkins-x.io/docs/managing-jx/common-tasks/storage/#gke-storage-permissions).

## Using the JX command line

If you have the JX command line setup locally, you can run `jx create cluster gke --skip-installation` to create a GKE cluster from there with defaults.

## Using the Google Cloud Console or CLI

To setup the kubernetes cluster we recommend `jx create cluster gke --skip-installation` which should add the scopes required to your node pool to be able to push images to GCR. 

If you setup your cluster directly via the web console or `gcloud` you may need to setup those scopes yourself. e.g. with `gcloud` add `--scopes` for the following scopes:

* https://www.googleapis.com/auth/cloud-platform
* https://www.googleapis.com/auth/compute
* https://www.googleapis.com/auth/devstorage.full_control
* https://www.googleapis.com/auth/service.management
* https://www.googleapis.com/auth/servicecontrol
* https://www.googleapis.com/auth/logging.write
* https://www.googleapis.com/auth/monitoring


### Using the Google Cloud Console

You can create Kubernetes clusters in a few clicks on the [Google Cloud Console](https://console.cloud.google.com/).

First make sure you have created/selected a Project:

<img src="/images/quickstart/gke-select-project.png" class="img-thumbnail">


Now you can click the `create cluster` button on the [kubernetes clusters](https://console.cloud.google.com/kubernetes/list) page or try [create cluster](https://console.cloud.google.com/kubernetes/add).


### Using gcloud

The CLI tool for working with google cloud is called `gcloud`. If you have not done so already please [install gcloud](https://cloud.google.com/sdk/install).

To create a cluster with gcloud [follow these instructions](https://cloud.google.com/kubernetes-engine/docs/how-to/creating-a-cluster).




## Connecting to your cluster

Once you have created a cluster, you need to connect to it so you can access it via the `kubectl` or [jx](/docs/getting-started/setup/install/) command line tools.

To do this click on the `Connect` button on the [Kubernetes Engine page](https://console.cloud.google.com/kubernetes/list) in the [Google Console](https://console.cloud.google.com/).

<img src="/images/quickstart/gke-connect.png" class="img-thumbnail">

You should now be able to use the `kubectl` and `jx` CLI tools on your laptop to talk to the GKE cluster. e.g. this command should list the nodes in your cluster:

```sh
kubectl get node
```
-->
