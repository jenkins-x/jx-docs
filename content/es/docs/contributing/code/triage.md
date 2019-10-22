---
title: Triaging issues
linktitle: Triaging issues
description: How to triage issues on the Jenkins X project
weight: 30
---

The main issue tracker for the Jenkins X project is https://github.com/jenkins-x/jx/issues.  This aims to capture issues, ideas and development work.  If in doubt please raise an issue and a Jenkins X team member will look to triage it as soon as possible.

As Jenkins X is using [prow](https://www.cloudbees.com/blog/serverless-jenkins-jenkins-x) from the Kubernetes ecosystem we figured we'd take their lead in triaging a large number of issues to aid and encourage contributions.  We are reusing the style of labels including colours in an attempt to create familiarity across open source projects and reduce the barrier to contributing.

# Triaging issues

For a full list of available labels please see https://github.com/jenkins-x/jx/labels

When triaging an issue, someone from the Jenkins X team will assign labels to describe the __area__ and __kind__ of issue.  Where possible they will also add a priority however these are subject to change after further analysis or wider visibility.

Labels are added via the prow [label](https://prow.k8s.io/plugins) plugin using GitHub comments.  For example:
```text
/kind bug
/area prow
/priority important-soon
```
![Triage](/images/contribute/triage.png)

# Assigning issues

When triaging we will attempt to assign someone to the issue.  This may change depending on the investigation or availability of people.

# Investigating issues

When anyone is working on an issue we aim to capture any analysis by adding comments.  This helps people learn tips on how to investigate similar problems, helps people understand the thought process and provides context for any linked fixes via pull requests.

# New labels

If you would like to request a new label be created please raise an issue with as much context as possible.

# Stale issues

As we encourrage a wide range of issue kinds like general ideas and thoughts the issue tracker can grow quite high.  We are going to be enabling the prow [lifecycle](https://prow.k8s.io/plugins) plugin to help manage stale issues.  This is not meant to be intrusive but instead allow us to continually rethink problems and keep momentum across issues.
