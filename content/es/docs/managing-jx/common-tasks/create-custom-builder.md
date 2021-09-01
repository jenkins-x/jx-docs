---
title: Construcción Personalizada
linktitle: Construcción Personalizada
description: ¿Cómo crear una construcción personalizado para Jenkins X?
categories: [getting started]
keywords: [install,builder]
weight: 260
---

En Jenkins X, es posible crear sus Constructores personalizados (también conocidos como [POD templates](https://github.com/jenkinsci/kubernetes-plugin)) o sobrescribir las existentes. Solo necesita basar su imagen de Docker en esta [imagen base de construcción](https://github.com/jenkins-x/jenkins-x-builders-base/blob/master/builder-base/Dockerfile.common). Estas imágenes contienen una serie de herramientas pre-instaladas que se actualizan y publican constantemente en [Docker Hub](https://hub.docker.com/r/jenkinsxio/builder-base/).

## Crear un Constructor personalizado desde cero

### Imagen Constructora

Primero debes crear una imagen de Docker para tu constructor. Por ejemplo, el ficheor `Dockerfile` inicial puede verse así:

```dockerfile
FROM jenkinsxio/builder-base:latest

# Install your tools and libraries
RUN yum install -y gcc openssl-devel

CMD ["gcc"]
```

Ahora puede construir la imagen y publicarla en su repositorio:

```sh
export BUILDER_IMAGE=<YOUR_REGISTRY>/<YOUR_BUILDER_IMAGE>:<VERSION>
docker build -t ${BUILDER_IMAGE} .
docker push ${BUILDER_IMAGE}
```

No se preocupe, no es necesario que ejecute estos pasos manualmente cada vez que necesite construir una nueva imagen. Jenkins X puede manejar esto por ti. Solo necesita insertar su ficheor `Dockerfile` en un repositorio similar a [este](https://github.com/jenkins-x/jenkins-x-builders/tree/master/builder-go). Ajuste el fichero `Jenkinsfile` de acuerdo con el nombre de su organización y aplicación, y luego importe el repositorio en su plataforma Jenkins X con:

```sh
jx import --url <REPOSITORY_URL>
```

De ahora en adelante, cada vez que agregue una modificación Jenkins X va a construir y publicar automáticamente esta imagen.

### Instalar el Constructor

Puede instalar su constructor tanto al inicio de la instalación de Jenkins X como durante la actualización.

Crea el fichero `myvalues.yaml` en su carpeta local `~/.jx/` con el siguiente contenido:

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

Modifique el nombre del constructor y su imagen correspondiente.

Ahora puede continuar con la instalación de Jenkins X, el generador se agregará automáticamente a la plataforma.

### Utilizar el Constructor

Ahora que su constructor/generador a sido instalado en Jenkins, puede hacer referencia a él en el fichero `Jenkinsfile`:

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

## Sobreescribir el Constructor existente

Jenkins X viene con una serie de [constructores pre-instalados](https://raw.githubusercontent.com/jenkins-x/jenkins-x-platform/master/jenkins-x-platform/values.yaml) que puede sobrescribir si es necesario durante la instalación o actualización.

Solo necesita crear su imagen personalizada ya sea en [base a la imagen del generador](https://github.com/jenkins-x/jenkins-x-builders-base/blob/master/builder-base/Dockerfile.common) o la [imagen del generador](https://hub.docker.com/u/jenkinsxio/) que desea sobrescribir. Ver más detalles arriba.

Luego puede crear el fichero `myvalues.yaml` en su carpeta local `~/.jx/` con el siguiente contenido:

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

Ahora puede continuar con la instalación de Jenkins X, el generador se agregará automáticamente a la plataforma.
