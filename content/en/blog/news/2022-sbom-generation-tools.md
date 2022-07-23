---
title: "Software Bill Of Materials generation tools"
date: 2022-07-24
draft: false
weight: 100
description: >
  In the third blog post, we get to realize the actual implementation of Software Bill Of Materials (SBOM) generation through different tools and packages.
categories: [blog]
keywords: [Community, GSoC, 2022, supply chain security, BOM, SBOM]
slug: "sbom-tools"
aliases: []
author: Osama Magdy
---


## Prerequisite ##

Before you read this, you have to understand [what are SBOMs](/blog/2022/07/24/intro-to-sbom) and [what are different formats of SBOMs](/blog/2022/07/24/sbom-formats)

## Different SBOM generation tools comparison ##

If you got this far, you already realize the importance of SBOM generation, and also it should meet certain requirements to achieve its purpose. Due to various requirements depending on what standard you're following, there has to be a way to automatically generate different output formats for different standards. Also, it has to be suited for ci/cd solutions to keep up with the increasing number of releases for each organization.

Note: Here we're only considering open source tools

### 1 - Anchore Syft ##

***Introduction:***

[Anchore](https://anchore.com/)is a platform that implements sbom-powered supply chain security solutions for developers and enterprises. For generating SBOMs, a CLI tool and library named [Syft](https://github.com/anchore/syft) was developed by Anchore that could be injected into your ci/cd pipeline to generate SBOMs from container images and filesystems at each step.

***Integration and Support:***

Syft is supported on Linux, Mac, and Windows and it can run as a docker container which makes it a great suit for CI systems. Other than the 3 SBOM standards, Syft can generate its JSON standard format to be input for other Anchore tools like [Grype](https://github.com/anchore/grype/) which is a vulnerability scanner for container images and filesystems. It supports projects based on the following package managers:

* Alpine (apk)
* C (conan)
* C++ (conan)
* Dart (pubs)
* Debian (dpkg)
* Dotnet (deps.json)
* Objective-C (cocoapods)
* Go (go.mod, Go binaries)
* Haskell (cabal, stack)
* Java (jar, ear, war, par, sar)
* JavaScript (npm, yarn)
* Jenkins Plugins (jpi, hpi)
* PHP (composer)
* Python (wheel, egg, poetry, requirements.txt)
* Red Hat (rpm)
* Ruby (gem)
* Rust (cargo.lock)
* Swift (cocoapods)

***Features and Specs:***

* Easy to use
  * Syft can generate a simple basic sbom by just running `syft <image>` this will only include the softwares included in the image's final layer. Or `syft <image> --scope all-layers` for more verbose sbom to include all image layers
* Different formats support the ability to convert between them.
  * Syft JSON
  * SPDX 2.2 JSON
  * SPDX 2.2 tag-value
  * CycloneDX 1.4 JSON
  * CycloneDX 1.4 XML
* Cryptographically sign and attest SBOMs
  * Syft uses [in-toto attestations](https://github.com/in-toto/attestation) with `syft attest` command and the digital signature management is integrated with sigstore cosign. You can view more [here](https://anchore.com/sbom/creating-sbom-attestations-using-syft-and-sigstore/).
* Support a variety of sources to generate SBOMs from
  * OCI and docker image formats `syft <image>`
  * Container images archives `syft path/to/image.tar`
  * Filesystems and local directories `syft path/to/dir`

For more resources about Syft capabilities refer to the [source repo](https://github.com/anchore/syft) and [official documentation](https://anchore.com/sbom/how-to-generate-an-sbom-with-free-open-source-tools/)

### 2- Opensbom's Spdx-Sbom-Generator ##

***Introduction:***

[Opensbom-Generator](https://github.com/opensbom-generator) is an open source project initiated by the Linux Foundation SPDX workgroup to generate SBOMs using CLI tools. Currently, they support the standard spdx 2.2 formats and JSON with their [spdx-sbom-generator](https://github.com/opensbom-generator/spdx-sbom-generator) tool based on golang. It can only be used to generate SBOMs from a repository containing package files (no container images or archives support yet). They aim to provide SBOM generation support in ci/cd solutions.

***Integration and Support:***

You can download the binaries and install the tool on your system. The available binaries to install are for Linux, Windows, and macOS and it can also be used as a docker container from this spdx [repo](https://hub.docker.com/r/spdx/spdx-sbom-generator). It can detect which package managers or build systems are being used by the software. It is supporting the following package managers:

`GoMod (go), Cargo (Rust), Composer (PHP), DotNet (.NET), Maven (Java), NPM (Node.js), Yarn (Node.js), PIP (Python), Pipenv (Python), Gems (Ruby), Swift Package Manager (Swift)`

***Features and Specs:***

* CLI easy to use and simple interface
* Automatic detection of the package manager

### 3- Kubernetes BOM ##

***Introduction:***

[BOM](https://github.com/kubernetes-sigs/bom) is a general-purpose CLI tool developed by [kubernetes-sigs](https://github.com/kubernetes-sigs) (Special Interest Groups) that can generate SBOMs from directories, container images, single files, and other sources. The utility has a built-in license classifier that can check for license compliance of your packages with around 400+ licenses in the [SPDX catalog.](https://spdx.org/licenses/)

***Integration and Support:***

BOM is supported as a Golang package that can be installed on any system having to go with `go install sigs.k8s.io/bom/cmd/bom` this adds the support for Linux, Mac, and Windows. It is compatible with creating SBOMs from files, images, and docker archives (images in tarballs). It also supports pulling images from remote container registries for analysis. BOM is mainly generating SBOMs in SPDX formats.

***Features and Specs:***

* CLI usage to support CI/CD solutions
* Golang dependency analysis
* Full `.gitignore` support when scanning git repositories
* Ability to check for license compliance with SPDX catalog
* Support for different sources to generate sboms
* Other than the command `bom generate`, it uses `bom document` to work with already present SPDX documents to outline and draw a structure for them
* It doesn't necessarily require a whole project directory but it can specify a single file to analyze with the `-f path/to/file` flag and it can have a collection of those files to be analyzed together.
* It also supports the namespacing separation between SBOM documents using the `-n <URI>` flag to isolate each document from the other

### 4- Microsoft SBOM tool ##

***Introduction:***

Recently, Microsoft open-sourced their SBOM generation tool which is described as a general purpose, enterprise-proven, build-time SBOM generator. They have been developing the tool internally since 2019 and tuning its feature according to their needs and providing other companies with the solution. What is new is that Microsoft has chosen to merge efforts with the Linux Foundation's work and use [Software Package Data Exchange (SPDX)](https://spdx.dev/) for all SBOMs generated, and to do this for all software produced. It has a promising number of features like including other SBOM documents recursively to provide its users with the ability to have a full dependency tree that goes to the origin of every package.

***Integration and Support:***

Microsoft SBOM is supported on Linux, macOS, and Windows. It can be easily integrated into and auto-detects the following package managers

`NPM, NuGet, PyPI, CocoaPods, Maven, Golang, Rust Crates, RubyGems, Linux packages within containers, Gradle, Ivy, GitHub public repositories`

and Microsoft is adding more detectors to improve deeper integration with the community. The tool is currently committed to generating the SPDX 2.2.1 format for its users and is still in development to include all optional fields before integrating with other formats.

***Features and Specs:***

* Enterprise ready and highly scalable as already used at scale by Microsoft
* Adding build provenance information to the SBOM
* Auto-detection of the underlying package manager
* Supports namespacing separation between SBOM documents with the `-nsb` flag
* Validating SBOMs at release using hashes and digital signatures
  
  ![img](/images/sbom-guide/microsoft-sbom.png)

  Fig 1: <https://devblogs.microsoft.com/engineering-at-microsoft/wp-content/uploads/sites/72/2021/10/adiglio-figure-1.png>

For more information about the tool visit the GitHub [repo](https://github.com/microsoft/sbom-tool)and refer to the documentation [here](https://github.com/microsoft/sbom-tool/tree/main/docs)

### 5- Tern ##

***Introduction:***

[Tern](https://github.com/tern-tools/tern) is a VMware-originated open source inspection tool used to generate SBOMs following standard formats. It gathers metadata for the packages installed in container images and Dockerfiles. Tern starts to analyze the contents of a container (through the image itself or the Dockerfile), layer by layer, without requiring the user to have in-depth technical knowledge about how the container was built.

***Integration and Support:***

Tern itself is available as a [Github Action](https://github.com/marketplace/actions/tern-action) but it is mainly supported to be installed as a CLI tool on Linux. With Linux installation, Tern is built with python so it requires python, pip, and jq installed mainly (more about installation [here](https://github.com/tern-tools/tern#getting-started)). Some features like analyzing Dockerfiles and the [lock function](https://automatecompliance.org/news/2020/04/23/tern-2-0-0-now-available/) require Docker installation in your Linux. Moreover, Tern can run as a docker container which makes it easy to use in ci systems and can be used as a workaround to run on other operating systems like Windows, and macOS. Also, this helps to deploy Tern as a Kubernetes job with a host mount to retrieve generated SBOMs.

For now, Tern only supports container images built using Docker using [image manifest version 2, schema 2](https://docs.docker.com/registry/spec/manifest-v2-2/) and it will support Docker images and it is aimed to support other images that follow the OCI standards in the future.

For license compliance, Term doesn't have its file-level license analyzer. So, it allows you to extend its analysis using an external CLI tool or Python packages as extensions. An example is [Scancode](https://github.com/tern-tools/tern#scancode) which is a CLI tool used for license compliance along with other supported integrations like [cve-bin-tool](https://github.com/tern-tools/tern#cve-bin-tool) for vulnerability scanning.

Tern supports generating reports with multiple formats:

* Human Readable Simple format
* JSON format
* HTML format
* YAML format
* SPDX tag-value Format
* SPDX JSON Format
* CycloneDX JSON Format

***Features and Specs:***

* CLI is easy to use and can be installed as a docker container which makes it suitable for CI/CD solutions
* Multiple supported output formats which are readable for both humans and machines
* Ability to generate SBOMs following both SPDX and CycloneDX formats
* Support for Dockerfile locking to create more reproducible Docker images which is a unique feature supported by Tern only, view more about it [here](https://automatecompliance.org/news/2020/04/23/tern-2-0-0-now-available/).
* The concept of extensions/plugins is only supported by Tern between all the previously mentioned tools. This is a great feature that is proven to extend its capabilities in the coming future and open for creativity from the open source community (this was proven before to increase the functionality and popularity of other tools like Jenkins).

For more information about the tool visit the GitHub [repo](https://github.com/tern-tools/tern) and refer to the documentation [here](https://github.com/tern-tools/tern/tree/main/docs).
