---
title: Recursos Personalizados
linktitle: Recursos Personalizados
description: Recursos Personalizados definidos para Jenkins X
parent: "components"
weight: 10
aliases:
  - /docs/managing-jx/common-tasks/custom-resources
---

Kubernetes proporciona un mecanismo de extensión llamado [Recursos Personalizados](https://kubernetes.io/docs/concepts/api-extension/custom-resources/) que permite que los microservicios extiendan la plataforma Kubernetes para resolver problemas de orden superior.

Entonces, en Jenkins X, hemos agregado una serie de Recursos Personalizados para ayudar a ampliar Kubernetes para admitir CI/CD.

También puede [navegar por la Referencia de API de Recursos Personalizados](/apidocs/).

## Environments

Jenkins X admite de forma nativa los [entornos](/es/docs/concepts/features/#entornos) que le permiten ser definidos para su equipo y luego consultarlos a través de [jx get environments](/commands/jx_get_environments).

```sh
jx get environments
```

Durante el funcionamiento de ese comando se utiliza el recurso personalizado de Kubernetes `Environments`.

Por lo tanto, también puede consultar los entornos a través de [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/):

```sh
kubectl get environments
```

O editarlos vía `YAML` directamente si lo desea:

```sh
kubectl edit env staging
```

aunque puede preferir el comando [jx edit environment](/commands/jx_edit_environment), que es más fácil.

## Release

Los pipelines de Jenkins X generan el recurso personalizado `Release` que podemos utilizar para realizar un seguimiento de:

* qué versión, etiqueta Git y URL Git se asignan a una versión en Kubernetes/Helm
* qué URL y registro pipeline de Jenkins se usaron para realizar el lanzamiento
* qué compromisos, problemas y PR formaron parte de cada lanzamiento para que podamos implementar los [comentarios a medida que los problemas se solucionan en Staging/Production](/es/docs/concepts/features/#retroalimentación)

## SourceRepository

Esto almacena información sobre los repositorios de código fuente que Jenkins X está configurado para construir.

Es creado por `jx import` y `jx create quickstart` y se elimina cada vez que se invoca una `jx delete application`.

## Scheduler

Esto se utiliza para definir una configuración para uno o más `SourceRepository` y `jx boot` lo usa para generar la configuración de Prow.

Esto le permite configurar un `Scheduler` predeterminado para un equipo y luego no tiene que tocar su configuración de Prow en absoluto; Todos los proyectos importados/creados heredarán del `Scheduler` predeterminado.

O cuando realiza `jx import` o `jx create quickstart` puede pasar el parámetro de línea de comando `--scheduler` para usar un programador específico.

## PipelineActivity

Este recurso almacena el estado del pipeline en términos de etapas de pipelines de Jenkins, más la [actividad de promoción](/es/docs/concepts/features/#promoción).

Este recurso también lo utiliza el comando [jx get activities](/commands/jx_get_activities).

## Team

El recurso personalizado `Team` se crea mediante el comando [jx create team](/commands/jx_create_team/) y el controlador `team controller` lo utiliza para observar los nuevos recursos `Team` para luego crear una instalación de Jenkins X en el namespace del `teams`. Para obtener más información sobre los equipos, consulte [la función del equipo](/es/docs/concepts/features/#equipos).

### User

El recurso personalizado `User` se utiliza para admitir RBAC en los distintos [entornos](/es/docs/concepts/features/#entornos) y [vistas previas de entornos](/about/features/#preview-environments) en equipos.

También lo utilizan el comando [jx edit userroles](/commands/jx_edit_userroles/) para cambiar los roles de usuario.

## EnvironmentRoleBinding

El recurso `EnvironmentRoleBinding` es como el recurso estándar de Kubernetes [RoleBinding](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#rolebinding-v1-rbac-authorization-k8s-io), pero permite la asignación de un rol a múltiples [entornos](/es/docs/concepts/features/#entornos) y [vistas previas de entornos](/about/features/#preview-environments) en un equipo mediante el uso de un selector de entornos en el que se vinculan roles.

Esto facilita la vinculación de un `Role` a todos los entornos, a todos los entornos de vista previa o a ambos o a un conjunto determinado de usuarios.