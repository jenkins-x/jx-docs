---
title: Preguntas sobre ChatOps
linktitle: Preguntas sobre ChatOps
description: Preguntas sobre el uso de ChatOps en Jenkins X
weight: 20
---

## ¿Qué es ChatOps?

Usamos la frase _ChatOps_ para referirnos a los cambios en el código operativo y la promoción de GitOps a través del chat. Más específicamente, esto generalmente se hace comentando los Pull Requests en el sitio web de su proveedor de Git; aunque en el futuro esto podría ser a través de Slack o consolas web también.

## ¿Cuáles son los beneficios de ChatOps?

ChatOps ayuda a los desarrolladores a colaborar en los PR y acelera la mezcla de los PR. Queremos poder mezclar los cambios lo más rápido posible en la rama master para que podamos integrar continuamente el código y minimizar las desventajas de las ramas a largo plazo.

ChatOps (y [tide en particular](#qué-hace-hook)) también ayuda a automatizar y acelerar las tareas, p.ej.

* los desarrolladores no tienen que seguir presionando recargar en una página de PR esperando que se pasen todas las pruebas para que puedan hacer clic en `Merge`. Simplemente agregue un comentario `/lgtm` o apruebe la revisión del código y el PR se fusionará automáticamente una vez que sus pruebas se vuelvan verdes. ¡Esto también evita que los desarrolladores presionen accidentalmente el botón `Merge` antes de que pasen todas las pruebas!
* todas los PR se vuelven a clasificar automáticamente y se prueban contra la rama master antes de mezclarsse, lo que garantiza que no rompamos la rama master accidentalmente
* la mezcla por lotes de los PR es compatible para acelerar la mezcla de los PRs.

Para ampliar los detalles vea [qué es lo que tide hace](#qué-hace-hook)

## ¿Qué tipos de webhook admiten ChatOps?

[Prow](/docs/reference/components/prow/) y [Lighthouse](/architecture/lighthouse/) admiten webhooks y ChatOps, mientras que Jenkins solo admite webhooks.

## ¿Cómo vuelvo a activar un PR de un pipeline?

Si un pipeline falla debido a algún error de compilación o falla en la prueba, corrija el código y envíe sus cambios y el pipeline del PR se volverá a ejecutar.

Si cree que el pipeline falló debido a alguna razón de infraestructura temporal, puede usar ChatOps para reactivar el pipeline comentando el PR:

* `/retest` vuelve a ejecutar solamente los pipelines fallidos.
* `/test all` vuelve a a ejecutar todos los pipelines fallidos.
* `/test foo` vuelve a ejecutar todos los pipelines con nombre `foo`.

Tenga en cuenta que debe estar en el archivo `OWNERS` como [aprobador para que esto funcione](#por-qué-un-pull-request-no-tiene-un-pipeline-activado).

## ¿Cómo agrego múltiples pipelines paralelos a un proyecto?

Puede ser útil tener varios pipelines para realizar diferentes tipos de pruebas de ejecución prolongada en PR. p.ej. ejecutar el mismo conjunto de pruebas utilizando diferentes bases de datos, configuraciones de microservicios o infraestructura subyacente.

En Jenkins X puede crear un recurso personalizado `Scheduler` en su configuración [jx boot](/es/docs/getting-started/setup/boot/), en el fichero `env/templates/myscheduler.yaml`, que puede agregar múltiples contextos con nombre en la sección `presubmits`. Luego, para cada nombre de contexto, asegúrese de tener un fichero llamado `jenkins-x-${context}.yml` en su proyecto.

Entonces Jenkins X invocará cada contexto a pedido a través de `/test mycontext` o automáticamente si habilita `alwaysRun: true`.

Puede ver cómo definimos muchos [contextos de prueba paralelas en la secuencia de versiones aquí](https://github.com/jenkins-x/environment-tekton-weasel-dev/blob/f377a72498282de9ee49b807b4d5ba74321a4fab/env/templates/jx-versions-scheduler.yaml#L18), que todos se ejecutan en paralelo e informan su estado en cada PR en la [secuencia de versiones](/es/about/concepts/version-stream/)

Consulte también [¿Cómo asigno SourceRepository a un Scheduler personalizado?](/docs/resources/faq/boot/#how-do-i-map-sourcerepository-to-a-custom-scheduler)

## ¿Qué hace hook?

`hook` es el nombre del microservicio en [Prow](/docs/reference/components/prow/) y el enlace http en [Lighthouse](/architecture/lighthouse/) que escucha los webhooks provenientes de su proveedor Git que luego se procesa como un comando ChatOps o como un disparador de un pipeline.

## ¿Qué hace tide?

`tide` es un microservicio en [Prow](/docs/reference/components/prow/) and [Lighthouse](/architecture/lighthouse/) que periódicamente consulta los Pull Request abiertos en los repositorios que ha importado a Jenkins X. Luego realiza la siguiente lógica:

* si un PR ha pasado todas sus pruebas de revisión + CI (p.ej, ha aplicado las etiquetas `approved` y/o `lgtm` o ha pasado una revisión del código github) y es verde y se basa en la rama master, se mezcla automáticamente.
* si un PR ha pasado todas sus pruebas de revisión + CI pero no se basa en la rama master, sus pipelines se vuelven a activar en función de la rama master para garantizar que el PR sea válido si se mezclara.
* si el procesamiento por lotes está habilitado y hay varias PRs pendientes que están aprobadas y en verde, se activa un pipeline de lote que mezcla múltiples PRs en un solo cambio: si todas esos pipelines se vuelven verdes, todas las PRs se mezclan a la vez y se cierran . Esto acelera enormemente las mezclas de múltiples PRs (ya que evita volver a activar las pruebas de cada RP después de fusionar cada una).

## ¿Cómo puedo hacer ChatOps HA?

Para hacer que ChatOps sea altamente accesible, amplíe los despliegues que escuchan las solicitudes http hasta, por ejemplo, 3 réplicas.

Cuando se utiliza [Lighthouse](/architecture/lighthouse/) significa modificar las réplicas para el despliegue de `lighthouse`. p.ej. en su repositorio git [boot](/es/docs/getting-started/setup/boot/) intente cambiar el fichero `env/lighthouse/values.tmpl.yaml` a:

```yaml
replicaCount: 3
```

Cuando utilice [Prow](/es/docs/reference/components/prow/), debe escalar los servicios `hook` y `pipelinerunner`. p.ej. en su repositorio Git boot intente cambiar el fichero `env/prow/values.tmpl.yaml` a:

```yaml
hook:
  replicaCount: 3
pipelinerunner:
  replicaCount: 3
```

## ¿Debo usar prow o lighthouse?

Si está utilizando un servidor Git que no sea https://github.com, le recomendamos [Lighthouse](/architecture/lighthouse/).

Si está utilizando https://github.com recomendamos por ahora [Prow](/docs/reference/components/prow/), ya que ha tenido más pruebas que [Lighthouse](/architecture/lighthouse/).

Aunque [Lighthouse](/architecture/lighthouse/) es nuestra dirección estratégica. Estamos comenzando a mover gradualmente nuestros repositorios de código abierto a [Lighthouse](/architecture/lighthouse/). En algún momento en el futuro, una vez que hayamos estado usando [Lighthouse](/architecture/lighthouse/) en producción para todos nuestros repositorios de código abierto y comerciales, [Lighthouse](/architecture/lighthouse/) se convertirá en nuestra solución recomendada para todos los proveedores Git para que podamos tener una base de código única, más simple y más pequeña para mantener.

## ¿Cómo manejar un pipeline dañado?

Si tiene un PR pendiente que está bloqueado debido a que alguna de las pruebas falla; puede usar ChatOps para anular su estado a través del comando ChatOps: `/override nameOfPipeline`

## ¿Por qué un Pull Request no tiene un pipeline activado?

[Prow](/docs/reference/components/prow/) y [Lighthouse](/architecture/lighthouse/) usan un archivo `OWNERS` almacenado en cada repositorio Git para definir qué desarrolladores pueden revisar y aprobar cambios. Incluso puede limitar esos roles a diferentes carpetas.

Si un no revisor envía una PR, no activará los pipelines de CI de forma predeterminada hasta que un revisor agregue un comentario `/ok-to-test` en el PR.

Si tiene repositorios públicos de Git, esto también evita el problema de seguridad de un no aprobador que envía una PR para cambiar el pipeline para enviarles por correo electrónico sus credenciales de seguridad en al pipeline CI ;)