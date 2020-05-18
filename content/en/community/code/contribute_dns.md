---
title: DNS
linktitle: DNS for contributors
description: How to configure DNS on GCP for developing features, reproducing issues and demos
keywords: [dns]
authors: [pmuir]
type: docs
weight: 10
aliases:
    - /docs/contributing/code/contribute_dns/
---

Some features and issues require DNS to be configured. The domain name `jenkins-x.rocks` is available for
use. Jenkins X can either manage your DNS for you or you can manage the DNS manually. Read more about how
[Jenkins X manages your DNS for you](/docs/resources/guides/managing-jx/common-tasks/dns/).

In both scenarios you can reuse the domain name if you delete the old cluster that was using it and create a new one. If
you run both clusters at the same time you will need a domain name for each.

We cover both scenarios here as you may be debugging an issue that requires a particular setup - check the issue to find out what the user did! If you are unsure or it doesn't seem relevant to the issue then the External DNS setup is easier to manage and we recommend you follow that.

## With External DNS on Google Cloud Platform

To add records, visit [the Google Cloud DNS dashboard](https://console.cloud.google.com/net-services/dns/zones/jenkins-x-rocks?project=jenkins-x-rocks&organizationId=41792434410) for the jenkins-x-rocks project.
If you need access please contact one of the project maintainers.

Once you have access, you can use the `Add record set` button to add entries. External DNS will automatically update the
records if you reuse the domain name, so if you delete the old cluster and create a new one there is no need to go through
this process again.

1. Choose a unique DNS name; you can use nested domains (e.g. `demo.example.pmuir.jenkins-x.rocks`). We recommend using
  `<unique name>.<your username>.jenkins-x.rocks` so you can easily identify domains created by you. Enter this in the
  `DNS Name` field using the format `<unique name>.<your username>.jenkins-x-rocks.` (note that you can't change the
  the `jenkins-x.rocks` suffix and it is prefilled for you).
2. Run `jx create domain gke --domain <unique name>.<your username>.jenkins-x.rocks`. Make a note of the nameservers printed out.
3. Change the `Resource Record Type` to `NS`) and use the default values for `TTL` (`5`) and `TTL Unit` (`minutes`).
4. Add the first nameserver to the `Name server` field
5. Click `Add item` and add the second nameserver. Do the same for rest of the nameservers
6. Click `Create`
7. Tell Jenkins X about the name.
  * If you are using `jx install --external-dns` then paste `<unique name>.<your username>.jenkins-x.rocks` into the prompt where you paused earlier
  * If you are using `jx boot` then edit `jx-requirements.yml`, and update the `domain` field (in `ingress`)
    to `<unique name>.<your username>.jenkins-x.rocks` and run `jx boot`

## Without External DNS on Google Cloud Platform

To add records, visit [the Google Cloud DNS dashboard](https://console.cloud.google.com/net-services/dns/zones/jenkins-x-rocks?project=jenkins-x-rocks&organizationId=41792434410) for the jenkins-x-rocks project.
If you need access please contact one of the project maintainers.

Once you have access, you can use the `Add record set` button to add entries or the pencil to edit entries.

1. Choose a unique DNS name; you can use nested domains (e.g. `demo.example.pmuir.jenkins-x.rocks`). We recommend using
  `<unique name>.<your username>.jenkins-x.rocks` so you can easily identify domains created by you. Enter this in the
  `DNS Name` field using the format `*.<unique name>.<your username>.jenkins-x-rocks.` (note that you can't change the
  the `jenkins-x.rocks` suffix and it is prefilled for you).
2. Find the cluster IP. The way to do this varies.
  * If you used `jx install` then you **must** configure this during install. When you are prompted if you want to use
    the default `.nip.io` domain copy the IP. You **must** now wait until your domain name is ready.
  * If you used jx boot then you can do this at any time. The domain name is present in the domain name and can be found
    in `jx-requirements.yml`. Copy the IP.
3. Use the default values for `Resource Record Type` (`A`), `TTL` (`5`) and `TTL Unit` (`minutes`).
4. Paste the IP address you found above into the `IPv4 Address` field
5. Click `Create`
6. Check if the DNS has propagated to wherever you are running the `jx` command. Run
`watch dig +short A test-dns.<unique name>.<your username>.jenkins-x.rocks`. Once the output changes to the IP address
you found above the DNS has propagated. If you are using a Mac `watch` can be installed using `brew install watch`
7. Tell Jenkins X about the name.
  * If you are using `jx install` then paste `<unique name>.<your username>.jenkins-x.rocks` into the prompt where you paused earlier
  * If you are using `jx boot` then edit `jx-requirements.yml`, and update the `domain` field (in `ingress`)
    to `<unique name>.<your username>.jenkins-x.rocks` and run `jx boot`

> If you prefer to use the gcloud CLI you can find instructions for usage on the "Create record set" screen.
