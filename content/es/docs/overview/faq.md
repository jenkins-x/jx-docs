---
title: Preguntas Generales
linktitle: Preguntas Generales
description: Preguntas generales acerca del proyecto Jenkins X
weight: 20
---

Hemos tratado de recopilar problemas comunes aquí con soluciones alternativas. Si su problema no figura aquí, [háganoslo saber](https://github.com/jenkins-x/jx/issues/new).

## ¿Es Jenkins X un proyecto de código abierto?

¡Si! Todo el código fuente y los artefactos de Jenkins X son de código abierto; ¡Apache o MIT y siempre lo serán!

## ¿Cómo se compara Jenkins X con Jenkins?

Jenkins X proporciona [flujos automatizados CI/CD](/es/about/concepts/features/#pipelines-automatizados) para aplicaciones en Kubernetes con [promoción GitOps a través de entornos](/es/about/concepts/features/#promoción) y [vista previa de entornos en PR](/es/about/concepts/features/#entornos-de-vista-previa). (Vea [las funcionalidades para más detalles](/es/about/concepts/features/)).

Jenkins es un servidor de CI/CD de propósito general que se puede configurar para hacer lo que desee agregando complementos (plugins), cambiando la configuración y escribiendo sus propios flujos de actividades (pipelines).

En Jenkins X, solamente con la [instalación de Jenkins X](/es/docs/getting-started/) se configuran automáticamente un grupo de herramientas como Helm, registro de docker, Nexus, etc. Luego puede [crear](/docs/resources/guides/using-jx/common-tasks/create-spring/) / [importar](/docs/resources/guides/using-jx/creating/import/) proyectos y obtendrá el flujo CI/CD completamente automatizado junto con las vistas previas. Esto permitirá que sus desarrolladores se concentren en crear aplicaciones mientras usted delega en Jenkins X la administración de su CI+CD.

Jenkins X admite diferentes motores de ejecución; puede orquestar un servidor Jenkins por equipo reutilizando Jenkins en un contenedor docker. Sin embargo, cuando utilizamos los [Pipelines de Jenkins X sin servidor](/es/about/concepts/jenkins-x-pipelines/), utilizamos [Tekton](https://tekton.dev/) en lugar de Jenkins como motor de los flujos CI/CD para proporcionar una arquitectura nativa en la nube, moderna y de alta disponibilidad.

## ¿Es Jenkins X una bifurcación de Jenkins?

¡No! Jenkins X puede orquestar el servidor Jenkins reutilizándolo dentro de un contenedor y configurándolo para que sea lo más nativo posible.

Sin embargo, cuando utilizamos los [Pipelines de Jenkins X sin servidor (serverless)](/es/about/concepts/jenkins-x-pipelines/), utilizamos [Tekton](https://tekton.dev/) en lugar de Jenkins como el motor de CI/CD para proporcionar una arquitectura nativa en la nube, moderna y de alta disponibilidad.

## ¿Por qué crear un subproyecto?

Somos grandes admiradores de [Kubernetes](https://kubernetes.io/) y de la nube. Creemos que es el enfoque futuro a largo plazo para ejecutar software para muchas personas.

Sin embargo, mucha gente todavía querrá ejecutar Jenkins de la manera regular de jenkins a través de: `java -jar jenkins.war`

Entonces, la idea del subproyecto Jenkins X es centrarse al 100% en el caso de uso de Kubernetes y Cloud Native y dejar que el proyecto principal de Jenkins se enfoque en el enfoque clásico de Java.

Una de las grandes fortalezas de Jenkins siempre ha sido su flexibilidad y su enorme ecosistema de diferentes
complementos y capacidades. El subproyecto Jenkins X por separado ayuda a la comunidad a iterar e ir rápido
mejorando tanto el Cloud Native como las distribuciones clásicas de Jenkins en paralelo.