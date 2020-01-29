---
title: 创建自定义 Builder
linktitle: 创建自定义 Builder
description: 如何为 Jenkins X 创建一个自定义 Builder
date: 2018-09-22
publishdate: 2018-09-22
categories: [getting started]
keywords: [install,builder]
---

在 Jenkins X 中，可以创建字段自定义的 Builder （也就是 [POD templates](https://github.com/jenkinsci/kubernetes-plugin)）或覆盖已有的。你只需要基于 [builder-base](https://github.com/jenkins-x/builder-base/blob/master/Dockerfile.common) 或它的 [slim](https://github.com/jenkins-x/builder-base/blob/master/Dockerfile.slim) 版本的镜像。

## 从零创建一个自定义 Builder

### Builder 镜像

首先，您需要为 Builder 创建一个 docker 镜像。从 `Dockerfile` 开始的一个实例可能类似于：

```dockerfile
FROM jenkinsxio/builder-base:latest

# Install your tools and libraries
RUN yum install -y gcc openssl-devel

CMD ["gcc"]
```

现在，您可以构建并发布这个镜像到您的 registry：

```sh
export BUILDER_IMAGE=<YOUR_REGISTRY>/<YOUR_BUILDER_IMAGE>:<VERSION>
docker build -t ${BUILDER_IMAGE} .
docker push ${BUILDER_IMAGE}
```

别担心，当新的镜像需要构建时，您无需每次手动执行这些步骤。Jenkins X 可以为您管理这些。您只需要把 `Dockerfile` 推送到类似于[这个](https://github.com/jenkins-x/jenkins-x-builders/tree/master/builder-go)代码仓库中。然后，根据您的组织名称来调整 `Jenkinsfile` ，并使用下面的命令导入 Jenkins X 平台：

```sh
jx import --url <REPOSITORY_URL>
```

之后，您每次推送一个变更，Jenkins X 将会自动地构建和发布镜像。

### 安装 Builder

当您安装或者升级 Jenkins X 时就可以安装您的 Builder 了。

在您的 `~/.jx/` 目录下创建文件  `myvalues.yaml` 并写入下面内容：

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

根据需要替换 Builder 名称和镜像。

您可以继续安装 Jenkins X ，然后 Builder 将会自动添加到平台。

### 使用 Builder

现在，您的 Builder 已经在 Jenkins 中安装了，您可以在 `Jenkinsfile` 中轻松地引用：

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

## 覆盖已有的 Builder

Jenkins X 自带了很多[预安装的 Builder](https://raw.githubusercontent.com/jenkins-x/jenkins-x-platform/master/values.yaml)，在安装或升级过程中可以根据需要覆盖。

您只需要基于[基础 Builder](https://github.com/jenkins-x/builder-base/blob/master/Dockerfile.common) 镜像或者[Builder 镜像](https://hub.docker.com/u/jenkinsxio/) 自定义。在上面查看细节。

然后，您可以在目录 `~/.jx/` 中创建文件 `myvalues.yaml` ，并写入一下内容：

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

您可以继续安装 Jenkins X，这些 Builder 将会自动地添加到平台。
