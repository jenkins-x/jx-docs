---
title: Preguntas sobre Pipelines
linktitle: Preguntas sobre Pipelines
description: Preguntas sobre cómo utilizar Pipelines Serverless en Jenkins X
weight: 10
---

Para obtener más información, consulte la guía sobre los [Pipelines Serverless Jenkins X](/es/docs/concepts/jenkins-x-pipelines/) con [Tekton](https://tekton.dev/). También está la referencia de [sintaxis de Pipelines en Jenkins X](/docs/reference/pipeline-syntax-reference/).

## ¿Cómo agrego un paso personalizado?

Para agregar un nuevo paso personalizado a su fichero `jenkins-x.yml`, vea [cómo utilizar jx create step](/es/docs/concepts/jenkins-x-pipelines/#personalizar-el-pipelines).

## ¿Cómo modifico un paso?

Si hay un paso con nombre en el pipeline que desea modificar, puede agregar las líneas YAML a su fichero `jenkins-x.yml` de la siguiente manera:

En este caso, vamos a reemplazar el paso llamado `helm-release` en el pipeline `release`

```
pipelineConfig:
  pipelines:
    overrides:
      - pipeline: release
        name: helm-release
        step:
          image: busybox
          sh: echo "this command is replaced"
```

Puede ver el efecto de este cambio localmente antes de enviarlo a Git mediante el comando [jx step syntax effective](/commands/jx_step_syntax_effective/):

```
$ jx step syntax effective -s
```

Puede anular etapas enteras o reemplazar un paso específico con un solo paso o una secuencia de pasos. También puede agregar pasos antes/después de otro paso.

Para obtener más detalles, consulte [cómo modificar los pasos](/architecture/pipeline-syntax-reference/#specifying-and-overriding-release-pull-request-and-feature-pipelines).

## ¿Cómo puedo modificar la imagen predeterminada del contenedor?

Como puede ver arriba, puede modificar cualquier paso en cualquier paquete de compilación; pero también puede modificar la imagen del contenedor utilizada de forma predeterminada en todos los pasos agregando este YAML a su `jenkins-x.yml`:

```
pipelineConfig:
  agent:
    label: jenkins-go
    container: somerepo/my-container-image:1.2.3
```

Puede ver el efecto de este cambio localmente antes de enviarlo a Git mediante el comando [jx step syntax effective](/commands/jx_step_syntax_effective/):

```
$ jx step syntax effective -s
```

Para obtener más detalles, consulte [cómo modificar los pasos](/architecture/pipeline-syntax-reference/#specifying-and-overriding-release-pull-request-and-feature-pipelines).

## ¿Cómo se comparan los pipelines de Jenkins X con los pipelines de Jenkins?

Vea las [diferencias entre los Pipelines de ambos sistemas: Jenkins X y Jenkins](/es/docs/concepts/jenkins-x-pipelines/#diferencias-con-los-pipelines-de-jenkins).

## ¿Cómo obtengo el completamiento de IDE editando `jenkins-x.yml`?

Vea la guía de IDE para [IDEA](/es/docs/concepts/jenkins-x-pipelines/#modificaciones-en-idea) y [VS Code](/es/docs/concepts/jenkins-x-pipelines/#modificaciones-en-vs-code).

## ¿Qué variables de entorno están disponibles por defecto dentro de un pipeline?

Vea las [variables de entorno preestablecidas creadas para los pasos de los pipelines](/es/docs/concepts/jenkins-x-pipelines/#variables-de-entorno-predeterminadas).

## ¿Hay alguna referencia para la sintaxis?

Vea la [sintaxis de referencia para los Pipelines de Jenkins x](/es/docs/reference/pipeline-syntax-reference/).

## ¿Cómo se monta un Secret o ConfigMap?

Cada paso del pipeline de Jenkins X en el fichero `jenkins-x.yml` es básicamente un [contenedor](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.15/#container-v1-core) de Kubernetes para que pueda especificar la imagen, los límites de recursos, las variables de entorno y montar `ConfigMap` o `Secret`.

Puede ver un ejemplo de [cómo montar un Secret en una variable de entorno aquí](/docs/reference/pipeline-syntax-reference/#full-pipeline-definition-in-jenkins-x-yml).

Si está dentro de un script de shell, también puede usar el comando [jx step credential](/commands/jx_step_credential/).

## ¿Puedo montar un volumen persistente en mi pipeline?

Tekton ya monta un Persistent Volumen separado para cada pod construido en `/workspace`, por lo que los resultados de la compilación se mantienen durante un tiempo hasta que se recolecta la basura.

En la mayoría de los clústeres de Kubernetes, no puede compartir fácilmente un solo volumen persistente en varios pods; Por lo tanto, tener un PV compartido en varias compilaciones generalmente no es fácil ni compatible. Sin embargo, puede agregar un paso para llenar su PV al inicio desde un bucket de la nube y al final de un pipeline copiar datos en un bucket para acelerar el almacenamiento en caché.

También puede hacer cosas como utilizar Nexus como caché de red para obtener dependencias de Maven (que ocurre OOTB con las compilaciones de Maven en Jenkins X) o agregar el proxy Athens para Go.

Esperemos que la comunidad de Tekton encuentre algunas soluciones de almacenamiento en caché aún mejores para acelerar las compilaciones.

## ¿Cómo defino una variable de entorno dentro de un paso para otros pasos?

Los archivos son el enfoque más fácil ya que el directorio `/workspace` se comparte con todos los pasos. Entonces escriba en un paso y use el valor de otros pasos, etc.

La otra opción es montar un `ConfigMap` como variables de entorno en cada paso y modificarlo en un paso; pero los archivos son realmente más fáciles.