---
title: "Foreign aliases"
date: 2023-02-09T00:00:00-00:00
draft: false
description: >
  Handling of OWNERS and OWNERS_ALIASES for many repositories 
categories: [blog]
keywords: [Jenkins X,Community,2023]
slug: "foreign-aliases"
aliases: []
author: Mårten Svantesson
---

## Background

In an organisation with many repositories and developers that are frequently shifting the maintenance of OWNERS and 
OWNERS_ALIASES files can be tedious. In the passing year a couple of functionalities has been added to help 
with this.

## Foreign aliases

To avoid maintaining the OWNERS_ALIASES file in many repositories you can now refer to the OWNERS_ALIASES file in 
another repository. In the Jenkins X project we have the main OWNERS_ALIASES file in the 
[jx-community](https://github.com/jenkins-x/jx-community) repository. So in the [jx](http://github.com/jenkins-x/jx) repository 
the OWNERS_ALIASES file only looks like this:

```yaml
foreignAliases:
- name: jx-community
``` 

The organisation defaults to be the same as for the repository, but can specify as well. So in the 
[jx-project](https://github.com/jenkins-x-plugins/jx-project) repository the OWNERS_ALIASES file looks like this:

```yaml
foreignAliases:
- name: jx-community
  org: jenkins-x
```

Using the filed `ref` you can also specify a branch or tag to use instead of the default one of the repository.

## OWNERS and OWNERS_ALIASES in new repositories

When creating or importing a repository using `jx project` the default content of OWNERS and OWNERS_ALIASES isn't 
that useful since only the current user are put in the files.

If you [create your own quickstarts](https://jenkins-x.io/v3/about/extending/#quickstarts) you place the OWNERS and 
/ or OWNERS_ALIASES files with the content of your liking in those.

A recent new functionality is that you can put OWNERS and / or OWNERS_ALIASES files in the `extensions` directory of 
your cluster repository. These files will then be used as the default content of the files in new repositories. 
