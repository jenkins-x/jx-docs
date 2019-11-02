---
title: Conceptos
linktitle: Conceptos
description: Un resumen de los conceptos en Jenkins X.
weight: 5
aliases:
  - /about/concepts
---

Jenkins X está diseñado para simplificar el trabajo de los desarrolladores según los principios y las mejores prácticas de DevOps. Los enfoques adoptados se basan en la investigación exhaustiva realizada para el libro [*ACCELERATE: Building and Scaling High Performing Technology Organsiations*](https://goo.gl/vZ8BFN). Puedes leer por qué usamos [Accelerate](../overview/accelerate) como base para los principios de Jenkins X.

## Principios
---

*"DevOps es un conjunto de prácticas destinadas a reducir el tiempo entre la confirmación de un cambio en un sistema y el momento en que se aplica en producción, al tiempo que garantiza una alta calidad."*

Los objetivos de los proyectos DevOps son:

* Rápidos tiempos de comercialización
* Mejoras en la frecuencia de despliegues
* Disminución de tiempo entre correcciones
* Disminución del índice de errores por liberaciones
* Aumento del Tiempo Medio de recuperación

Los equipos de alto rendimiento deberían poder desplegarse varias veces al día en comparación con el promedio de la industria que cae entre una vez por semana y una vez por mes.

El tiempo de espera para que el código migre de 'código comprometido' a 'código en producción' debe ser inferior a una hora y la tasa de falla de cambio debe ser inferior al 15%, en comparación con un promedio de entre 31 y 45%.

El tiempo medio para recuperarse de una falla también debe ser inferior a una hora.

Jenkins X ha sido diseñado desde los primeros principios para permitir que los equipos apliquen las mejores prácticas de DevOps para alcanzar los objetivos de rendimiento más importantes de la industria.

## Prácticas
---
Las siguientes mejores prácticas son consideradas clave para manjar una estrategia exitosa de DevOps:

* Arquitectura con Bajo Acoplamiento
* Auto-servicio de Configuración
* Abastecimiento Automático
* Construcción, Integración y Entrega Continuas
* Gestión Automática de Liberaciones
* Pruebas Incrementales
* Configuración de Infraestructura como Código
* Gestión de la Configuración Integral
* Desarrollo basado en un troncos/bases y características con marcas

Jenkins X reúne una serie de metodologías y componentes ya existentes en un enfoque integrado que minimiza la complejidad.

## Arquitectura

Jenkins X se basa en el modelo DevOps de arquitecturas con bajo acoplamiento y está diseñado para ayudar a desplegar grandes cantidades de microservicios distribuidos de manera repetible y manejable a lo largo de múltiples equipos.

<img src="/images/jx-arch.png" class="img-thumbnail">

### Modelo conceptual

<img src="/images/model.png" class="img-thumbnail">

## Construyendo Bloques

Jenkins X se basa en los siguientes principales componentes:

### Kubernetes & Docker
---

En el corazón del sistema está Kubernetes, que se ha convertido en la plataforma de infraestructura virtual de facto para DevOps. Todos los principales proveedores de Cloud ahora ofrecen Kubernetes como servicio bajo demanda y la plataforma también se puede instalar internamente en una infraestructura privada, si es necesario. Los entornos de prueba también se pueden crear en el hardware de desarrollo local utilizando el instalador de Minikube.

Funcionalmente, la plataforma Kubernetes extiende los principios básicos de los Contenedores proporcionados por Docker para abarcar múltiples Nodos físicos.

En resumen, Kubernetes proporciona una infraestructura virtual homogénea que se puede escalar dinámicamente agregando o eliminando nodos. Cada nodo participa en un único espacio grande de red virtual privada plana.

La unidad de despliegue en Kubernetes es el Pod, que comprende uno o más contenedores Docker y algunos metadatos. Todos los contenedores dentro de un Pod comparten la misma dirección IP virtual y espacio de puerto. Los despliegues dentro de Kubernetes son declarativos, por lo que el usuario especifica el número de instancias de una versión determinada de un Pod que se desea desplegar y Kubernetes calcula las acciones necesarias para pasar del estado actual al estado deseado mediante el despliegue o eliminación de Pods en todos los nodos. La decisión de dónde se colocar cada instancia de Pods está influenciada por los recursos disponibles, los recursos deseados y la coincidencia de etiquetas. Una vez desplegados, Kubernetes se compromete a garantizar que el número deseado de Pods de cada tipo permanezca operativo realizando controles de estado periódicos y finalizando/reemplazando los Pods que no responden.

Para imponer cierta estructura, Kubernetes permite la creación de espacios de nombres virtuales que se pueden utilizar para separar los pods lógicamente y para asociar potencialmente grupos de pods con recursos específicos. Los recursos en un espacio de nombres pueden compartir una política de seguridad única, por ejemplo. Se requiere que los nombres de recursos sean únicos dentro de un espacio de nombres, pero se pueden reutilizar en espacios de nombres.

En el modelo Jenkins X, un Pod equivale a una instancia desplegada de un Microservicio (en la mayoría de los casos). Cuando se requiere el escalado horizontal del Microservicio, Kubernetes permite que se desplieguen múltiples instancias idénticas de un Pod determinado, cada una con su propia dirección IP virtual. Estos se pueden agregar en un único punto final virtual conocido como Servicio que tiene una dirección IP única y estática y una entrada DNS local que coincide con el nombre del Servicio. Las llamadas al Servicio se reasignan dinámicamente a la IP de una de las instancias de Pod saludables de forma aleatoria. Los servicios también se pueden usar para reasignar puertos. Dentro de la red virtual de Kubernetes, se puede hacer referencia a los servicios con un nombre de dominio completo en este formato: `<service-name>.<namespace-name>.svc.cluster.local`, que se puede acortar a `<service-name>.<namespace-name>` o simplemente `<service-name>` en el caso de servicios que se encuentran dentro del mismo espacio de nombres. Por lo tanto, un servicio RESTful llamado 'payments' desplegado en un espacio de nombres llamado 'finance' podría referirse en código a través de `http://payments.finance.svc.cluster.local`, `http://payments.finance` o simplemente `http://payments`, dependiendo de la ubicación del código donde se hace la llamada.

Para acceder a los Servicios desde fuera de la red local, Kubernetes necesita la creación de un Ingress para cada Servicio. La forma más común de hacerlo es utilizando uno o más balanceadores de carga con direcciones IP estáticas, que se encuentran fuera de la infraestructura virtual de Kubernetes y redirigen las solicitudes de red a los servicios internos asignados. Al crear una entrada DNS externa para la dirección IP estática del balanceador de carga, es posible asignar servicios a nombres de dominio externos correctamente verificados. Por ejemplo, si nuestro balanceador de carga está asignado a `*.jenkins-x.io`, nuestro servicio de 'payments' podría quedar expuesto como `http://payments.finance.jenkins-x.io`.

Kubernetes representa una plataforma poderosa en constante mejora para desplegar servicios a gran escala, pero también es compleja de entender y puede ser difícil de configurar correctamente. Jenkins X trae a Kubernetes un conjunto de acuerdos predeterminados y algunas herramientas simplificadas con el objetivo de optimizar los propósitos de DevOps y de gestionar los servicios de bajo-acoplamiento.

La herramienta de línea de comandos `jx` proporciona una forma simple de realizar operaciones comunes en instancias de Kubernetes, como ver registros y conectarse a instancias de contenedor. Además, Jenkins X amplía la convención de Kubernetes Namespace para crear entornos (Environments) que se pueden encadenar entre sí y formar una jerarquía de promoción en los flujos de liberación.

Un Entorno (Environment) en Jenkins X puede representar un entorno de infraestructura virtual como Dev, Staging, Production, etc para un equipo de desarrollo determinado. Las reglas de promoción entre entornos se pueden definir para que las versiones se puedan mover de forma automática o manual a través de los diferentes flujos (pipelines). Cada entorno se gestiona siguiendo la metodología GitOps: el estado deseado de un entorno se mantiene en un repositorio de Git y la confirmación o la reversión de los cambios en el repositorio desencadena un cambio de estado asociado en el entorno dado en Kubernetes.

Los clústeres de Kubernetes se pueden crear directamente utilizando el comando `jx create cluster`, lo que facilita la reproducción de clústeres en caso de fallo. Del mismo modo, la plataforma Jenkins X se puede actualizar en un clúster existente utilizando `jx upgrade platform`. Jenkins X admite trabajar con múltiples clústeres de Kubernetes a través de `jx context` y cambiar entre múltiples entornos dentro de un clúster con `jx environment`.

Los desarrolladores deben conocer las capacidades que proporciona Kubernetes para distribuir datos de configuración y credenciales de seguridad en todo el clúster. Los ConfigMaps se puede utilizar para crear conjuntos de llave/valor para metadatos de configuración no confidenciales y los Secrets realizan un mecanismo similar pero encriptado para credenciales de seguridad y tokens. Kubernetes también proporciona un mecanismo para especificar Cuotas de recursos para los Pods, esto es necesario para optimizar los despliegues en todos los nodos y que discutiremos en breve.

Por defecto, el estado del Pod es efímero. Cualquier dato escrito en el sistema de archivos local de un Pod se pierde cuando se elimina ese Pod. Los desarrolladores deben tener en cuenta que Kubernetes puede decidir de forma unilateral eliminar instancias de Pods y volver a crearlos en cualquier momento como parte del proceso general de balanceo de carga para los nodos, por lo que los datos locales pueden perderse en cualquier momento. Cuando se requieren datos con estado, los volúmenes persistentes deben declararse y montarse dentro del sistema de archivos de Pods específicos.

### Helm y Draft
---
La interacción directa con Kubernetes implica realizar configuraciones de forma manual utilizando la línea de comandos `kubectl` o pasando varios tipos de datos YAML a la API. Esto puede ser complejo y está abierto a la aparición de errores humanos. De acuerdo con el principio de DevOps de 'configuración como código', Jenkins X aprovecha Helm y Draft para crear bloques atómicos de configuración para sus aplicaciones.

Helm simplifica la configuración de Kubernetes a través del concepto de Cartas Náuticas (Chart en inglés). El chart es un conjunto de archivos que juntos especifican los metadatos necesarios para implementar una aplicación o servicio en Kubernetes. En lugar de mantener una serie de archivos YAML repetitivos basados en la API de Kubernetes, Helm utiliza un lenguaje de plantillas para crear las especificaciones YAML necesarias a partir de un único conjunto compartido de valores. Esto hace posible especificar aplicaciones Kubernetes reutilizables donde la configuración se puede modificada en el momento del despliegue.