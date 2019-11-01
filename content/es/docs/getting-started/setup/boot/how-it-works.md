---
title: ¿Cómo funciona?
linktitle: ¿Cómo funciona?
description: Instalar, configurar o actualizar Jenkins X a través de GitOps y Jenkins X Pipeline
weight: 100
---

## Repositorio de Origen

Boot configura automáticamente todos los elementos de tipo [SourceRepository](/docs/reference/components/custom-resources/#sourcerepository) que existan en la carpeta [repositories/templates](https://github.com/jenkins-x/jenkins-x-boot-config/tree/master/repositories/templates). De igual agrega todo los elementos de tipo [Scheduler](/docs/reference/components/custom-resources/#scheduler) para reconstruir la configuración de Prow.

De igual forma, Boot crea y actualiza automáticamente los webhooks que se necesiten en el proveedor de git para los recursos [SourceRepository](/docs/reference/components/custom-resources/#sourcerepository).

Si está utilizando GitOps, esperamos automatizar la gestión de la carpeta [repositories/templates](https://github.com/jenkins-x/jenkins-x-boot-config/tree/master/repositories/templates) a medida que se importa/crea proyectos. Hasta entonces, puede crear manualmente un Pull Request en su repositorio git de boot a través de [jx step create pullrequest repositories](/commands/jx_step_create_pullrequest_repositories/).

## Pipeline

El proceso de instalación/actualización está definido en un [Jenkins X Pipeline](/docs/concepts/jenkins-x-pipelines/) en el fichero con nombre [jenkins-x.yml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/jenkins-x.yml).

Lo típico es que no tenga que modificar este fichero, pero si necesitas hacerlo revisa primero [esta guía](/docs/concepts/jenkins-x-pipelines/#customising-the-pipelines).

## Configuración

El proceso boot se configura utilizando el estilo de configuración de Helm basado en ficheros `values.yaml`. Aunque también admitimos el uso de algunas [extensiones para helm](https://github.com/jenkins-x/jx/issues/4328).

### Fichero de Parámetros

Se ha definido el fichero [env/parameters.yaml](https://github.com/jenkins-x/environment-tekton-weasel-dev/blob/master/env/parameters.yaml) para establecer todos los parámetros registrados y cargados desde Vault o desde el directorio de archivos local con información sensible.

#### Inserción de secrets en los parámetros

Si observan en el fichero [env/parameters.yaml](https://github.com/jenkins-x/environment-tekton-weasel-dev/blob/master/env/parameters.yaml) podrán ver algunos valores en el propio fichero y otros relacionados con un enlace, por ejemplo `local:my-cluster-folder/nameofSecret/key`. Las definiciones con enlace permiten 2 esquemas:

* `vault:` para obtener valores desde Vault (ubicación + llave).
* `local:` para obtener valores desde el fichero almacenado en `~/.jx/localSecrets/$path.yml` (llave solamente).

Esto significa que se pueden almacenar todos los Parámetros utilizados en la configuración inicial para luego hacer referencia a ellos desde la fichero `values.tmpl.yaml` y poblar el árbol de valores a insertar luego en Vault.

### Poblar el fichero `parameters.yaml`

Se puede poblar o nutrir el fichero `env/parameters.yaml` del Pipeline a través del comando:

```sh
jx step create values --name parameters
```

Se utiliza el fichero [parameters.schema.json](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/env/parameters.tmpl.schema.json) para nutrir el UI.

### Mejoras al fichero values.yaml

#### Mantenimiento del árbol de ficheros values.yaml

En lugar de tener solo un fichero enorme values.yaml con todas las anidaciones posibles, se puede tener una estructura de arbórea de archivos para cada aplicación que solo incluya la configuración específica en cada carpeta. p.ej.

```sh
env/
  values.yaml   # nivel máximo de configuración
  prow/
    values.yaml # configuraciones específicas de Prow
  tekton/
    values.yaml  # configuraciones específicas de Tekton
```

#### Plantillas values.tmpl.yaml

Al utilizar `jx step helm apply` permitimos que los archivos `values.tmpl.yaml` utilicen las plantillas go/helm en la misma forma que los archivos `templates/foo.yaml` son utilizados dentro de las plantillas helm. De esta forma se pueden generar cadenas de valor/dato que utilicen plantillas para estructurar cosas como valores de secrets más pequeños. p.ej. crear un fichero maven `settings.xml`  o un fichero docker `config.json` que incluye muchos usuarios/contraseñas para diferentes registros.

Podemos ver en el fichero `values.tmpl.yaml` cómo están todos los elementos estructurados y podremos referencia a ellos como valore de secrets a través de URLs (o funciones de plantillas) para acceder a Vault o al almacenamiento local.

Para hacer esto se utiliza la expresión `{{ .Parameter.pipelineUser.token }}` en algún lugar del archivo `values.tmpl.yaml`. Entonces se podrá insertar valores dentro de la plantillas helm; pero esto sucede primero para ayudar a generar el fichero `values.yaml`.
