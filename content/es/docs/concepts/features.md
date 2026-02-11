---
title: Funcionalidades
linktitle: Funcionalidades
description: ¿Cómo Jenkins X puede ayudarte con las entregas continuas?
weight: 30
---

## Línea de Comando

Jenkins X viene con una útil y práctica herramienta de línea de comandos [jx](/commands/jx/) para:

* [instalar Jenkins X](/docs/getting-started/setup/install/) dentro de un clúster de Kubernetes existente
* [crear un nuevo cluster de Kubernetes](/docs/getting-started/setup/create-cluster/) e instalar Jenkins X dentro de él
* [cargar/importar proyectos](/docs/resources/guides/using-jx/creating/import/) dentro de Jenkins X junto a su flujos de configuración CI/CD
* [crea nuevas aplicaciones Spring Boot](/developing/create-spring/) las cuales son cargadas dentro de Jenkins X junto a sus flujos de configuración CI/CD

## Pipelines Automatizados

En lugar de tener que tener un conocimiento profundo de las partes internas de Jenkins Pipeline, Jenkins X configurará automáticamente pipelines (flujos de actividades) increíbles para que sus proyectos implementen completamente CI y CD utilizando las [mejores prácticas de DevOps](/about/concepts/)

## Entornos

Un _entorno_ es un lugar donde se despliegan las aplicaciones. Los desarrolladores a menudo hacen referencia a los entornos usando un nombre corto como `Testing, Staging/UAT or Production`.

Con Jenkins X cada _equipo_ tiene sus propios Entornos. De forma predeterminada, Jenkins X crea los entornos `Staging` y `Production` para cada equipo, pero puede crear nuevos entornos a través de [jx create environment](/commands/jx_create_environment/).

También está el entorno `Dev`, que es donde se instalan herramientas como Jenkins, Nexus o Prow y donde se ejecutan los pipelines de CI/CD.

Utilizamos GitOps para gestionar la configuración y la versión de los recursos de Kubernetes que se despliegan en cada entorno. Por lo tanto, cada Entorno tiene su propio repositorio Git que contiene todos los Helm Charts, sus versiones y la configuración para que las aplicaciones se ejecuten en el entorno.

Un Entorno se asigna a un espacio de nombres (namespace) en un clúster de Kubernetes. Cuando los PR son mezclados en el repositorio Git del entorno, se desencadena la ejecución de los pipelines para aplicar los cambias a través de los Helms Charts en el namespace del entorno.

Esto significa que tanto los desarrolladores como administradores pueden utilizar el mismo repositorio de Git para administrar todas las configuraciones y versiones de todas las aplicaciones y recursos para un entorno, por lo tanto, todos los cambios en el entorno se capturan en Git. De esta forma es fácil ver quién realizó los cambios y, lo que es más importante, es fácil revertir los cambios cuando sucedan cosas malas.

<img src="/images/gitops.png" class="img-thumbnail">

## Equipos

Un equipo en Jenkins X está representado por una instalación de Jenkins X en un namespace separado.

Puede instalar Jenkins X en diferentes namespaces en el mismo clúster si lo desea utilizando el argumento `--namespace` en la línea de comando [jx create cluster](/commands/jx_create_cluster/) o [jx install](/commands/deprecation/). Tenga en cuenta que para admitir múltiples instalaciones de Jenkins X en el mismo clúster, debe [evitar Tiller si está utilizando helm 2.x](/news/helm-without-tiller/).

También puede utilizar la CLI [jx create team](/commands/jx_create_team/) para crear un nuevo `Team` [Custom Resource](/docs/reference/components/custom-resources/). Al utilizar este comando el controlador de equipos creará, en segundo plano, una nueva instalación de Jenkins X en los namespaces del equipo, reutilizando de forma predeterminada el mismo nexus y registro de docker.

Lea la [guía de configuración](/docs/resources/guides/managing-jx/common-tasks/config/) para ampliar los detalles sobre cómo compartir recursos como Nexus entre equipos.

## Promoción

La promoción es implementada con GitOps generando una PR en el repositorio Git del entorno para que todos los cambios pasen por Git para su revisión, aprobación y para que cualquier cambio sea fácil de revertir.

Cuando un nuevo cambio dentro del repositorio Git del entorno se mezcla con la rama master, se activa el pipeline para el entorno, el cual aplica los cambio a los recursos a través de helm; siempre utilizando el código del repositorio Git como única fuente de información.

Los Pipelines para CD de Jenkins X automatizan la promoción de cambios de versión a través de cada Entorno que se configura con la propiedad _promotion strategy_ en `Auto`. De forma predeterminada, el entorno `Staging` utiliza la promoción automática y el entorno `Production` utiliza la promoción manual.

Para promover manualmente una versión de la aplicación hacia un entorno debes utilizar el comando [jx promote](/developing/promote/).

<img src="/images/overview.png" class="img-thumbnail">

## Entornos de Vista Previa

Jenkins X le permite activar Entornos de Vista Previa para los PR, de esta forma podrá obtener rápida retroalimentación antes de mezclar los cambios en la rama master. Además de una rápida retroalimentación, esta funcionalidad le permite evitar la aprobación humana dentro de su pipeline de liberación para acelerar las entregas de cambios mezclados a master.

Cuando el Entorno de Vista Previa esté en funcionamiento, Jenkins X comentará su PR con un enlace para que, con un solo clic, los miembros de su equipo puedan probar la vista previa.

<img src="/images/pr-comment.png" class="img-thumbnail">


## Retroalimentación

Como puede ver arriba, Jenkins X agrega comentarios automáticamente en los PR cuando utilizar Entornos de Vista Previa.

Si los comentarios del commit hacen referencia a los problemas (issues, p.ej. con el texto `fixes #123`), los pipelines de Jenkins X generarán notas de la versión como las mostradas en los [jx releases](https://github.com/jenkins-x/jx/releases).

Además, a medida que la versión (conjunto de nuevos commits) sea promovida en `Staging` o `Production`, recibirá comentarios automáticos sobre cada problema solucionado diciendo que el problema solucionado se encuentra disponible para su revisión en el correspondiente entorno. p.ej.

<img src="/images/issue-comment.png" class="img-thumbnail">

## Aplicaciones

Una colección de las mejores herramientas de software empaquetadas con charts de helm vienen pre-integradas con Jenkins X, tales como: Nexus, ChartMuseum, Monocular, Prometheus, Grafana, etc.

### Complementos

Algunas de estas aplicaciones están ajustadas; como: Nexus, ChartMuseum, Monocular. Otros se proporcionan como un `Addon`.

Para instalar un complemento utilice el comando [jx create addon](/commands/jx_create_addon/). p.ej.

```sh
jx create addon grafana
```