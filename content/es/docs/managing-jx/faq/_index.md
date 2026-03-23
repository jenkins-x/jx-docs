---
title: FAQ
linktitle: FAQ
description: Preguntas sobre cómo gestionar Jenkins X
weight: 60
---

## ¿Cómo agrego un usuario a mi instalación de Jenkins X?

Jenkins X asume que cada usuario tiene acceso al mismo clúster de desarrollo kubernetes en el que se está ejecutando Jenkins X.

Si su usuario no tiene acceso al clúster de kubernetes, debemos configurar su archivo `~/.kube/config` para que pueda acceder a él.

Si está utilizando el GKE de Google, puede navegar por la [Consola GKE](https://console.cloud.google.com) para ver todos los clústeres y hacer clic en el botón `Connect` al lado de su clúster de desarrollo y eso le permite copiar/pegar el comando para conectarse al clúster.

Para otros clústeres, estamos planeando escribir algunos [comandos CLI para exportar e importar la configuración de kube](https://github.com/jenkins-x/jx/issues/1406).

Además, [CloudBees](https://www.cloudbees.com/) está trabajando en una distribución de Jenkins X que incluirá un inicio de sesión único junto con una increíble interfaz de usuario web para visualizar equipos, pipelines, registros, entornos, aplicaciones, versiones e infraestructura. La interfaz de usuario de CloudBees proporciona una manera fácil para que cualquier persona de su equipo inicie sesión en Jenkins X desde la línea de comandos con el botón `Connect` en la página `Teams` que utiliza [jx login](/commands/deprecation/).

### Una vez que el usuario tiene acceso al clúster de Kubernetes

Una vez que el usuario tiene acceso al clúster de Kubernetes:

* [instale el binario jx](/es/docs/getting-started/setup/install/)

Si Jenkins X fue instalado en el namespace `jx`, entonces lo siguientes debe ser [cambiar su contexto](/docs/resources/guides/using-jx/developing/kube-context/) al namespace `jx`:

    $  jx ns jx

Para probar, debe poder escribir:

    $  jx get env
    $  jx open

Para ver los entornos y cualquier herramienta de desarrollo como las consolas de Jenkins o Nexus.

## ¿Cómo funciona el control de acceso y la seguridad?

Vea la [documentación de control de acceso](/docs/resources/guides/managing-jx/common-tasks/access-control/).

## ¿Cómo actualizo mi instalación de Jenkins X?

Nuestra estrategia para la instalación, configuración y actualización de Jenkins X es [jx boot](/es/docs/getting-started/setup/boot/).

Si está utilizando [jx boot](/es/docs/getting-started/setup/boot/) puede habilitar las actualizaciones [automáticas](/es/docs/getting-started/setup/boot/#actualizaciones-automáticas) o hacerlas [manualmente](/es/docs/getting-started/setup/boot/#actualizaciones-manuales).

Si algo va mal durante la actualización (p.ej, si es borrado el clúster, el namespace o Tekton), puede volver a ejecutar el cmando [jx boot](/es/docs/getting-started/setup/boot/) en su laptop para restaurar el estado del clúster.


De lo contrario, el enfoque anterior es el siguiente:

### Si no utiliza boot

Puede actualizar Jenkins X a través del comando [jx upgrade](/commands/jx_upgrade/). Comience por:

```sh
$ jx upgrade cli
```

para que obtenga la última versión de la sistema CLI, luego actualice la plataforma:

```sh
$ jx upgrade platform
```

## ¿Cómo actualizo el binario jx usado dentro de las compilaciones cuando uso jenkins sin servidor?

Utilizamos `BuildTemplates` específicos para diferentes lenguajes de programación. Estas `BuildTemplates` describen los pasos que se ejecutarán como parte del trabajo, que en el caso de Jenkins X BuildTemplates, todos ejecutan `JenkinsfileRunner` para ejecutar el Jenkinsfile del proyecto.

```sh
$ kubectl get buildtemplates
NAME                        AGE
environment-apply           9d
environment-build           9d
jenkins-base                9d
jenkins-csharp              9d
jenkins-cwp                 9d
jenkins-elixir              9d
jenkins-filerunner          9d
jenkins-go                  9d
jenkins-go-nodocker         9d
jenkins-go-script-bdd       1d
jenkins-go-script-ci        1d
jenkins-go-script-release   1d
jenkins-gradle              9d
jenkins-javascript          9d
jenkins-jenkins             9d
jenkins-maven               9d
jenkins-python              9d
jenkins-rust                9d
jenkins-scala               9d
jenkins-test                9d
knative-chart-ci            9d
knative-chart-release       9d
knative-deploy              9d
knative-maven-ci            9d
knative-maven-release       9d
```

La imagen Docker que tiene el proceso `Jenkinsfile` también tiene otras herramientas instaladas, como el binario `jx`. Si necesita actualizar `jx` a una versión más nueva, debe [modificar el Dockerfile base utilizado para el paso del proceso Jenkinsfile de BuildTemplate](https://github.com/jenkins-x/jenkins-x-serverless/blob/def939f559b6b0e6735c043ce032686397053a6e/Dockerfile.base#L120-L123), para que use la versión jx que desee. Aunque esto [normalmente se hace automáticamente](https://github.com/jenkins-x/jenkins-x-serverless/commits/def939f559b6b0e6735c043ce032686397053a6e/Dockerfile.base).

Una vez hecho esto, debe cambiar BuildTemplate en su clúster para que comience a usar la nueva versión de la imagen de Docker. Por ejemplo, puede ver la versión actual de esta imagen para Go BuildTemplate en su clúster:

```sh
$ kubectl describe buildtemplate jenkins-go | grep Image
Image:       jenkinsxio/jenkins-go:256.0.44
```

Si desea utilizar una versión diferente que use una versión más nueva de jx, puede cambiar manualmente todas las BuildTemplates, pero en su lugar, vamos a ocuparnos de jx

```sh
jx upgrade addon jx-build-templates
```

Compruebe que se han realizado los cambios:

```sh
$ kubectl describe buildtemplate jenkins-go | grep Image
Image:       jenkinsxio/jenkins-go:256.0.50
```

## ¿Cómo difiere `--prow` de `--gitops`?

* `--prow` usa [jenkins sin servidor](/news/serverless-jenkins/) y usa [prow](https://github.com/kubernetes/test-infra/tree/master/prow) para implementar ChatOps en los PRs.
* `--gitops` todavía está en progreso, pero usará GitOps para administrar la instalación de Jenkins X (el entorno de desarrollo) para que la instalación de la plataforma se almacene en un repositorio de git y la actualización / adición de aplicaciones / cambio de configuración se cambie a través de PRs como cambios en la promoción de aplicaciones a los entornos de puesta en escena o producción.

## ¿Cómo reutilizo mi controlador Ingress existente?

De manera predeterminada, [cuando instala Jenkins X en un clúster de Kubernetes existente](/docs/resources/guides/managing-jx/common-tasks/install-on-cluster/), le pregunta si desea instalar un controlador Ingress. Jenkins X necesita un controlador Ingress de algún tipo para que podamos configurar los recursos `Ingress` para cada `Service` para que podamos acceder a las aplicaciones web a través de URL fuera del clúster de Kubernetes (por ejemplo, dentro de los navegadores web).

El comando [jx install](/commands/deprecation/) toma una serie de parámetros CLI que comienzan con `--ingress` donde puede apuntar el namespace, el deployment y el service del controlador de entrada que desea usar para la instalación.

Si puede, le recomendamos que use el controlador de entrada predeterminado, ya que sabemos que funciona muy bien y solo usa una sola IP de LoadBalancer para todo el clúster (su proveedor de la nube a menudo cobra por dirección IP). Sin embargo, si desea apuntar a un controlador de entrada diferente, simplemente especifique esos argumentos en la instalación:

```sh
$ jx install \
  --ingress-service=$(yoursvcname) \
  --ingress-deployment=$(yourdeployname) \
  --ingress-namespace=kube-system
```

## ¿Cómo habilito las URL HTTPS?

En general utilizamos el comando [jx upgrade ingress](/commands/deprecation/).

Para más detalles vea los siguiente documentos:

* [Actualización de reglas de entrada y adición de certificados TLS con Jenkins X](https://technologyconversations.com/2019/05/31/upgrading-ingress-rules-and-adding-tls-certificates-with-jenkins-x/) por [Viktor Farcic](https://technologyconversations.com)
* [Jenkins X — Habilitar TLS en Vistas Previas](https://itnext.io/jenkins-x-tls-enabled-previews-d04fa68c7ce9?source=friends_link&sk=c13828b223f56ed662fd7ec0872c3d1e) por [Steve Boardwell](https://medium.com/@sboardwell)
* [Jenkins X — Seguridad en el Clúster](https://itnext.io/jenkins-x-securing-the-cluster-e1b9fcd8dd05?source=friends_link&sk=e1e46e780908b2e3c8415c3191e82c56) por [Steve Boardwell](https://medium.com/@sboardwell)

## ¿Cómo cambio las URL en un entorno?

Utilizamos [exposecontroller](https://github.com/jenkins-x/exposecontroller) para automatizar la configuración de los recursos `Ingress` para los Servicios expuestos, lo que permite TLS y también inyecta URL externas para servicios en el código (por ejemplo, para que podamos registrar webhooks).

La plantilla `UrlTemplate` predeterminada para cada entorno tiene la forma: `{{.Service}}.{{.Namespace}}.{{.Domain}}` donde el `Service` es el nombre del servicio, `Namespace` es el espacio de nombres de Kubernetes y `Domain` está configurado el Dominio DNS

Si desea modificar los esquemas de URL de su servicio en un entorno, edite el fichero `env/values.yaml` en su repositorio Git de Entornos. Para encontrar las URL de cada repositorio de origen, use el comando `jx get env`.

Luego, modifique el contenido en `env/values.yaml` para incluir el valor `urlTemplate:` de la siguiente manera:

```yaml
expose:
  config:
    urltemplate: "{{.Service}}-{{.Namespace}}.{{.Domain}}"
```

Hemos omitido los otros valores de `expose:` y `config:` por brevedad; lo importante es asegurarse de que especifique un valor personalizado de `expose.config.urltemplate`. El valor predeterminado es `{{.Service}}.{{.Namespace}}.{{.Domain}}` si no se especifica ninguno.

Cada vez que modifique el repositorio de git para un entorno, el pipeline de GitOps se ejecutará para actualizar sus recursos de Ingress para que coincidan con su `UrlTemplate`.