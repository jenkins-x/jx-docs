---
title: Jenkinsfile support
linktitle: Jenkinsfile support
type: docs
description: Working with Jenkinsfiles, Jenkins and Tekton
weight: 30
aliases: 
    - /v3/develop/jenkinsfile
---


When importing a project [jx project import](/v3/develop/reference/jx/project/import) looks for a `Jenkinfile` in the source code. 

If there is no `Jenkinsfile` then the wizard assumes you wish to proceed with automated CI/CD pipelines based on [tekton](https://github.com/tektoncd/pipeline) and imports it in the usual Jenkins X way. You also get to confirm the kind of pipeline catalog  and language you wish to use for the automated CI/CD - so its easy to import any workload whether its a library, a binary, a container image, a helm chart or a fully blown microservice for automated kubernetes based CI/CD.

If a `Jenkinsfile` is present then the wizard asks you how you want to proceed:

* use the automated CI/CD pipelines based on [tekton](https://github.com/tektoncd/pipeline). 
  * this option will ignore the `Jenkinfile` for now - you can always use it later
* use a [Jenkins server](/v3/admin/guides/jenkins/) to execute the `Jenkinfile` pipeline 
* use [Jenkinsfile Runner](https://github.com/jenkinsci/jenkinsfile-runner) to run the pipelines

### Using Jenkins Server

If you choose the [Jenkins server](/v3/admin/guides/jenkins/) option and you have not yet configured a Jenkins server in your cluster, the wizard will prompt you for the new Jenkins server name and will automatically [create you a Jenkins server via GitOps](/v3/admin/guides/jenkins/getting-started/#adding-jenkins-servers-into-jenkins-x)

Otherwise you choose which Jenkins server to use for your project. You could have multiple jenkins servers with different configurations and plugins.

When using a Jenkins Server you get to use the full power of the Jenkins server and `Jenkinfile`. Jenkins X uses the [upstream Jenkins helm chart](https://github.com/jenkinsci/helm-charts) which you can [configure fully via GitOps](/v3/admin/guides/jenkins/getting-started/#configure-jenkins)


### Using Jenkinsfile Runner

When using [Jenkinsfile Runner](https://github.com/jenkinsci/jenkinsfile-runner) we still reuse [tekton](https://github.com/tektoncd/pipeline) to run the pipelines and [lighthouse](https://github.com/jenkins-x/lighthouse) to handle webhooks and to trigger pipelines. The [Jenkinsfile Runner](https://github.com/jenkinsci/jenkinsfile-runner) container runs as a step in a [Tekton pipeline](https://github.com/jenkins-x/jx3-pipeline-catalog/tree/master/packs/jenkinsfilerunner/.lighthouse/jenkins-x)
