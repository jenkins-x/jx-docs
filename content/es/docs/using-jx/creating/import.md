---
title: Importar
linktitle: Importar
description: ¿Cómo importar un proyecto existente en Jenkins X?
weight: 70
---

Si ya tiene algún código fuente que desea importar a Jenkins X, puede usar el comando [jx import](/commands/jx_import/). p.ej.

```sh
cd my-cool-app
jx import
```

Al utilizar el comando [jx import](/commands/jx_import/) se realizarán las siguientes acciones (se le indicará en el camino):

* adiciona su código en un repositorio Git si no existe actualmente
* crea un repositorio Git remoto en plataformas como [GitHub](https://github.com)
* empuja su código al repositorio Git remoto
* adiciona ficheros necesarios a su código si no existen, fichero como:
  * `Dockerfile` para construir la imagen Docker de su aplicación
  * `Jenkinsfile` para implementar el pipeline CI/CD
  * chart de Helm para ejecutar la aplicación dentro de Kubernetes
  * registra un enlace (webhook) entre el repositorio Git remoto y sus equipos de Jenkins
* adiciona el repositorio Git a sus equipos de Jenkins
* desencadena el primer pipeline

### Evitando docker + helm

Si estás importando un repositorio que no crea una imagen Docker puede utilizar el parámetro `--no-draft` en la línea de comando para indicarle que no utilice Draft. De esta forma no serán creados los ficheros `Dockerfile` y el chart de Helm.

### Importando a través de la URL

Si desea importar un proyecto que ya está en un repositorio git remoto, puede usar el parámetro `--url`:

```sh
jx import --url https://github.com/jenkins-x/spring-boot-web-example.git
```

### Importar proyectos de GitHub

Si desea importar proyectos desde una organización de GitHub puede utilizar:

```sh
jx import --github --org myname
```

El sistema le preguntará por el repositorio que desea importar. Utilice las flechas y la barra de espacio para seleccionar/desmarcar repositorios:

Si desea que estén marcados todos los repositorios a la hora de importarlos utilice `--all`, luego puede desmarcar el que desee:

```sh
jx import --github --org myname --all
```

Para filtrar el listado puede adicionar el parámetro `--filter`

```sh
jx import --github --org myname --all --filter foo
```

## Patrones de Ramas

Al importar proyectos en Jenkins X, usamos patrones de rama Git para determinar qué nombres de rama se configuran automáticamente para CI/CD.

Por lo general, eso puede ser predeterminado a algo como `master|PR-.*|feature.*`. Eso significa que la rama `master`, cualquier rama que comience con `PR-` o `feature` se escaneará para buscar el fichero `Jenkinsfile` para configurar los pipelines CI/CD.

Si usa otro nombre de rama que no sea `master`, como `develop` o lo que sea, puede cambiar este patrón para que sea lo que quiera a través del parámetro `--branches` siempre que ejecute [jx import](/commands/jx_import/), [jx create spring](/commands/jx_create_spring/) o [jx create quickstart](/commands/jx_create_quickstart/).

```sh
jx import --branches "develop|PR-.*|feature.*"
```

Puede desear establecer simplemento `.*` para trabajar con todas las ramas.

```sh
jx import --branches ".*"
```

## Configurar los patrones de ramas de tu equipos

Por lo general, un equipo usa las mismas convenciones de nomenclatura para las ramas, por lo que es posible que desee configurar los patrones de las ramas a nivel de equipo para que se usen de forma predeterminada si alguien en su equipo ejecuta [jx import](/commands/jx_import/), [jx create spring](/commands/jx_create_spring/) o [jx create quickstart](/commands/jx_create_quickstart/).

Estas configuraciones se almacenan en el recurso [Environment Custom Resource](/docs/reference/components/custom-resources/) en Kubernetes.

Para establecer los patrones de ramas para su equipo, utilice el comando [jx edit branchpattern](/commands/jx_edit_branchpattern/).

```sh
jx edit branchpattern  "develop|PR-.*|feature.*"
```

Luego puede ver los patrones de rama actuales para su equipo a través del comando [jx get branchpattern](/commands/jx_get_branchpattern/):

```sh
jx get branchpattern
```
