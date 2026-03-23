---
title: FAQ
linktitle: FAQ
description: Preguntas sobre cómo desarrollar aplicaciones nativas en la nube con Jenkins X
weight: 40
aliases:
  - /faq/
---

## ¿Cómo habilito el completamiento de bash?

El completamiento en bash le ayuda a utilizar la línea de comandos `jx`, presionando `TAB` podrá completar comandos y argumentos de línea de comandos.

Para ver cómo habilitar la finalización de bash, consulte el comando [jx completion](/commands/jx_completion/)

## ¿Cómo se incluyen configuraciones específicas del entorno?

Cada entorno en Jenkins X se define en un repositorio Git; utilizamos GitOps para gestionar todos los cambios en cada entorno, tales como:

* agregar/eliminar aplicaciones
* cambiar la versión de una aplicación (actualizar o degradar)
* configurar cualquier aplicación con valores específicos del entorno

Los primeros dos elementos son definidos en el fichero `env/requirements.yaml` del repositorio Git de su entorno. El último es definido en el fichero `env/values.yaml`.

Los charts de Helm utilizan el [fichero values.yaml](https://github.com/helm/helm/blob/master/docs/chart_template_guide/values_files.md) por lo tanto, puedes modificar/sobre-escribir cualquier configuración dentro del chart para cambiar las configuraciones p.ej, etiquetas, anotaciones, número de réplicas, variables de entornos, entre otros.

Por ejemplo, si desea cambiar el número de réplicas (`replicaCount`) de la aplicación `foo` en `Staging`, entonces debe:

1. buscar la URL del repositorio Git correspondiente al entorno `Staging` a través del comando [jx get env](/commands/jx_get_environments/)
2. acceder al fichero `env/values.yaml` para adicionar/editar el número de réplicas

```yaml
foo:
  replicaCount: 5
```

3. Enviar los cambios a través de un Pull Request (PR) para que se realice las pruebas correspondientes de flujo de CI así como cualquiér otra revisión/aprobación necesaria
4. Se mezclan los cambios hacia la rama master para modificar el valor de `replicaCount` en la aplicación `foo` (se asume que existe un chart `foo` en el fichero `env/requirements.yaml`)

Puede usar helm para hacer cosas como establecer el `namespace` actual si lo necesita.

Para ver un ejemplo más complejo de cómo puede utilizar el fichero `values.yaml` para establecer valores en chart de helm, vea cómo lo hacemos para [configurar el propio Jenkins X](/docs/resources/guides/managing-jx/common-tasks/config/).

## ¿Cómo se inserta la configuración de vista previa?

Consulte la pregunta anterior sobre [cómo insertar la configuración específica del entorno en entornos](#cómo-se-incluyen-configuraciones-específicas-del-entorno).

Los Entornos de Vista Previa son similares a otros entornos, como `Staging` y `Production`, solo que en lugar de almacenar los entornos en un repositorio Git separado, el entorno de vista previa se define dentro de cada carpeta de la aplicación `charts/preview`.

Por lo tanto, para inyectar cualquier configuración personalizada en su entorno de Vista previa, puede modificar el fichero `charts/preview/values.yaml` de sus aplicaciones ubicado en el repositorio Git para sobre-escribir cualquier parámetro de la plantilla helm definido en el chart con ubicación `charts/myapp`.

Es posible que deba modificar los charts de Helm para agregar una configuración adicional si la configuración que desea configurar no se cambia fácilmente a través del fichero `values.yaml`.

## ¿Cómo gestiono los secretos en cada entorno?

Estamos utilizando secretos sellados por nosotros mismos para administrar Jenkins X en producción para todos los flujos CI/CD, por lo que los secretos se cifran y se registran en el repositorio Git de cada entorno. Utilizamos el plugin [helm-secrets](https://github.com/futuresimple/helm-secrets) para hacer esto.

Aunque un enfoque más agradable sería utilizar un operador de Vault que estamos investigando ahora, que buscaría + poblaría secretos (y los reciclaría, etc.) a través de Vault.

## ¿Cuándo se eliminan los Entornos de Vista Previa?

Tenemos un trabajo de recolección de basura en segundo plano que elimina los Entornos de Vista Previa después de cerrar/mezclar el PR. Puede ejecutarlo cuando lo desee a través del comando [jx gc previews](/commands/jx_gc_previews/).

```sh
jx gc previews
```

También puede ver las vistas previas actuales a través de [jx get previews](/commands/jx_get_previews/):

```sh
jx get previews
```

y eliminar una vista previa eligiendo una para eliminar a través de [jx delete preview](/commands/jx_delete_preview/):

```sh
jx delete preview
```

## ¿Cómo agrego otros servicios a una Vista Previa?

Cuando crea un PR, de forma predeterminada Jenkins X crea un nuevo [Entorno de Vista Previa](/es/about/concepts/features/#entornos-de-vista-previa). Dado que este es un nuevo espacio de nombres dinámico, es posible que desee configurar microservicios adicionales en el `namespace` para que pueda probar adecuadamente su vista previa de la construcción.

Para obtener más información, vea [cómo agregar charts, servicios o configuraciones a su entorno de vista previa](/docs/reference/preview/#adding-more-resources).

## ¿Puedo utilizar mi actual pipeline de liberación?

Con Jenkins X, puede crear su propio pipeline de liberaciones si lo desea; aunque hacerlo significa que se pierde nuestro [modelo de extensión](/docs/contributing/addons/) que le permite habilitar fácilmente varias aplicaciones de extensión como Gobernanza, Cumplimiento, calidad de código, cobertura de código, escaneo de seguridad, pruebas de vulnerabilidad y varias otras extensiones que se agregan todo el tiempo a través de nuestra comunidad.

Hemos creado específicamente este modelo de extensión para minimizar el trabajo que tienen sus equipos para editar y mantener los pipelines en muchos microservicios separados. La idea es que estamos tratando de automatizar tanto los pipelines como las extensiones de los pipelines para que los equipos puedan centrarse en su código real y menos en la tubería de CI/CD, que es prácticamente todo el trabajo pesado indiferenciado en estos días.

## ¿Cómo puedo manejar ramas personalizadas con tekton?

No usamos `patrones de rama` con tekton; son una configuración específica de jenkins.

Para Tekton utilizamos la configuración [prow](/docs/reference/components/prow/) / [lighthouse](/docs/reference/components/lighthouse/) para especificar qué ramas desencadenan qué contextos de los pipelines.

Si está utilizando [boot](/es/docs/getting-started/setup/boot/) para instalar Jenkins X, puede crear su propio recurso personalizado `Scheduler`  en el fichero`env/templates/myscheduler.yaml` basado en [la configuración predeterminada](https://github.com/jenkins-x-charts/jxboot-resources/blob/master/jxboot-resources/templates/default-scheduler.yaml).

p.ej. así es como especificamos [las ramas utilizadas para crear las liberaciones](https://github.com/jenkins-x-charts/jxboot-resources/blob/master/jxboot-resources/templates/default-scheduler.yaml#L48).

También puede crear contextos de pipelines; p.ej. así es como agregamos múltiples canales de prueba paralelos en [el flujo de la versión](/about/concepts/version-stream/) a través de un [Scheduler personalizado](https://github.com/jenkins-x/environment-tekton-weasel-dev/blob/master/env/templates/jx-versions-scheduler.yaml#L21) para que podamos tener muchas pruebas de integración ejecutadas en paralelo en un solo PR. Luego, cada contexto nombrado enumerado tiene un fichero `jenkins-x-$context.yml` asociado en el repositorio de origen para definir el pipeline a ejecutar como [este ejemplo que define el contexto `boot-lh`](https://github.com/jenkins-x/jenkins-x-versions/blob/master/jenkins-x-boot-lh.yml)

Luego puede asociar sus recursos `SourceRepository` con su scheduler personalizado de la siguiente manera:

* especificando el nombre del planificador en la propiedad `spec.scheduler.name` de su `SourceRepository` a través de `kubectl edit sr my-repo-name`
* especificando el nombre del planificador cuando importa un proyecto a través de `jx import --scheduler myname`
* especificando el nombre del planificador predeterminado en su entorno de desarrollo `dev` en `spec.teamSettings.defaultScheduler.name` antes de importar proyectos

Si no está usando [boot](/es/docs/getting-started/setup/boot/), puede utilizar `kubectl edit cm config` y modificar la configuración prow a mano, aunque recomendamos usar [boot](/es/docs/getting-started/setup/boot/) y GitOps; La configuración de prow es fácil de romper si la cambia a mano.

## ¿Cómo funciona realmente la promoción?

Los recursos de kubernetes que se despliegan se definen como archivos YAML en el código fuente de su aplicación en `charts/myapp/templates/*.yaml`. Si no especifica nada, Jenkins X crea recursos predeterminados (un `Service + Deployment`) pero puede agregar cualquier recurso k8s como YAML en esa carpeta (`PVCs, ConfigMaps, Services`, etc.).

Luego, el pipeline de liberación de Jenkins X comprime automáticamente los archivos YAML en un paquete inmutable versionado (usando el mismo número de versión como imagen de Docker, la etiqueta Git y las notas de liberación) y lo despliega en un repositorio de charts de su elección (por defecto, chartmuseum pero usted puede cambiarlo fácilmente a almacenamiento en la nube/nexus/o lo que sea) para que cualquier lanzamiento pueda usar fácilmente la versión inmutable.

La promoción en Jenkins X está completamente separada del lanzamiento y apoyamos la promoción de cualquier lanzamiento si se empaqueta como un chart de Helm. La promoción a través de comando [jx promote](/es/docs/getting-started/promotion/) genera un PR en el repositorio de Git para un entorno (Staging, Canary, Promotion o cualquier otro). Básicamente, se trata de GitOps: especificando qué versiones y configuraciones de qué aplicaciones están en cada entorno utilizando un repositorio Git y configuraciones como código.

El PR activa un pipeline de CI para verificar que los cambios son válidos (por ejemplo, que el chart de Helm existe y se puede descargar, que existen las imágenes de Docker, etc.). Cada vez que el PR se mezclan (podría ser automáticamente o puede requerir tickets reviews/+1s/JIRA/ServiceNow o lo que sea), entonces se activa otro pipeline para aplicar los charts de Helm desde la rama master al clúster k8s de destino y a el `namespace`.

Jenkins X automatiza todo lo anterior, pero dado que ambos pipelines se definen en un repositorio Git de entornos en un fichero `Jenkinsfile`, puede personalizarlo para agregar sus propios pasos previos/posteriores si lo desea. p.ej. puede analizar el YAML para pre-aprovisionar PVs para cualquier PVCs utilizando alguna herramienta de salvas de disco personalizada. O puede hacerlo en una tarea desencadenada por un enlace de Helm. Aunque preferimos que estas herramientas se creen como parte del [modelo de extensión](/docs/contributing/addons/) de Jenkins X para evitar que los pipelines personalizados se dañen en futuras versiones de Jenkins X, aunque no es un gran problema.

## How do I change the owner of a docker image

Cuando se utiliza un registro de docker como gcr.io, el propietario de la imagen de docker `gcr.io/owner/myname:1.2.3` puede ser diferente a su propietario/organización de Git.

En el GCR de Google, esta suele ser su ID de proyecto de GCP; que puede tener muchos proyectos diferentes para agrupar imágenes.

Hay algunas opciones para definir qué propietario de registro de docker usar:

* especificándolo en su fichero `jenkins-x.yml`

```yaml
dockerRegistryHost: gcr.io
dockerRegistryOwner: my-gcr-project-id
```
* especificándolo en el [CRD del Entorno](/docs/reference/components/custom-resources/) llamado `dev` en `env.spec.teamSettings.dockerRegistryOrg`
* defina una variable de entorno `DOCKER_REGISTRY_ORG`

Si no se encuentra ninguno de ellos, el código predeterminado es el propietario del repositorio Git.

Para ampliar los detalles vea el código de para resolverlo [aquí](https://github.com/jenkins-x/jx/blob/65962ff5ef1a6d1c4776daee0163434c9c2cb566/pkg/cmd/opts/docker.go#L14)

## ¿Qué pasa si mi equipo no quiere usar Helm?

Para ayudar a automatizar CI/CD con GitOps, asumimos que los charts de Helm se crean como parte de la configuración automatizada del proyecto y del CI/CD. p.ej. simplemente [importe su código fuente](/docs/resources/guides/using-jx/creating/import/) y se generará una imagen de docker + chart de Helm para usted; los desarrolladores no necesitan saber ni preocuparse si no quieren usar Helm:

Si un desarrollador desea crear específicamente un recurso (por ejemplo, `Secret, ConfigMap`, etc.), simplemente puede hackear el YAML directamente en `charts/myapp/templates/*.yaml`. Cada vez más, la mayoría de los IDE tienen asistentes de IU para crear + editar recursos de kubernetes.

Por defecto, los límites de recursos se colocan en ficheros `values.yaml`, por lo que es fácil personalizarlos según sea necesario en diferentes entornos (solicitudes/límites, chequeos de estados y similares).

Si tiene un desarrollador que se opone a la solución de administración de configuración de helm para configurar el entorno, puede optar por no usar eso y simplemente usar Helm como una forma de versionar y descargar grupos inmutables de YAML y simplemente adherirse a los archivos YAML comunes, digamos, `charts/myapp/templates/deployment.yaml`.

Luego, si desea utilizar otra herramienta de administración de configuración, puede agregarla, p.ej [kustomise support](https://github.com/jenkins-x/jx/issues/2302).

## ¿Cómo cambio el dominio de las aplicaciones sin servidor?

Si utiliza [aplicaciones sin servidor](/docs/guides/tutorials/serverless-apps/) con Knative, no usaremos el mecanismo `exposecontroller` predeterminado para los recursos de `Ingress`, ya que Knative no usa los recursos `Service` de Kubernetes.

Puede solucionar esto editando manualmente la configuración Knative a través de:

```sh
kubectl edit cm config-domain --namespace knative-serving
```

Para ampliar los detalles vea [cómo personalizar el dominio con Knative](https://knative.dev/docs/serving/using-a-custom-domain/)

## ¿Puedo reutilizar exposecontroller para mis aplicaciones?

Debería poder utilizar directamente [exposecontroller](https://github.com/jenkins-x/exposecontroller/blob/master/README.md) en cualquier aplicación que implemente en cualquier entorno (por ejemplo, `Staging` o `Production`) ya que activamos exposecontroller en cada nueva versión.

Usamos [exposecontroller](https://github.com/jenkins-x/exposecontroller/blob/master/README.md) en Jenkins X para manejar la generación de recursos `Ingress` para que podamos admitir todos los DNS en un dominio o automatizar la configuración de HTTPS/TLS junto con la inyección de endpoints externos en aplicaciones con ConfigMaps a través de [anotaciones](https://github.com/jenkins-x/exposecontroller/blob/master/README.md#using-the-expose-url-in-other-resources).

Para que [exposecontroller](https://github.com/jenkins-x/exposecontroller/blob/master/README.md) genere el recurso `Ingress` para un `Service`, simplemente [agregue la etiqueta a su Servicio](https://github.com/jenkins-x/exposecontroller/blob/master/README.md#label). p.ej. agregue esto a sus `charts/myapp/templates/service.yaml`:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: myapp
  annotations:
    fabric8.io/expose: "true"
```

Si desea inyectar la URL o el nombre de host de la URL externa o su `Ingress`, simplemente [use estas anotaciones](https://github.com/jenkins-x/exposecontroller/blob/master/README.md#using-the-expose-url-in-other-resources).

## ¿Cómo agregar anotaciones personalizadas al controlador de entrada?

Puede haber ocasiones en las que necesite agregar sus anotaciones personalizadas al controlador de entradas o al [exposecontroller](https://github.com/jenkins-x/exposecontroller) que `jx` utiliza para exponer servicios.

Puede agregar una lista de anotaciones al Helm Chart del servicio de su aplicación, que se encuentra en el repositorio de código de su aplicación.

Se puede agregar una anotación personalizada en el fichero `charts/myapp/values.yaml` y puede tener el siguiente aspecto:

```yaml
# Default values for node projects.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.
replicaCount: 1
image:
  repository: draft
  tag: dev
  pullPolicy: IfNotPresent
service:
  name: node-app
  type: ClusterIP
  externalPort: 80
  internalPort: 8080
  annotations:
    fabric8.io/expose: "true"
    fabric8.io/ingress.annotations: "kubernetes.io/ingress.class: nginx"

```

Para ver un ejemplo de dónde agregamos múltiples anotaciones y el `exposecontroller` agrega a las reglas de entrada generadas, eche un vistazo a este fichero [values.yaml](https://github.com/jenkins-x/jenkins-x-platform/blob/08a304ff03a3e19a8eb270888d320b4336237005/values.yaml#L655).

## ¿Debo usar un monorepo?

Todos estamos tratando de [acelerar](/about/overview/accelerate/) y entregar valor comercial a nuestros clientes más rápido. Es por eso que a menudo usamos los 2 equipos de pizza y microservicios como una forma de capacitar a los equipos para ir rápido; liberar microservicios de forma independiente sin necesidad de coordinación entre equipos para acelerar las cosas.

Si está desarrollando microservicios en 2 equipos de pizza separados, entonces, como [otros](https://medium.com/@mattklein123/monorepos-please-dont-e9a279be011b), no creemos que deba usar monorepos; en su lugar, use un repositorio por microservicio para que cada mciroservicio pueda liberarse en su propia cadencia de lanzamiento individual.

Monorepo generalmente funciona mejor cuando un solo equipo está trabajando en un monolito que publica todo periódicamente después de cambiar un solo repositorio.

## ¿Cómo puedo utilizar un monorepo?

Hemos centrado la automatización de los CI/CD en Jenkins X para ayudar a los equipos a [acelerar](/about/overview/accelerate/) utilizando microservicios para construir aplicaciones nativas en la nube. Por lo tanto, asumimos repositorios separados para cada microservicio.

Si tiene un monorepo existente que desea importar a Jenkins X, puede hacerlo; solo tenga en cuenta que tendrá que crear y mantener sus propios pipelines para su monorepo. Tan solo modifíquelos en su fichero `jenkins-x.yml` después de importar su monorepo.

Vea cómo [agregar un paso personalizado a su pipeline](/about/concepts/jenkins-x-pipelines/).

## ¿Cómo se inyectan secretos de Vault en entornos de staging/production/preview?

### Staging/Production

De forma predeterminada, [habilitar Vault](/docs/getting-started/setup/boot/#vault) a través de los `jx-requirements.yml` de `jx boot` solo lo activará en sus entornos de pipeline y vista previa, no en staging y producción. Para activarlo también en esos entornos, simplemente agregue un archivo `jx-requirements.yml` a la raíz de su repositorio, con al menos el siguiente contenido:

```yaml
secretStorage: vault
```

Luego, suponiendo que tenga un secreto en Vault con ruta `secret/path/to/mysecret` que contiene la contraseña `password`, puede inyectarla en el servicio `myapp` (por ejemplo, como una variable de entorno `PASSWORD`) agregando lo siguiente a su repositorio staging `/env/values.yaml`:

```yaml
myapp:
  env:
    PASSWORD: vault:path/to/mysecret:password
```

Observe el prefijo con `vault:`: esquema de URL y también que omitimos el primer componente de ruta (`secret/`), ya que se agrega automáticamente. Finalmente, el nombre de la clave está separado de la ruta por dos puntos (`:`).

Si su secreto no es específico del entorno, también puede inyectarlo directamente en el `/charts/myapp/values.yaml` de su aplicación:

```yaml
env:
  PASSWORD: vault:path/to/mysecret:password
```

Sin embargo, tenga en cuenta que este valor se anularía a nivel de entorno si la misma clave también está presente allí.

### Preview

Vault no necesita estar explícitamente habilitado para el entorno de vista previa. Para inyectar el mismo secreto que el anterior en su vista previa, simplemente agregue lo siguiente a el fichero `/charts/preview/values.yaml` de su aplicación:

```yaml
preview:
  env:
    PASSWORD: vault:path/to/mysecret:password
```

## ¿Cómo se inyecta un secreto de Vault a través de un secreto de Kubernetes?

Cuando inyecta secretos directamente en variables de entorno, aparecen en el fichero `Deployment` yaml como texto sin formato, lo que no es aconsejable. Se recomienda inyectarlos en un yaml secreto que se montará como variables de entorno.

Por ejemplo, comience por inyectar el secreto en su repositorio staging `/env/values.yaml`:

```yaml
myapp
  mysecrets:
    password: vault:path/to/mysecret:password
```

Luego, en las plantillas de su aplicación `/charts/myapp/templates`, cree un fichero `mysecrets.yaml`, en el que se refiera al secreto que acaba de agregar:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: mysecrets
data:
  PASSWORD: {{ .Values.mysecrets.password | b64enc }}
```

Observe cómo codificamos el valor secreto en Base64, ya que este es el formato esperado en un yaml secreto.

Además, asegúrese de agregar un valor predeterminado para la misma clave en el fichero `/charts/myapp/values.yaml` de su aplicación:

```yaml
mysecrets:
  password: ""
```

Eso le permite a Helm resolver hasta cierto punto durante el revestimiento de su `mysecrets.yaml`, ya que el revestimiento no parece tener en cuenta los valores del entorno. De lo contrario, podría obtener algo como:

```sh
error: failed to build dependencies for chart from directory '.': failed to lint the chart '.': failed to run 'helm lint --values values.yaml' command in directory '.', output: '==> Linting .
[ERROR] templates/: render error in "myapp/templates/secrets.yaml": template: myapp/templates/secrets.yaml:6:21: executing "myapp/templates/secrets.yaml" at <.Values.mysecrets.password>: nil pointer evaluating interface {}.password
```

Finalmente, monte el yaml secreto como variables de entorno en su aplicación `/charts/myapp/templates/deployment.yaml`:

```yaml
...
    spec:
      containers:
      - name: {{ .Chart.Name }}
        envFrom:
        - secretRef:
            name: mysecrets
...
```