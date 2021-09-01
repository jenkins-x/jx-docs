---
title: Promoción y Entornos
linktitle: Promoción y Entornos
description: Promueva las nuevas versiones de su aplicación hacia los entornos
weight: 4
---

Los Pipelines de Entrega Continua de Jenkins X automatizan la [promoción](/es/about/concepts/features/#promoción) de cambio de versiones a través de cada [Entorno](/es/about/concepts/features/#entornos). Cada Entorno se encuentra configurado con la propiedad _estrategia de promoción_ en `Auto`. La configuración pre-establecida para los entornos es:

* El entorno `Staging` utiliza promoción automática
* El entorno `Production` utiliza promoción `Manual`

Para realizar una Promoción manual de tu aplicación hacia un entorno específico debes utilizar el comando [jx promote](/commands/jx_promote/).

```sh
jx promote --app myapp --version 1.2.3 --env production
```

El comando espera hasta que se complete la promoción registrando los detalles del progreso. Puedes especificar el tiempo de espera antes de que se realice la promoción a través del argumento `--timeout`.

p.ej. para esperar 5 horas.

```sh
jx promote  --app myapp --version 1.2.3 --env production --timeout 5h
```

Puedes utilizar varias expresiones de tiempo para especidicar el timpo de espera como `20m` o `10h30m`.

<img src="/images/overview.png" class="img-thumbnail">

## Retroalimentación

Si el mensaje presente en el commit hace referencia a un problema (p.ej. a través del texto `fixes #123`), entonces el pipeline de Jenkins X va a generar notas de liberación como el siguiente [ejemplo de jx](https://github.com/jenkins-x/jx/releases).

Cuando la versión que incluye estos commits se promueva a `Staging` o `Production`, recibirá comentarios automáticos sobre cada problema solucionado con la siguiente información:

* el problema ahora está disponible para su revisión en el entorno correspondiente
* un enlace a las notas de la versión
* un enlace a la aplicación en ejecución en ese ambiente

p.ej.

<img src="/images/issue-comment.png" class="img-thumbnail">

## Promoviendo aplicaciones externas

Puede que existan aplicaciones que estén actualmente liberadas por otros equipos u organizaciones y que tal vez no utilicen Jenkins X ni estén en su repositorio de plantillas Helm.

Si desea buscar en sus repositorios de helm una aplicación para promocionar, puede usar la opción `-f` de filtro para encontrar la plantilla a utilizar en la promoción.

p.ej. para encontrar y promover la plantilla helm de `redis` hacia `Staging` debe utilizar el siguiente comando:

```sh
jx promote -f redis --env staging
```

Para las bases de datos seguramente vas a desear utilizar un alias (`--alias`). El alias será el nombre de la plantilla helm para darle un nombre lógico acorde al tipo de base de datos que necesites. Si necesitas múltiples bases de datos en el mismo entorno para distintos microservicios el `--alias` será quien pueda ayudarte. p.ej.

```sh
jx promote -f postgres --alias salesdb --env staging
```

Si no puedes encontrar una aplicación en particular necesitarás adicionar el correspondiente repositorio de charts a su instalación de helm a través de:

```sh
helm repo add myrepo https://something.acme.com/charts/
```

p.ej. para adicionar las plantillas estables de la comunidad helm.

```sh
helm repo add stable https://kubernetes-charts.storage.googleapis.com/
"stable" has been added to your repositories
```

para adicionar las plantillas de incubación de la comunidad helm.

```sh
helm repo add incubator https://kubernetes-charts-incubator.storage.googleapis.com/
"incubator" has been added to your repositories
```

Actualmente existe un [gran número de plantillas creadas por la comunidad helm](https://github.com/helm/charts/tree/master/stable). Si deseas adicionar tu aplicación desarrollada fuera de Jenkins X solo tienes que empaquetar tus ficheros YAML en una plantilla helm e instalarla en un repositorio de plantillas.
