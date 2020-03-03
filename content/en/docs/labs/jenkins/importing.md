---
title: Importing Projects
linktitle: Importing Projects
description: Importing Jenkinsfile based projects
weight: 50
---

Once you have [added one or more Jenkins Servers to the registry](/docs/labs/jenkins/getting-started/#adding-jenkins-servers) you can import a `Jenksinfile` based project.


## From inside the source code

If you are inside a git clone of the project you have with a `Jenkinsfile`  then run the import wizard:

```bash 
jxl project import
``` 

This will prompt you to import the repository into Jenkins X.

You get to pick which Jenkins server you wish to use (if you have more than one).

In addition you get to pick between:

* importing the project directly into the Jenkins server as a Jenkins _multi branch project_ where Jenkins performs the webhook handling (the default)
* using `lighthouse`  for ChatOps and webhook handling but when a pipeline is triggered we then trigger the pipeline directly into the remote Jenkins server
