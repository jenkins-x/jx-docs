---
title: Decisiones
linktitle: Decisiones
description: Decisiones tomadas por el proyecto Jenkins X
weight: 20
---

# Decisiones

Jenkins X es una experiencia de desarrollo basada en opiniones de expertos, aquí explicaremos los antecedentes y las decisiones que hemos tomado para ayudar a explicar las razones de estas opiniones. También puede consultar la página [Accelerate](/about/opinions/) para obtener detalles sobre cómo Jenkins X implementa las competencias recomendadas por este libro.

## Kubernetes

Primero es por qué Jenkins X se centra exclusivamente en Kubernetes y solo está destinado a ejecutarse en él.

Kubernetes ha ganado las guerras de la nube, cada proveedor importante de la nube ahora es compatible con Kubernetes o está trabajando activamente en una solución de Kubernetes. Google, Microsoft, Amazon, Red Hat, Oracle, IBM, Alibaba, Digital Ocean, Docker, Mesos y Cloud Foundry, por nombrar algunos. Ahora tenemos una plataforma de despliegues hacia donde apuntar y para desarrollar aplicaciones portables de primera clase.

El ecosistema de Kubernetes es rico en innovación y con una comunidad vibrante, innovadora y diversa de código abierto que invita sola, la cual sugiere grandes cosas para todos los involucrados.

Jenkins X recomienda usar clústeres de Kubernetes administrados en la nube pública siempre que sea posible. GKE, AKS y EKS ofrecen servicios gestionados de Kubernetes, lo que reduce drásticamente el riesgo de instalar, actualizar y mantener su clúster de Kubernetes para que pueda concentrarse en desarrollar un código increíble.

es decir, permite que las personas que saben cómo ejecutar contenedores y administrar clústeres a escala puedan concentrarse en agregar valor a su negocio.

## Draft

[Draft](https://draft.sh) tiene algunas capacidades, pero Jenkins X solo usa la función de detección de idioma y la creación de paquetes. Jenkins X mantiene sus propios [paquetes de draft](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes)  diseñados para ejecutarse con Jenkins X.

Draft proporciona una excelente manera de iniciar un proyecto de código fuente con el paquete necesario para ejecutar la aplicación en Kubernetes.

El proyecto Draft vino de Deis, que fue adquirida por Microsoft y continúa invirtiendo y evolucionando su historia de desarrollador de Kubernetes.

## Helm

[Helm](https://helm.sh) proporciona el paquete de plantillas para ejecutar aplicaciones en Kubernetes. Hemos recibido comentarios mixtos de nuestro uso de Helm. Desde nuestra experiencia, poder crear plantillas y componer múltiples Helm Charts juntos ha sido un hallazgo muy bien recibido. Esto condujo a nuestro uso de Helm para componer, instalar y actualizar entornos completos y poder anteponer valores fácilmente como el número de réplicas o los límites de recursos de aplicaciones por entorno, por ejemplo.

Las plantillas OpenShift tenían como objetivo hacer algo similar, sin embargo, son específicas de OpenShift.

Muchas de las preocupaciones con Helm se están abordando con la actualización de la versión principal de Helm 3. Eliminar el uso de Tiller, el componente del lado del servidor de Helm, es una gran victoria, ya que se considera inseguro debido a los permisos elevados que necesita para ejecutarse. Jenkins X [proporciona una forma](/architecture/helm3/) de usar la versión beta de Helm 3 para las personas que deseen probar esto en su lugar, lo estamos utilizando nosotros mismos y hasta ahora está funcionando muy bien. Si hay problemas, nos gustaría enviar comentarios al proyecto Helm para que podamos ayudarlos a llegar a GA antes.

El proyecto Helm vino de Deis, que fue adquirido por Microsoft y continúa invirtiendo y evolucionando su historia de desarrollador de Kubernetes.

## Skaffold

Jenkins X utiliza [Skaffold](https://github.com/GoogleContainerTools/skaffold) para realizar las acciones de construcción y empuje de imagen en un pipeline. Skaffold nos permite implementar diferentes servicios de creación de imágenes y de registros como [Google Container Builder](https://cloud.google.com/container-builder/), [Azure Container Builder](https://github.com/Azure/acr-builder) y [ECR](https://aws.amazon.com/ecr/).

Para las personas que no trabajan en una nube pública con el generador de contenedores o los servicios de registro, Skaffold también puede trabajar con [kaniko](https://github.com/GoogleContainerTools/kaniko), esto permite a los pipelines construir imágenes de Docker utilizando contenedores sin raíz. Esto es significativamente más seguro que montar el socket de Docker desde cada nodo en el clúster.

## Jenkins

Jenkins, ¿por qué una gran JVM que no está altamente disponible? Puede parecer una sorpresa ésta selección como el motor de pipelines para usar en la nube, sin embargo, la adopción de Jenkins por parte de los desarrolladores y la comunidad que tiene significa que es ideal para usar y evolucionar su propia historia nativa de la nube. Jenkins X ya genera definiciones de recursos personalizados de Kubernetes para actividades en los pipelines que utilizan nuestras las herramientas IDE y CLI en lugar de consultar a Jenkins. Almacenaremos construcciones y ejecuciones de Jenkins en Kubernetes en lugar de en `$JENKINS_HOME`, lo que significa que podemos escalar los maestros de Jenkins. También estamos cambiando a Prow para interceptar eventos de webhook de Git en lugar de utilizar Jenkins, esto significa que podemos tener una solución altamente disponible, así como entregar la programación de construcciones a Kubernetes.

TL;DR estamos moviendo muchas de las funcionalidades del master de Jenkins a la plataforma Kubernetes.

Tomar este enfoque también significa que podremos habilitar otros motores de pipelines en el futuro.

## Prow

[Prow](https://github.com/kubernetes/test-infra/tree/master/prow) maneja eventos Git y puede desencadenar flujos de trabajo en Kubernetes.

Prow puede ejecutarse en un modo de alta disponibilidad donde existen múltiples pods para una URL de entrada de webhook. A diferencia de Jenkins, si realiza una actualización, Jenkins tiene un tiempo de inactividad en el que se pueden perder los eventos de webhook. Esto está en nuestros planes futuros y esperamos tenerlo disponible pronto.

## Nexus

[Nexus](https://help.sonatype.com/repomanager3) es una JVM con sobrepeso que recientemente se mudó a OSGi, sin embargo, hace el trabajo que necesitamos. Dependencias de caché para compilaciones más rápidas y proporciona un repositorio compartido donde los equipos pueden compartir sus artefactos liberados.

Si alguien desarrollara un servidor de repositorio de artefactos de código abierto en un lenguaje más amigable para la nube como Go, entonces Jenkins X probablemente cambiaría para ahorrar en facturas en la nube.

En este momento, Jenkins X no utiliza el registro de Docker de Nexus. La razón principal fue que necesitábamos hacer un trabajo para configurar las definiciones de pod con secretos de extracción de imágenes para que podamos utilizar el registro autenticado. Sin embargo, nuestro enfoque recomendado es cambiar al uso de registros de proveedores de nube nativos como [ECR de Amazon](https://aws.amazon.com/ecr/), [Google Container Registry](https://cloud.google.com/container-registry/) o DockerHub, por ejemplo, con la ayuda de Skaffold.

## Docker registry

Como se indicó anteriormente, no tenemos la intención de usar [este registro](https://github.com/kubernetes/charts/tree/master/stable/docker-registry) a largo plazo, ya que preferimos usar registros de proveedores de la nube como [ECR de Amazon](https://aws.amazon.com/ecr/), [Google Container Registry](https://cloud.google.com/container-registry/) o Dockerhub, por ejemplo, con la ayuda de Skaffold.

## ChartMuseum

Al momento de crear Jenkins X, había pocas opciones de cómo publicar Helm Charts, la comunidad de Kubernetes usa páginas de GitHub, pero queríamos encontrar una solución que funcione para las personas que usan cualquier proveedor de Git. [ChartMuseum](https://github.com/kubernetes-helm/chartmuseum) está escrito en Go, por lo que funciona bien en la nube, admite múltiples almacenamiento en la nube y funciona muy bien con Monocular.

## Monocular

Usamos [Monocular](https://github.com/kubernetes-helm/monocular) para descubrir las aplicaciones publicadas de nuestros equipos, podríamos usar KubeApps de forma predeterminada si la comunidad lo prefiere, pero habilitaremos KubeApps como complemento independientemente.

## Git

Jenkins X solo trabaja con Git. Hay muchas dependencias e implementaciones de clientes que Jenkins X ya necesita admitir para diferentes proveedores de Git, no escuchamos suficiente demanda para admitir otros sistemas de control de versiones, por lo que por ahora Jenkins X está vinculado a Git.

## Programming languages

Jenkins X tiene como objetivo ayudar a proporcionar el nivel adecuado de comentarios para que los desarrolladores entiendan cómo funcionan sus aplicaciones y brindarles formas fáciles de experimentar con otros lenguajes que puedan adaptarse mejor a la función y a ejecutarse en la nube. Por ejemplo, hay muchas organizaciones basadas en Java que solo saben cómo escribir, ejecutar y mantener aplicaciones Java. Java es extremadamente intensivo en recursos en comparación con Golang, Rust, Swift, NodeJS, por nombrar algunos, esto genera facturas en la nube mucho más altas cada mes. Con Jenkins X, nuestro objetivo es ayudar a los desarrolladores a experimentar con otras opciones utilizando inicios rápidos y complementos de métricas como Grafana y Prometheus para ver cómo se comportan en la nube.

Por ejemplo, cualquier microservicio nuevo que creemos en el proyecto Jenkins X tiende a estar en Golang o NodeJS dado el enorme efecto que tiene en nuestra facturación en la nube. Lleva tiempo cambiar a un nuevo lenguaje de programación, pero con Jenkins X esperamos poder mitigar un gran riesgo utilizando inicios rápidos, CI/CD automatizados y una forma relativamente consistente de trabajar en todos los idiomas.

### Maven

Maven tiene algunas herramientas que mucha gente está acostumbrada a usar y que no se adaptan particularmente bien al CD. Por ejemplo, el [plugin de liberación de Maven](http://maven.apache.org/maven-release/maven-release-plugin/) versionará un proyecto y se comprometerá directamente a dominar la nueva versión SNAPSHOT que en el mundo de CD desencadenaría otra versión que resultaría en un bucle recursivo.

Para proyectos Java, Jenkins X usa la versión [maven version:set plugin](https://www.mojohaus.org/versions-maven-plugin/set-mojo.html) para actualizar todos los poms en un proyecto usando la próxima versión de lanzamiento siguiendo el paso #Versioning mencionado anteriormente.

Si se necesita un nuevo incremento de versión mayor o menor, los usuarios pueden crear una nueva etiqueta Git con el nuevo número mayor/menor y Jenkins X lo respetará. Alternativamente, puede actualizar el padre `pom.xml` y cualquier archivo pom hijo él mismo y Jenkins X detectará y usará la nueva versión mayor o menor.