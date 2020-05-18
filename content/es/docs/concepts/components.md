---
title: Componentes
linktitle: Componentes
description: Resumen de componentes de una típica instalación de Jenkins X
weight: 10
---

Una instalación de Jenkins X consiste en:

* un Entorno de Desarrollo por equipo que corresponde con un [namespace en Kubernetes](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/)
* de cero a muchos otros [Entornos Permanentes](/es/about/concepts/features/#entornos)
  * lo que está listo para se utilizado es que cada equipo tenga su propios entornos de `Staging` y `Production`
  * cada equipo puede tener tantos entornos como deseen y pueden nombrarlos de la manera que prefieran
* opcional [Vista Previa del Entorno](/es/about/concepts/features/#entornos-de-vista-previa)

Normalmente cada entorno es asociado con su propio [namespace en Kubernetes](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) para garantizar un correcto aislamiento entre entornos.

Técnicamente 2 equipos podrían compartir el mismo espacio de nombres (mismo namespace en Kubernetes), pero esto podría traer problemas y por eso no lo recomendamos. Pensemos en el namespace `Staging` y en 2 equipos donde cada uno tiene una aplicación en un repositorio Git, en total 2 repositorios. Al realizar cambios en uno de los repositorios Git se podrían generar conflictos con el otro en los nombres de los elementos o en los DNS. Para evitar estos problemas, es preferible mantener estructurar los equipos (las aplicaciones) en namespaces separados y realizar los enlaces entre servicios utilizando la estructura local DNS.

Revise la lista completa de [componentes de Jenkins X](/docs/reference/components/).

## Entornos de Desarrollo

En el entorno de desarrollo, hemos instalado una serie de aplicaciones principales que creemos son necesarias como mínimo para comenzar con CI/CD en Kubernetes.

También admitimos [complementos](/es/about/concepts/features/#aplicaciones) para ampliar este conjunto básico.

Jenkins X viene con una configuración que conecta estos servicios entre sí, lo que significa que todo funciona de conjunto de inmediato. Esto reduce drásticamente el tiempo para comenzar con Kubernetes, ya que todas las contraseñas, las variables de entorno y los archivos de configuración están configurados para funcionar entre sí.

1. __Jenkins__ — proporciona la automatización de flujos CI/CD. Hay un esfuerzo para descomponer Jenkins con el tiempo para volverlo más nativo de la nube y hacer mayor uso de los conceptos de Kubernetes en torno a: CRD, almacenamiento, escalado, entre otros.
2. __Nexus__ — actúa como un caché de dependencia para aplicaciones NodeJS y Java para mejorar dramáticamente los tiempos de compilación. Después de una compilación inicial de una aplicación SpringBoot, el tiempo de compilación se reduce de 12 minutos a 4. Todavía no hemos intentado demostrar, pero lo haremos pronto, el intercambiarlo con Artifactory.
3. __Docker registry__  — un registro de docker dentro del clúster donde nuestros pipelines envían imágenes de aplicaciones, pronto pasaremos a utilizar registros de proveedores nativos de la nube, como Google Container Registry, Azure Container Registry o Amazon Elastic Container Registry (ECR), por ejemplo.
4. __ChartMuseum__ — un Repositorio para publicar los charts de Helm
5. __Monocular__  — una interfaz de usuario utilizada para obtener y ejecutar charts de Helm

## Entornos Permanentes

Estos [entornos](/es/about/concepts/features/#entornos), como `Staging` y `Production` utilizan GitOps para auto-gestionarse, por lo que cada uno tiene asociado un repositorio Git con el código necesario para configurar todas las aplicaciones y servicios que son desplegados en el.

Normalmente se utilizan charts de Helm dentro del repositorio para definir qué chart será instalado, que versión utilizar y cualquier otra configuración específica necesaria del entorno, así como recurso adicionales. p.ej. Información sensible (Secrets) o aplicaciones como Prometheus, etc.

## Entornos de Vista Previa

Los [Entornos de Vista Previa](/es/about/concepts/features/#entornos-de-vista-previa) son similares a los [Entornos Permanentes](/es/about/concepts/features/#entornos) en el punto donde ambos están definidos en el código fuente utilizando los charts de Helm.

La principal diferencia es que los entornos de vista previa están configurados dentro del código fuente de la aplicación, en la carpeta `./chart/preview`.

Además, estos entornos no son permanentes, sino que se crean a partir de un PR en el repositorio Git de la aplicaciones y luego se eliminan un tiempo después (manualmente o mediante la recolección automática de basura).

## Anotaciones Personalizadas de Entrada

Para obtener información sobre cómo agregar anotaciones personalizadas al controlador de entradas, consulte [¿Cómo agregar anotaciones personalizadas al controlador de Entradas?](/docs/resources/guides/using-jx/faq/#how-to-add-custom-annotations-to-ingress-controller)