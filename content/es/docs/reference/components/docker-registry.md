---
title: Registro Docker
linktitle: Registro Docker
description: Configure su registro de Docker
weight: 90
---

Para poder crear y publicar imágenes de Docker necesitamos usar un Registro de Docker.

De forma predeterminada, Jenkins X se entrega con un Registro Docker que se incluye en el namespace del sistema para Jenkins X junto con Jenkins y Nexus. Dado que este registro de Docker se ejecuta dentro de su clúster de Kubernetes y se usa internamente dentro de su clúster, es difícil exponerlo a través de HTTPS con certificados autofirmados, por lo que de manera predeterminada usamos registros de Docker inseguros para el rango de IP de IP de servicio en su clúster de Kubernetes.

## Utilizando un registro de Docker diferente

Si está utilizando la nube pública, puede aprovechar el registro de docker de sus proveedores de nube; o reutilice su propio registro de docker existente.

### Si está utilizando un Master de Jenkins Estático

Para especificar el host/puerto Docker Registry, puede usar la consola Jenkins:

```sh
$ jx console
```

Luego navegue a `Manage Jenkins -> Configure System` y cambie la variable de entorno `DOCKER_REGISTRY` para apuntar a su registro de docker de elección.

Otro enfoque es agregar lo siguiente a su archivo `values.yaml` para la personalización de los charts de Helm en la plataforma Jenkins X:

```yaml
jenkins:
  Servers:
    Global:
      EnvVars:
        DOCKER_REGISTRY: "gcr.io"
```

## Actualice el secreto en config.json

Va a necesitar actualizar el valor del secreto de docker almacenado en `config.json`.

Puede logarlo a través del comando [jx create docker auth](/commands/jx_create_docker/):

```
$ jx create docker auth --host "foo.private.docker.registry" --user "foo" --secret "FooDockerHubToken" --email "fakeemail@gmail.com"

```

Si crea un fichero `config.json` para su proveedor de registro de docker, p.ej para GCR en Google Cloud, seguramente necesitará algo como esto:

```json
{
    "credHelpers": {
        "gcr.io": "gcloud",
        "us.gcr.io": "gcloud",
        "eu.gcr.io": "gcloud",
        "asia.gcr.io": "gcloud",
        "staging-k8s.gcr.io": "gcloud"
    }
}
```

Para AWS es como esto:

```json
{
	"credsStore": "ecr-login"
}
```

Para actualizar el secreto `jenkins-docker-cfg` puede hacerlo de la siguiente forma:

```
$ kubectl delete secret jenkins-docker-cfg
$ kubectl create secret generic jenkins-docker-cfg --from-file=./config.json
```

**NOTA** el archivo debe llamarse `config.json` ya que el nombre del archivo se usa en la clave del `secret` subyacente en kubernetes

## Utilizando Docker Hub

Si desea almacenar las imágenes en DockerHub, entonces debe modificar su fichero `config.json` como se describe a continuación:

```json
{
    "auths": {
        "https://index.docker.io/v1/": {
            "auth": "MyDockerHubToken",
            "email": "myemail@acme.com"
        }
    }
}
```

## Utilizando jFrog BinTray (Artifactory)

Utilizar JFrog BinTray como registro privado para docker es posible. Esto ha sido probado solamente durante la creación del clúster y pasando el parámetro `--docker-registry=private-reg.bintray.io`. Luego, después de creado el clúster, va a necesitar lo siguiente:

1. Borre el `Secret` existente con el nombre `jenkins-docker-cfg` ejecutando:

```sh
$ kubectl delete secret jenkins-docker-cfg
```

1. Cree un fichero local con el nombre `config.json` y su valor debe estar en el siguiente formato (actualice los valores basados en su registro de usuario y FQDN):

```json
{
    "auths": {
        "https://private-reg.bintray.io": {
            "auth": "username:password (base64 encoded)",
            "email": "myemail@acme.com"
        }
    }
}
```

1. Cree el nuevo recurso `Secret` con nombre `jenkins-docker-cfg` con el contenido del fichero `config.json` como lo siguiente:

```sh
$ kubectl create secret generic jenkins-docker-cfg --from-file=./config.json
```

Con esto debe ser sufiente, ahora debe poder ejecutar los pipelines y almacenar las imágenes en registro jFrog BinTray.

### Montar el Secreto para su registro

Su registro docker va a necesitar un Secreto que necesita ser montado en la [Plantilla Pod](/docs/resources/guides/managing-jx/common-tasks/pod-templates/).