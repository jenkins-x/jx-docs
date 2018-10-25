---
title: Contribute to the Jenkins X Project
linktitle: Contribute to Jenkins X
description: Contribute to Jenkins X development and documentation.
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
categories: [contribute]
keywords: []
menu:
  docs:
    parent: "contribute"
    weight: 01
weight: 01	#rem
draft: false
slug:
aliases: [/community/contributing/]
toc: false
---

Jenkins X relies heavily on the enthusiasm and participation of the open-source community. We need your help so please dive in! There are many ways to help:


* [Give us feedback](https://jenkins-x.io/community/). What could we improve? Anything you don't like or you think is missing?
* Help [improve the documentation](/contribute/documentation/) so its more clear how to get started and use Jenkins X
* [Add your own quickstarts](/developing/create-quickstart/#adding-your-own-quickstarts) so the Jenkins X community can easily bootstrap new projects using your quickstart. If you work on an open source project is there a good quickstart we could add to Jenkins X? 
* Create an [Addon](/about/features/#applications). To add your own addon just create a Helm chart for some useful way to extend Jenkins X and then submit a Pull Request on [the pkg/kube/constants.go file](https://github.com/jenkins-x/jx/blob/master/pkg/kube/constants.go#L32-L50) to add your chart into the `AddonCharts` with its name matching a chart name
* If you'd like to [contribute to the code](https://jenkins-x.io/contribute/development/) then try browse the [current issues](https://github.com/jenkins-x/jx/issues).
  * we have marked issues [help wanted](https://github.com/jenkins-x/jx/issues?q=is%3Aopen+is%3Aissue+label%3A%22help+wanted%22) or [good first issue](https://github.com/jenkins-x/jx/issues?q=is%3Aopen+is%3Aissue+label%3A%22good+first+issue%22) to save you hunting around too much
  * in particular we would love help on getting Jenkins X [working well on windows](https://github.com/jenkins-x/jx/issues?q=is%3Aopen+is%3Aissue+label%3Awindows) or the [integrations with cloud services, git providers and issues trackers](https://github.com/jenkins-x/jx/issues?q=is%3Aissue+is%3Aopen+label%3Aintegrations)
 * for more long term goals we've the [long term roadmap](https://jenkins-x.io/contribute/roadmap)
 * we could always use more test cases and to improve test coverage!
