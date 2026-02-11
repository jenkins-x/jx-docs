---
title: Problemas comunes
linktitle: Problemas comunes
description: Preguntas sobre problemas comunes configurando Jenkins X.
weight: 50
---

Hemos tratado de recopilar problemas comunes aquí con soluciones alternativas. Si su problema no aparece en esta lista, [infórmenos](https://github.com/jenkins-x/jx/issues/new).

## Jenkins X no se inicia

Si su instalación no se inicia, podría haber algunas razones diferentes por las que los módulos Jenkins X no se inician.

Su clúster podría estar sin recursos. Puede revisar los recursos de reserva de su clúster a través del comando [jx status](/commands/jx_status/):

```sh
$ jx status
```

También tenemos un comando de diagnóstico para detectar problemas comunes, [jx step verify install](/commands/jx_step_verify_install/):

```sh
$ jx step verify install
```

Un problema común para lo cual pudieran no iniciar los pods es si el clúster no tiene una [clase de almacenamiento predeterminado](https://kubernetes.io/docs/concepts/storage/storage-classes/) configurada, por lo tanto, los recursos `Persistent Volume Claims` no pueden obtener los `Persistent Volumes` como se describe en las [instrucciones de instalación](/docs/resources/guides/managing-jx/common-tasks/install-on-cluster/).

Puede revisar su clase de almacenamiento y volúmenes persistentes a través de:

```sh
$ kubectl get pvc
```

Si las cosas están funcionando debe ver algo similar a esto:

```sh
$ kubectl get pvc
NAME                        STATUS    VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
jenkins                     Bound     pvc-680b39b5-94f1-11e8-b93d-42010a840238   30Gi       RWO            standard       12h
jenkins-x-chartmuseum       Bound     pvc-6808fb5e-94f1-11e8-b93d-42010a840238   8Gi        RWO            standard       12h
jenkins-x-docker-registry   Bound     pvc-680a415c-94f1-11e8-b93d-42010a840238   100Gi      RWO            standard       12h
jenkins-x-mongodb           Bound     pvc-680d6fd9-94f1-11e8-b93d-42010a840238   8Gi        RWO            standard       12h
jenkins-x-nexus             Bound     pvc-680fc692-94f1-11e8-b93d-42010a840238   8Gi        RWO            standard       12h
```

Puede ver el estado (`status`) en `Pending` entonces significa que no tiene la [clase de almacenamiento predetermianda](https://kubernetes.io/docs/concepts/storage/storage-classes/) configurada en su clúster de Kubernetes, o te puedes haber quedado sin espacio de almacenamiento.

Por favor, intente crear una [clase de almacenamiento predeterminada](https://kubernetes.io/docs/concepts/storage/storage-classes/) para su clúster o contacte con el equipo de operaciones - proveedor cloud.

Si todos los `Persistent Volume Claims` tienen el estado `Bound` y todavía no se ha iniciado, entonces intente:

```sh
$ kubectl get pod
```

Si un pod no puede iniciarse, intente:

```sh
$ kubectl describe pod some-pod-name
```

Tal vez este comando le de alguna pista. Podría estar relacionado RBAC?

Si todavía está atascado envíenos la descripción del problema [create an issue](https://github.com/jenkins-x/jx/issues/new).

## http: el servidor dio respuesta HTTP al cliente HTTPS

Si su pipeline ha fallado con algo similar a esto:

```sh
The push refers to a repository [100.71.203.90:5000/lgil3/jx-test-app]
time="2018-07-09T21:18:31Z" level=fatal msg="build step: pushing [100.71.203.90:5000/lgil3/jx-test-app:0.0.2]: Get https://100.71.203.90:5000/v1/_ping: http: server gave HTTP response to HTTPS client"
```

Esto significa que está utilizando el registro de Docker interno de Jenkins X para sus imágenes, pero el servicio de Docker de su clúster de Kubernetes no ha sido configurado para registros inseguros (`insecure-registries`), por lo que tiene que utilizar `http` para acceder al servicio del registro Docker `jenkins-x-docker-registry` en su cluster.

Por defecto, Docker desea que todos los registros sean expuestos a través de `https` y utilizar TLS y certificados. Esto debe estar garantizado por todos los registros públicos. Sin embargo, al utilizar Jenkins X con un registro de Docker interno es difícil lograrlo porque no hay un nombre DNS público disponible y no se tiene HTTPS or certificados; por lo que de forma predeterminada se necesita tener registros inseguros configurados (`insecure-registry`) en todos los servicios de Docker en sus nodos Kubernetes.

Intentamos automatizar esta configuración cuando usamos `jx create cluster`, p.ej en AWS, el valor predeterminado es el rango de IP `100.64.0.0/10` para que coincida con la mayoría de las direcciones IP del servicio Kubernetes.

En [EKS](/commands/jx_create_cluster_eks/), usamos ECR de manera predeterminada para evitar este problema. Del mismo modo, pronto cambiaremos por defecto a GCR y ACR en GKE y AKS respectivamente.

Por lo tanto, una solución alternativa es utilizar un [registro real de contenedores externos](/docs/resources/guides/managing-jx/common-tasks/docker-registry/) o habilitar el registro inseguro (`insecure-registry`) en sus demonios de Docker en sus nodos en su clúster de Kubernetes.

## Helm falla con el Error: UPGRADE FAILED: incompatible versions client[...] server[...]'

En términos generales, esto sucede cuando su laptop tiene una versión de Helm diferente a la versión utilizada en nuestras imágenes de Docker y/o la versión de Helm que se ejecuta en su servidor.

La solución más simple para esto es [no usar tiller en absoluto](/news/helm-without-tiller/), lo que en realidad ayuda a evitar que este problema suceda y resuelve una serie de problemas de seguridad también.

Sin embargo, cambiar de usar Tiller a No Tiller requiere una re-instalación de Jenkins X (¿aunque podría intentar hacerlo en un conjunto separado de namespaces y luego mover los proyectos gradualmente?).

La solución manual es instalar [la misma versión de Helm que la utilizada en el servidor](https://github.com/helm/helm/releases)

O puede intentar cambiar Tiller para que coincida con la versión de su cliente:

* ejecute `helm init --upgrade`

Aunque tan pronto como se ejecute un pipeline, cambiará la versión de Helm nuevamente, por lo que deberá seguir repitiendo lo anterior.

## error creando credenciales de Jenkins jenkins-x-chartmuseum 500 Server Error

Esto es un [problema pendiente](https://github.com/jenkins-x/jx/issues/1234) que resolveremos lo antes posible.

Básciamente sucede cuando tienes un token viejo de API en `~/.jx/jenkinsAuth.yaml` para la URL del servidor Jenkins. Tú también puedes:

* eliminarlo del fichero manualmente
* ejecutar el siguiente comando [jx delete jenkins token](/commands/deprecation/):

        $ jx delete jenkins token admin

## errores con chartmuseum.build.cd.jenkins-x.io

Si ve un error como este:

```sh
error:failed to add the repository 'jenkins-x' with URL 'https://chartmuseum.build.cd.jenkins-x.io'
```

o

```sh
Looks like "https://chartmuseum.build.cd.jenkins-x.io" is not a valid chart repository or cannot be reached
```

entonces parece que tienes una referencia hacia una URL caducada del chartmuseum para los charts en Jenkins X.

La nueva URL es: http://chartmuseum.jenkins-x.io

Puede ser que tu instalación Helm tenga una URL del repositorio vieja. Puedes verla así:

```sh
$ helm repo list
NAME     	URL
stable   	https://kubernetes-charts.storage.googleapis.com
jenkins-x	http://chartmuseum.jenkins-x.io
```

Si está viendo esto ...

```sh
$ helm repo list
NAME     	URL
jenkins-x	https://chartmuseum.build.cd.jenkins-x.io
```

entonces por favor, ejecute ...

```sh
helm repo remove jenkins-x
helm repo add jenkins-x	http://chartmuseum.jenkins-x.io
```

y podrá resolver su problema y seguir adelante.

Otra causa posible es tener una URL vieja en tu repositorio Git del entorno, tal vez tenga una referencia a la anterior URL.

Entonces abra su fichero `env/requirements.yaml` en sus repositorios Git staging/production y modifíquelos para usar la URL http://chartmuseum.jenkins-x.io en lugar de **chartmuseum.build.cd.jenkins-x.io** como este [fichero de requisitos](https://github.com/jenkins-x/default-environment-charts/blob/master/env/requirements.yaml).

## errores de git: POST 401 Bad credentials

Esto indica que su token API de git se ingresó incorrectamente o se ha regenerado y ahora es incorrecto.

Para recrearlo con un nuevo valor de token de API, intente lo siguiente (cambiar el nombre del servidor git para que coincida con su proveedor git):

```sh
$ jx delete git token -n github <yourUserName>
$ jx create git token -n github <yourUserName>
```

Puede ver más detalles en [cómo utilizar Git y Jenkins X aquí](/docs/resources/guides/managing-jx/common-tasks/git/).

## Invalidar token git para escanear un proyecto

Si recibe un error en Jenkins cuando intenta escanear sus repositorios en busca de ramas, algo como:

```sh
hudson.AbortException: Invalid scan credentials *****/****** (API Token for acccessing https://github.com git service inside pipelines) to connect to https://api.github.com, skipping
```

Entonces su token para la API de Git debe ser incorrecta o estar vencida.

Para recrear el valor del token para la API intente lo siguiente (cambiar el nombre del servidor git para que coincida con su proveedor git):

```sh
$ jx delete git token -n GitHub admin
$ jx create git token -n GitHub admin
```

Puede ver más detalles en [cómo utilizar Git y Jenkins X aquí](/docs/resources/guides/managing-jx/common-tasks/git/).

## ¿Cuáles son las credenciales para acceder a los servicios principales?

Los servicios principales autenticados de Jenkins X incluyen Jenkins, Nexus, ChartMuseum. El nombre de usuario predeterminado es `admin` y la contraseña por defecto se genera e imprime en el terminal después de `jx create cluster` o `jx install`.

### Establecer nombre de usuario y contraseña de administrador para los servicios principales

Puede establecer nombre del usuario de administración a través del parámetro `--default-admin-username=username`.

{{< alert >}}
Quizás esté utilizando el dominio de seguridad de Active Directory en Jenkins. Es en este escenario que tiene sentido configurar el nombre de usuario de administrador a través de `--default-admin-username` según sus cuentas de servicio existentes.

También puede pasar este valor a través de `myvalues.yaml`.
{{< /alert >}}

Si desea establecer la contraseña predeterminada usted mismo, puede establecer el indicador `--default-admin-password=foo` en los dos comandos anteriores.

Si ya no tiene la salida de la consola del terminal, puede buscar en el archivo local `~/.jx/jenkinsAuth.yaml` y encontrar la contraseña que coincida con la URL de su servidor Jenkins para el clúster deseado.

## Persistent Volume Claims no se enlazan

Si observa que las peticiones de volumen persistentes creados al instalar Jenkins X no se unen con

    $ kubectl get pvc

Debe comprobar que tiene una clase de almacenamiento predeterminada de clúster para el aprovisionamiento dinámico de volumen persistente. Consulte [aquí](https://kubernetes.io/docs/concepts/storage/dynamic-provisioning/) para obtener más detalles.

## No puedo conectarme a nodos en AWS

Si no ve ningún nodo válido devuelto por `kubectl get node` u obtiene errores al ejecutar` jx status`, algo como:

```sh
Unable to connect to the server: dial tcp: lookup abc.def.regino.eks.amazonaws.com on 10.0.0.2:53: no such host
```

podría ser que su configuración de kube esté obsoleta. Tratar

```sh
aws eks --region <CLUSTER_REGION> update-kubeconfig --name <CLUSTER_NAME>
```

Eso debería regenerar su archivo local `~/kube/config` y entonces `kubectl get node` o `jx status` deberían encontrar sus nodos

## ¿Cómo puedo diagnosticar problemas de exposecontroller?

Cuando promueve una nueva versión de su aplicación a un entorno, como el entorno Staging, se genera un PR en el repositorio del entorno.

Cuando el pipeline del master se ejecuta en un entorno, se crea un `Job` de Kubernetes para [exposecontroller](https://github.com/jenkins-x/exposecontroller) que ejecuta un pod hasta que finaliza.

Puede ser complicado encontrar el registro para trabajos temporales ya que se elimina el pod.

Una manera de diagnosticar los registros en su entorno Staging, es [descargar e instalar kail](https://github.com/boz/kail) y agregarlo a su `PATH`.

Luego ejecute este comando:

```sh
kail -l job-name=expose -n jx-staging
```

Si luego promueve el entorno Staging o vuelve a activar el pipeline en la rama `master` de su repositorio Git de Staging (p.ej, a través de [jx start pipeline](/commands/jx_start_pipeline/)), debería ver la salida del [exposecontroller] (https://github.com/jenkins-x/exposecontroller) pod.

## ¿Por qué la promoción es realmente lenta?

Si encuentra que recibe muchas advertencias en sus pipelines como esta ...

```sh
"Failed to query the Pull Request last commit status for https://github.com/myorg/environment-mycluster-staging/pull/1 ref xyz Could not find a status for repository myorg/environment-mycluster-staging with ref xyz
```

y la promoción demora 30 minutos desde la liberación de un pipeline en una aplicación que comienza con el cambio que afecta a `Staging`, y probablemente se deba principalmente a Webhooks.

Cuando [importamos proyectos](/docs/resources/guides/using-jx/creating/import/) o [creamos inicios rápidos](/es/docs/getting-started/first-project/create-quickstart/), automatizamos la configuración de los pipelines de CI/CD para el repositorio Git. Lo que esto hace es configurar Webhooks en el repositorio de Git para activar Jenkins X para activar pipelines (ya sea usando Prow para [Jenkins X Pipelines sin servidor](/es/about/concepts/jenkins-x-pipelines/) o el servidor estático jenkins si no).

Sin embargo, a veces su proveedor de Git (por ejemplo, [GitHub](https://github.com/) puede no poder conectarse a su instalación Jenkins X (por ejemplo, debido a problemas de red/firewall).

La forma más fácil de diagnosticar esto es abrir el repositorio Git (por ejemplo, para el repositorio de su entorno).

```sh
jx get env
```

Entonces:

* clic en la URL generada para, p.ej, su repositorio Git de `Staging`
* clic el icon `Settings`
* selecciona el tab `Webhooks` en la izquierda
* selecciona la URL del webhook de Jenkins X
* vea el último webhook - ¿Tuvo éxito? Intenta reactivarlo? Eso debería resaltar cualquier problema de red, etc.

Si no puede usar webhooks públicos, puede mirar algo como [ultrahook] (http://www.ultrahook.com/)

## No puede crear un clúster en minikube

Si estás utilizando Mac, entonces `hyperkit` es el mejor controlador de Máquinas Virtuales a utilizar - pero necesita que instale primero [Docker para Mac](https://docs.docker.com/docker-for-mac/install/). Inténtenlo y vuelva a ejecutar el comando `jx create cluster minikube`.

Si su minikube está fallando al inicio, entonces puede intentar:

```sh
$ minikube delete
$ rm -rf ~/.minikube
```

Si el comando `rm` falla, tal vez necesite:

```sh
sudo rm -rf ~/.minikube
```

Ahora intente `jx create cluster minikube` nuevamente: ¿eso ayudó? A veces hay certificados obsoletos o archivos que cuelgan de antiguas instalaciones de minikube que pueden romper cosas.

A veces, un reinicio puede ayudar en casos donde la virtualización sale mal ;)

De lo contrario, puede intentar seguir las instrucciones del minikube

* [instalar minikube](https://github.com/kubernetes/minikube#installation)
* [ejecutar minikube start](https://github.com/kubernetes/minikube#quickstart)

## Minkube e hyperkit: No puede encontrar la dirección IP

Si está utilizando minikube en un mac con hyperkit y encuentra que minikube no puede comenzar con un registro como:

```sh
Temporary Error: Could not find an IP address for 46:0:41:86:41:6e
Temporary Error: Could not find an IP address for 46:0:41:86:41:6e
Temporary Error: Could not find an IP address for 46:0:41:86:41:6e
Temporary Error: Could not find an IP address for 46:0:41:86:41:6e
```

Es posible que haya encontrado [este problema en minikube e hyperkit](https://github.com/kubernetes/minikube/issues/1926#issuecomment-356378525).

La solución es intentar lo siguiente:

```sh
$ rm ~/.minikube/machines/minikube/hyperkit.pid
```

Entonces vuelva a intentarlo. Esperamos que esta vez funcione correctamente!

## No se puede acceder a los servicios en minikube

Al ejecutar minikube localmente, `jx` usa de manera predeterminada [nip.io](http://nip.io/) como una forma de usar nombres DNS agradables para los servicios y evitar el hecho de que la mayoría de las computadoras portátiles no pueden usar DNS. Sin embargo, a veces [nip.io](http://nip.io/) tiene problemas y no funciona.

Para evitar usar nip.io, puede hacer lo siguiente:

Edite el archivo `~/.jx/cloud-environments/env-minikube/myvalues.yaml` y agregue el siguiente contenido:

```yaml
expose:
  Args:
    - --exposer
    - NodePort
    - --http
    - "true"
```

Luego, vuelva a ejecutar `jx install` y esto cambiará los servicios que se expondrán en los puertos de nodo en lugar de usar el ingreso y DNS.

Entonces, si escribes:

```sh
jx open
```

Verá todas las UR del formulario `http://$(minikube ip):somePortNumber` que luego evita pasar por [nip.io](http://nip.io/), solo significa que las URL son un poco más crípticas utilizando números de puerto mágicos en lugar de simples nombres de host.

## ¿Cómo obtengo la contraseña y el nombre de usuario para Jenkins?

Instale [KSD](https://github.com/mfuentesg/ksd) ejecutando `go get github.com/mfuentesg/ksd` y luego ejecute `kubectl get secret jenkins -o yaml | ksd`

## ¿Cómo veo el registro de exposecontroller?

Por lo general, ejecutamos el `exposecontroller` como un trabajo posterior a la instalación cuando realizamos la promoción a `Staging` o `Production` para exponer servicios sobre Ingress y posiblemente inyectar URL externas en la configuración de las aplicaciones.

Por lo tanto, el `Job` activará un `Pod` de corta duración para que se ejecute en el namespace de su entorno, luego se eliminará el pod.

Si desea ver los registros del `exposecontroller`, deberá observar los registros utilizando un selector y luego activar el pipeline de promoción para capturarlo.

Una forma de hacerlo es a través de la CLI de [kail](https://github.com/boz/kail):

```sh
$ kail -l  job-name=expose
```

Esto buscará registros de exposecontroller y luego los volcará a la consola. Ahora active un pipeline de promoción y debería ver la salida dentro de un minuto más o menos.

## No se pueden crear certificados TLS durante la configuración de Ingress

> [cert-manager](https://docs.cert-manager.io/en/latest/index.html) cert-manager es un proyecto separado de _Jenkins X_.

Los clústeres GKE recién creados o el clúster existente que ejecuta Kubernetes **v1.12** o anterior encontrarán el siguiente error al configurar Ingress con TLS en todo el sitio:

```sh
Waiting for TLS certificates to be issued...
Timeout reached while waiting for TLS certificates to be ready
```

Este problema se debe a que el pod _cert-manager_ no tiene la etiqueta `disable-validation` establecida, que es un problema conocido de cert-manager que [está documentado en su sitio web](https://docs.cert-manager.io/en/latest/getting-started/install/kubernetes.html). Los siguientes pasos, tomados de la página web [cert-manager/troubleshooting-installation](https://docs.cert-manager.io/en/latest/getting-started/troubleshooting.html#troubleshooting-installation), deberían resolver el problema:

Compruebe si existe la etiqueta _disable-validation_ en el pod de cert-manager.

```sh
$ kubectl describe namespace cert-manager
```

Si no puede ver la etiqueta `certmanager.k8s.io/disable-validation=true` en su namespace, debe agregarla con:

```sh
$ kubectl label namespace cert-manager certmanager.k8s.io/disable-validation=true
```

Confirme que la etiqueta ha sido adicionada al pod _cert-manager_.

```sh
$ kubectl describe namespace cert-manager

Name:         cert-manager
Labels:       certmanager.k8s.io/disable-validation=true
Annotations:  <none>
Status:       Active
...
```

Ahora vuelva a ejecutar la configuración Ingres con _jx_:

```sh
jx upgrade ingress
```

Mientras se ejecuta el comando ingress, puede seguir los registros de _cert-manager_ en otra terminal y ver qué está sucediendo. Necesitará encontrar el nombre de su pod _cert-manager_ usando:

```sh
kubectl get pods --namespace cert-manager
```

Entonces imprima los registros del pod _cert-manager_.

```sh
kubectl logs YOUR_CERT_MNG_POD --namespace cert-manager -f
```

Sus certificados TLS ahora deberían estar configurados y funcionando, de lo contrario, consulte las instrucciones oficiales de [solución de problemas del administrador de certificados](https://docs.cert-manager.io/en/latest/getting-started/troubleshooting.html).

## Other issues

Por favor [háganos saber](https://github.com/jenkins-x/jx/issues/new) si podemos ayudar? ¡Buena suerte!