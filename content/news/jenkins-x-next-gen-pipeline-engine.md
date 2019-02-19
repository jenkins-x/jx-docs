---
title: "Next Gen Pipeline engine"
date: 2019-02-19T10:36:00+02:00
description: "Jenkins X: Next Gen Pipeline engine" 
categories: [blog]
keywords: []
slug: "jenkins-x-next-gen-pipeline-engine"
aliases: []
author: rawlingsj
---

## Jenkins X: Next Gen Pipeline engine

The [Jenkins X](https://jenkins-x.io/) team and [CloudBees](https://www.cloudbees.com/) are excited to announce some changes that we’ve been working on for the future of Jenkins Pipeline. 

So far, you’ve been able to use [Serverless Jenkins](https://medium.com/@jdrawlings/serverless-jenkins-with-jenkins-x-9134cbfe6870) to run Jenkins pipelines. Soon, you will be able to author cloud native Jenkins pipelines by using a YAML syntax. These pipelines will run with our new cloud native pipeline execution engine built using the currently named [Knative Build Pipeline](https://github.com/knative/build-pipeline) project.

We ’ve been calling this initiative “Next Generation Pipeline” and the intent is to bring a truly cloud native experience to Jenkins users, with less overhead, increased predictability and tighter integrations with Jenkins X. 

The Next Generation Pipeline is in its early stages still. It’s not yet ready for production testing. However, when we do announce its availability,  and we very much want your help in testing it out and giving us feedback. Currently, there’s no automated way to take your existing Jenkins pipelines and move them to the new syntax, but we are working with CloudBees to provide that in the future. 

If you are using Serverless Jenkins to test out Jenkins X, you will need to migrate your existing Jenkinsfile scripted or declarative syntax to the new YAML syntax. However, if you are using Jenkins X for CI/CD on a production app or service, you likely want to hold off on using the new pipeline syntax since the syntax is not yet complete and may not be forward compatible.

We’ll continue to update the community on progress accordingly and welcome your feedback! Feel free to contact the [Jenkins X team via Slack](https://jenkins-x.io/community/#slack), [office hours](https://jenkins-x.io/community/#office-hours) or send us an email with any questions or concerns. The next office hours will be on Thursday, February 21st, at 11:00am ET and Andrew Bayer will be demoing progress. Thanks!