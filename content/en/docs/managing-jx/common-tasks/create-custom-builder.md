---
title: Create custom Builder
linktitle: Create custom Builder
description: How to create a custom Builder for Jenkins X
date: 2013-07-01
publishdate: 2013-07-01
categories: [getting started]
keywords: [install,builder]
weight: 260
aliases:
  - /getting-started/create-custom-builder
---

In Jenkins X, it is possible to create your custom Builders (aka [POD templates](https://github.com/jenkinsci/kubernetes-plugin)) or overwrite existing onces. You just need to base your Docker
image on this [builder-base](https://github.com/jenkins-x/jenkins-x-builders-base/blob/master/Dockerfile.common) image.
These images contain a number of pre-installed tools which get constantly updated and published to [Docker Hub](https://hub.docker.com/r/jenkinsxio/builder-base/).

## Create a custom Builder from scratch

### Builder image

First you need to create a docker image for your builder. For instance a starting `Dockerfile` can look like this:

```dockerfile
FROM jenkinsxio/builder-base:latest

# Install your tools and libraries
RUN yum install -y gcc openssl-devel

CMD ["gcc"]
```

Now you can build the image and publish it to your registry:

```sh
export BUILDER_IMAGE=<YOUR_REGISTRY>/<YOUR_BUILDER_IMAGE>:<VERSION>
docker build -t ${BUILDER_IMAGE} .
docker push ${BUILDER_IMAGE}
```

Do not worry, you do not have to run manually these steps every time when a new image needs to be built.
Jenkins X can manage this for you. You just need to push your `Dockerfile` in a repository similar with [this
](https://github.com/jenkins-x/jenkins-x-builders/tree/master/builder-go) one. Adjust the `Jenkinsfile` according with your organization and
application name, and then import the repository into your Jenkins X platform with:

```sh
jx import --url <REPOSITORY_URL>
```

From now on, every time you push a change, Jenkins X will build and publish automatically the image.

### Install the Builder

You can now install your builder either when you install Jenkins X or upgrade it.

Create a `myvalues.yaml` file in your `~/.jx/` folder with the following content:

```yaml
jenkins:
  Agent:
    PodTemplates:
      MyBuilder:
        Name: mybuilder
        Label: jenkins-mybuilder
        volumes:
        - type: Secret
          secretName: jenkins-docker-cfg
          mountPath: /home/jenkins/.docker
        EnvVars:
          JENKINS_URL: http://jenkins:8080
          GIT_COMMITTER_EMAIL: jenkins-x@googlegroups.com
          GIT_AUTHOR_EMAIL: jenkins-x@googlegroups.com
          GIT_AUTHOR_NAME: jenkins-x-bot
          GIT_COMMITTER_NAME: jenkins-x-bot
          XDG_CONFIG_HOME: /home/jenkins
          DOCKER_CONFIG: /home/jenkins/.docker/
        ServiceAccount: jenkins
        Containers:
          Jnlp:
            Image: jenkinsci/jnlp-slave:3.14-1
            RequestCpu: "100m"
            RequestMemory: "128Mi"
            Args: '${computer.jnlpmac} ${computer.name}'
          Dlang:
            Image: <YOUR_BUILDER_IMAGE>
            Privileged: true
            RequestCpu: "400m"
            RequestMemory: "512Mi"
            LimitCpu: "1"
            LimitMemory: "1024Mi"
            Command: "/bin/sh -c"
            Args: "cat"
            Tty: true
```

Replace the builder name and image accordingly.

You can proceed now with the Jenkins X installation, the builder will be automatically added to the platform.

### Use the Builder

Now that your builder was installed in Jenkins, you can easily reference it in a `Jenkinsfile`:

```Groovy
pipeline {
    agent {
        label "jenkins-mybuilder"
    }
    stages {
      stage('Build') {
        when {
          branch 'master'
        }
        steps {
          container('mybuilder') {
              // your steps
          }
        }
      }
    }
    post {
        always {
            cleanWs()
        }
    }
}
```

## Overwrite existing Builders

Jenkins X comes with a number of [pre-installed builders](https://raw.githubusercontent.com/jenkins-x/jenkins-x-platform/master/jenkins-x-platform/values.yaml)
which you can overwrite if required during installation or upgrade.

You just need to build your custom image either based on [builder-base](https://github.com/jenkins-x/jenkins-x-builders-base/blob/master/Dockerfile.common)
image or the [builder image](https://hub.docker.com/u/jenkinsxio/) you want to overwrite. See more details above.

Then you can create a `myvalues.yaml` file in your `~/.jx/` folder with the following content:

```yaml
jenkins:
  Agent:
    PodTemplates:
      Maven:
        Containers:
          Maven:
            Image: <YOUR_REGISTRY>/<YOUR_MAVEN_BUILDER_IMAGE>:<VERSION>
      Nodejs:
        Containers:
          Nodejs:
            Image: <YOUR_REGISTRY>/<YOUR_NODEJS_BUILDER_IMAGE>:<VERSION>
      Go:
        Containers:
          Go:
            Image: <YOUR_REGISTRY>/<YOUR_GO_BUILDER_IMAGE>:<VERSION>
```

You can proceed now with the Jenkins X installation, the builder will  be added automatically to the platform.

