---
title: Plantillas Pod
linktitle: Plantillas Pod
description: Pods utilizados para implementar pipelines de Jenkins
weight: 160
---

Implementamos pipelines CI/CD utilizando pipelines declarativos de Jenkins a través del fichero `Jenkinsfile` en el código de cada aplicación o entorno de repositorio git.

Utilizamos [plugins de Kubernetes](https://github.com/jenkinsci/kubernetes-plugin) para que Jenkins pueda activar nuevos pods en Kubernetes para cada construcción, lo que nos da un grupo elástico de agentes para ejecutar tuberías gracias a Kubernetes.

El complemento Kubernetes utiliza plantillas (_pod templates_) para definir el pod utilizado para ejecutar un pipeline de CI/CD que consiste en:

* uno o más contenedores de compilación para ejecutar comandos dentro (p.ej, sus herramientas de compilación como `mvn` o `npm` junto con las herramientas que utilizamos para otras partes del pipeline como `git, jx, helm, kubectl`, etc.)
* volúmenes para persistencia
* Variables de entorno
* secretos para que el pipeline pueda escribir en repositorios git, registros de docker, repositorios maven/npm /helm, etc

## Refiriéndose a Plantillas de Pod

Jenkins X viene con un conjunto predeterminado de plantillas de pod para los lenguajes y tiempos de ejecución admitidos en nuestros paquetes de compilación y se denominan algo así como: `jenkins-$PACKNAME`.

Por ejemplo, el [paquete de compilación de Maven](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes/blob/master/packs/maven/) utiliza la plantilla de pod `jenkins-maven`.

Luego podemos referirnos al nombre de la [plantilla de pod en el fichero Jenkinsfile](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes/blob/master/packs/maven/Jenkinsfile#L1-L4) usando la sintaxis del agente `agent { label "jenkins-$PACKNAME" }` en el pipeline declarativo. p.ej.

```groovy
// my declarative Jenkinsfile

pipeline {
    agent {
      label "jenkins-maven"
    }
    environment {
      ...
    }
    stages {
      stage('CI Build and push snapshot') {
        steps {
          container('maven') {
            sh "mvn deploy"
          }
          ...
```

## Enviar nuevas Plantillas de Pod

Si está trabajando en un nuevo [paquete de compilación](/architecture/build-packs/), nos encantaría que [envíe](/docs/contributing/) una nueva plantilla de pod y podemos incluirla en la distribución Jenkins X!

Ahora sigue las instrucciones sobre cómo hacer esto. Por favor, si algo no está claro, ven [únete a la comunidad y pregunta](/community/) ¡estaremos encantados de ayudarte!

Para enviar un nuevo paquete de compilación:

* bifurcar el repositorio [jenkins-x-platform](https://github.com/jenkins-x/jenkins-x-platform/)
* agregue su paquete de compilación al [archivo values.yaml en el repositorio jenkins-x-platform](https://github.com/jenkins-x/jenkins-x-platform/blob/master/jenkins-x-platform/values.yaml) en la sección `jenkins.Agent.PodTemplates` de YAML
* es posible que desee comenzar copiando/pegando la plantilla de pod existente más similar (por ejemplo, copie `Maven` si está trabajando en un pod de compilación basado en Java) y simplemente configure el nombre, la etiqueta y la imagen, etc.
* ahora envíe una solicitud de extracción en el repositorio [jenkins-x-platform](https://github.com/jenkins-x/jenkins-x-platform/) para su plantilla de pod

### Construir contenedores

Al usar plantillas de pod y pipeliens de Jenkins, puede usar muchos contenedores diferentes para cada herramienta. p.ej. un contenedor para `maven` y otro para `git`, etc.

Hemos encontrado que es mucho más simple tener un solo contenedor de constructor con todas las herramientas comunes en su interior. Esto también significa que puede usar `kubectl exec` o (/commands/jx_rsh) para abrir un shell dentro del pod de compilación y tener todas las herramientas que necesita disponibles para depurar/diagnosticar pipelines con problemas.

Por lo tanto, tenemos una imagen de docker base ([builder-base](https://github.com/jenkins-x/builder-base)) en el generador que contiene [todas las diferentes herramientas](https://github.com/jenkins-x/jenkins-x-builders-base/blob/master/Dockerfile.common#L4-L15) que tendemos a utilizar en los pipelines de CI/CD como `jx, skaffold, helm, git, updatebot`.

Si desea usar una sola imagen de generador para su nueva plantilla de pod, puede usar la base de generador y luego agregar sus herramientas personalizadas en la parte superior.

p.ej. [builder-maven](https://github.com/jenkins-x/jenkins-x-builders/tree/master/builder-maven) utiliza un [Dockerfile](https://github.com/jenkins-x/jenkins-x-builders/blob/master/builder-maven/Dockerfile#L1) para hacer referencia al constructor base.

Entonces, lo más simple podría ser copiar un constructor similar, como [builder-maven](https://github.com/jenkins-x/jenkins-x-builders/tree/master/builder-maven) y luego editar el `Dockerfile` para agregar las herramientas de compilación que necesite.

Nos encantan las solicitudes de extracción y las [contribuciones](/docs/contributing/), así que envíe solicitudes de extracción para nuevos contenedores de compilación y plantillas de pods, ¡y estamos más que felices de [ayudar](/docs/contributing/)!

## Agregar sus propias Plantillas de Pod

Para mantener las cosas Limpias y simples, tendemos a definir plantillas de pod en la configuración de Jenkins y luego nos referimos al nombre en el `Jenkinsfile`.

Hay intentos de facilitar la inserción de definiciones de plantillas de pod dentro de su `Jenkinsfile` si lo necesita; aunque una plantilla de pod tiende a tener muchas cosas específicas del entorno de desarrollador dentro, como secretos, por lo que preferiríamos mantener la mayoría de las plantillas de pod dentro del código fuente de su entorno de desarrollo en lugar de copiarlas/pegarlas en cada aplicación.

Hoy, la forma más fácil de agregar nuevas plantillas de pod es a través de la consola Jenkins. p.ej.

```sh
jx console
```

Eso abrirá la consola de Jenkins. Luego navegue a `Manage Jenkins` (en el menú de la izquierda) y luego a `Configure System`.

Ahora se enfrentará a una gran página de opciones de configuración ;) Las plantillas de pod generalmente están en la parte inferior; debería ver todas las plantillas de pod actuales para cosas como maven, NodeJS, etc.

Puede editar/agregar/eliminar plantillas de pod en esa página y presionar Guardar.

Sin embargo, tenga en cuenta que a largo plazo esperamos [mantener su entorno de desarrollo a través de GitOps, como lo hacemos para Staging y Production](https://github.com/jenkins-x/jx/issues/604), lo que significa que los cambios realizados a través de la interfaz de usuario de Jenkins se perderán al [actualizar su entorno de desarrollo](/commands/deprecation/).

A largo plazo, esperamos agregar las plantillas de pod en su archivo `values.yaml` en el repositorio git de su entorno de desarrollador como lo hacemos para el [chart jenkins-x-platform](https://github.com/jenkins-x/jenkins-x-platform/blob/master/values.yaml#L194-L431).

Si está creando plantillas de pod utilizando herramientas de compilación de código abierto, puede ser más sencillo [enviar su plantilla de pod en una solicitud de extracción](#enviar-nuevas-plantillas-de-pod) y podemos agregar esa plantilla de pod en futuras versiones de Jenkins X.
