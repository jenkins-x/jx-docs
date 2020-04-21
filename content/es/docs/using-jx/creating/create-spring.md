---
title: Crear Spring Boot
linktitle: Crear Spring Boot
description: ¿Cómo crear una aplicación Spring Boot e importarla en Jenkins X?
weight: 40
---

Los desarrolladores de microservicios de Java pueden aprovechar los recursos recomendados de [Spring
Boot](https://spring.io/projects/spring-boot), así como sus componentes pre-configurados. Este framework toma la plataforma Spring y agrega componentes pre-establecidos, bibliotecas de terceros, empaquetadores de software y herramientas de línea de comandos para ejecutar scripts especializados.

El objetivo de Spring Boot es crear software basado en Spring, como microservicios, que se puede desplegar utilizando la línea de comando `java` o los ficheros de empaquetado *Web Application Resource* (WAR). Spring Boot usa Spring como base para el desarrollo, y lo mejora con componentes que proporcionan un desarrollo y despliegues más rápidos, así como configuración para comenzar a desarrollar microservicios, y un marco de plugin con soporte para funcionalidades de los proyectos Maven y Gradle.

## Spring Boot y Jenkins X

Puede incorporar Jenkins X en su proyecto Spring Boot de dos formas:

1.  Importando un proyecto existente de Spring BootBy utilizando `jx import`

2.  Creando una aplicación Spring Boot desde cero utilizando `jx create spring`

## Importando un proyecto existente de Spring Boot

Si usted tiene un proyecto en Spring Boot (tal vez creado utilizando [Spring Boot Initializr](http://start.spring.io/)) y desea gestionar sus construcciones con Jenkins X, utilice el comando `jx import` para:

* incluir tu código en un servidor Git como puede ser GitHub
* adicionar el fichero `Dockerfile` para construir la imagen Docker
* adicionar el fichero `pipeline.yaml` al directorio local `~/.jx/` para gestionar el pipeline del desarrollo
* adicionar el chart de Helm para ejecutar la aplicación en Kubernetes

Los pasos para lograr este objetivo son:

1. Vaya al directorio de su proyecto Spring Boot:

```sh
cd my-springapp/
```

1.  Ejecute el comando import desde la línea de comando:

```sh
jx import
```

3.  La aplicación le pregunta su nombre de usuario Git (p.ej `myuser`).

4.  La aplicación le pregunta si desea inicializar su proyecto en Git.

5.  La aplicaicón le pregunta qué organización utilizar para las construcciones (p.ej, `myorg`).

6.  La aplicación le pregunta qué nombre ponerle al repositorio remoto en Git (p.ej `my-springapp`)

Ahora puede realizar compilaciones, adicionar código del proyecto en su repositorio Git recién creado, y Jenkins X procesará automáticamente los PR y creará [vistas previas](/docs/reference/preview/) de sus aplicaciones para pruebas y validación.

## Creando una aplicación Spring Boot

Si está evaluando Spring Boot para su entorno Jenkins X y necesita una aplicación de ejemplo con estas características, así como su configuración de pipelines CI/CD con promociones GitOps, utilice `jx create` para lograr su objetivo.

Los pasos para lograrlo son los siguientes:

1. Ejecute siguiente comando para crear la aplicación Spring Boot:

```sh
jx create spring
```

1. La aplicación le preguntará por su usuario en Git (p.ej `myuser`)

2. La aplicación le permitirá seleccionar la organización que desee utilizar

3. La aplicación le preguntará por el nombre del repositorio, (p.ej `my-springapp1`)

4. La aplicación le preguntará por el lenguaje de programación que va a utilizar (por defecto `java`)

5. La aplicación le preguntará por el ID del grupo (por defecto, `com.example`)

6. La aplicación le preguntará por alguna entrada o dependencia que desee utilizar durante el desarrollo de la aplicación.
   Le recomendamos que como mínimo utilice las dependencias `Acurator` y `Web`, las cuales pueden ser seleccionadas utilizando la `Barra de Espacio`.

7. La aplicación le mostrará para inicializar el repositorio Git.

Esta es una [demostración utilizando el comando jx create spring](/docs/resources/demos-talks-posts/create_spring/).

También puede adicionar algunas opciones al comado `jx create` como por ejemplo, especificar las dependencias:

```sh
jx create spring -d web -d actuator
```

El argumento `-d` le permite especificar las dependencias de Spring Boot que desea agregar a su aplicación. En el ejemplo anterior, el comando llama al argumento `web`, que pasa en la dependencia de Web Starter para crear aplicaciones web RESTful; la dependencia del `acurator` para monitorear el estado y las métricas de su aplicación. Cuando omite los argumentos `-d`, el comando `jx` le preguntará que elija las dependencias a través de un asistente de CLI.

Recomendamos que siempre incluya la dependencia **actuator** en sus aplicaciones Spring Boot, ya que ayuda a proporcionar comprobaciones de [Liveness and Readiness probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/).

## Proyectos Spring Boot gestionados por Jenkins X

Los dos métodos para configurar proyectos Spring Boot en Jenkins X realizan varias acciones:

- Crea una nueva aplicación Spring Boot en un subdirectorio local
- Adiciona el código fuente a un repositorio Git
- Crea un repositorio Git remoto en plataformas como [GitHub](https://github.com)
- Agrega el código al repositorio Git remoto
- Agrega los siguientes ficheros al proyecto:
  - Un `Dockerfile` para construir la imagen de Docker del proyecto
  - Un `pipeline.yaml` para implementar el pipeline CI/CD
  - Un chart de Helm para ejecutar la aplicacion en Kubernetes
- Registra un enlace (p.ej `http://hook-jx.192.169.1.100.nip.io/hook`) en el repositorio Git remoto
- Inicia el primer pipeline de construcción

Ahora puede usar su subdirectorio de proyecto local habilitado para Git para realizar cambios en su aplicación Spring Boot, enviar esos cambios a Git y hacer que Jenkins X construya automáticamente, cree [vistas previas](/docs/reference/preview/) para pruebas y validación, y [promueva](/developing/promote/) su aplicación a producción para uso general.