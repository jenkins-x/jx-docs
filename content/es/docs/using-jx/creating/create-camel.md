---
title: Crear Camel
linktitle: Crear Camel
description: ¿Cómo crear un nuevo microservicio Apache Camel e importarlo a Jenkins X?
weight: 20
---

Si desea crear un nuevo microservicio Spring Boot usando [Apache Camel](http://camel.apache.org/), puede utilizar el comando [jx create camel](/commands/deprecation/).

```sh
jx create camel
```

Luego se le solicita el nombre del proyecto.

Si lo desea, puede especificar esto en la línea de comando:

```sh
jx create camel -a myapp
```

### ¿Qué sucede cuando creas un microservicio de Camel?

Una vez que haya elegido el proyecto a crear y le haya dado un nombre, los siguientes pasos se automatizarán para usted:

* crea un nuevo microservicio Camel en un subdirectorio
* adiciona su código fuente a un repositorio Git
* crea un repositorio Git remoto en un servidor Git como por ejemplo [GitHub](https://github.com)
* empuja el código local al repositorio remoto Git
* adiciona los siguientes ficheros:
  * `Dockerfile` para construir su aplicación en una imagen Docker
  * `Jenkinsfile` para implementar el pipeline CI/CD
  * chart Helm para ejecutar la aplicación dentro de Kubernetes
* registra un enlace en el repositorio remoto Git y sus equipos en Jenkins
* adiciona el repositorio Git a sus equipos en Jenkins
* desencadena el primer pipeline