---
title: "Crear, probar y obtener la vista previa de una aplicación"
weight: 3
description: >
  Este tutorial le ayudará a comprender cómo construir, probar y obtener una vista previa de su aplicación en varios **entornos** integrados en Jenkins X
---

A toda persona que ha desarrollado en entornos de Git le resultará familiar los entornos de desarrollo en Jenkins X, con la diferencia de poder contar en este último con funcionalidades que le permitan automatizar el proceso de desarrollo, las compilaciones y las promociones.

## El tradicional entorno de desarrollo

El flujo tradicional de desarrollo en Git tiene los siguientes pasos:

1. Bifurcación - El desarrollador crea una bifurcación del repositorio del proyecto en su área personal.
2. Ramificación - El desarrollador crea una rama en el repositorio de su área personal por las posibles razones:
  - Crear una nueva funcionalidad
  - Corregir un error
  - Adicionar un parche de seguridad
3. Inserción - El desarrollador ingresa el código a su rama del repositorio local y le envía hacia su repositorio remoto, creando de esta forma una diferencia en el fichero (`diff`).
4. Creación de solicitud de extracción - El desarrollador crea una solicitud de extracción (PR) desde su repositorio hacia el repositorio principal.
5. Corrección - Los cambios en el código son revisado por el equipo de calidad (QA) del repositorio principal para validar la nueva funcionalidad o la corrección del error. En este proceso se pueden sugerir cambios en caso de ser necesario.
6. Mezclado - El código modificado en el PR, si es aceptado, se mezcla en la rama master del proyecto principal.

## El proceso de desarrollo en Jenkins X

Desarrollar con Jenkins X es similar al flujo tradicional de Git, incluyendo los beneficios de la automatización del despliegue continuo a través del contexto de Git, también conocido como *GitOps*.

Jenkins X va un paso más allá brindando una *vista previa del entorno* permitiendo a los desarrolladores o al equipo de pruebas QA validar la nueva funcionalidad o las correcciones para evaluar la compilación de la funcionalidad dentro del PR de Git.

### Generar el entorno de vista previa

En un escenario típico de desarrollo en Jenkins X, los usuarios realizan cambios a la aplicación que han importado o creado a través de una de las posibles variantes, p.ej [inicios rápidos](/es/docs/getting-started/first-project/create-quickstart/), [importar proyectos](/es/docs/resources/guides/using-jx/creating/import/), entre otros.

Luego de tener el proyecto, el proceso para generar la vista previa de entorno a partir de los cambios realizados es muy similar al flujo tradicional de Git. Los pasos serían:

1. El desarrollador crea una rama en su repositorio local para crear la nueva funcionalidad:
```sh
git checkout -b acme-feature1
```
2. El desarrollador realiza las modificaciones en el código y luego los agrega como cambios en Git:
```sh
git add index.html server.js
```
3. El desarrollador establece los cambios en Git junto a un comentario:
```sh
git commit -m "nifty new image added to the index file"
```
4. El desarrollador empuja los cambios hacia el repositorio remoto:
```sh
git push origin acme-feature1
```
5. En su terminal se mostrará un enlace para crear la solicitud de extracción. Haga *clic en el enlace* para acceder a la página de GitHub de su repositorio y crear la solicitud de extracción.
6. Jenkins X creará una vista rápida del entorno en el PR creado en el paso anterior. Se mostrará un enlace para que pueda evaluar la nueva funcionalidad:

<img src="/images/pr-comment.png" class="img-thumbnail">

El entorno de vista rápida es creada cada vez que se realice una modificación en el repositorio, permitiendo así la validación y evaluación por parte de los integrantes del proyecto de las nuevas funcionalidades o correcciones.

### Probando el entorno de vista previa

El sistema envía una notificación por email tanto el desarrollador como al responsable de aprobar los cambios en el repositorio indicando que los cambios están listos para ser revisados. Durante el proceso de aprobación, los integrantes pueden dar clic en el enlace de vista previa del entorno para revisar y validar los cambios.

Cuando el responsable de aprobar los cambios considera que el nuevo estado es correcto, puede aprobar y mezclar los cambios a la rama `master` simplemente haciendo el siguiente comentario en el PR:
```sh
/approve
```
En este momento los cambios se mezclan y se inicia una nueva compilación en la rama `master` con todas las modificaciones incluidas para que luego sea liberadas a los entornos `Staging` y `Production`.