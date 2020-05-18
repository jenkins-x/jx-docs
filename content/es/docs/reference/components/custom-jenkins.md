---
title: Servidores de Jenkins Personalizados
linktitle: Servidores de Jenkins Personalizados
description: ¿Cómo trabajar con Servidores de Jenkins Personalizados en Jenkins X?
weight: 70
---

Jenkins X proporciona CI/CD automatizado para las bibliotecas y microservicios que desee implementar en Kubernetes, pero ¿qué pasa con esas otros pipelines basadas en `Jenkinsfile` que ya ha creado en un servidor Jenkins personalizado?

Jenkins X ahora tiene una [aplicación Jenkins](https://github.com/jenkins-x-apps/jx-app-jenkins) que facilita agregar uno o más servidores Jenkins personalizados a su equipo y utilizar el servidor Jenkins personalizado para implementar cualquier pipeline personalizado que haya desarrollado.

**NOTA** la aplicación Jenkins está diseñada solo para ejecutar pipelines personalizadas de `Jenkinsfile` que haya desarrollado a mano; no es un motor de ejecución para los pipelines automatizadas de CI/CD en Jenkins X para cargas de trabajo de Kubernetes; para eso realmente recomendamos los [pipelines de Jenkins X sin servidor](/es/about/concepts/jenkins-x-pipelines/), pero también puede usar un servidor Jenkins estático incorporado.

## ¿Por qué Jenkins personalizado?

Esta aplicación le permite mantener su inversión en sus pipelines de Jenkins existentes, invocándolas en un Servidor Jenkins personalizado de su propia elección y configuración mientras comienza a usar más CI/CD automatizado en Jenkins X para nuevas bibliotecas y microservicios utilizando [Pipelines de Jenkins sin servidor X](/about/concepts/jenkins-x-pipelines/) o el servidor estático incorporado de Jenkins en Jenkins X.

Luego puede mezclar y combinar entre el CI/CD automatizado en Jenkins X y sus pipelines personalizadas de Jenkins, ¡todo bien organizado junto con Jenkins X!

## Instalar un Jenkins personalizado

Para instalar el servidor de Jenkins personalizado debe ejecutar el siguiente comando:

```sh
jx add app jenkins
```

Esto instalará un nuevo servidor Jenkins en su equipo actual. Entonces debería aparecer a través de ...

```sh
jx open
```

Esto también creará un token API automáticamente para que la CLI `jx` pueda consultar o iniciar pipelines en el servidor Jenkins personalizado. Puede tomar un minuto más o menos para completar el trabajo de configuración.

## Obtener el nombre de usuario/contraseña

Desafortunadamente, hay una limitación en la aplicación Jenkins actual de que no le solicita la contraseña cuando agrega la aplicación Jenkins.

Entonces, para encontrar la contraseña, tendrá que encontrarla a mano, me temo.

* descargar [ksd](https://github.com/mfuentesg/ksd) y adicionarlo a su $PATH
* escriba lo siguiente (debe necesitar cambiar el nombre del `Secret` si utiliza un alias diferente en su servidor Jenkins):

```sh
kubectl get secret jx-jx-app-jenkins -o yaml | ksd
```

Luego podrá ver su usuario/contraseña en la pantalla si lo desea para para registrase en la interfaz de Jenkins a través del comando [jx console](/commands/deprecation/).

## Usando el Jenkins personalizado

El comando `jx` que funciona con servidores Jenkins puede funcionar directamente con su nuevo servidor Jenkins personalizado; aunque debe especificar que desea interactuar con un servidor Jenkins personalizado en lugar del motor de ejecución incorporado en Jenkins X (p.ej, [Pipelines de Jenkins X sin servidor](/about/concepts/jenkins-x-pipelines/) o el servidor Jenkins incorporado dentro de Jenkins X)

Si solo tiene una aplicación Jenkins personalizada en su equipo, puede usar `-m` para especificar que desea trabajar con un servidor Jenkins personalizado. De lo contrario, puede especificar `-n myjenkinsname`.

```sh
# view the pipelines
jx get pipeline -m

# view the log of a pipeline
jx get build log -m

# view the Jenkins console
jx console -m

# lets start a pipeline in the custom jenkins
jx start pipeline -m
```

## Administrar servidores Jenkins personalizados a través de GitOps

Hemos diseñado la aplicación Jenkins para Jenkins X utilizando el [framework de extensión de la aplicación](/docs/contributing/addons/), lo que significa que puede administrar sus servidores Jenkins personalizados a través de [GitOps](/docs/resources/guides/managing-jx/common-tasks/manage-via-gitops/), manteniendo todas las aplicaciones, su versión y configuración en git y utilizando las herramientas Jenkins X para agregar/actualizar/configurar/eliminar sus aplicaciones.