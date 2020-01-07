---
title: Instalar jx
linktitle: Instalar jx
description: ¿Cómo instalar el binario jx en tu máquina?
weight: 5
keywords: [instalar]
---

Elija las instrucciones más adecuadas para su sistema operativo:

## macOS

En una Mac puedes utilizar [brew](https://brew.sh/):

```sh
brew install jenkins-x/jx/jx
```

Para instalar Jenkins X en macOS sin utilizar brew debes descargar el fichero `.tar` y descomprimirlo en el directorio donde puedas ejecutar el comando `jx`.

1.  Descargue el archivo binario `jx` utilizando `curl` y la barra `|` a través del comando:

```sh
curl -L "https://github.com/jenkins-x/jx/releases/download/$(curl --silent https://api.github.com/repos/jenkins-x/jx/releases/latest | jq -r '.tag_name')/jx-darwin-amd64.tar.gz" | tar xzv "jx"
```

    o, si no tienen instalado `jq` utilice el siguiete comando:

```sh
curl -L "https://github.com/jenkins-x/jx/releases/download/$(curl --silent "https://github.com/jenkins-x/jx/releases/latest" | sed 's#.*tag/\(.*\)\".*#\1#')/jx-darwin-amd64.tar.gz" | tar xzv "jx"
```


2.  Instale el binario `jx` moviendo el fichero descargado al directorio correspondientes al PATH de su entorno, utilice el comando `mv`.

```sh
sudo mv jx /usr/local/bin
```

3. Ejecute `jx version` para confirmar que tienes la última versión estable

```sh
jx version
```

## Linux

Para instalar Jenkins X en Linux descargue el fichero `.tar` y descomprímalo en el directorio donde puedas ejecutar el comando `jx`.

1.  Descargue el archivo binario `jx` utilizando `curl` y la barra `|` a través del comando:

```sh
curl -L "https://github.com/jenkins-x/jx/releases/download/$(curl --silent https://api.github.com/repos/jenkins-x/jx/releases/latest | jq -r '.tag_name')/jx-linux-amd64.tar.gz" | tar xzv "jx"
```

    o, si no tienen instalado `jq` utilice el siguiete comando:

```sh
curl -L "https://github.com/jenkins-x/jx/releases/download/$(curl --silent "https://github.com/jenkins-x/jx/releases/latest" | sed 's#.*tag/\(.*\)\".*#\1#')/jx-linux-amd64.tar.gz" | tar xzv "jx"
```

2.  Instale el binario `jx` moviendo el fichero descargado al directorio correspondientes al PATH de su entorno, utilice el comando `mv`.

```sh
sudo mv jx /usr/local/bin
```

3. Ejecute `jx version` para confirmar que tienes la última versión estable

```sh
jx version
```

## Windows

Puede instalar Jenkins X en Windows a través de Chocolatey, un sistema de administración de paquetes de terceros que proporciona comandos convenientes en un solo paso para las instalaciones y actualizaciones locales de Jenkins X.

Instale el sistema de gestión de paquetes de Chocolatey utilizando un Shell de administración:

1.  Clic-Derecho menu: Inicio\[Comando Rápido (Admin)\].

2.  En la ventana de comando, ejecute `powershell.exe` para descargar e instalar el binario  `choco` en la ruta donde podrá ser ejecutado, utilice la siguiente línea:

        @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

3.  Instalar Jenkins X utilizando Chocolatey:

        choco install jenkins-x

Puedes actualizar Jenkinx X a su última versión utilizando Chocolatey:

```sh
choco upgrade jenkins-x
```

- Si utilizas [scoop](https://scoop.sh), entonces hay un [manifiesto disponible](https://github.com/lukesampson/scoop/blob/master/bucket/jx.json).

  Para instalar el binario `jx` ejecute:

  ```sh
  scoop install jx
  ```

  Para actualizar el binario `jx` ejecute:

  ```sh
  scoop update jx
  ```

## Plataforma Google Cloud (GCP)

Para ejecutar los comandos `jx` desde GCP Cloud Shell, instale los binarios de Jenkins X desde el repositorio de GitHub y hágalo con los comandos de GCP Shell:

1.  Abra [GCP Cloud Shell](https://cloud.google.com/shell/docs/starting-cloud-shell),
    y seleccione su proyecto GCP para Jenkinx X.

{{% alert %}}
Es altamente recomendable que utilice el navegador Google Chrome con GCP Cloud Shell para evitar problemas inesperados.
{{% /alert %}}

1.  Estando en GCP Cloud Shell, descargue el archivo binario `jx` utilizando `curl` y la barra `|` a través del comando:

```sh
curl -L "https://github.com/jenkins-x/jx/releases/download/$(curl --silent https://api.github.com/repos/jenkins-x/jx/releases/latest | jq -r '.tag_name')/jx-linux-amd64.tar.gz" | tar xzv "jx"
```

1.  Mueva el ejecutable `jx` al directorio de ejecutables utilizando el siguiente comando:

```sh
sudo mv jx /usr/local/bin
```

4. Ejecute `jx version` para confirmar que tienes la última versión estable

```sh
jx version
```

Una vez instalado el binario `jx` podrás [configurar el clúster para Jenkins X en Google Kubernetes Engine](/getting-started/create-cluster/).

## Otras plataformas

[descargue el binario](https://github.com/jenkins-x/jx/releases) para `jx` y agréguelo al su `$PATH`

También puede intentar [construirlo usted mismo](https://github.com/jenkins-x/jx/blob/master/docs/contributing/hacking.md). Sin embargo, si lo construye usted mismo ten cuidado de eliminar cualquier binario `jx` anterior para que su compilación local se encuentre primero en el `$PATH` :)

## Obtener Ayuda

Para identificar los comandos disponibles escriba:

```sh
jx
```

O, para obtener información sobre un comando específico, por ejemplo `create`, escriba:

```sh
jx help create
```

También puedes buscar en la [documentación de referencia para comandos jx](/commands/jx/)
