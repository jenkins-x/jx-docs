---
title: Preguntas sobre Tecnología
linktitle: Preguntas sobre Tecnología
description: Preguntas tecnológicas sobre Kubernetes y los proyectos de código abierto asociados
weight: 50
---

## ¿Qué es Helm?

[helm](https://www.helm.sh/) es el administrador de paquetes de código abierto para Kubernetes.

Funciona como cualquier otro administrador de paquetes (brew, yum, npm, etc) donde existen uno o más repositorios de donde se instalan los paquetes. Los paquetes en helm se llaman cartas náuticas (`charts`) para seguir con el tema náutico en kubernetes. Estos `charts` pueden ser buscados, instalados y actualizados.

Un [chart de helm es básicamente un conjunto de ficheros YAML versionados](https://docs.helm.sh/developing_charts/#charts) de kubernetes que se puede instalar fácilmente en cualquier clúster.

Helm permite la composición entre charts (un chart puede contener otro chart) a través del fichero `requirements.yaml`.

## ¿Qué es Skaffold?

[skaffold](https://github.com/GoogleContainerTools/skaffold) en una herramienta de código abierto para construir imágenes de docker en los clústeres de kubernetes y luego desplegarlas/actualizarlas a través de `kubectl` o `helm`.

El reto de construir imágenes de docker dentro del clúster de kubernetes es seleccionar cómo hacerlo, porque existen varias estrategias a seguir para lograr el mismo objetivo, p.ej:

* utilizar el proceso (daemon) y socket local de docker del clúster de kubernetes.
* utilizar el servicio de la nube como por ejemplo Google Cloud Builder
* utilizar un enfoque sin docker-daemon como es [kaniko](https://github.com/GoogleContainerTools/kaniko) que no necesita tener accesso al daemon de docker.

Lo bueno de skaffold es que abstrae su código o CLI de esos detalles; te permite definir la política para construir imágenes de docker en su archivo `skaffold.yaml` para cambiar entre docker daemon, GCB o kaniko, etc.

Skaffold también es realmente útil dentro de [DevPods](/docs/reference/devpods/) para hacer compilaciones incrementales rápidas si cambia el código fuente.

## ¿Cómo se compara Helm con Skaffold?

`helm` le permite instalar/actualizar paquetes llamados charts que utilizan una o más imágenes de docker que se encuentran en algún registro de docker junto con algunos ficheros kubernetes YAML para instalar/actualizar aplicaciones en un clúster de kubernetes.

`skaffold` es una herramienta para realizar construcciones de imágenes de docker y, opcionalmente, volver a desplegar aplicaciones a través de `kubectl` o `helm`, ya sea dentro del pipeline CI/CD o cuando se desarrolla localmente.

Jenkins X utiliza `skaffold` en sus pipelines de CI/CD para crear imágenes de docker. Luego se liberan versiones de imágenes de docker y charts de helm en cada mezcla de master. Luego se promueven los cambios a través de `helm`.

## ¿Qué es exposecontroller?

Resulta que exponer servicios fuera del clúster de Kubernetes puede ser complejo. p.ej.

* ¿Qué dominio usar?
* ¿Debería usar TLS y generar certificados y asociarlos con los dominios?
* ¿Estás usando OpenShift si es así, entonces quizás usar `Route` es mejor que usar `Ingress`?

Entonces, hemos simplificado los microservicios en Jenkins X delegando a un microservicio llamado [exposecontroller](https://github.com/jenkins-x/exposecontroller) el trabajo de ocuparse de estas cosas, como p.ej:

* exponer todos los `Service` que tienen una etiqueta para indicar que están destinados a ser expuestos utilizando el clúster actual
* controla las reglas de exposición de los namespaces como el dominio
* utilizar o no TLS
* utilizar `Route` o `Ingress`

Si mira dentro del repositorio git de su entorno, puede observar que hay 2 `exposecontroller` de forma predeterminada. Ambos `exposecontroller` son [charts de helm](https://github.com/jenkins-x/default-environment-charts/blob/master/env/requirements.yaml).

Estas 2 tareas son utilizadas de forma predeterminada para la generación o limpieza de recursos `Ingress` para exponer los recursos `Services` etiquetados para a los que desee acceder desde fuera del clúster. p.ej aplicación web o api rest.

Puede optar por no utilizar exposecontroller si lo desea, simplemente no use las etiquetas de exposecontroller en sus servicios. Si lo desea, puede eliminar el trabajo de exposecontroller de un entorno, ¡aunque no podrá acceder a ninguno de nuestros QuickStarts desde fuera del clúster si lo hace!