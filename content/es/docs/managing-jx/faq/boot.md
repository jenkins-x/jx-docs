---
title: Preguntas sobre Boot
linktitle: Preguntas sobre Boot
description: Preguntas sobre cómo utilizar 'jx boot'
weight: 20
---

Para ampliar los detalles vea cómo utilizar [jx boot](/es/docs/getting-started/setup/boot/).

## ¿Cómo actualizo boot?

Si está utilizando [jx boot](/es/docs/getting-started/setup/boot/) puede habilitar las [actualizaciones automáticas](/es/docs/getting-started/setup/boot/#actualizaciones-automáticas) o puedes [hacerlas manualmente](/es/docs/getting-started/setup/boot/#actualizaciones-manuales).

Si en algún momento algo va mal (p.ej, se borra el clúster, el namespace o Tekton), siempre puede volver a ejecutar [jx boot](/es/docs/getting-started/setup/boot/) en su laptop para restaurar el clúster.

## ¿Cómo adiciono más recursos?

Adicione recursos (p.ej, `Ingress, ConfigMap, Secret`) a su entorno de desarrollo en como ficheros YAML al directorio boot `env/templates`.

## ¿Cómo adiciono un nuevo Entorno?

Agregue un nuevo recurso `SourceRepository` y `Environment` a la carpeta `env/templates` para cada nuevo entorno que desee crear. Actualmente solo hemos agregado `dev, staging, production`.

Desde su clúster en ejecución, siempre puede tomar el recurso `SourceRepository` and `Environment` a través de lo siguiente (donde XXX es el nombre del repositorio de Staging devuelto a través de `kubectl get sr`):

```sh
$ kubectl get env staging -oyaml > env/templates/myenv.yaml
$ kubectl get sr XXX -oyaml > env/templates/myenv-sr.yaml
```

luego modifique el YAML para adaptarlo, cambiando los nombres de los recursos para evitar chocar con su repositorio de Staging.

## ¿Cómo administrar los recursos SourceRepository?

Vea cómo actualizar su [configuración boot con los últimos recursos SourceRepository](/es/docs/getting-started/setup/boot/how-it-works/#repositorio-de-origen).

## ¿Cómo enlazo SourceRepository a un Scheduler personalizado?

Debe asignar su `SourceRepository` a un `Scheduler` especificando `--scheduler` cuando utilice los comandos `jx create quickstart / jx import` en su repositorio o modifique el `spec.scheduler.name` de `SourceRepository` del CRD en su repositorio Git de desarrollo o especificando un programador predeterminado diferente en el `dev environment.spec.teamSettings.defaultScheduler.name` luego la próxima vez que se genere la configuración de prow (en el comando `jx create quickstart / jx import / jx boot` actualizará la configuración de prow para usar su programador.

Consulte también [¿Cómo agrego múltiples pipelines paralelas a un proyecto?](/docs/resources/guides/using-jx/faq/chatops/#how-do-i-add-multiple-parallel-pipelines-to-a-project)

## ¿Cómo adiciono charts en Jekins X?

Dependerá de en cuál namespaces desea instalar el chart.

Si está en el entorno de desarrollo (el namespace `jx` por defecto), entonces `env/requirements.yaml` es donde agregar el chart y para un chart `foo` puede agregar `env/foo/values.yaml` para configurarlo. (o `env/foo/values.tmpl.yaml` si desea utilizar algunas [plantillas](/docs/getting-started/setup/boot/how-it-works/#improvements-to-values-yaml) con ficheros `values.yaml`).

Sin embargo, si desea que nuestro chart esté en otro namespace, entonces usamos la convención de agregar una carpeta en el directorio `system`, en la configuración boot (por ejemplo, como lo hacemos para las entradas, administrador de certificados, velero, malla de servicio, etc.). Entonces, cree una nueva carpeta `system`  y agregue el paso `jx step helm apply` en el pipeline en `jenkins-x.yml` como lo hacemos para `cert-manager`, `nginx`, `velero`, etc.

## ¿Cómo desactivo el controlador de Entrada?

Si ya tiene su propio controlador de Entrada y no desea que `jx boot` instale otro, simplemente puede eliminar el paso `install-nginx-controller` en el repositorio Git de su entorno de desarrollo. p.ej. [elimine este paso](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/jenkins-x.yml#L85-L99) del fichero `jenkins-x.yml` en el repositorio Git de su entorno de desarrollo.