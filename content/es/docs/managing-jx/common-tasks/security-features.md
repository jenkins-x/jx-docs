---
title: Funcionalidades de Seguridad
linktitle: Funcionalidades de Seguridad
description: Complementos de seguridad para Jenkins X
weight: 170
---

Jenkins X tiene algunos complementos útiles que pueden ayudar a garantizar la seguridad de sus aplicaciones desplegadas. Hay seguridad estática y de contenedores, así como complementos de seguridad dinámicos disponibles.

### Seguridad estática

[Anchore Engine](https://github.com/anchore/anchore-engine) se utiliza para proporcionar seguridad a las imágenes de docker. Anchore examina el contenido de las imágenes a partir de un PR, de un estado de revisión o desde un contenedores en ejecución.

Esto fue introducido en [esta publicación](https://jenkins.io/blog/2018/05/08/jenkins-x-anchore/).

Para habilitar esto, ejecute el siguiente comando y el servicio de Anchore será configurado:

```sh
jx create addon anchore
```

Esto lanzará los recursos necesarios, y tendrá disponible el servicio para ejecutarse en cualquiera de los entornos de su equipo, y en cualquier aplicación de vista previa en ejecución.

Para probarlo, puede usar el siguiente comando para informar sobre cualquier problema encontrado:

```sh
jx get cve --environment=staging
```

Aquí hay un video que [lo muestra en acción](https://youtu.be/rB8Sw0FqCQk). Para eliminar este complemento utilice el siguiente comando:

```sh
jx delete addon anchore
```

### Seguridad dinámica

El sitio web Open Web Application Security Project publica una herramienta llamada ZAP: el [Zed Attack Proxy](https://www.owasp.org/index.php/OWASP_Zed_Attack_Proxy_Project). Esto proporciona varias herramientas, incluido un comando de línea que se puede ejecutar contra una entrada de la aplicación en busca de un conjunto básico de problemas.

En Jenkins X, esto se puede ejecutar contra una aplicación de vista previa (que obtiene cada aplicación) creando un enlace a la vista previa:

```sh
jx create addon owasp-zap
```

Luego de habilitar este complemento cada PR tendrá su vista previa de la aplicación ejecutada a través del análisis de ZAP. En caso de detectarse fallas finalizará el pipeline CI automáticamente. Los pipelines no se modifican para ejecutar esta prueba, y se aplicarán a todas los PR para el equipo.

Para eliminar el componente ZAP utilice el siguiente comando:

```sh
jx delete post preview job --name owasp-zap
```

El enlace de vista previa también se puede configurar con el comando:

```sh
jx create post preview job --name owasp --image owasp/zap2docker-weekly:latest -c "zap-baseline.py" -c "-I" -c "-t" -c "\$(JX_PREVIEW_URL)"
```

Puede tener múltiples enlaces configurados, por lo tanto, si tuviera contenedores específicos a los que necesite revisar/probar, podría ejecutar en cada aplicación de vista previa (es decir, cada PR) utilizando el siguiente comando:

[Entornos de vista previa](/developing/preview)