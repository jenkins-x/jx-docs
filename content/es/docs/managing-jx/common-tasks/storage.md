---
title: Almacenamiento
linktitle: Almacenamiento
description: ¡Guardemos sus archivos de tubería en algún lugar nativo de la nube!
weight: 180
---

Cuando utilizamos un servidor Jenkins estático (Static Jenkins Server) con Jenkins X heredamos el modelo de almacenamiento habitual Jenkins; que crean registros, resultados de pruebas e informes los cuales son almacenados en un volumen (Persistent Volume) persistente del servidor Jenkins.

Sin embargo, a medida que avanzamos hacia un [Jenkins más nativo en la nube](/news/changes-november-26-2018/) y usamos Jenkins sin servidor ([Serverless Jenkins](/news/serverless-jenkins/)), necesitamos una mejor solución para el almacenamiento de cosas como registros, resultados de pruebas, informes de cobertura de código, etc.

## Extensiones de almacenamiento

Así que hemos agregado un punto de extensión de almacenamiento que se usa desde:

* almacenar registros cuando se utiliza [Serverless Jenkins](/news/serverless-jenkins/), que se realiza mediante el comando [jx controller build](/commands/jx_controller_build/)
* utilizando el comando [jx step stash](/commands/jx_step_stash/) que oculta archivos de una compilación (informes de prueba o cobertura)

## Configurar el Almacenamiento

Puede configurar la ubicación predeterminada a utilizar para el almacenamiento. Actualmente permitimos:

* almacenar archivos (registros, informes de prueba o cobertura) en una rama de un repositorio git. p.ej. podrían ser parte de la rama `gh-pages` para su sitio estático.
* almacenar ficheros en espacios en la nube (buckets) como por ejemplo S3, GCS, Azure blobs, etc.

El almacenamiento utiliza clasificaciones que se utilizan para definir la carpeta donde se guardarán los tipos de recursos como

* registros (logs)
* pruebas (tests)
* cobertura (coverage)

También puede usar la clasificación especial `default` que se utiliza si no tiene una configuración para la clasificación en cuestión. p.ej. puede definir una ubicación de `default` y luego simplemente configurar dónde van los `logs` si eso es diferente.

Si está utilizando [jx boot](/es/docs/getting-started/setup/boot/) para instalar y configurar Jenkins X, modifique el fichero `jx-requirements.yml` para configurar el almacenamiento como se describe en la [documentación de boot](/es/docs/getting-started/setup/boot/#almacenamiento)

De lo contrario, para configurar la ubicación de almacenamiento para una clasificación y un equipo, use el comando [jx edit storage](/commands/jx_edit_storage/).

p.ej.

```sh
# Configure the tests to be stored in cloud storage (using S3 / GCS / Azure Blobs etc)
jx edit storage -c tests --bucket-url s3://myExistingBucketName

# Configure the git URL and branch of where to store logs
jx edit storage -c logs --git-url https://github.com/myorg/mylogs.git --git-branch cheese
```

Puede ver la configuración de almacenamiento de su equipo a través de [jx get storage](/commands/jx_get_storage/)

## Utilizando el Almacenado (Stash)

Dentro del pipeline, puede ejecutar el comando [jx step stash](/commands/jx_step_stash/) para almacenar archivos:

```sh
# lets collect some files with the file names relative to the 'target/test-reports' folder and store in a Git URL
jx step stash -c tests -p "target/test-reports/*" --basedir target/test-reports

# lets collect some files to a specific AWS cloud storage bucket
jx step stash -c coverage -p "build/coverage/*" --bucket-url s3://my-aws-bucket
```

* especifique el clasificador mediante el parámetro `-c` para pruebas o cobertura, etc.
* especifique los archivos que se recopilarán mediante el parámetro `-p`, que admite expresiones como `*` para archivos que se almacenarán con la ruta relativa del directorio.
* si desea eliminar un prefijo de directorio de los archivos guardados, como por ejemplo `target/reports`, puede utilizar `--basedir` para especificar el directorio para crear nombres de archivo relativos

De forma predeterminada, [jx step stash](/commands/jx_step_stash/) usará la ubicación configurada de su equipo para la clasificación que usted proporcione. Si lo desea, puede anular la ubicación de almacenado utilizando `--git-url` o `--bucket-url`.

### Recuperar ficheros Almacenados (Unstashing)

Si lo necesita, puede recuperar los ficheros previamente almacenados a través del comando [jx step unstash](/commands/jx_step_unstash/).

Si está en algún código fuente de Go y tiene una URL de Jenkins X, como una URL de registro de compilación o un archivo adjunto de un [PipelineActivity Custom Resource](/docs/reference/components/custom-resources/), la URL podría tener varias formas, como:

  * `gs://anotherBucket/mydir/something.txt` : utilizando un bucket GCS en GCP
  * `s3://nameOfBucket/mydir/something.txt` : utilizando un bucket S3 en AWS
  * `azblob://thatBucket/mydir/something.txt` : utiliznado un bucket de Azure
  * `http://foo/bar` : fichero almacenado en un repositorio git HTTP
  * `https://foo/bar` : fichero almacenado en un repositorio git HTTPS

Si desea poder leer fácilmente desde la URL del código fuente de Go, puede usar [la función `ReadURL`](https://github.com/jenkins-x/jx/blob/e5a7943dc0c3d79c27f30aea73235f18b3f5dcff/pkg/cloud/buckets/buckets.go#L44-L45).