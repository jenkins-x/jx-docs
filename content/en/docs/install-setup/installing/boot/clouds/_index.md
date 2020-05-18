---
title: Cloud Providers
linktitle: Cloud Providers
description: Using Boot on different kubernetes providers
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
weight: 40
aliases:
  - /docs/getting-started/setup/boot/clouds
  - /docs/getting-started/setup/boot/clouds/
  - /docs/install-setup/boot/clouds
  - docs/install-setup/boot/clouds/
---

Jenkins X is designed to work on any kubernetes cluster; whether on premise, hybrid or public clouds.

However if you try doing any significant work with Kubernetes particularly with things like storage, networking, ingress, TLS, certificates, DNS, secrets - you will find that things can be different on different cloud providers.

This section of the documentation will try guide you through the best way to use Jenkins X on different cloud providers.

## Cloud Provider Support Maturity

The following table lists the maturity of Jenkins X with boot on the different cloud providers. 

| Cloud Provider  | Maturity |
| ------------- | ------------- |
| [Google Cloud](google/) | GA  |
| [AWS](amazon/)  | GA  |
| Azure | Beta  |
| [On Premise](on-premise/) | Beta (*) note that on premise clusters differ wildly in capabilities and configuration |

### Terminology

In the above we are using the following terms:

* `GA` means generally available. We know this works and have automated testing to verify it works.
* `Beta` its available and we have seen it work but we don't have any automated tests. If you would like to help provide automated testing on this platform then please [join our community](/community/) 
* `Alpha` its experimental and please help us improve it


 