---
title: Actualizando Jenkins X
linktitle: Actualizando Jenkins X
description:  Instrucciones para actualizar su instalación de Jenkins X
categories: [tutorials]
keywords: [usage,docs]
weight: 190
---

Puede mantener actualizado su entorno de Jenkins X utilizando la línea de comando `jx upgrade`. A continuación se muestran los recursos que pudiera actualizar con mayor frecuencia. Para consultar un detallado listado de recursos posibles a actualizar ve [la documentación del propio comando](/commands/jx_upgrade/).

Actualizando el binario CLI
------------------------

Actualice la interfaz de línea de comandos de Jenkins X abriendo un terminal y ejecutando:

    jx upgrade cli

Si no utiliza parámetros adicionales, el comando actualizará el binario `jx` a la última versión liberada. Sin embargo, si desea instalar una versión específica puede agregar el parámetro `-v` como se muestra a continuación:

    jx upgrade cli -v 2.0.46

Actualizando la plataforma
----------------------

Actualice su plataforma de Jenkins X junto a los paquetes relacionados con ella a través del comando:

    jx upgrade platform

La palabra `platform` en el comando de actualización hace referencia a los siguientes sistemas: Jenkins, Helm, ChartMuseum, Nexus y Monocular. La plataforma también hace referencia a cualquier servidor ChartMuseum asociado con el clúster.

Actualizando Aplicaciones
--------------

Puede actualizar cualquier aplicación instalada en Jenkins X durante el proceso de creación del clúster utilizando `jx` para actualizar el recurso:

    jx upgrade apps

La palabra `apps` hace referencia a todas las aplicaciones instaladas en su clúster de Kubernetes si hay actualizaciones disponibles. Si desea actualizar solo aplicaciones específicas, puede usar el comando `jx upgrade app` junto a la aplicación especificada:

    jx upgrade app cb-app-slack
