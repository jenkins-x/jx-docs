---
title: Madurez de las Funcionalidades
linktitle: Madurez de las Funcionalidades
description: Definiciones y procesos sobre cómo las funcionalidades maduran o son obsoletas
weight: 50
---

# Niveles de Madurez y Definiciones

Las funcionalidades generalmente pasarán por los siguientes niveles de madurez (aunque algunas nunca pueden ser obsoletas)

1. Experimental - en inglés Experimental
2. Estable - en inglés Stable
3. Producción - en inglés Production
4. Obsoleta - en inglés Deprecated

Cada uno de los niveles se detalla a continuación, incluidas las pasos por las que debe pasar una funcionalidad para "subir de nivel"

## Experimental

{{< alert >}}
TL;DR: Úselo bajo su propio riesgo
{{< /alert >}}

Este sería el nivel inicial para la mayoría de las nuevas funcionalidades. Es probable que sea el primer impulso de algo que al menos funcione para el contribuyente. No se espera que las funcionalidades en este nivel cumplan con los requisitos, y podría ser una sugerencia de cómo abordar un problema determinado. También podría ser una cosa muy bien estructurada, pensada y pulida que en su mayoría solo necesita ser examinada por otros antes de ser elevada en madurez.

La conclusión principal para este nivel de madurez es que existe el riesgo de que las cosas cambien (configuración/alcance/comportamiento/etc.) y probablemente no sea algo en lo que deba confiar en un entorno de producción a menos que sienta que sabe lo que está haciendo.

## Estable

{{< alert >}}
TL;DR: Funcionalidad completa; necesita más pruebas/documentación
{{< /alert >}}

Después de haber estado en el estado Experimental durante un período de tiempo, y la función ha recibido comentarios de otros, etc., eventualmente debería alcanzar un estado de función completa, donde se puede esperar que funcione en la mayoría de las circunstancias. Es posible que las pruebas automatizadas aún sean pocas y que la documentación también deba desarrollarse un poco más.

Para que una funcionalidad alcance este nivel, debería haber llegado a un punto en el que no se espera que cambien varios "contratos" (configuración, API, etc.); al menos no drásticamente. También debe tener algunas pruebas automatizadas y documentación; al menos para los flujos principales. Lo que debería permanecer es, en su mayoría, solo correcciones de errores, pruebas y la documentación completa.

## Producción

{{< alert >}}
TL;DR: Nivel de produccion. Bien probado y documentado
{{< /alert >}}

Este es el nivel final de madurez, y como consumidor de una funcionalidad estable, debe esperar que sea sólido, bien probado en varias configuraciones/entornos y bien documentado.

Las funcionalidades en nivel de producción ciertamente pueden cambiar, pero los cambios deben anunciarse en el registro de cambios y, posiblemente, en el blog, y también deben expresarse claramente en un número de versión (la versión principal/secundaria/parche aumenta cuando sea apropiado). Si una característica de nivel de producción ha cambiado (modificado la configuración de instalación, una nueva opción, etc.) debería ser fácil para un usuario estar al tanto de esto, antes de actualizar a la nueva versión que incluye los cambios.

## Obsoleta

{{< alert >}}
TL;DR: Esto se eliminará pronto. No usar
{{< /alert >}}

Eventualmente, algunas funcionalidades quedarán en desuso por cualquier razón (se encontró un mejor enfoque, el problema que resolvió ya no es un problema, etc.). Sin embargo, esto no debería suceder durante la noche, y las obsolescencias deben anunciarse en el registro de cambios y en el blog con al menos un mes de antelación.

Una vez que una función se ha anunciado como obsoleta, se marcará como tal (ver más abajo para más detalles) y la eliminación final también se expresará claramente en un número de versión (protuberancias de versión mayor/menor cuando corresponda).

# Funciones Experimenales

Para ayudar a aclarar qué funcionalidades son experimentales y cuáles son estables/producción, puede consultar la documentación (este sitio) o el comando `jx --help`.

El sitio de documentación tendrá banderas como esta:

{{< alert color="warning" >}}
Experimental
{{< /alert >}}

El comando `--help` incluirá la información en la descripción de un comando, de esta forma:

```sh
Installing:
  profile          Set your jx profile
  boot             (Experimental) Boots up Jenkins X in a Kubernetes cluster using GitOps and a Jenkins X Pipeline
  install          (Stable) Install Jenkins X in the current Kubernetes cluster
  .
  .
```

Las funciones/comandos de nivel de producción no se marcarán específicamente.

{{< alert color="warning" >}}
En este punto, estas marcas no se han aplicado universalmente. En caso de duda, pregunte en el canal slack `# jenkins-x-user`
{{< /alert >}}

## Acceso a Funciones Experimentales

Como podría involucrarse un poco con algunas funcionalidades experimentales, debe permitir específicamente su uso; si no, simplemente serán ignorados.

Para habilitar las funciones experimentales, realice una de las siguientes acciones (según dónde necesite acceder a ellas)

### JX Boot

Actualice su configuración JX Boot para incluirlas a través de: `allow-experimental: true`

### jx CLI

Adicione `--allow-experimental` al comando para utilizar las funciones experimentales

# Funcionalidades Obsoletas

Para resaltar las funcionalidades obsoletas y hacer que sea fácil ver cuáles evitar, la documentación (este sitio) incluirá una advertencia como esta:

{{< alert color="warning" >}}
Obsoleta en jx desde 2.0.134. Será eliminada en el 2 de diciembre del 2019.
{{< /alert >}}

en páginas que se refieren a funciones obsoletas. La advertencia indicará la versión donde la función se detendrá/dejará de incluirse.

De manera similar a los comandos experimentales y estables, el comando `jx --help` resaltará comandos obsoletos con `(DEPRECATED)` en la descripción del comando.
