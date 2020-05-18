---
title: Version Stream
linktitle: Version Stream
description: ¿Cómo mejoramos la estabilidad de Jenkins X y sus Aplicaciones?
weight: 60
---

Jenkins X está compuesto por una gran cantidad de línea de comandos empaquetados, imágenes de docker y charts de helm, algunos de los cuales son lanzados por la comunidad Jenkins X y otros provienen del ecosistema de código abierto más amplio.

Para mejorar la estabilidad de Jenkins X cuando muchos paquetes y charts están cambiando todo el tiempo, hemos introducido el Flujo de versiones de Jenkins X, `Version Stream`.

<figure>
<img src="/images/jx-version-stream-v1.png"/>
<figcaption>
<h5>El diagrama muestra cómo se propagará una nueva versión JX a través de los componentes.</h5>
</figcaption>
</figure>

## ¿Cómo funciona?

El flujo de versiones (`Version Stream`) se almacena en el repositorio Git [jenkins-x/jenkins-x-versions](https://github.com/jenkins-x/jenkins-x-versions) y almacena la versión estable de todos los paquetes y charts utilizados por Jenkins X.

Cuando ejecuta un comando, como por ejemplo [crear un clúster](/es/docs/getting-started/setup/create-cluster/), [instalar en un clúster existente](/docs/resources/guides/managing-jx/common-tasks/install-on-cluster/) o ejecutar el comando [jx upgrade](/commands/jx_upgrade/), el comando `jx` se asegurará de que tenga un clon local del repositorio Git [jenkins-x/jenkins-x-versions](https://github.com/jenkins-x/jenkins-x-versions) actualizado. Después de clonado el repositorio Jenkins X se descarga la versión estable de los charts y paquetes descritos en el, o registrará una advertencia si la versión no lo es.

La versión [jx](https://github.com/jenkins-x/jx) por ahora se publica como una [versión preliminar](https://help.github.com/en/articles/creating-releases). Cada versión de jx se actualiza solamente cuando una nueva versión llega con éxito al repositorio jenkins-x-versions. Cada nueva versión es sometida a rondas de pruebas BDD (_consulte el diagrama anterior para obtener más información_) antes de ser marcadas como listas para liberar.

## ¿Cómo actualizamos el Flujo de Versiones?

Utilizamos GitOps y CI/CD para administrar el Flujo de Versiones (`Version Stream`).

A medida que se lanzan nuevos paquetes o charts, generamos PR en el repositorio git [jenkins-x/jenkins-x-versions](https://github.com/jenkins-x/jenkins-x-versions). Luego activamos nuestras [pruebas BDD](https://github.com/jenkins-x/bdd-jx) a través de [jx step bdd](/commands/jx_step_bdd/) y verificamos que la nueva versión del chart/paquete funcione antes de mezclar los cambios. Actualmente activamos manualmente las pruebas de BDD a través del comentario `/test this`, pero esperamos pasar a la activación periódica de las pruebas de BDD (por ejemplo, una vez al día).

Las personas que aprueban los PR también pueden optar por ejecutar sus propias pruebas manuales en las PR si lo desean.

Al completar con éxito todas las pruebas BDD ejecutadas en el PR, mezclará el cambio y ejecutará una actualización de todas las dependencias jx (homebrew-jx, jx-docs, jx-tutorial y dev-env-base).

## Creando Pull Requests (PR)

Tenemos un simple comando CLI [jx step create pullrequest versions](/commands/jx_step_create_pullrequest_versions/) que se puede utilizar para generar automáticamente solicitudes de extracción (PR) en el repositorio git [jenkins-x/jenkins-x-versions](https://github.com/jenkins-x/jenkins-x-versions).

Si eres el responsable de un chart de entrada que utiliza Jenkins X, sería increíble agregar este comando al final de su pipeline de liberación para generar un PR y que de esa forma podamos actualizar Jenkins X para utilizar su nueva versión (después que las pruebas BDD hayan pasado correctamente):

```sh
jx step create pullrequest versions -n mychartName -v 1.2.3
```

donde mychartName es el nombre de gráfico completo que utiliza el prefijo de repositorio remoto. p.ej. jenkins-x / prow es el nombre del gráfico de proa mantenido en el repositorio de gráficos jenkins-x.

donde `mychartName` es el nombre completo del chart donde se incluye el prefijo para el repositorio remoto. p.ej `jenkins-x/prow` sería `prow` el nombre del chart que se le da manteminiento y `jenkins-x` el repositorio del chart.

### Actualizaciones Periódicas

No siempre es fácil/posible actualizar los pipelines de entrada para impulsar los cambios de versión a Jenkins X a través de los PRs. Por lo tanto, puede configurar tareas periódicas para buscar actualizaciones de versión para todos los charts o para charts que coincidan con una expresión regular.

p.ej para actualizar las versiones de todos los charts incluidos en `jenkins-x` utilice el siguiente comando:

```sh
jx step create version pr -f "jenkins-x/*"
```

## Ejecutar los tests BDD

Desde un clon de Git master o un PR, puede ejecutar las pruebas BDD contra la combinación de la versión del PR utilizando el comando [jx step bdd](/commands/jx_step_bdd/) y especificando `--dir .` para el directorio del clon.

p.ej. puede ejecutar las pruebas BDD usted mismo a través de ...

```sh
git clone https://github.com/jenkins-x/jenkins-x-versions.git

# env vars for the git / jenkins secrets
export GIT_PROVIDER=github
export GIT_PROVIDER_URL=https://github.com
export BUILD_NUMBER=10
export JENKINS_CREDS_PSW=mypassword
export GIT_CREDS_PSW=XXXXXXX
export GIT_USER=YYYYY

jx step bdd --dir . --config jx/bdd/staticjenkins.yaml --gopath /tmp --git-provider=$GIT_PROVIDER --git-provider-url=$GIT_PROVIDER_URL --git-username $GIT_USER --git-owner $GIT_USER --git-api-token $GIT_CREDS_PSW --default-admin-password $JENKINS_CREDS_PSW --no-delete-app --no-delete-repo --tests test-create-spring
```

Los diversos archivos YAML en la carpeta [jx/bdd](https://github.com/jenkins-x/jenkins-x-versions/tree/master/jx/bdd) contienen una selección de diferentes grupos configuraciones que se pueden utilizar.