---
title: "Introduction to Software Bill Of Materials"
date: 2022-07-24
draft: false
weight: 300
description: >
  Here we discuss the concepts of SBOM, how it can help in securing your software.
categories: [blog]
keywords: [Community, GSoC, 2022, supply chain security, BOM, SBOM]
slug: "intro-to-sbom"
aliases: []
author: Osama Magdy
---

## Introduction

Before going through Software Bill Of Materials (SBOMs), we need to set the ground for a rising concern in the software industry which is Software Supply Chain Security.
Like traditional industries, deploying a piece of a software artifact goes through multiple stages composed of collecting source code components, libraries, tools, and processes used in those stages.

![comparing the different steps in a real world supply chain with software supply chain](/images/sbom-guide/supply-chain.png)

Fig. 1 <https://blog.convisoappsec.com/en/is-your-software-supply-chain-secure/>

A supply chain attack can occur along the chain from submitting unauthorized malicious code in your source, unauthorized injection of harmful dependencies, and even replacing packages after being built with other compromised artifacts.
A more detailed explanation about those types of attacks is [here](https://slsa.dev/spec/v0.1/threats)

Due to its importance and being a critical issue, generating SBOM for your software adds another layer of protection to this threat.

## Definition: What is SBOM?

As far as we know, developers around the world are building web applications using hundreds of third-party open-source libraries and packages. You can confidently tell that 90% of the software products around the world are built over open-source components. With that in mind, we need to keep track of using these dependencies while building our applications. What if there are vulnerabilities in the libraries we use? How to efficiently protect ourselves against it?.

**[Software Bill Of Materials](https://en.wikipedia.org/wiki/Software_supply_chain#:~:text=Software%20vendors%20often,could%20harm%20them.)** (SBOM) is a complete formally structured list of the materials (components, packages, libraries, SDK) used to build (i.e. compile, link) a given piece of software and the supply chain relationships between all these materials.

It is an inventory of all the components developers used to make this software. It has many formats and many generating tools but all have the same purpose in the end.
***Example: a simple formatted SBOM of Ubuntu alpine docker image using [syft](https://anchore.com/sbom/how-to-generate-an-sbom-with-free-open-source-tools/)***

``` bash
✔ Loaded image  
 ✔ Parsed image  
 ✔ Cataloged packages      [14 packages]
NAME                    VERSION      TYPE 
alpine-baselayout       3.2.0-r18    apk   
alpine-keys             2.4-r1       apk   
apk-tools               2.12.7-r3    apk   
busybox                 1.34.1-r3    apk   
ca-certificates-bundle  20191127-r7  apk   
libc-utils              0.7.2-r3     apk   
libcrypto1.1            1.1.1l-r7    apk   
libretls                3.3.4-r2     apk   
libssl1.1               1.1.1l-r7    apk   
musl                    1.2.2-r7     apk   
musl-utils              1.2.2-r7     apk   
scanelf                 1.3.3-r0     apk   
ssl_client              1.34.1-r3    apk   
zlib                    1.2.11-r3    apk

```

Here it shows only softwares included in the final layer of the container (default choice by syft). If we want to view a detailed SBOM with one detailed format, we can run `syft alpine -o spdx-json`. This will view the output as `.json` file following the `spdx` format (will discuss that later)

## Use cases in Supply chain security

What makes a supply chain attack susceptible is the lack of transparency and visibility about whether the software gets affected by a recent exploit or not. This greatly affects both producers and customers of the product.

On the user's side if they know the components of the software and that there is one component affected by certain vulnerabilities, they are better aware and ready to protect against potential attacks. This is crucial in many cases, especially with open-source tools.

On the software producer's side, it happens a lot that they are not fully aware of all the third parties used inside the project, and in turn, they can not track vulnerabilities in the system that could pose a threat. Cases like the [Log4Shell](https://snyk.io/blog/log4shell-in-a-nutshell/) vulnerability are an example of a component (in this case, a logging library) that many producers never bothered to check because it isn't a direct software dependency, but rather a transitive one that is depended upon by other components.

SBOM can also be useful in licensing and legal issues with some formats. SPDX (Software Package Data Exchange) standard for SBOM identifies the licenses of the used components and can be checked for compliance later.

Next, we view the different standards and formats for SBOMs and the specifications of each one. See them [here](/blog/2022/07/24/sbom-formats)
