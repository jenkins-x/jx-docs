---
title: Importing Projects
linktitle: Importing Projects
description: Importing Jenkinsfile based projects
weight: 50
---


Once you have [added one or more Jenkins Servers to the registry](/docs/v3/jenkins/getting-started/#adding-jenkins-servers) you can import a `Jenksinfile` based project.


## Import the code

First you need to import the code via one of these approaches: 
 
### From inside the source code

If you are inside a git clone of the project you have with a `Jenkinsfile`  then run the import wizard:

```bash 
jxl project import
``` 

### Import via a git URL 

If you don't have a local git clone then use:


```bash 
jxl project import --git-url=https://github.com/myorg/myrepo.git
```           

## Choose the remote Jenkins server 

Next the wizard will prompt you to pick which Jenkins server you wish to use (if you have more than one).

In addition you get to pick between:

* importing the project directly into the Jenkins server as a Jenkins _multi branch project_ where Jenkins performs the webhook handling (the default)
* using `lighthouse`  for ChatOps and webhook handling but when a pipeline is triggered we then trigger the pipeline directly into the remote Jenkins server
