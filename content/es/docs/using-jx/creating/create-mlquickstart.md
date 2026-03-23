---
title: "Crear MLquickstart"
linktitle: Crear MLquickstart
description: ¿Cómo crear una aplicación de aprendizaje automático de inicio rápido e importarla a Jenkins X?
weight: 30
---

El inicio rápido de aprendizaje automático (Machine learning quickstarts) son aplicaciones pre-configuradas de aprendizaje automático que puedes utilizar para iniciar tus propios proyectos.

Puede crear nuevas aplicaciones desde nuestra lista de inicio rápido de aprendizaje automático a través del comando [jx create mlquickstart](/commands/jx_create_mlquickstart/).

```sh
jx create mlquickstart
```
Luego se le solicita que elija de un listado de aplicaciones posibles.

Verá que estos vienen en grupos de tres:

```sh
? select the quickstart you wish to create  [Use arrows to move, space to select, type to filter]
> machine-learning-quickstarts/ML-python-pytorch-cpu
  machine-learning-quickstarts/ML-python-pytorch-cpu-service
  machine-learning-quickstarts/ML-python-pytorch-cpu-training
  machine-learning-quickstarts/ML-python-pytorch-mlpc-cpu
  machine-learning-quickstarts/ML-python-pytorch-mlpc-cpu-service
  machine-learning-quickstarts/ML-python-pytorch-mlpc-cpu-training
  machine-learning-quickstarts/ML-python-pytorch-mlpc-gpu
  machine-learning-quickstarts/ML-python-pytorch-mlpc-gpu-service
  machine-learning-quickstarts/ML-python-pytorch-mlpc-gpu-training
```

Cada inicio rápido de aprendizaje automático consta de dos proyectos, un proyecto de entrenamiento que administra el script de capacitación para su modelo y un proyecto de servicio que le permite abarcar sus instancias de modelo entrenadas con API de servicio listas para integrarse en su aplicación.

Si desea crear solo el proyecto `-service` o `-training`, puede hacerlo seleccionando la opción con el sufijo de nombre correspondiente.

Sin embargo, la mayoría de las veces, lo que desea hacer es seleccionar *el conjunto de proyectos*, que es la primera opción con el mismo nombre de prefijo y sin sufijo. Eso creará un par de proyectos coincidentes que están vinculados. Por ejemplo, si llama al repositorio `my-first-ml-project` y selecciona el conjunto de proyectos `ML-python-pytorch-cpu`, creará dos proyectos independientes en la carpeta actual, `my-first-ml-project-training` y `my-first-ml-project-service`.

Si los crea individualmente, es importante que sus proyectos compartan el mismo nombre raíz y que terminen con los sufijos `-training` y `-service` para que puedan integrarse automáticamente durante el proceso de construcción.

Puede utilizar un filtro de texto para filtrar los nombres de los proyectos:

```sh
jx create mlquickstart -f gpu
```

### ¿Qué sucede cuando se crea un inicio rápido?

Una vez que haya elegido el proyecto a crear y le haya dado un nombre, se automatizará lo siguiente:

* crea un par de proyectos desde el inicio rápido en subdirectorios
* adiciona el código de ambos en un par de repositorios Git
* crea un repositorio Git  para cada repositorio Git local en una plataforma como [GitHub](https://github.com)
* empuja el código de los repositorios locales hacia los repositorios remotos
* adiciona los siguientes ficheros:
  * `Dockerfile` para construir la imagen Docker de la aplicación
  * `Jenkinsfile` para implementar el pipeline CI/CD para las construcciones de entrenamiento y servicio
  * charts de Helm para ejecutar la aplicación en Kubernetes
* registra un enlaces (webhooks) en el repositorio Git remoto hacia los equipos del servidor Jenkins X
* desencadena los pipelines de entrenamiento y despliegue del servicio

Una vez que cree un inicio rápido de aprendizaje automático, los proyectos de entrenamiento y servicio se construirán simultáneamente. El proyecto de servicio se desplegará, pero la primera vez no se iniciará porque todavía no tiene un modelo de entrenamiento para trabajar.

Mientras tanto, el proyecto de entrenamiento comenzará a trabajar en la capacitación del modelo y, una vez capacitado, realizará algunas pruebas de aceptación para verificar que la instancia del modelo capacitado sea lo suficientemente precisa como para que valga la pena promoverla para futuras pruebas. Si el modelo no ha aprendido lo suficientemente bien, la construcción del entrenamiento fallará en este punto.

Puede reiniciar el entrenamiento con el comando:

```sh
jx start pipeline
```

y luego seleccione el nombre del proyecto de entrenamiento que desea ejecutar nuevamente, o puede editar su secuencia de comandos de capacitación, confirmar sus cambios y enviarlos para activar automáticamente otra ejecución de capacitación.

Una vez completado el entrenamiento con éxito, la versión de su modelo que acaba de recibir capacitación y las métricas asociadas con esta ejecución se pasarán a su proyecto `-service` mediante un PR. Ahora debe revisar el repositorio del proyecto `-service` y verificar las métricas de capacitación para verificar su idoneidad. El proyecto `-service` se reconstruirá automáticamente utilizando la instancia del modelo recién entrenado y se desplegará en un entorno de vista previa donde puede probarlo utilizando su API.

Si se aprueban todas las comprobaciones de control de calidad, puede cerrar la sesión de la misma manera que lo haría para cualquier otra compilación dentro de Jenkins-X (haga que los aprobadores y revisores issue /approve y /lgtm comentarios en el hilo del PR).

Una vez que se cierra la sesión, la instancia del modelo entrenado se mezcla en la rama `master` de su proyecto `-service`, se reconstruye y se despliega en etapas para pruebas e integración adicionales.

Cada vez que reinicie el proyecto de entrenamiento, obtendrá una nueva instancia de modelo que puede elegir promover de la misma manera. Todos los modelos se versionan a través de Git, por lo que puede realizar un seguimiento de cada instancia y sus métricas.

### ¿Cómo funciona el inicio rápido?

La fuente de estos proyectos de Inicio Rápido se mantiene en [la organización GitHub de machine-learning-quickstarts](https://github.com/machine-learning-quickstarts).

Al igual que con los inicios rápidos convencionales de Jenkins-X, utilizamos [los paquetes de compilación Jenkins X](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes) para que utilizar el paquete adecuado para el proyecto utilizando el lenguaje de código fuente y los tipos frameworks de aprendizaje automático para elegir la combinación más adecuada.

Cuando utilice [jx create](/es/docs/getting-started/setup/create-cluster/), [jx install](/docs/resources/guides/managing-jx/common-tasks/install-on-cluster/) o [jx init](/commands/deprecation/), [los paquetes de compilación de Jenkins X](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes) serán clonados en su carpeta local `~/.jx/draft/packs`.

Entonces, cuando creas un proyecto de inicio rápido de aprendizaje automático, [los paquetes de compilación de Jenkins X](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes) son utilizado para:

* buscar el paquete correspondiente al lenguaje de programación. p.ej aquí está la actual [lista de paquetes para lenguajes](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes/tree/master/packs).
* el paquete de lenguaje es utilizado para seleccionar los siguientes ficheros correspondientes si no existen:
  * `Dockerfile` para crear la imagen Docker de la aplicación
  * `jenkins-x.yml` para implementar los pipelines CI/CD utilizando pipelines declarativos como código
  * Charts Helms para desplegar la aplicación en Kubernetes y para implementar [Vistas Previas de Entornos](/es/about/concepts/features/#entornos-de-vista-previa).

## Adicionar tus propios Inicios Rápidos

Si desea enviar un nuevo inicio rápido a Jenkins X, simplemente [plantee un problema](https://github.com/jenkins-x/jx/issues/new?labels=quickstart&title=Add%20mlquickstart&body=Please%20add%20this%20github%20mlquickstart:) con la URL en GitHub de su inicio rápido y podemos bifurcarlo en la [organización de inicio rápido](https://github.com/machine-learning-quickstarts) para que aparezca en el menú `jx create mlquickstart`.

O si forma parte de un proyecto de código abierto y desea seleccionar su propio conjunto de inicios rápidos para su proyecto; puede [plantear un problema](https://github.com/jenkins-x/jx/issues/new?labels=quickstart&title=Add%20mlquickstart&body=Please%20add%20this%20github%20mlquickstart:) proporcionándonos detalles de la organización de GitHub donde están los inicios rápidos y lo agregaremos como una organización predeterminada en el comando [jx create mlquickstart](/commands/jx_create_mlquickstart/). Es más fácil para [jx create mlquickstart](/commands/jx_create_mlquickstart/) si mantiene los inicios rápidos en una organización separada de inicio rápido en GitHub.

Hasta que lo hagamos, puede seguir usando sus propios Inicios Rápidos en el comando `jx create mlquickstart` a través del parámetro `-g` o `--organisation`. p.ej.

```sh
jx create mlquickstart  --organisations my-github-org
```

Luego, todos los inicios rápidos de aprendizaje automático que se encuentran en `my-github-org` se enumerarán además de los valores predeterminados.

Tenga en cuenta que hay algunos estándares para crear inicios rápidos de aprendizaje automático:

* Todos los nombres de inicio rápido deben comenzar con las letras `ML-` para distinguirlo de un inicio rápido convencional
* Los proyectos de entrenamiento deben tener sufijos `-training`
* Los proyectos de servicio deben tener el sufijo `-service`
* Todos los componentes de un conjunto de proyectos deben compartir el mismo prefijo raíz a su nombre

Para crear un conjunto de proyectos de aprendizaje automático, cree un nuevo repositorio en su organización de inicio rápido de modo que el nombre sea el prefijo compartido para su inicio rápido, por ejemplo: `machine-learning-quickstarts/ML-python-pytorch-cpu`

Intente elegir nombres explicativos para que quede claro qué lenguaje, framework y hardware están asociados con este conjunto de proyectos.

Dentro de su repositorio de conjuntos de proyectos, cree un único archivo llamado `projectset` que tenga el siguiente formato:

```yaml
[
   {
      "Repo":"ML-python-pytorch-cpu-service",
      "Tail":"-service"
   },
   {
      "Repo":"ML-python-pytorch-cpu-training",
      "Tail":"-training"
   }
]
```

## Personalizar sus equipos de Inicio Rápido

Puede configurar a nivel de equipo los inicios rápidos que se le presentan en el comando `jx create mlquickstart`. Estas configuraciones se almacenan en el recurso [Environment Custom Resource](/docs/reference/components/custom-resources/) en Kubernetes.

Para agregar la ubicación de un conjunto de inicios rápidos de aprendizaje automático, puede usar el comando [jx create quickstartlocation](/commands/jx_create_quickstartlocation/).

```sh
jx create quickstartlocation --url https://mygit.server.com --owner my-mlquickstarts --includes=[ML-*]
```

Tenga en cuenta que DEBE especificar la opción `--includes=[ML-*]` o sus inicios rápidos se agregarán a la lista de inicio rápido convencional en lugar de a la lista de aprendizaje automático.

Si omite el parámetro `--url`, el comando asumirá que es un repositorio de [GitHub](https://github.com/). Tenga en cuenta que se admiten repositorios públicos y privados.

Esto significa que puede tener sus propios inicios rápidos privados compartidos para reutilizar dentro de su organización. Por supuesto, obviamente preferimos que [comparta sus inicios rápidos con nosotros a través del código abierto](https://github.com/jenkins-x/jx/issues/new?labels=quickstart&title=Add%20mlquickstart&body=Please%20add%20this%20github%20mlquickstart:), luego podemos incluir su inicio rápido con toda la comunidad, pero puede haber ocasiones en las que desee seleccionar sus propios inicios rápidos internos utilizando un software propietario.

También puede especificar otros patrones como `--includes` o `--excludes` para filtrar los nombres de los repositorios donde `*` coincide con cualquier cosa y `foo*` coincide con cualquier cosa que comience por `foo`. p.ej. puede incluir los lenguajes y las tecnologías que admite su organización y excluir el resto, etc.

También tenga en cuenta que puede usar el alias de `qsloc` en lugar de `quickstartlocation` si desea alias más cortos;)

Luego puede ver las ubicaciones actuales de inicio rápido para su equipo a través del comando [jx get quickstartlocations](/commands/jx_get_quickstartlocation/):

```sh
jx get quickstartlocations
```

O utilizando la abreviatura

```sh
jx get qsloc
```

También está el comando [jx delete quickstartlocation](/commands/jx_delete_quickstartlocation/) si necesita eliminar una organización Git.