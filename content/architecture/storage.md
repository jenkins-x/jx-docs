---
title: Storage
linktitle: Storage
description: Let's save your pipeline files somewhere cloud native!
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
menu:
  docs:
    parent: "architecture"
    weight: 77
weight: 77
sections_weight: 77
draft: false
toc: true
---

When we use a Static Jenkins Server with Jenkins X we inherit the usual Jenkins storage model; that build logs and test results and reports are stored on the Persistent Volume of the Jenkins server.

However as we move towards a more [Cloud Native Jenkins](/news/changes-november-26-2018/) and use [Serverless Jenkins](/news/serverless-jenkins/) we need a better solution for the storage of things like logs, test results, code coverage reports etc.

## Storage Extensions

So we've added a storage extension point which is used from:

* storing logs when using [Serverless Jenkins](/news/serverless-jenkins/) which is done by the [jx controller build](/commands/jx_controller_build/) command
* using the [jx step stash](/commands/jx_step_stash/) command which stashes files from a build (test or coverage reports)


## Configuring Storage

You can setup the default location to use for storage. We currently support: 

* storing files (logs, test or coverage reports) in a branch of a git repository. e.g. they could be part of your `gh-pages` branch for your static site.
* storing files in Cloud Storage buckets like S3, GCZ, Azure blobs etc

Storage uses classifications which are used to define the folder in which the kind of resources live such as 

* logs
* tests
* coverage

You can also use the special classification `default` which is used if you don't have a configuration for the classification in question. e.g. you could define a location of `default` and then just configure where `logs` go if thats different.

Then to configure the storage location for a classification and team you use the [jx edit storage](/commands/jx_edit_storage/)

e.g.

```shell 
# Configure the tests to be stored in cloud storage (using S3 / GCS / Azure Blobs etc)
jx edit storage -c tests --bucket-url s3://myExistingBucketName
  
# Configure the git URL and branch of where to store logs
jx edit storage -c logs --git-url https://github.com/myorg/mylogs.git' --git-branch cheese
```
   
