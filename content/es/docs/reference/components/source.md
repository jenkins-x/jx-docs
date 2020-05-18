---
title: Código Fuente
linktitle: Código Fuente
description: La ubicación de varios repositorios de código fuente
parent: "components"
weight: 400
---

Jenkins X está construido sobre los hombros de gigantes y también tiene muchos repositorios de diferentes orígenes para hacer lograr varios objetivos, desde herramientas CLI, imágenes de docker, helm charts y [aplicaciones como complementos](/docs/contributing/addons/).

Esta página enumera las principales organizaciones y repositorios.

## Organizaciones

* [jenkins-x](https://github.com/jenkins-x) la organización principal para el código fuente
* [jenkins-x-apps](https://github.com/jenkins-x-apps) contiene el estándar de [aplicaciones de componentes](/docs/contributing/addons/) para Jenkins X
* [jenkins-x-buildpacks](https://github.com/jenkins-x-buildpacks) contiene los paquetes de [compilación disponibles](/docs/resources/guides/managing-jx/common-tasks/build-packs/)
* [jenkins-x-charts](https://github.com/jenkins-x-charts) los principales helm charts que distribuimos
* [jenkins-x-images](https://github.com/jenkins-x-images) contiene algunas compilaciones de imágenes de docker personalizadas
* [jenkins-x-quickstarts](https://github.com/jenkins-x-quickstarts) los proyectos de inicio rápido utilizados por [create quickstart](/docs/getting-started/first-project/create-quickstart/)
* [jenkins-x-test-projects](https://github.com/jenkins-x-test-projects) proyectos de prueba que usamos en casos de prueba

## Repositorios

Aquí mencionaremos a algunos de los principales repositorios en las organizaciones anteriores:

* [jenkins-x/jx](https://github.com/jenkins-x/jx) el repositorio principal que crea la CLI `jx` y los pasos de pipelines reutilizables
* [jenkins-x/jx-docs](https://github.com/jenkins-x/jx-docs) la documentación basada en Hugo que genera este sitio web
* [jenkins-x/bdd-jx](https://github.com/jenkins-x/bdd-jx) las pruebas BDD que utilizamos para verificar los cambios de plataforma y verificar los PR en [jenkins-x/jx](https://github.com/jenkins-x/jx)
* [jenkins-x/jenkins-x-platform](https://github.com/jenkins-x/jenkins-x-platform) el principal helm chart compuesto para la plataforma Jenkins X
* [jenkins-x/jenkins-x-versions](https://github.com/jenkins-x/jenkins-x-versions) contiene el [flujo de versiones](/es/about/concepts/version-stream/): las versiones estables de todos los _charts_ y _paquetes_ de CLI
* [jenkins-x/cloud-environments](https://github.com/jenkins-x/cloud-environments) las configuraciones helm para diferentes proveedores de la nube

### Construir pods e imágenes

* [jenkins-x/jenkins-x-builders](https://github.com/jenkins-x/jenkins-x-builders) genera las imágenes estáticas de docker de los pod de compilación del servidor jenkins
* [jenkins-x/jenkins-x-image](https://github.com/jenkins-x/jenkins-x-image) genera la imagen docker para el servidor jenkins estático que usamos por defecto
* [jenkins-x/jenkins-x-serverless](https://github.com/jenkins-x/jenkins-x-serverless) genera las imágenes de docker para [jenkins sin servidor](/news/serverless-jenkins/) cuando se utiliza [Prow](/architecture/prow/)

### Herramientas

* [jenkins-x/lighthouse](https://github.com/jenkins-x/lighthouse) la solución estratégica para webhooks y ChatOps para múltiples proveedores de git
* [jenkins-x/exposecontroller](https://github.com/jenkins-x/exposecontroller) una `Deployment` o `Job` que se puede usar para generar/actualizar recursos de `Ingress` (o `Route` en OpenShift) si cambia su dominio DNS o habilita TLS; también puede inyectar URL externas en su aplicación a través de la inyección del `ConfigMap`.