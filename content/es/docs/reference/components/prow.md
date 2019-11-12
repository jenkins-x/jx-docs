---
title: Prow
linktitle: Prow
description: El sistema CI/CD que Kubernetes usa para construirse
parent: "components"
weight: 40
aliases:
  - /docs/managing-jx/common-tasks/prow
  - /architecture/prow
---

Prow es un sistema CI/CD basado en Kubernetes. Los trabajos pueden ser activados por varios tipos de eventos e informar su estado a muchos servicios diferentes. Además de la ejecución del trabajo, Prow proporciona automatización de GitHub en forma de cumplimiento de políticas, operaciones de chat a través de comandos de estilo /foo y mezclas automáticamente las solicitudes de extracción (Pull Request, PR).

Prow tiene una arquitectura de microservicio implementada como una colección de contenedor que se ejecutan como despliegues de Kubernetes.

## hook

Hay un [binario llamado hook](https://github.com/kubernetes/test-infra/tree/master/prow/cmd/hook) que recibe todos los enganches web de GitHub. Es un servidor sin estado que escucha los webhooks de GitHub y los envía a los plugins apropiados. Los plugins de Hook se usan para activar trabajos, implementar comandos en `slash`, publicar en Slack y más. El enlace binario expone un punto final /hook para recibir las solicitudes de enlace web del servidor Git (básicamente todos los enlaces web van a /hook). Hay una regla de ingreso que expone ese punto final al exterior del clúster.

## Prow Plugins

El [binario hook](https://github.com/kubernetes/test-infra/tree/master/prow/cmd/hook) usa diferentes plugins que se pueden habilitar/deshabilitar de forma independiente, para hacer cosas diferentes. Básicamente son controladores de eventos para los diferentes eventos de GitHub recibidos a través de enlaces web. Estos plugins se configuran utilizando una configuración yaml que se pasa desde un ConfigMap de Kubernetes para establecer el enlace, y se puede habilitar por repositorio u organización.
Todos los plugins tienen la misma interfaz. El proceso de enlace pasa dos objetos a cada plugin es: un cliente del plugin que les permite hablar con k8s, git, GitHub, los archivos de propietarios en git repo, slack, etc., y el evento deserializado de GitHub (como IssueCommentEvent).

### lgtm plugin

[El plugin LGTM](https://github.com/kubernetes/test-infra/tree/master/prow/plugins/lgtm) es un buen ejemplo para comenzar a usar plugins. Es un complemento que agrega la etiqueta LGTM cuando alguien comenta /lgtm en una solicitud de extracción.

### UpdateConfig plugin

[Un plugin que actualiza automáticamente un ConfigMap](https://github.com/kubernetes/test-infra/tree/master/prow/plugins/updateconfig) cada vez que se mezcla un PR en un repositorio. De esta forma, puede mantener actualizados automáticamente sus ConfigMaps, siguiendo un flujo de GitOps.
Puede asignar archivos específicos a ConfigMaps, o incluso usar expresiones regulares.
Normalmente se usa para actualizar el ConfigMap que contiene la configuración de Prow, por lo que cada vez que un PR se mezcla con cambios en los archivos que contienen la configuración de Prow, ConfigMap se actualizará automáticamente.

### Trigger plugin

Probablemente el plugin más importante. Es un plugin que reacciona a los comentarios en los PR, por lo que podemos desencadenar construcciones (escribiendo "prueba" como un comentario o cualquier otro desencadenante). Determina qué trabajos ejecutar en función de la configuración del trabajo. Cuando encuentra un trabajo que necesita ser activado, crea un [ProwJob CRD](https://github.com/kubernetes/test-infra/blob/master/prow/apis/prowjobs/v1/types.go#L85), utilizando la configuración que se encuentra en el enganche del ConfigMap (de esa manera puede crear un objeto [ProwJob](https://github.com/kubernetes/test-infra/blob/master/prow/apis/prowjobs/v1/types.go#L85) diferente dependiendo de la organización o repositorio, como usar un agente de construcción diferente (Jenkins vs Knative vs pods), el tipo de trabajo, etc. Este CRD contiene algunos campos interesantes:

- agent: para seleccionar qué controlador k8s se encargará de este trabajo
- refs: Repositorio y revisión de GitHub para usar para el código fuente
- type: ya sea envío previo o posterior al envío (ejecute el trabajo antes de mezclar o publicar)
- pod_spec: especificación para crear un objeto Pod, si usamos [plank](https://github.com/kubernetes/test-infra/tree/master/prow/plank)
- build_spec: especificación para crear un [objeto Knative Build](https://github.com/knative/docs/blob/master/build/builds.md), si se está utilizando [prow-build](https://github.com/kubernetes/test-infra/blob/master/prow/cmd/build/controller.go)

El ciclo de vida de un [ProwJob](https://github.com/kubernetes/test-infra/blob/master/prow/apis/prowjobs/v1/types.go#L85) es gestionado por el controlador de ProwJob que está ejecutándose en el clúster. Los posibles estados del ProwJob son:

- triggered: el trabajo ha sido creado pero aún no está programado.
- pending: el trabajo ha sido programado pero no ejecutado.
- Success/failure: El trabajo se ha completado.
- aborted: significa que Prow detuvo el trabajo antes de tiempo (nueva confirmación empujada, tal vez).
- error: significa que el trabajo no ha sido programado (tal vez por una mala configuración).

#### Job Type

En la configuración de Prow, puede configurar trabajos de Presubmits y Postsubmits por repositorio que se activan con el plugin de activación. Los envíos previos (`Presubmits`) se ejecutan cuando el código PR cambia (abriendo un nuevo PR o enviando código a la rama del PR), para que pueda probar los cambios en su nuevo código. Las publicaciones posteriores (`Postsubmits`) se ejecutan cada vez que aparece una nueva confirmación en una rama de origen (evento push de GitHub).

El caso de uso para envíos posteriores es donde puede haber menos de 100 mezclas por día en un repositorio de gran volumen, pero podría haber diez o cien veces más que muchos trabajos de envío previo ejecutados. Los envíos de correos se pueden usar cuando algo es muy costoso de probar y no necesariamente bloquea la mezcla, pero sí desea señal. Del mismo modo, la forma en que mezcla el sistema es que su verificación previa al envío se ejecutará con su código mezclado en la rama a la que se dirige, por lo que técnicamente el compromiso de mezcla que termina en la rama `master` ya se ha probado de manera efectiva y, a menudo, esto significa que puede desea un trabajo de envío previo pero no duplicarlo también, ya que no le da más señal.

### ProwJob controllers

Más tarde, podemos usar diferentes operadores de Kubernetes que reaccionan a los objetos ProwJob para ejecutar nuestras construcciones, en función del campo del agente (cada operador busca ProwJobs con un valor de agente específico):

- [Plank](https://github.com/kubernetes/test-infra/blob/master/prow/plank/controller.go) es uno que utiliza pods de Kubernetes. Usa el campo `pod_spec`.
- [prow-build](https://github.com/kubernetes/test-infra/blob/master/prow/cmd/build/controller.go) es un operador de construcción que utiliza Knative Build CRD. Utiliza el campo `build_spec`.
- There is a [jenkins-operator](https://github.com/kubernetes/test-infra/blob/master/prow/jenkins/controller.go) que se ejecuta en Jenkins. Esto no se recomienda actualmente.

Estos controladores administran [el ciclo de vida de un ProwJob](https://github.com/kubernetes/test-infra/blob/master/prow/life_of_a_prow_job.md).

#### [plank](https://github.com/kubernetes/test-infra/tree/master/prow/plank)
Plank es un operador de Kubernetes que reacciona a los recursos personalizados de ProwJob. Crea un Pod para ejecutar la compilación asociada con el objeto ProwJob. El objeto ProwJob en sí contiene un PodSpec.

- Si ProwJob no tiene un Pod, crea un pod para ejecutar la construcción. Use init-container para hacer la obtención de VCS.
- Si ProwJob tiene un Pod con estado completado, marque ProwJob como completado.
- Si se completa ProwJob, no haga nada.

Nosotros utilizamos construcciones Knative en Jenkins X, que utilizan el [controlador prow-build](https://github.com/kubernetes/test-infra/blob/master/prow/cmd/build/controller.go), por lo que no tiene que preocuparse por plank.

#### [prow-build](https://github.com/kubernetes/test-infra/blob/master/prow/cmd/build/controller.go)
Operador de Kubernetes que observa los objetos de ProwJob y reacciona a aquellos cuyo campo de agente es el agente de construcción Knative. Creará [un objeto Knative Build](https://github.com/knative/docs/blob/master/build/builds.md) basado en el campo `build_spec` del objeto ProwJob.
[El controlador de construcción de Knative](https://github.com/knative/build/blob/master/cmd/controller/main.go) reacciona y crea un Pod para ejecutar la construcción. Todos los ProwJob, Build y Pod tienen el mismo nombre (un UUID).

El objeto Build contiene campos interesantes:

- serviceAccountName: [ServiceAccount contiene los Secrets necesarios para acceder al servidor Git o al registro Docker](https://github.com/knative/docs/blob/master/build/auth.md).
- source: Repositorio y revisión de Git para usar para el código fuente.
- steps: Especifica una o más imágenes de contenedores que desea ejecutar en su construcción. Cada imagen de contenedor se ejecuta hasta su finalización o hasta que se detecta la primera falla.
- template: contiene el nombre de un Knative BuildTemplate registrado, junto con las variables de entorno para pasar al objeto Build. La plantilla debe ser un objeto BuildTemplate que exista en el clúster. **Si se define el campo de plantilla, el campo de pasos se ignorará**.

##### Steps

Los pasos en una compilación son las diferentes acciones que se ejecutarán como parte de esa construcción. Cada paso en una construcción que debe especificar una imagen del Builder, o el tipo de imagen del contenedor que se adhiere al [Contrato del constructor Knative](https://github.com/knative/docs/blob/master/build/builder-contract.md) . Estos pasos/imágenes del constructor

- Se ejecutan y evalúan en orden, comenzando desde la parte superior del archivo de configuración.
- Cada uno se ejecuta hasta su finalización o hasta que se detecta la primera falla.
- Tener dos volúmenes que se comparten entre todos los pasos. Uno se montará en /workspace, que contiene el código especificado en el campo fuente Build. Otro es /builder/home que está montado en $HOME, y se usa principalmente para guardar archivos de credenciales que se usarán en diferentes pasos.

Una imagen del builder es una imagen especial que podemos ejecutar como un paso de Build CRD, y que normalmente es un contenedor especialmente diseñado cuyo punto de entrada es una herramienta que realiza algunas acciones y sale con un estado cero en caso de éxito. Estos puntos de entrada suelen ser herramientas de línea de comandos, por ejemplo, git, docker, mvn, etc.

##### BuildTemplate

[Un BuildTemplate](https://github.com/knative/docs/blob/master/build/build-templates.md) encapsula un proceso de compilación compartida con algunas capacidades de parametrización limitadas.

Una plantilla contiene pasos para ejecutar en la compilación. En lugar de especificar los mismos pasos en diferentes compilaciones, podemos reutilizar esos pasos creando una BuildTemplate que contenga estos pasos. Utilizamos BuildTemplates para compartir pasos entre diferentes Builds. Hay [BuildTemplates de la comunidad](https://github.com/knative/build-templates/) que puede usar, o puede definir sus propias plantillas.

###### Jenkins X Build Templates

Jenkins X utiliza BuildTemplates personalizadas para ejecutar las compilaciones de las aplicaciones. En [este repositorio](https://github.com/jenkins-x/jenkins-x-serverless) puede encontrar las diferentes BuildTemplates disponibles, según el lenguaje de la aplicación. Estas BuildTemplates usan una imagen de constructor de Step diferente según el lenguaje, ya que tienen que construir la aplicación usando diferentes herramientas como maven, go o Gradle. Por lo tanto, cada imagen de Builder tiene diferentes herramientas instaladas, aunque eventualmente todas las imágenes de Builder básicamente ejecutan [Jenkins sin servidor](/news/serverless-jenkins/) (también conocido como [Jenkinsfile-Runner](https://github.com/jenkinsci/jenkinsfile-runner)). Eso permite que nuestras compilaciones definan los pasos en un Jenkinsfile. Todos estos pasos se ejecutan dentro del mismo [contenedor Jenkinsfile Runner](https://hub.docker.com/r/jenkins/jenkinsfile-runner/dockerfile/), que no coincide con el modelo de pasos de Knative Build.

##### El trabajo se ejecuta dentro del Pod

El Pod que se creó para ejecutar la compilación real tiene un contenedor que no hace nada, pero tiene contenedores de inicio para realizar los pasos necesarios para ejecutar el trabajo:

- [creds-init](https://github.com/knative/build/tree/master/cmd/creds-init): Los Secrets de la cuenta de servicio se montan en /var/build-secrets/ para que este contenedor tenga acceso a ellos. Los agrega en sus respectivos archivos de credenciales en $HOME, que es otro volumen compartido entre todos los pasos. Típicamente credenciales para el servidor git y el registro de docker.
- [git-init](https://github.com/knative/build/tree/master/cmd/git-init): clona el repositorio SHA/revisión Git especificado en uno de los volúmenes compartidos /workspace
- Otro contenedor de inicio para cada paso definido en Build o BuildTemplate.

Recuerde que cada contenedor de inicio usa su propia imagen de contenedor. Además, tienen diferentes namespaces de Linux del sistema de archivos. Pero tienen algunos volúmenes compartidos como las carpetas $HOME y /workspace.

## sinker

[Recolector de basura](https://github.com/kubernetes/test-infra/tree/master/prow/cmd/sinker) para ProwJobs y Pods creados para ejecutar compilaciones. Elimina ProwJobs completos después de 2 días y pods completados después de 30 minutos.

## crier

Otro controlador de Kubernetes que mira CRD de ProwJobs. Contiene diferentes notificadores de los cambios de ProwJob a clientes externos, como la verificación del estado de GitHub o un mensaje a PubSub.

Se utiliza para actualizar el estado de confirmación de GitHub cuando finaliza ProwJob.

## deck
[Presenta una UI de trabajos recientes](https://prow.k8s.io/) e [información de ayuda de comandos/plugins](https://prow.k8s.io/command-help).

## tide

Los RP que satisfacen un conjunto de criterios predefinidos se pueden configurar para que [Tide](https://github.com/kubernetes/test-infra/blob/master/prow/cmd/tide/README.md) los mezcle automáticamente. Volverá a probar automáticamente los RP que cumplan con los criterios ("marea alta") y los mezclará automáticamente cuando tengan resultados de prueba aprobados ("marea baja").

Consultará a GitHub de vez en cuando tratando de mezclar las solicitudes de extracción. No reacciona a los eventos, no es un plugin.

## Esfuerzos en curso

Uso de contenedores de inicio para los pasos [puede cambiar en el futuro](https://github.com/knative/build/pull/470), debido a limitaciones en los contenedores de inicio.
Knative Build CRD está en desuso en favor de Pipeline CRD. Build CRD será reemplazado por el nuevo Task CRD, pero son muy similares.