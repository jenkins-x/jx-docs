---
title: Lighthouse
linktitle: Lighthouse
description: Ligero webhook y [ChatOps](/es/docs/resources/guides/using-jx/faq/chatops/) para múltiples proveedores git.
weight: 41
---

[Prow](https://github.com/kubernetes/test-infra/tree/master/prow) es una excelente manera de hacer [ChatOps](/es/docs/resources/guides/using-jx/faq/chatops/) con los [Pipelines de Jenkins X](/es/about/concepts/jenkins-x-pipelines/), aunque desafortunadamente solo es compatible con GitHub.com y es bastante pesado y complejo. Para solucionar este problema, hemos creado [Lighthouse](https://github.com/jenkins-x/lighthouse).

[Lighthouse](https://github.com/jenkins-x/lighthouse) es un gestor de webhooks ligero basado en [ChatOps](/es/docs/resources/guides/using-jx/faq/chatops/) que puede activar los [Pipelines de Jenkins X](/es/about/concepts/jenkins-x-pipelines/) en webhooks de múltiples proveedores de git como: GitHub, GitHub Enterprise, BitBucket Server, BitBucket Cloud, GitLab, Gogs y Gitea.

Actualmente, Lighthouse se enfoca en usar [Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) con Tekton, aunque a largo plazo podría reutilizarse con Tekton orquestando pipelines de Jenkins a través de la aplicación [Custom Jenkins Server](/docs/resources/guides/managing-jx/common-tasks/custom-jenkins/)

## Features

Actualmente, Lighthouse admite los [plugins comunes de prow](https://github.com/jenkins-x/lighthouse/tree/master/pkg/prow/plugins) y maneja los webhooks de inserción a las ramas y los webhooks de solicitud de extracción para luego activar los pipelines Jenkins X.

Lighthouse utiliza la misma estructura de archivos `config.yaml` and `plugins.yaml` de Prow para que podamos migrar fácilmente desde `prow <-> lighthouse`.

Esto también significa que podemos reutilizar la limpia generación de la configuración de Prow desde los CRD de `SourceRepository`, `SourceRepositoryGroup` y `Scheduler` integrados en [jx boot](/docs/reference/boot/). p.ej. Aquí está la [configuración predeterminada del planificador](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/env/templates/default-scheduler.yaml) que se utiliza para cualquier proyecto importado a su clúster Jenkins X; sin tener que tocar los archivos de configuración de Prow. Puede crear muchos planificadores y asociarlos a diferentes recursos de `SourceRepository`.

También podemos reutilizar la capacidad de Prow de definir muchos pipelines separados en un repositorio (para PR o versiones) a través de contextos separados. Luego, en una solicitud de extracción, podemos usar `/test something` o `/test all` para activar los pipelines y usar los comandos `/ok-to-test` y `/approve` o `/lgtm`.

## Using Lighthouse with boot

Hemos integrado [lighthouse](https://github.com/jenkins-x/lighthouse) en [jx boot](/docs/reference/boot/). Para cambiar a `lighthouse` desde `prow`, debe agregar algo como esto a su fichero `jx-requirements.yml`:

```yaml
webhook: lighthouse
```

Una vez modificado su fichero `jx-requirements.yml` solo tiene que ejecutar el comando `jx boot`.

Si está utilizando algo más que github.com como su proveedor de git, también necesitará un poco más de YAML para configurar el proveedor de git. Aquí hay unos ejemplos:

## GitHub Enterprise

```yaml
cluster:
  provider: gke
  zone: europe-west1-c
  environmentGitOwner: myowner
  gitKind: github
  gitName: ghe
  gitServer: https://my-github.com
webhook: lighthouse
```

## BitBucket Server

```yaml
cluster:
  provider: gke
  environmentGitOwner: myowner
  gitKind: bitbucketserver
  gitName: bs
  gitServer: https://my-bitbucket-server.com
webhook: lighthouse
```

## GitLab

```yaml
cluster:
  provider: gke
  environmentGitOwner: myowner
  gitKind: gitlab
  gitName: gitlab
  gitServer: https://my-gitlab-server.com
webhook: lighthouse
```

## Comparaciones con Prow

Lighthouse es muy parecido a Prow y actualmente reutiliza el código fuente del complemento Prow y un [montón de plugins de prow](https://github.com/jenkins-x/lighthouse/tree/master/pkg/prow/plugins).

Sin embargo, tiene algunas diferencias:

* en lugar de ser un faro específico de GitHub, utiliza [jenkins-x/go-scm](https://github.com/jenkins-x/go-scm) para que pueda ser compatible con cualquier proveedor de git
* lighthouse es principalmente como el servicio `hook` de Prow; un controlador de webhook de escala automática: para mantener el tamaño reducido. Esto también significa que si algo sale mal manejando webhooks, solo tiene un pod para investigar.
* lighthouse también es muy ligero. En Jenkins X tenemos alrededor de 10 pods relacionados con Prow; con lighthouse tenemos solo 1 junto con el controlador Tekton en sí. Ese módulo lighthouse también podría escalarse fácilmente de 0 a muchos, ya que se inicia muy rápidamente.
* lighthouse se centra exclusivamente en las tuberías de Tekton, por lo que no requiere un CRD `ProwJob`; en cambio, un webhook de inserción a una rama de solicitud de liberación o extracción puede desencadenar cero a muchos CRD de `PipelineRun`.

## Portar comandos de Prow

Si hay algún comando de Prow que desee que aún no hayamos transferido, es relativamente fácil portar plugins de Prow.

Hemos reutilizado el código del plugin de Prow y el código de configuración; Por lo tanto, se trata principalmente de cambiar las importaciones de `k8s.io/test-infra/prow` a `github.com/jenkins-x/lighthouse/pkg/prow`, y luego modificar las estructuras del cliente github de, por ejemplo, `github.PullRequest` a `scm.PullRequest`.

La mayoría de las estructuras de github mapean 1-1 con los equivalentes [jenkins-x/go-scm](https://github.com/jenkins-x/go-scm) (por ejemplo, Issue, Commit, PullRequest) aunque la API go-scm tiende a devolver segmentos a los recursos de forma predeterminada. Sin embargo, hay algunas diferencias de nombres en diferentes partes de la API.

p.ej. compare la API de `githubClient` para [prow lgtm](https://github.com/kubernetes/test-infra/blob/344024d30165cda6f4691cc178f25b16f1a1f5af/prow/plugins/lgtm/lgtm.go#L134-L150) versus [lighthouse lgtm](https://github.com/jenkins-x/lighthouse/blob/master/pkg/prow/plugins/lgtm/lgtm.go#L135-L150).

Todo el código relacionado con el plugin Prow vive en el árbol de paquetes [pkg/prow](https://github.com/jenkins-x/lighthouse/tree/master/pkg/prow). En general, todo lo que hemos hecho es cambiar a [jenkins-x/go-scm](https://github.com/jenkins-x/go-scm) y cambiar los agentes de Prow actuales y, en su lugar, usar un solo agente Tekton usando [PlumberClient](https://github.com/jenkins-x/lighthouse/blob/master/pkg/plumber/interface.go#L3-L6) para activar los pipelines.

## Variables de entornos

Las siguientes variables de entornos son utilizadas:

| Nombre  |  Descripción |
| ------------- | ------------- |
| `GIT_KIND` | el tipo de servidor git: `github, bitbucket, gitea, stash` |
| `GIT_SERVER` | la URL del servidor si no usa los proveedores públicos alojados de Git: https://github.com or https://bitbucket.org https://gitlab.com |
| `GIT_USER` | el usuario git (bot name) a utilizar en las operacionse de Git |
| `GIT_TOKEN` | el token de git para realizar las operaciones en el repositorio (agregar comentarios, etiquetas, etc) |
| `HMAC_TOKEN` | el token enviado desde el proveedor Git en los webhooks |
| `JX_SERVICE_ACCOUNT` | la cuenta de servicio que se usará para los pipelines generados |