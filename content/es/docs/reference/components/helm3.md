---
title: Helm 3
linktitle: Helm 3
description: Usando Helm 3 con Jenkins X
weight: 110
---

Jenkins X utiliza [Helm](https://www.helm.sh/) para instalar Jenkins X e instalar las aplicaciones que cree en cada uno de los [Entornos](/about/concepts/features/#environments) (como `Staging` y `Production`).

**NOTA** hasta que Helm 3 sea GA recomendamos que las personas utilicen [Helm 2.x sin Tiller](/news/helm-without-tiller/)

Actualmente se está desarrollando Helm 3 que tiene una serie de grandes mejoras:

* elimine el componente del lado del servidor, Tiller, para que la `instalación de Helm` use el RBAC del usuario/ServiceAccount actual
* las versiones se vuelven conscientes de los namespaces evitando la necesidad de crear nombres de versiones únicos a nivel global

En el momento de escribir Helm 3 todavía está en su desarrollo, pero para mejorar los comentarios, hemos agregado soporte para Helm 2 y Helm 3 en Jenkins X.

Puede usar Helm 2 o Helm 3 para hacer cualquiera de estas cosas:

* instalar Jenkins X
* instalar sus aplicaciones en los entornos `Staging` y `Production`

p.ej. puede utilizar Helm 2 para instalar Jenkins X, luego utilizar Helm 3 para sus entornos `Staging` y `Production`.

Vea cómo especificar cuál versión de Helm utilizar.

## Utilizar helm 3 para instalar Jenkins X

Cuando instale Jenkins X a través de `jx create cluster ...` o `jx install` puede especificar `--helm3` para utilizar helm 3 en vez de helm 2.x.

Si lo instala utilizando helm 2, entonces su equipo por defecto utilizará helm 2 para su liberaciones. Si lo instala utilizando helm 3, entonces su equipo utilizará por defecto la versión 3.

Para cambiar la versión de helm utilizada por su equipo use el comando [jx edit helmbin](/commands/jx_edit_helmbin/):

```
jx edit helmbin helm3
```

o para cambiar a helm 2:

```
jx edit helmbin helm
```

Puede ver la configuración actual para su equipo a través del comando [jx get helmbin](/commands/jx_get_helmbin/):

```
jx get helmbin
```

Básicamente la [plantilla del pod](/docs/resources/guides/managing-jx/common-tasks/pod-templates/) contiene ambos binarios:

* `helm` which is a 2.x distro of helm
* `helm3` which is a 3.x distro of helm