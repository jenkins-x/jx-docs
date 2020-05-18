---
title: Paquetes de Compilación
linktitle: Paquetes de Compilación
description: Convertir el código fuente en aplicaciones en Kubernetes
weight: 30
---

Usamos paquetes de compilación de estilo [draft](https://draft.sh/) para diferentes lenguajes, tiempos de ejecución y herramientas de compilación para agregar los archivos de configuración necesarios a los proyectos a medida que los [importamos](/docs/resources/guides/using-jx/creating/import/) o los [creamos](/docs/resources/guides/using-jx/common-tasks/create-spring/) para que podamos compilarlos e desplegarlos en Kubernetes.

Los paquetes de compilación se utilizan para predeterminar los siguientes archivos si aún no existen en el proyecto que se está creando/importando:

* `Dockerfile` para convertir el código en una imagen de docker para ejecutarla en Kubernetes
* `Jenkinsfile` para definir de forma declarativa el pipeline de Jenkins para definir los pasos CI/CD de la aplicación
* helm chart en la carpeta `charts` para generar los recursos de Kubernetes para ejecutar la apliación
* un _chart de vista previa_ en la carpeta `charts/preview` para definir las dependencias para el despliegue hacia el [entorno de vista previa](/es/about/concepts/features/#entornos-de-vista-previa) en una solicitud de extracción.

Los paquetes de compilación predeterminados están en [https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes) con una carpeta para cada lenguaje o herramienta de compilación.

La línea de comando `jx` clona los paquetes de compilación en la carpeta `.~/.jx/draft/packs/` y los actualiza a través del `git pull` cada vez que intenta crear o importar un proyecto.

## Modelo de extensión Pipeline

Como parte de la transición de [Jenkins hacia ser nativa de la nube](/docs/resources/guides/managing-jx/common-tasks/cloud-native-jenkins/), hemos reestructurado nuestros [paquetes de compilación](https://github.com/jenkins-x-buildpacks/) para que sean más modulares y más fáciles de componer y reutilizar en las cargas de trabajo.

Por ejemplo, el paquete de compilación [jenkins-x-kubernetes](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes) hereda del paquete de compilación [jenkins-x-classic](https://github.com/jenkins-x-buildpacks/jenkins-x-classic), reutilizando el CI y los pipelines de liberación, pero luego agregando las cargas de trabajo específicas de Kubernetes (por ejemplo, construyendo imágenes de docker, creando charts de helm, [vista previa de entornos](/es/about/concepts/features/#entornos-de-vista-previa) y [promoción a través de GitOps](/es/about/concepts/features/#promoción))

Para hacer esto, hemos introducido un nuevo formato de archivo YAML simple para definir pipelines.

## Pipelines

Cada fichero Pipeline YAML tiene un número de pipelines separados lógicamente:

* `release` para procesar las mezclas a la rama `master` que comúnmente crea una nueva versión y liberación, luego desencadena una promoción
* `pullRequest` para el procesamiento de las solicitudes de extracción (Pull Requests)
* `feature` para el procesamiento de las mezclas de las ramas de funcionalidades. Sin embargo, tenga en cuenta que el [libro accelerate](/about/accelerate/) no recomienda las ramas de funcionalidades a largo plazo. En su lugar, considere utilizar el desarrollo basado en troncales, que es una práctica de equipos de alto rendimiento.

## Ciclos de Vida

Luego, cada pipeline tiene una serie de fases distintas del ciclo de vida, algo así como Maven tiene `clean`,` compile`, `compile-test`,` package` etc.

Estas fases de ciclos de vida en Jenkins X Pipeline YAML son:

* `setup`
* `preBuild`
* `build`
* `postBuild`
* `promote`

## Extensible

Un Pipeline YAML puede extender otro archivo YAML. Puede hacer referencia a un pipeline base YAML a través de:

* usando `file` para hacer referencia a una ruta de archivo relativa en el mismo paquete de compilación [como este ejemplo usando `file`](https://github.com/jenkins-x-buildpacks/jenkins-x-classic/blob/f7027df958eb385d50fec0c0368e606a6d5eb9df/packs/maven/pipeline.yaml#L1-L2)
* usando `import` para hacer referencia a un archivo YAML que se importa como este [ejemplo usando import](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes/blob/45819e05fa197d9069af682fbbcad0af8d8d605a/packs/maven/pipeline.yaml#L2-L3) que luego se refiere a un [módulo importado nombrado a través de git](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes/blob/45819e05fa197d9069af682fbbcad0af8d8d605a/packs/imports.yaml#L2-L4)

## Anteponer pasos

Al igual que las clases en lenguajes como Java, puede anteponer los pasos en un Pipeline YAML desde un Pipeline YAML base. Esto le permite reutilizar los pasos en el ciclo de vida de un pipeline base y luego agregar sus propios pasos adicionales.

Por defecto, todos los pasos que defina se agregan después de los pasos YAML del pipeline base, [como en este ejemplo](https://github.com/jenkins-x/jx/blob/0520fe3d9740cbcb1cc9754e173fe7726219f58e/pkg/jx/cmd/test_data/step_buildpack_apply/inheritence/pipeline.yaml#L7).

Puede agregar pasos antes de los pasos del pipeline base utilizando la propiedad `preSteps:` c[omo este ejemplo](https://github.com/jenkins-x/jx/blob/0520fe3d9740cbcb1cc9754e173fe7726219f58e/pkg/jx/cmd/test_data/step_buildpack_apply/inheritence2/pipeline.yaml#L6).

Si desea reemplazar por completo todos los pasos de un pipeline base para un ciclo de vida particular, puede usar `replace: true` como [en este ejemplo](https://github.com/jenkins-x/jx/blob/0520fe3d9740cbcb1cc9754e173fe7726219f58e/pkg/jx/cmd/test_data/step_buildpack_apply/inheritence2/pipeline.yaml#L11-L14).

## Pipeline de ejemplo

Por ejemplo, para las bibliotecas maven, [usamos este archivo pipeline.yaml](https://github.com/jenkins-x-buildpacks/jenkins-x-classic/blob/f7027df958eb385d50fec0c0368e606a6d5eb9df/packs/maven/pipeline.yaml) que:

* [extiende](https://github.com/jenkins-x-buildpacks/jenkins-x-classic/blob/f7027df958eb385d50fec0c0368e606a6d5eb9df/packs/maven/pipeline.yaml#L1-L2) el [pipeline común](https://github.com/jenkins-x-buildpacks/jenkins-x-classic/blob/f7027df958eb385d50fec0c0368e606a6d5eb9df/packs/pipeline.yaml) que configura git y define pasos comunes de compilación posterior
* [configura el agente](https://github.com/jenkins-x-buildpacks/jenkins-x-classic/blob/f7027df958eb385d50fec0c0368e606a6d5eb9df/packs/maven/pipeline.yaml#L3-L5) en términos de [plantilla de pod](/docs/resources/guides/managing-jx/common-tasks/pod-templates/) y nombre del contenedor
* define los pasos para los [build steps](https://github.com/jenkins-x-buildpacks/jenkins-x-classic/blob/f7027df958eb385d50fec0c0368e606a6d5eb9df/packs/maven/pipeline.yaml#L7-L11) del pipeline del `pull request`
* define el [grupo de pasos de versión](https://github.com/jenkins-x-buildpacks/jenkins-x-classic/blob/f7027df958eb385d50fec0c0368e606a6d5eb9df/packs/maven/pipeline.yaml#L13-L18) del pipeline de liberación y los [pasos de compilación](https://github.com/jenkins-x-buildpacks/jenkins-x-classic/blob/f7027df958eb385d50fec0c0368e606a6d5eb9df/packs/maven/pipeline.yaml#L19-L21)

Luego, el [pipeline de maven kubernetes.yaml](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes/blob/45819e05fa197d9069af682fbbcad0af8d8d605a/packs/maven/pipeline.yaml) se [extiende](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes/blob/45819e05fa197d9069af682fbbcad0af8d8d605a/packs/maven/pipeline.yaml#L2-L3) desde el pipeline clásico para agregar los pasos kubernetes.

# Crear nuevos paquetes de compilación

Nos encantan las [contribuciones](/community/), así que considere agregar nuevos paquetes de compilación y [plantillas de pod](/docs/resources/guides/managing-jx/common-tasks/pod-templates/).

Aquí hay instrucciones sobre cómo crear un nuevo paquete de compilación. Por favor, si algo no está claro, [únase a la comunidad y solo pregunte](/community/), aquí estamos encantados de ayudar.

El mejor lugar para comenzar es una aplicación de _inicio rápido_. Un proyecto de muestra que puede usar como prueba. Así que cree/encuentre un proyecto de ejemplo adecuado y luego [impórtelo](/docs/resources/guides/using-jx/creating/import/).

Luego, agregue manualmente un `Dockerfile` y un `Jenkinsfile` si aún no ha agregado uno para usted. Puede comenzar con los archivos de las [carpetas del paquete de compilación actual](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes/tree/master/packs), utilizando el lenguaje/framework más similar al suyo.

Si su paquete de compilación está utilizando herramientas de compilación que aún no están disponibles en una de las [plantillas de pod](/es/docs/reference/components/pod-templates/) existentes, entonces deberá [enviar una nueva plantilla de pod](/es/docs/reference/components/pod-templates/#enviar-nuevas-plantillas-de-pod), probablemente también utilizando una nueva imagen del contenedor de compilación.

Una vez que tenga una plantilla de pod para usar, por ejemplo, `jenkins-foo`, consulte en su `Jenkinsfile`:

```groovy
// my declarative Jenkinsfile

pipeline {
    agent {
      label "jenkins-foo"
    }
    environment {
      ...
    }
    stages {
      stage('CI Build and push snapshot') {
        steps {
          container('foo') {
            sh "foo deploy"
          }
```
Una vez que su `Jenkinsfile` sea capaz de hacer CI/CD para su lenguage/tiempo de ejecución en su proyecto de muestra, entonces deberíamos poder tomar el `Dockerfile`, el `Jenkinsfile` y la carpeta de charts y copiarlos en una carpeta en su bifurcación del [jenkins-x/draft-packs repository](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes).

Puede probarlo localmente agregando estos archivos a su clon local del repositorio de paquetes de compilación en `~/.jx/draft/packs/github.com/jenkins-x/draft-packs/packs`.

p.ej.

```sh
export PACK="foo"
mkdir ~/.jx/draft/packs/github.com/jenkins-x/draft-packs/packs/$PACK
cp Dockerfile Jenkinsfile  ~/.jx/draft/packs/github.com/jenkins-x/draft-packs/packs/$PACK

# the charts will be in some folder charts/somefoo
cp -r charts/somefoo ~/.jx/draft/packs/github.com/jenkins-x/draft-packs/packs/$PACK/charts
```

Una vez que su paquete de compilación esté en una carpeta en `~/.jx/draft/packs/github.com/jenkins-x/draft-packs/packs/`, entonces debería ser utilizable por el comando [jx import](/commands/jx_import/) que utiliza la detección del lenguaje de programación para encontrar el paquete de compilación más adecuado para usar al importar un proyecto. Si su paquete de compilación requiere una lógica personalizada para detectarlo, avísenos y podemos ayudarlo agregando un parche en el comando [jx import](/commands/jx_import/) para que funcione mejor para su paquete de compilación. Por ejemplo, tenemos una lógica personalizada para [manejar mejor a Maven y Gradle](https://github.com/jenkins-x/jx/blob/712d9edf5e55aafaadfb3e0ac57692bb44634b1c/pkg/jx/cmd/common_buildpacks.go#L82:L108).

Si necesitas más ayuda [únete a la comunidad](/community/).