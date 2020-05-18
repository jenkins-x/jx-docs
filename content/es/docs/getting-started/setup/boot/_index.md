---
title: Jenkins X Boot
linktitle: Jenkins X Boot
description: Instalar, configurar y actualizar Jenkins X mediante GitOps y Jenkins X Pipeline
categories: [getting started]
keywords: [install]
weight: 10
---

## Resumen

_Jenkins X Boot_ utiliza el siguiente enfoque:

* cree su clúster de Kubernetes donde desee:
  * utilice Terraform para crear su clúster de Kubernetes junto a los recursos que sean necesarios de la plataforma.
  * utilice la consola web de su proveedor cloud para crear su clúster de Kubernetes.
  * utilice `jx create cluster --skip-installation`. Por ejemplo:
    ``` sh
    jx create cluster gke --skip-installation
    ```
  * utilice alguna herramienta personalizada de su elección o tal vez una proporcionado por su equipo de operaciones.

* seguramente va a desear verificar que puede comunicarse correctamente con su clúster de Kubernetes a través de:

``` sh
kubectl get ns
```

* ejecute el comando [jx boot](/commands/jx_boot/):
```sh
jx boot
```

Ahora se le solicitarán los parámetros necesarios para la instalación, como su usuario / contraseña de administrador, el usuario y token de Pipeline git, etc.

Entonces Jenkins X debe instalarse y configurarse en su clúster de Kubernetes.

### Acerca de 'jx boot'

El comando [jx boot](/commands/jx_boot/) interpreta y ejecuta el pipeline de arranque utilizando el binario local `jx`. El pipeline utilizado para arrancar Jenkins X puede ser ejecutado más tarde dentro de Kubernetes a través de Tekton. Si en algún momento algo sale mal con Tekton, siempre puedes volver a utilizar el comando `jx boot` para que las cosas vuelvan a funcionar (por ejemplo, si alguien elimina accidentalmente su clúster).

#### Pre and Post Validation

Antes de intentar cualquier tipo de instalación `boot` ejecutará [jx step verify preinstall](/commands/jx_step_verify_preinstall/) para comprobar que todo esté bien. También verificará que las versiones de los paquetes que requiere que estén instalados se encuentran dentro de los límites superior e inferior. Mas información al respecto, [aquí](https://github.com/jenkins-x/jenkins-x-versions/tree/master/packages). Si usas Terraform (tu archivo `jx-requirements.yml` tiene `terraform: true`)  `boot` fallará si Terraform aún no ha creado los recursos requeridos en la nube. Si no lo estás usando los recursos se crearán automáticamente. 

Una vez que la instalación se ha completado, se ejecuta el comando [jx step verify install](/commands/jx_step_verify_install/) para verificar que su instalación sea válida.

#### Packages

Para instalaciones basadas en `boot`, las versiones de paquetes que usa `jx` han de encontrarse entre los límites especificados en [version stream](https://github.com/jenkins-x/jenkins-x-versions/tree/master/packages). Habitualmente actualizar los paquetes es sencillo, sin embargo, no sucede igual si hay decrementar la versión.

##### Brew

Este [gist] (https://gist.github.com/rdump/b79a63084b47f99a41514432132bd408) describe cómo puede cambiar a diferentes versiones del paquete `kubectl` usando el administrador de paquetes `brew`.

## Modificando su instalación

En cualquier momento puede volver a ejecutar el comando [jx boot](/commands/jx_boot/) para aplicar cualquier cambio en su configuración.

Para lograrlo solamente edite cualquier elemento en la configuración y vuelva a ejecutar [jx boot](/commands/jx_boot/), ya sea para agregar o eliminar aplicaciones, para cambiar parámetros, configuraciones o para actualizar / degradar versiones de dependencias.

## Requisitos

Existe un fichero llamado [jx-requirements.yml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/jx-requirements.yml) que se utiliza para especificar o definir los requerimientos lógicos de su instalación, como por ejemplo:

* qué proveedor de Kubernetes va a utilizar
* dónde almacenar la información sensible (ficheros en la máquina local o con el sistema Vault)
* si estás utilizando Terraform para gestionar los recursos del cloud
* si deseas utilizar Kaniko para construir las imágenes de los contenedores

Este es el fichero principal de las configuraciones para `jx boot` y donde realizarás la mayoría de los cambios. Te recomendamos que revises el fichero [jx-requirements.yml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/jx-requirements.yml) y realices todos los ajustes que consideres necesarios.

## Información sensible (Secrets)

Boot actualmente admite las siguientes opciones para administrar secretos:

### Almacenamiento Local

Esta es la opción pre-establecida o puedes también especificarla utilizando `secretStorage: local`:

```yaml
cluster:
  provider: gke
environments:
- key: dev
- key: staging
- key: production
kaniko: true
secretStorage: local
webhook: prow
```

Para esta configuración la información está almacenada en la carpeta `~/.jx/localSecrets/$clusterName`. Si lo deseas puedes utilizar la variable `$JX_HOME` para modificar su ubicación.

### Vault

Esta es la estrategia recomendada cuando se utilizan los proveedores GKE o EKS. Puede ser configurados explícitamente con `secretStorage: vault`:

```yaml
cluster:
  provider: gke
environments:
- key: dev
- key: staging
- key: production
kaniko: true
secretStorage: vault
webhook: prow
```

Esta configuración va a provocar que el pipeline de `jx boot` instale Vault utilizando KMS y configure un almacenamiento en el cloud (bucket) para salvar/cargar la información sensible.

La gran ventaja de utilizar Vault se muestra en el trabajo de equipo, donde cada miembro puede fácilmente ejecutar el comando `jx boot` en el mismo cluster. Aún en el caso donde accidentalmente se borre su clúster de Kubernetes, su restauración será muy fácil utilizando KMS + el bucket de almacenamiento.

## Webhook

Jenkins X admite varios sistemas para gestionar webhooks y opcionalmente admite [ChatOps](/docs/resources/guides/using-jx/faq/chatops/).

[Prow](/docs/reference/components/prow/) y [Lighthouse](/architecture/lighthouse/) admiten webhooks y [ChatOps](/docs/resources/guides/using-jx/faq/chatops/), mientras que Jenkins solo admite webhooks.

### Prow

[Prow](/docs/reference/components/prow/) es actualmente el sistema de webhook y [ChatOps](/docs/resources/guides/using-jx/faq/chatops/) pre-establecido cuando se utiliza [Serverless Jenkins X Pipelines](/es/about/concepts/jenkins-x-pipelines/) con [Tekton](https://tekton.dev/) y GitHub.

Se configura a través de `webhook: prow` en el fichero `jx-requirements.yml`.

```yaml
cluster:
  provider: gke
environments:
- key: dev
- key: staging
- key: production
kaniko: true
storage:
  logs:
    enabled: false
  reports:
    enabled: false
  repository:
    enabled: false
webhook: prow
```

### Lighthouse

[Lighthouse](/architecture/lighthouse/) es actualmente el sistema de webhook y [ChatOps](/docs/resources/guides/using-jx/faq/chatops/) pre-establecido cuando se utiliza [Serverless Jenkins X Pipelines](/es/about/concepts/jenkins-x-pipelines/) con [Tekton](https://tekton.dev/) y un servidor git diferente a [GitHub](https://github.com).

Cuando Lighthouse sea más estable y esté bien probado, lo convertiremos en la configuración pre-establecida para todas las instalaciones que utilicen [Serverless Jenkins X Pipelines](/es/about/concepts/jenkins-x-pipelines/).

Se configura a través de `webhook: lighthouse` en el fichero `jx-requirements.yml`.

```yaml
cluster:
  provider: gke
environments:
- key: dev
- key: staging
- key: production
kaniko: true
storage:
  logs:
    enabled: false
  reports:
    enabled: false
  repository:
    enabled: false
webhook: lighthouse
```

### Jenkins

Para utilizar el servidor Jenkins en boot con el objetivo de procesar webhooks y pipelines se debe configurar el fichero `jx-requirements.yml` estableciendo `webhook: jenkins`.

## Git

Jenkins X admite diferentes proveedores de git. Puedes especificar el proveedor de git y la organización que desees utilizar para cada entorno en el fichero  [jx-requirements.yml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/jx-requirements.yml).

{{< pageinfo >}}

**NOTA** Jenkins X crea los repositorios como privados por defecto. Esto puede causar problemas al evaluar Jenkins X con GitHub si se utiliza una organización gratuita de GitHub para mantener los diversos repositorios (de entorno) creados, ya que las cuentas de la organización libre no tienen acceso a repositorios privados. Sin embargo, el uso de una cuenta personal de Github no es un problema, ya que las cuentas privadas gratuitas tienen repositorios privados ilimitados.

Para fines de evaluación, puede usar una cuenta privada de GitHub como propietario de los repositorios, y cambiar a una cuenta de organización paga una vez que esté listo para entrar. Alternativamente, puede habilitar los repositorios de entorno público estableciendo `environmentGitPublic` en `true` en su configuración de jx boot. En caso de que esté utilizando `jx create` o `jx install`, deberá agregar la opción `--git-public` como parte del comando para habilitar el repositorio público.
{{< /pageinfo >}}


### GitHub

Esta es la configuración pre-establecida si no especificas nada.

```yaml
cluster:
  environmentGitOwner: myorg
  provider: gke
environments:
- key: dev
- key: staging
- key: production
kaniko: true
storage:
  logs:
    enabled: false
  reports:
    enabled: false
  repository:
    enabled: false
webhook: prow
```

### GitHub Enterprise

La configuración es similar a la descrita anteriormente con la diferencia que necesitas especificar la URL del `gitServer` en caso de que sea diferente de https://github.com. Se configura a través de: `gitKind: github`

```yaml
cluster:
  provider: gke
  environmentGitOwner: myorg
  gitKind: github
  gitName: ghe
  gitServer: https://github.myserver.com
environments:
  - key: dev
  - key: staging
  - key: production
kaniko: true
secretStorage: local
storage:
  logs:
    enabled: true
    url: "gs://jx-logs"
  reports:
    enabled: true
    url: "gs://jx-logs"
  repository:
    enabled: true
    url: "gs://jx-logs"
webhook: lighthouse
```

### Bitbucket Server

Para este servidor git se especifica la URL `gitServer` y el tipo `gitKind: bitbucketserver`. Si deseas utilizar [Serverless Jenkins X Pipelines](/es/about/concepts/jenkins-x-pipelines/) con [Tekton](https://tekton.dev/) asegúrate de establecer [lighthouse webhook](#webhook) a través de `webhook: lighthouse`.

```yaml
cluster:
  provider: gke
  environmentGitOwner: myorg
  gitKind: bitbucketserver
  gitName: bs
  gitServer: https://bitbucket.myserver.com
environments:
  - key: dev
  - key: staging
  - key: production
kaniko: true
secretStorage: local
storage:
  logs:
    enabled: true
    url: "gs://jx-logs"
  reports:
    enabled: true
    url: "gs://jx-logs"
  repository:
    enabled: true
    url: "gs://jx-logs"
webhook: lighthouse
```

### Bitbucket Cloud

Para este servidor git se especifica el tipo `gitKind: bitbucketcloud`. Si deseas utilizar [Serverless Jenkins X Pipelines](/es/about/concepts/jenkins-x-pipelines/) con [Tekton](https://tekton.dev/) asegúrate de establecer [lighthouse webhook](#webhook) a través de `webhook: lighthouse`.

```yaml
cluster:
  provider: gke
  environmentGitOwner: myorg
  gitKind: bitbucketcloud
  gitName: bc
environments:
  - key: dev
  - key: staging
  - key: production
kaniko: true
secretStorage: local
storage:
  logs:
    enabled: true
    url: "gs://jx-logs"
  reports:
    enabled: true
    url: "gs://jx-logs"
  repository:
    enabled: true
    url: "gs://jx-logs"
webhook: lighthouse
```


### Gitlab

Para este servidor git se especifica la URL `gitServer` y el tipo `gitKind: gitlab`. Si deseas utilizar [Serverless Jenkins X Pipelines](/es/about/concepts/jenkins-x-pipelines/) con [Tekton](https://tekton.dev/) asegúrate de establecer [lighthouse webhook](#webhook) a través de `webhook: lighthouse`.

```yaml
cluster:
  provider: gke
  environmentGitOwner: myorg
  gitKind: gitlab
  gitName: gl
  gitServer: https://gitlab.com
environments:
  - key: dev
  - key: staging
  - key: production
kaniko: true
secretStorage: local
storage:
  logs:
    enabled: true
    url: "gs://jx-logs"
  reports:
    enabled: true
    url: "gs://jx-logs"
  repository:
    enabled: true
    url: "gs://jx-logs"
webhook: lighthouse
```

## Repositorios

Por defecto, Jenkins X utiliza:

* [Nexus](https://www.sonatype.com/nexus-repository-oss) como un repositorio de artefactos para almacenar elementos como: jars, archivos `pom.xml`, módulos npm, etc.
* [Chartmusem](https://chartmuseum.com/) como repositorio de charts de Helm

Puede configurar nexus a través del archivo `jx-requirements.yml`:

```yaml
repository: nexus
```

### Bucketrepo

El microservicio [bucketrepo](https://github.com/jenkins-x/bucketrepo) es un repositorio de artefactos que utiliza como almacenamiento la nube. Este servicio puede:

* actuar como un proxy maven para almacenar en caché las dependencias cuando se llevan a cabo las compilaciones de java/maven
* actuar como un repositorio de artefactos (p.ej, para desplegar artefactos maven)
* como repositorio de charts de helm

Para habilitar `bucketrepo` establezca la siguiente configuración en el fichero `jx-requirements.yml`:

```yaml
repository: bucketrepo
```

Este servicio utiliza de forma predeterminada el sistema de archivos local para almacenar los artefactos.

Para habilitar el almacenamiento en la nube de los artefactos guardados en `bucketrepo` debe establecer la configuración `storage.repository`, en cuyo caso se utiliza el bucket que esté utilizando en el proveedor cloud. Vea la [sección de almacenamiento para más detalles](#almacenamiento).

### Ninguna

Si desea inhabilitar el repositorio de artefactos (nexus) pero mantener chartmuseum para los charts, puede utilizar la siguiente configuración:

```yaml
repository: none
```

Tenga en cuenta que si no utiliza un repositorio para los artefactos no podrá desplegar artefactos de maven. Sin embargo, podrá seguir utilizando el [Chartmusem](https://chartmuseum.com/) para almacenar los charts.

## Almacenamiento

El fichero [jx-requirements.yml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/jx-requirements.yml) permite configurar almacenamiento a largo plazo para registros e informes.

Por ejemplo, el siguiente fichero `jx-requirements.yml` tiene habilitado el almacenamiento a largo plazo.

```yaml
cluster:
  provider: gke
environments:
- key: dev
- key: staging
- key: production
kaniko: true
storage:
  logs:
    enabled: true
  reports:
    enabled: false
  repository:
    enabled: false
```

Puedes establecer la URL del almacenamiento (cloud storage bucket) en la sección `storage` para definir dónde será guardada la información. Las siguientes sintaxis de URL son permitidas:

* `gs://anotherBucket/mydir/something.txt` : utilizando un bucket GCS en GCP
* `s3://nameOfBucket/mydir/something.txt` : utilizando un bucket S3 en AWS
* `azblob://thatBucket/mydir/something.txt` : utilizando un bucket en Azure
* `http://foo/bar` : fichero almacenado en un repositorio git sin utilizar HTTPS
* `https://foo/bar` : fichero almacenado en un repositorio git utilizando HTTPS

Por ejemplo:

```yaml
cluster:
  provider: gke
environments:
- key: dev
- key: staging
- key: production
kaniko: true
storage:
  logs:
    enabled: false
    url: gs://my-logs
  reports:
    enabled: false
    url: gs://my-logs
  repository:
    enabled: false
    url: gs://my-repo
```

Para ampliar detalles utilice la [Guía de Almacenamiento](https://jenkins-x.io/architecture/storage/).

## Ingress

Si no especificas nada en tu fichero [jx-requirements.yml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/jx-requirements.yml), boot va a establecer HTTP (en vez de HTTPS) junto con [nip.io](https://nip.io/) como mecanismo DNS.

Después de ejecutar boot, tu fichero `jx-requirements.yml` debe tener un aspecto similar a este:

```yaml
cluster:
  provider: gke
  clusterName: my-cluster-name
  environmentGitOwner: my-git-org
  project: my-gke-project
  zone: europe-west1-d
environments:
- key: dev
- key: staging
- key: production
ingress:
  domain: 1.2.3.4.nip.io
  externalDNS: false
  tls:
    email: ""
    enabled: false
    production: false
kaniko: true
secretStorage: local
storage:
  logs:
    enabled: false
  reports:
    enabled: false
  repository:
    enabled: false
webhook: prow
```

Si deseas habilitar un DNS externo, un nombre de dominio DNS o TLS (para registrar automáticamente todos las entradas DNS para los servicios) debes modificar la sección `ingress` adicionando `ingress.externalDNS = true` en el fichero `jx-requirements.yml` y volver a ejecutar `jx boot`.

Puedes también habilitar TLS a través de `ingress.tls.enabled = true`.

A continuación le mostramos un ejemplo completo.

```yaml
cluster:
  clusterName: mycluster
  environmentGitOwner: myorg
  gitKind: github
  gitName: github
  gitServer: https://github.com
  namespace: jx
  provider: gke
  vaultName: jx-vault-myname
environments:
- key: dev
- key: staging
- key: production
gitops: true
ingress:
  domain: my.domain.com
  externalDNS: true
  namespaceSubDomain: -jx.
  tls:
    email: someone@acme.com
    enabled: true
    production: true
kaniko: true
secretStorage: vault
storage:
  logs:
    enabled: true
    url: gs://jx-prod-logs
  reports:
    enabled: false
    url: ""
  repository:
    enabled: false
    url: ""
webhook: prow
```

## Actualizaciones

Con `jx boot` todas las versiones y configuraciones se realizan en git, por lo que es muy fácil gestionar cambios via GitOps tanto de forma automática como manual.

### Actualizaciones Automáticas

Puedes habilitar las actualizaciones automáticas en el fichero `jx-requirements.yml` a través de `schedule` con una expresión cron.

```yaml
autoUpdate:
  enabled: true
  schedule: "0 0 23 1/1 * ? *"
```

Cuando las actualizaciones automáticas están habilitadas un `CronJob` es ejecutado periódicamente para revisar cambios en el [flujo de versiones](/es/about/concepts/version-stream/) o en la [configuración del boot](https://github.com/jenkins-x/jenkins-x-boot-config). Si se detectan cambios el comando [jx upgrade boot](/commands/jx_upgrade_boot/) va a crear un Pull Request en el repositorio git de desarrollo. Una vez mezclado los cambios la configuración del boot se ha actualizado y por ende Tekton iniciará el pipeline para actualizar la instalación.

### Actualizaciones Manuales

Puedes ejecutar manualmente el comando [jx upgrade boot](/commands/jx_upgrade_boot/) siempre que lo desees. Si al ejecutarlo existen cambio en el [flujo de versiones](/es/about/concepts/version-stream/) o en la [configuración del boot](https://github.com/jenkins-x/jenkins-x-boot-config) se creará un Pull Request en el repositorio git de desarrollo.

Una vez mezclado los cambios la configuración del boot se ha actualizado y por ende Tekton iniciará el pipeline para actualizar la instalación.

### Restauración

Si algo en algún momento va mal, por ejemplo, el clúster, el namespace o Tekton, y su instalación no puede ejecutar pipelines, puedes siempre volver a ejecutar [jx boot](/docs/getting-started/setup/boot/) en su laptop para restaurar el clúster.


## Salvas

Jenkins X está integrado con [Velero](https://velero.io) para permitir salvar el estado de Jenkins X (CRDs with PVs).

Para habilitar Velero adicione las siguientes líneas en el fichero `jx-requirements.yml`:

```yaml
storage:
  backup:
    enabled: true
    url: gs://my-backup-bucket
velero:
  namespace: velero
```

Puedes utilizar cualquier URL almacenamiento habilitada. Para conocer sobre las URL revise la [guía de almacenamiento](/docs/resources/guides/managing-jx/common-tasks/storage/).
