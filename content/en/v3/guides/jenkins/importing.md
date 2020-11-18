---
title: Importing Projects
linktitle: Importing Projects
type: docs
description: Importing Jenkinsfile based projects
weight: 50
aliases:
  - /docs/v3/guides/jenkins/importing
---


Once you have [added one or more Jenkins Servers to Jenkins X](/docs/v3/guides/jenkins/getting-started/) you can import a `Jenksinfile` based project in the usual way.


## Import the code

First you need to import the code via one of these approaches: 
 
### From inside the source code

If you are inside a git clone of the project you have with a `Jenkinsfile`  then run the import wizard:

```bash 
jx project import
``` 

### Import via a git URL 

If you don't have a local git clone then use:


```bash 
jx project import --git-url=https://github.com/myorg/myrepo.git
```           

## Choose the remote Jenkins server 

Next the wizard will prompt you to pick which Jenkins server you wish to use (if you have more than one).
