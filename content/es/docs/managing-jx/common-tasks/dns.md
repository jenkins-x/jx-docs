---
title: DNS
linktitle: DNS
description: Configuración de DNS para el acceso externo de los servicios del clúster
weight: 80
---

Para poder acceder a los servicios alojados dentro de su clúster, usamos un dominio [nip.io](https://nip.io/). Esto hace que sea muy fácil configurar y administrar DNS.

Sin embargo, para los usuarios que desean que los servicios del clúster estén disponibles en un dominio personal, utilizamos DNS externos, que es igual de fácil.

## DNS Externos
**NOTA**: *Actualmente solo disponible en GKE*

Puede utilizar el servicio [ExternalDNS](https://github.com/kubernetes-incubator/external-dns) para exponer los Servicios (`Services`) y Entradas (`Ingress`) de Kubernetes mediante la sincronización con proveedores de DNS.

Si está utilizando [jx boot](/es/docs/getting-started/setup/boot/) para instalar y configurar su instalación, modifique el fichero `jx-requirements.yml` para habilitar `ingress.externalDNS: true` como se describe en la [documentación de entradas](/es/docs/getting-started/setup/boot/#ingress).

De lo contrario, para que su clúster utilice ExternalDNS utilice la siguiente línea de comando:

```sh
jx install --provider gke --tekton --external-dns
```

*Este comando le pedirá el dominio que desea utilizar.*

```sh
🙅 developer ~/go-workspace/jx(master)$ jx install --provider gke --tekton --external-dns
WARNING: When using tekton, only kaniko is supported as a builder
Context "gke_<your-project-id>_europe-west1-b_<your-cluster-name>" modified.
set exposeController Config URLTemplate "{{.Service}}-{{.Namespace}}.{{.Domain}}"
Git configured for user: **********  and email *********@****.***
helm installed and configured
? Provide the domain Jenkins X should be available at: your-domain.com
```

Luego se crea una zona administrada de CloudDNS dentro de su proyecto GCP de clústeres, los grupos de registros que exponen sus servicios serán creados por ExternalDNS dentro de esta zona administrada.

```sh
🙅 developer ~/go-workspace()$ gcloud dns managed-zones list
NAME                           DNS_NAME                   DESCRIPTION                       VISIBILITY
your-domain-com-zone           your-domain.com.           managed-zone utilised by jx       public
```

### Asignación

Una vez completada la instalación, se enviará una lista de servidores de nombres al terminal, actualice el sitio donde ha registrado su dominio utilizando estos servidores de nombres para delegar su dominio en Google CloudDNS.

```sh

        ********************************************************

            External DNS: Please delegate your-domain.com via
            your registrar onto the following name servers:
                ns-cloud-d1.googledomains.com.
                ns-cloud-d2.googledomains.com.
                ns-cloud-d3.googledomains.com.
                ns-cloud-d4.googledomains.com.

        ********************************************************

```

#### [Dominios en Google](https://domains.google)

Si está utilizando Dominios de Google como su registrador de dominios, consulte [aquí](https://support.google.com/domains/answer/3290309?hl=en-GB&ref_topic=9018335) para obtener detalles sobre cómo delegar en servidores de nombres personalizados.

### Plantillas URL

Todos los servicios deben estar disponibles en el mismo dominio, la cual se deriva de la siguiente manera:

```sh
<service>-<namespace>.<your-domain>
```