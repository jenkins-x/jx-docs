---
title: Jenkins Nativo de la Nube
linktitle: Jenkins Nativo de la Nube
description: Hagamos que Jenkins sea nativo de la nube
weight: 31
---

Jenkins X ayuda a admitir _Jenkins nativo en la nube_ a través de:

* orquestando tanto [Jenkins sin servidor](/news/serverless-jenkins/) con [prow](/architecture/prow/) como Jenkins Estático con maestros por equipo. Esto permite que los equipos se muevan hacia un sistema sin servidor mientras que también traen maestros estáticos.
* cada equipo puede instalar su propio Jenkins X en su propio namespace (a través de `jx install --namespace myteam`)
* soporte para diferentes cargas de trabajo por equipo (ver [jx edit buildpack](/commands/jx_edit_buildpack/)).


## Diferentes cargas de trabajo

Algunos equipos desarrollan aplicaciones nativas en la nube en Kubernetes y, por lo tanto, deberían usar la opción `kubernetes workloads`.

Para los equipos que no implementan aplicaciones en Kubernetes, como la entrega de bibliotecas o binarios, hay una nueva opción de `carga de trabajo de biblioteca` que tiene CI y versiones automatizadas pero no CD.

Cuando [crea un clúster](/es/docs/getting-started/setup/create-cluster/) o [instala Jenkins X](/docs/resources/guides/managing-jx/common-tasks/install-on-cluster/), se le solicita que elija entre los paquetes de construcción disponibles.

```sh
? Pick workload build pack:   [Use arrows to move, type to filter]
> Kubernetes Workloads: Automated CI+CD with GitOps Promotion
  Library Workloads: CI+Release but no CD
```

Puede cambiar esta configuración en cualquier momento a través de [jx edit buildpack](/commands/jx_edit_buildpack/).

Por defecto, simplemente presione enter para apegarse a la opción de cargas de trabajo de Kubernetes. Sin embargo, si tiene un número significativo de bibliotecas que desea administrar, puede configurar un equipo separado para esto e importar sus diversos proyectos de biblioteca allí.

## Cargas de trabajo actuales

Almacenamos nuestros paquetes de construcción en la organización [jenkins-x-buildpacks](https://github.com/jenkins-x-buildpacks/) en GitHub. Actualmente apoyamos:

* el paquete de construcción [jenkins-x-classic](https://github.com/jenkins-x-buildpacks/jenkins-x-classic) es compatible con las versiones CI+Release, pero no incluye el CD. p.ej. hacer CI y liberar sus bibliotecas Java o módulos de Nodo pero no desplegarlas en Kubernetes.
* el paquete de construcción [jenkins-x-kubernetes](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes) admite el CI+CD automatizado con la promoción GitOps y entornos de vista previa para `cargas de trabajo de Kubernetes`.

Sin embargo, debería poder extender cualquiera de estos paquetes de construcción para agregar plataformas y capacidades alternativas.

## Escribiendo su propio paquete de construcción

Queremos que [extienda Jenkins X](/docs/contributing/addons/), así que consulte la documentación sobre [cómo crear sus propios paquetes de construcción]/docs/resources/guides/managing-jx/common-tasks/build-packs/#creating-new-build-packs).