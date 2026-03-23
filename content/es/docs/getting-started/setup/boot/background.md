---
title: Antecedentes
linktitle: Antecedentes
description: ¿Por qué se ha creado Jenkins X Boot?
weight: 50
---

En los últimos 1-2 años, hemos aprendido que hay muchos tipos diferentes de clúster de Kubernetes y formas de configurar cosas como Ingress, DNS, dominios, certificados. Esta gran diversidad implica el aumento de la complejidad en los comandos actuales [jx create cluster](/commands/jx_create_cluster/) y [jx install](/commands/deprecation/).

Además, ahora se recomienda usar herramientas como Terraform para administrar todos sus recursos en la nube: crear / actualizar clústeres de Kubernetes, buckets de almacenamiento en la nube, cuentas de servicio, KMS, etc.

Detectamos también que teníamos muchos segmentos diferentes de lógica de instalación distribuidos por distintos comandos, por ejemplo, [jx create cluster](/commands/jx_create_cluster/), [jx install](/commands/deprecation/), el uso del [parámetro --gitops](/docs/resources/guides/managing-jx/common-tasks/manage-via-gitops/). A esto le podemos sumar las diferentes formas de gestionar la información sensible (Secrets). Esta gran matrix de combinaciones hace muy difícil el poder probar y mantener de forma sólida cada comando.

Además, nos topamos con problemas en los comandos [jx create cluster](/commands/jx_create_cluster/) y [jx install](/commands/deprecation/) porque estos deben instalar componentes como el Ingerss Controller y no se estaba dando la posibilidad de modificar/quitar su instalación.

Los usuarios a menudo tuvieron dificultades para comprender cómo configurar y anular fácilmente las cosas; o actualizar valores después de que las cosas se hayan instalado.

Por lo tanto, queríamos llegar a un nuevo enfoque limpio, libre de los problemas mencionados anteriormente. Este nuevo enfoque funcionara para todo tipo de instalación y proporcionará una forma estándar de ampliar y personalizar la configuración a través de [Jenkins X Pipelines](/es/about/concepts/jenkins-x-pipelines/) y del estilo de configuración de Helm.