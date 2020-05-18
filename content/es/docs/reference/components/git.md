---
title: Servidores Git
linktitle: Servidores Git
description: Trabajando con diferentes servidores Git
weight: 100
---

Jenkins X usa de manera predeterminada [GitHub](https://github.com/), la solución gratuita de alojamiento público de Git para proyectos de código abierto.

Sin embargo, al trabajar en la empresa, es posible que desee utilizar diferentes servidores git.

## Configurar servidores Git a través de boot

Recomendamos encarecidamente que use [boot](/docs/getting-started/setup/boot/) para instalar y configurar Jenkins X.

Si está utilizando boot, utilice [estas instrucciones para configurar Git](/es/docs/getting-started/setup/boot/#git)

## Listar servidores Git

Puede listar los servidores Git configurados a través del comando [jx get git](/commands/jx_get_git/):

```
jx get git
```
{{< alert >}}
**NOTA:** Todos los proveedores de Git mencionados aquí son compatibles si está utilizando Jenkins Static Masters. Sin embargo, si está utilizando **Jenkins X Serverless con Tekton**, solo se admite GitHub. Esto significa que todos los demás proveedores de Git, incluido GitHub Enterprise, no son compatibles actualmente debido a cómo Prow se comunica con las API.

Sin embargo, estamos integrando [Lighthouse](https://github.com/jenkins-x/lighthouse) para garantizar el soporte para los proveedores de Git listados en esta página en un entorno Jenkins X Serverless muy pronto.
{{< /alert >}}

## Utilizar diferentes proveedores Git por entornos

Cuando instales Jenkins X, creará repositorios de Git para `Staging` y `Production` usando GitHub.

Si desea utilizar un proveedor de Git diferente para sus entornos, cuando instale Jenkins X agregue el parámetro `--no-default-environments` en el comando [jx create cluster](/commands/jx_create_cluster/) o [jx install](/commands/deprecation/).

p.ej. para [crear un nuevo clúster](/es/docs/getting-started/setup/create-cluster/).

```sh
$ jx create cluster gke --no-default-environments
```

o [instalarlo en un clúster existente](/docs/resources/guides/managing-jx/common-tasks/install-on-cluster/)

```sh
$ jx install --no-default-environments
```

Luego, una vez que Jenkins X esté instalado, puede [agregar un nuevo proveedor git](#agregar-un-nuevo-proveedor-git).

Luego, cuando el proveedor git está configurado, puede verificar que esté disponible y que tenga el `gitKind` correcto a través de:

```sh
$ jx get git server
```

Ahora cree los entornos `Staging` y `Production` utilizando el proveedor de git que desee a través de:

```sh
$ jx create env staging --git-provider-url=https://gitproviderhostname.com
$ jx create env production --git-provider-url=https://gitproviderhostname.com
```

## Agregar un nuevo proveedor git

Si ya tiene un servidor git en algún lugar, puede agregarlo a Jenkins X a través de [jx create git server](/commands/jx_create_git_server/):

```sh
jx create git server gitKind someURL
```

Donde `gitKind` es uno de los tipos de proveedores de git compatibles como `github, gitea, gitlab, bitbucketcloud, bitbucketserver`

Puede verificar qué URL del servidor y los valores `gitKind` se configuran a través de:

```sh
jx get git server
```
**NOTA:** asegúrese de establecer el `gitKind` correcto para su proveedor de git; de lo contrario, se invocará el proveedor de API REST subyacente incorrecto.

## GitHub Enterprise

Para adicionar al servidor GitHub Enterprise intente:

```sh
jx create git server github https://github.foo.com -n GHE
jx create git token -n GHE myusername
```

Donde `-n` es el nombre del servicio git.

## BitBucket Cloud

Para adicionar BitBucket Cloud intente:

```sh
jx create git server bitbucketcloud -n BitBucket https://bitbucket.org
jx create git token -n BitBucket myusername
```

Por favor, asegúrece que `gitKind` está correctamente escrito como `bitbucketcloud` a través del comando:

```sh
jx get git server
```

y que aparece en la columna `Kind`.

## BitBucket Server

Para adicionar BitBucket Standalone Server intente:

```sh
jx create git server bitbucketserver -n BitBucket https://your_server_address
jx create git token -n BitBucket myusername
```

## Gitlab

Para adicionar el servidor Gitlab y el token intente:

```sh
jx create git server gitlab https://gitlab.com/ -n gitlab
jx create git token -n gitlab myusername
```

### Adicionar tokens de usuarios

Para utilizar este servidor git necesitarás adicionar el nombre de usuario y el token del API a través de [jx create git token](/commands/jx_create_git_token/):

```sh
jx create git token -n myProviderName myUserName
```

Se le preguntará el token del API.

### Proveedores Git hospedado en Kubernetes

Puede instalar proveedores git dentro del clúster de kubernetes que ejecuta Jenkins X.

p.ej. hay un complemento para [gitea](https://gitea.io/en-us/) que le permite instalar `gitea` como parte de su instalación de Jenkins X.

Para usar [gitea](https://gitea.io/en-us/) con Jenkins X, debe habilitar el complemento `gitea` antes de instalar Jenkins X:

```sh
jx edit addon gitea -e true
```

Puede ver los complementos habilitados a través de [jx get addons](/commands/jx_get_addons/):

```sh
jx get addons
```

Ahora, cuando [instales Jenkins X](/docs/getting-started/) también instalará el componente `gitea`.

Luego, cada vez que Jenkins X necesite crear un repositorio git para un entorno o para un nuevo proyecto, el servidor gitea aparecerá en la lista de selección.

#### Limitaciones conocidas de gitea

Al momento de escribir, [el plugin de gitea para Jenkins](https://issues.jenkins-ci.org/browse/JENKINS-50459) no actualiza correctamente el PR y los estados de construcción de git commit que rompen los canales de promoción de GitOps. La promoción puede funcionar a través de la aprobación manual, pero el pipeline informa un fallo.

Otro problema es que los nuevos proyectos creados por `jx` dentro de `gitea` no habilitan los [botones de combinación en los PR](https://github.com/go-gitea/go-sdk/issues/100). La solución es que después de crear un proyecto en github, vaya a la página de `Settings` para el repositorio dentro de la consola web de `gitea` y active los botones de mezcla allí.