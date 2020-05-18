---
title: Crear un inicio rápido
linktitle: Crear un inicio rápido
description: ¿Cómo crear e importar una nueva aplicación de forma rápida en Jenkins?
weight: 10
---

Los inicios rápidos son aplicaciones prefabricadas desde las que puede iniciar un proyecto, en lugar de comenzar desde cero.

Puedes crear nuevas aplicaciones desde nuestra lista de aplicaciones de inicio rápido seleccionadas a través del comando [jx create quickstart](/commands/jx_create_quickstart/).


```sh
jx create quickstart
```

Luego se le solicita una lista de aplicaciones de inicio rápido para elegir.

Si conoces el lenguaje que deseas utilizar podrás utilizarlo para filtrar el listado de aplicaciones de inicio rápido, por ejemplo:

```sh
jx create quickstart -l go
```

O utilizar el texto `filter` para filtrar por el nombre del proyecto:

```sh
jx create quickstart -f http
```

### ¿Qué ocurre cuando creas una aplicación de inicio rápido?

Una vez seleccionado el proyecto a crear y le definas un nombre, se realizarán los siguientes pasos de forma automática:

* se crea una nueva aplicación desde el inicio rápido en un sub-directorio
* se adiciona el código fuente al repositorio de git local
* se crea un repositorio git remoto en el servicio de git, como por ejemplo [GitHub](https://github.com)
* se empuja tu código local al servicio de git remoto
* se adicionan los ficheros:
  * `Dockerfile` para construir la aplicación como una imagen de docker
  * `Jenkinsfile` para implementar el flujo de CI / CD
  * Plantilla Helm para ejecutar la aplicación dentro de Kubernetes
* si está usando Jenkins X Pipelines y tekton entonces:
  * se registra un detonador (webhook) en el repositorio remoto git para desencadenar / activar un flujo de tareas (pipeline) en tekton a través de prow / lighthouse.
  * se adiciona el repositorio a la configuración de prow / lighthose
* si estás utilizando Jenkins Server entonces:
  * se registra un detonador en el repositorio remoto git para desencadenar / activar un flujo de tareas en Jenkins
  * se crea un proyecto multi-branch en el servidor Jenkins
* se provoca (trigger) el primer flujo de tareas (pipeline)

### ¿Cómo funcionan los inicios rápido?

El código de estas aplicaciones de inicio rápido se encuentra en la [organización jenkins-quickstarts en GitHub](https://github.com/jenkins-x-quickstarts).

Cuando creas el inicio rápido se utiliza el [paquete de construcción de Jenkins X](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes) para identificar la configuración que necesita del proyecto. Durante la identificación se tiene en cuenta los diferentes lenguajes existentes en el proyecto y se selecciona el paquete más adecuado.

Cuando utilizas [jx create](/docs/getting-started/setup/create-cluster/), [jx install](/docs/resources/guides/managing-jx/common-tasks/install-on-cluster/) o [jx init](/commands/deprecation/) el [paquete de construcción de Jenkins X](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes) es clonado ha la carpeta local `~/.jx/draft/packs`.

Dependiendo del tipo de instalación de Jenkins X (Serverless Jenkins vs Static Master Jenkins), puedes ver todos los lenguajes disponibles en los paquetes de construcción si listas los elementos de la siguiente ubicación de tu máquina:

*Serverless Jenkins*:
```sh
ls -al ~/.jx/draft/packs/github.com/jenkins-x-buildpacks/jenkins-x-kubernetes/packs
```

*Static Master Jenkins*:
```sh
ls -al ~/.jx/draft/packs/github.com/jenkins-x-buildpacks/jenkins-x-classic/packs
```

Entonces, cuando creas un proyecto de inicio rápido, ya sea a través de [jx create spring](/docs/resources/guides/using-jx/common-tasks/create-spring/) o [jx import](/docs/resources/guides/using-jx/creating/import/), el [constructor de paquetes de Jenkins X](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes) realiza lo siguiente:

* selecciona el paquete correcto basado en el lenguaje del código ([listado de posibles paquetes](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes/tree/master/packs)).
* el paquete seleccionado es utilizado para incluir los siguientes fichero en caso de que no existan:
  * `Dockerfile` para crear la imagen de docker para la aplicación
  * `Jenkinsfile` para implementar el flujo de tareas CI / CD utilizando la declaración de tareas como código (declarative pipeline as code)
  * Plantillas Helm para desplegar la aplicación en Kubernetes e implementar la [Vista Previa de Entornos](/es/about/concepts/features/#entornos-de-vista-previa)

## Agregar tu propio Inicio rápido

Si desea enviar un nuevo inicio rápido a Jenkins X, [simplemente plantee el problema](https://github.com/jenkins-x/jx/issues/new?labels=quickstart&title=Add%20quickstart&body=Please%20add%20this%20github%20quickstart:) con la URL en GitHub de su inicio rápido y podremos bifurcarlo (fork) en la [organización de inicio rápido](https://github.com/jenkins-x-quickstarts) para que aparezca en el menú de inicio rápido `jx create`.

Otra forma puede ser si forma parte de un proyecto de código abierto y desea crear tu propio grupo de inicios rápidos para su proyecto; puede [plantear el problema](https://github.com/jenkins-x/jx/issues/new?labels=quickstart&title=Add%20quickstart&body=Please%20add%20this%20github%20quickstart:) dándonos detalles de la organización en GitHub donde están los inicios rápidos y los agregaremos a la  organización para que aparezcan en el comando [jx create quickstart](/commands/jx_create_quickstart/). Es más fácil para el [jx create quickstart](/commands/jx_create_quickstart/) si se mantienen los inicios rápidos separados por organizaciones en GitHub.

Una vez incluidos, podrá utilizar sus propios inicios rápidos en el comando `jx create quickstart` mediante el parámetro de comando `-g` o `--organisations`. Por ejemplo:

```sh
jx create quickstart  -l go --organisations my-github-org
```

Entonces todos los inicios rápidos que se encuentren en `my-github-org` serán listados adicionalmente a los existentes en la organización Jenkins X.

## Personalizar los grupos de inicio rápido

Puedes configurar a nivel de grupos las aplicaciones de inicio rápido que desees que se muestren con el comando `jx create quickstart`. Esta configuración se encuentra guardada en un [Environment Custom Resource](/docs/reference/components/custom-resources/) en Kubernetes.

Para adicionar una nueva ubicación de aplicaciones de inicio rápido puedes utilizar el comando [jx create quickstartlocation](/commands/jx_create_quickstartlocation/).

```sh
jx create quickstartlocation --url https://mygit.server.com --owner my-quickstarts
```

Si omites el parámetro `--url` el comando va a asumir como repositorios a [GitHub](https://github.com/). Ten en cuenta que está permitido incluir tanto repositorios privados como públicos.

Esto significa que puedes tener tu repositorio privado para inicios rápidos en tu organización. Nosotros recomendamos lógicamente que [los nuevos inicios rápidos sean compartidos como proyectos open source](https://github.com/jenkins-x/jx/issues/new?labels=quickstart&title=Add%20quickstart&body=Please%20add%20this%20github%20quickstart:) para que puedan ser incluidos y compartidos con toda [la comunidad](/community/) - pero puede darse el caso que desees tener un repositorio propio privado para utilizarlo con proyectos propietarios.

Puedes además especificar `--includes` o excluir `--excludes` patrones para filtrar por nombres de repositorios donde `*` incluye a todos los elementos y `foo*` selecciona todos aquellos que empiezen con `foo`. Por ejemplo, puedes solamente incluir los lenguajes y tecnologías de tu organización necesite y el resto excluirlos.

Te interesará saber que puedes utilizar el alias `gsloc` en vez de `quickstartlocation` si te gustan más lo alias cortos ;)

Puedes entonces ver la ubicación actual de tus aplicaciones de inicio rápido de tu equipo utilizando el comando [jx get quickstartlocations](/commands/jx_get_quickstartlocation/)

```sh
jx get quickstartlocations
```

O con su alias corto

```sh
jx get qsloc
```

Existe el comando [jx delete quickstartlocation](/commands/jx_delete_quickstartlocation/) por si necesitas eliminar la ubicación del repositorio git.

