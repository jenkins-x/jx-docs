---
title: Pipelines en Jenkins X
linktitle: Pipelines en Jenkins X
description: Flujo de actividades sin servidor (serverless) pensadas para la nube
keywords: [tekton]
weight: 40
---

Hemos [anunciado recientemente](/news/jenkins-x-next-gen-pipeline-engine/) la incorporación de los **Pipelines en Jenkins X**. Estos Pipelines son ejecuciones sin servidor basados en el motor de [Tekton Pipelines](https://tekton.dev/).

Tekton es un proyecto open source diseñado como solución moderna nativa de la nube para ejecutar pipelines.

El trabajo aquí todavía es experimental, pero nos encantaría recibir comentarios y ayuda de la comunidad para impulsarlo.

## Probar los Pipelines de Jenkins X

En este momento, para habilitar una instalación basada en Tekton, puede crear un nuevo clúster usando `jx` junto con estos indicadores:

```sh
jx create cluster gke --tekton
```

O bien, si desea participar en la próxima generación de Jenkins X con GitOps incorporado para su entorno de desarrollo, utilizando Tekton y Vault para el almacenamiento de Secretos, utilice el siguiente comando (solo funciona en GCP y AWS en este momento):

```sh
jx create cluster gke --ng
```

La experiencia general del desarrollador, los complementos CLI e IDE deberían funcionar como antes, ¡pero utilizando los Recursos Personalizados de [Tekton Pipelines](https://tekton.dev/) como maquinaria en lugar de crear un servidor Jenkins por equipo!

## Utilizando un Inicio Rápido

Una vez que se inicia su clúster, puede crear un nuevo inicio rápido, hemos estado usando el NodeJS de manera confiable.

```sh
jx create quickstart
```

Se crea un `prowjob` (trabajo/ejecución de prow), un nuevo controlador pipelines prow vigila estos trabajos y cuando recibe un evento verificará si tiene una especificación `pipelinerun` presente, si no, publicará el `prowjob` en un nuevo servicio `pipelinerunner` de Jenkins X que a su vez clona el repositorio que luego traducen a su `jenkins-x.yml` en recursos comunes de Tekton Pipeline. Una vez que se crean, el controlador `tekton-pipeline-controller` ejecuta las construcciones.

## Diferencias con los Pipelines de Jenkins

El Pipeline en Jenkins X utiliza un nuevo archivo `jenkins-x.yml` que es YAML en lugar del fichero Groovy `Jenkinsfile` utilizado por Jenkins.

Sin embargo, todavía se están reutilizando los mismos paquetes de construcción reutilizables y de composición por detrás del telón. (Los paquetes de construcción de Jenkins X - [build packs](/docs/create-project/build-packs/) - en realidad están escritos en YAML en los Pipelines de Jenkins X).

Una cosa que notará es que con los Pipelines de Jenkins X no necesitamos copiar/pegar un gran archivo `Jenkinsfile` en el repositorio Git de cada aplicación; por lo general, el archivo `jenkins-x.yml` generado es pequeño, como este:

```yaml
buildPack: maven
```

¡Eso es! Lo que eso significa básicamente es que, en tiempo de ejecución, el Pipeline de Jenkins X utilizará los paquetes de construcción - [build packs](/docs/create-project/build-packs/) - para generar el Pipeline de Tekton.

## Personalizar el Pipelines

Tener paquetes de compilación - [build packs](/docs/create-project/build-packs/) - automatizados para hacer todo su CI+CD es bastante impresionante, ya que la mayoría de las veces sus microservicios se compilarán, probarán, empaquetarán, lanzarán y promocionarán de la misma manera. ¡CI+CD es a menudo un trabajo pesado indiferenciado que deberíamos automatizar!

Sin embargo, hay veces que desea [personalizar un pipeline](/docs/create-project/build-packs/#pipelines) en particular (liberación, PR, característica, etc.) o modificar pasos involucrados dentro del [ciclo de vida](/docs/first-projects/build-packs/#life-cycles).

Puede leer más sobre el [modelo de extensión](/docs/create-project/build-packs/#pipeline-extension-model) para descubrir todo lo que puede hacer. Básicamente, puede agregar pasos antes/después de cualquier ciclo de vida o reemplazar completamente un conjunto de ciclos de vida o incluso optar por salir del paquete de compilación por completo e alinear sus pipelines dentro de su `jenkins-x.yml`.

Para una forma rápida de agregar un nuevo paso en el ciclo de vida de su pipeline, utilice el comando [jx create step](/commands/deprecation/):

<figure>
<img src="/images/architecture/create-step.gif" />
<figcaption>
<h5>Crea un nuevo paso en su Pipeline de Jenkins X a través del CLI</h5>
</figcaption>
</figure>

También puede agregar o anular una variable de entorno en su pipeline a través del comando [jx create variable](/commands/jx_create_variable/).

## Modificaciones en VS Code

Si está utilizando [VS Code](https://code.visualstudio.com/), le recomendamos que instale la [extensión de lenguaje YAML](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml) de Red Hat.

Esta extensión le permite editar archivos YAML con validación de esquema JSON de forma opcional.

El esquema JSON de Jenkins X ya está registrado en [schemastore.org](http://schemastore.org/json/), por lo tanto, editar su archivo `jenkins-x.yml` en VS Code incluirá la finalización inteligente y la validación.

<figure>
<embed src="/images/architecture/yaml-edit.mp4" autostart="false" height="400" width="600" />
<figcaption>
<h5>Editar el Pipeline de Jenkins X en VS Code</h5>
</figcaption>
</figure>

Nos encantaría mejorar esta experiencia de usuario, por si te [apetece ayudar](/docs/contributing/).

## Modificaciones en IDEA

Esto ya debería estar incluido de fábrica debido a que el esquema JSON de Jenkins X está registrado en [schemastore.org](http://schemastore.org/json/), por lo que editar su archivo `jenkins-x.yml` en IDEA incluirá la finalización inteligente y la validación.

Nos encantaría mejorar esta experiencia de usuario, por si te [gustaría ayudar](/docs/contributing/).

## Variables de entorno predeterminadas

Las siguientes variables de entorno están disponibles para su uso en los pasos del Pipeline de Jenkins X:

| Nombre | Descripción |
| --- | --- |
| DOCKER_REGISTRY | el servidor de registro de docker (p.ej. `docker.io` o `gcr.io`) |
| BUILD_NUMBER | el número de construcción (1, 2, 3) comienza en `1` para cada repo y rama |
| PIPELINE_KIND | el tipo de pipeline p.ej `release` o `pullrequest` |
| PIPELINE_CONTEXT | el contexto del pipeline si existen múltiples pipelines por PR (para diferenciar tests/governance/lint etc) |
| REPO_OWNER | el dueño del repositorio Git |
| REPO_NAME | el nombre del repositorio Git |
| JOB_NAME | el nombre de la tarea que normalmente tiene este aspecto `$REPO_OWNER/$REPO_NAME/$BRANCH_NAME` |
| APP_NAME | el nombre de la applicación que normalmente es `$REPO_NAME`
| BRANCH_NAME | el nombre de la rama p.ej `master` o `PR-123` |
| JX_BATCH_MODE | indica a jx que utilice bash si el valor es `true` |
| VERSION | contiene el número de versión que ha sido liberada o la versión de la vista previa del PR |
| BUILD_ID | igual que `$BUILD_NUMBER`
| JOB_TYPE | la tipo de tarea de prow p.ej `presubmit` para el PR o `postsubmit` para la liberación |
| PULL_BASE_REF | la rama/referencia en Git |
| PULL_BASE_SHA | el SHA en Git que ha sido construido |
| PULL_NUMBER | para los PRs este será el número sin el prefijo `PR-`
| PULL_REFS | para combinar por lotes todas las referencias de Git |

