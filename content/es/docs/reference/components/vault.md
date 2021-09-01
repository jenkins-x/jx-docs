---
title: Vault
linktitle: Vault
description: Gestione sus Secretos
weight: 200
---

{{< pageinfo >}}
Tenga en cuenta que actualmente Vault solo funciona en Google Cloud Platform (GCP) con Google Kubernetes Engine (GKE). Estamos trabajando para ampliar el soporte a otros proveedores de la nube.
{{< /pageinfo >}}

# ¿Qué es Vault?

[Vault](https://www.vaultproject.io) es un proyecto de código abierto para administrar secretos de forma segura y es nuestra forma preferida de administrar secretos en sus entornos en Jenkins X.

En las infraestructuras informáticas tradicionales, todos los recursos y componentes (hardware, redes, disponibilidad, seguridad e implementación) así como los costos laborales asociados se gestionan localmente. Terceros entornos informáticos como proveedores de servicios en la nube y de Git ofrecen soluciones descentralizadas con distintas ventajas en el servicio de fiabilidad y costos sobre las soluciones tradicionales.

Sin embargo, un problema con el uso de servicios en la nube, almacenamiento distribuido y repositorios remotos es la falta de redes confiables, hardware examinado, y otras medidas de seguridad observadas de cerca practicadas en entornos locales de
infraestructura. Por conveniencia, los usuarios a menudo almacenan información como credenciales de autenticación en repositorios públicos y abiertos, expuestos a posibles actividades maliciosas.

[Hashicorp *Vault*](https://www.vaultproject.io/) es una herramienta que centraliza la gestión de secretos: recursos que proporcionan autenticación a su entorno informático, como tokens, claves, contraseñas y certificados.

Jenkins X maneja los recursos de seguridad y autenticación a través de la integración de Vault. Los usuarios pueden implementar Vault para almacenar y administrar de forma segura todos los aspectos de su plataforma de desarrollo.

Jenkins X instala y configura Vault para su clúster de manera predeterminada a través del proceso de creación del clúster.

## Características de Vault

Vault es una herramienta para acceder y almacenar secretos de usuario. Gestiona el Complejidad del acceso seguro a los recursos:

- Almacenamiento de secretos: Vault coloca los secretos en un formato cifrado en un depósito (bucket) de almacenamiento remoto.

- Creación y eliminación de secretos - Vault crea secretos para un acceso dinámicos a depósitos de almacenamiento, acceso efímero que son
creados/destruidos según sea necesario para el acceso temporal a datos, y genera claves para la autenticación de la base de datos.

- Cifrado de datos: Vault almacena los secretos en un depósito de almacenamiento remoto en directorios seguros con cifrado seguro.

Jenkins X interactúa con Vault a través del programa de línea de comando `jx`. Hay comandos para crear, eliminar y gestionar secretos y bóvedas.

Jenkins X usa Vault para almacenar todos los secretos de Jenkins X, como el token de acceso personal de GitHub generado para el pipeline del bot (sistema) cuando [crea un clúster de Jenkins X cluster](/docs/getting-started/setup/boot/). También almacena cualquier secreto de GitOps, como contraseñas para los depósitos de almacenamiento y claves para acceso seguro al servidor.

Los secretos pueden ser recuperados por el pipeline o por la línea de comando si está registrado en la cuenta asociada con el servicio Kubernetes, así como en cualquier secreto almacenado en el espacio de nombres `jx` para el pipeline.

Las bóvedas se aprovisionan en Kubernetes usando `vault-operator`, un Controlador Kubernetes de código abierto instalado cuando Vault está siendo  configurado durante la creación del clúster y la instalación de Jenkins X.

# Utilizando Vault en el CLI

Primero necesita descargar e instalar el CLI [safe](https://github.com/starkandwayne/safe) para Vault.

Una vez instalado [safe](https://github.com/starkandwayne/safe) puede ejecutar el siguiente comando:

```
eval `jx get vault-config`
```

ahora debe poder utilizar [safe](https://github.com/starkandwayne/safe) CLI para acceder a Vault.

Puede entonces obtener un secreto a través de:

```
safe get /secret/my-cluster-name/creds/my-secret
```

o puede actualizar un secreto a través de:

```
safe set /secret/my-cluster-name/creds/my-secret username=myname password=mytoken
```

Si tiene un blob de JSON para codificar como secreto, como una clave de cuenta de servicio, convierta el archivo a base64 primero y luego configúrelo ...

```sh
cat my-service-account.json | base64 > myfile.txt
safe set /secret/my-cluster-name/creds/my-secret json=@myfile.txt
```

# Configurar DNS y TLS para Vault

Para una instalación segura de Jenkins X, debe habilite TLS cuando interactúe con el servicio de almacenamiento. Para configurar TLS, primero debe configurar los ajustes de DNS de Zona en Google Cloud Platform, y luego configure los ajustes de DNS externos para el `Ingress` y TLS en el
fichero de configuración ``jx-requirements.yml`.

## Configurar Google Cloud DNS

Para configurar el acceso DNS y TLS de Vault correctamente, debe configurar Google Cloud DNS de forma adecuada.

Debe tener un nombre de dominio registrado, por ejemplo `www.acmecorp.example` antes de configurar el DNS en la Zona de Configuraciones de Google. Para obtener más información, consulte la guía de [Creación de una Zona Administrada Pública](https://cloud.google.com/dns/docs/quickstart#create_a_managed_public_zone).

1. Navegue hasta la página de [Selección de Proyecto](https://console.cloud.google.com/projectselector2/home/dashboard) y elija su proyecto de Google Cloud Platform.

2. [Cree un DNS de Zona](https://console.cloud.google.com/networking/dns/zones/~new)

3. Elija como su *Tipo de zona* Public.

4. Escriba un *Nombre de zona* para su zona.

5. Adicione un sufijo al DNS in *DNS name*, p.ej `acmecorp.example`.

6. Seleccione su *DNSSEC* o el estado de Seguridad DNS, que debe se configurado como `Off` para este ejemplo.

7. (Opcional) Ingrese una *Descripción* para su zona DNS.

8. Clic en `Create`.

Una vez creada, se carga la página *Zone Details*. *NS* (servidor de nombres) y los registros *SOA* (Inicio de autoridad) se crean automáticamente para su dominio (por ejemplo, `acmecorp.example`)

## Configurar DNS Externo en Jenkins X

Una vez que haya configurado Google Cloud DNS, puede usar la página de [Zonas](https://console.cloud.google.com/net-services/dns/zones) en su proyecto de Google Cloud Platform para configurar su dominio externo.

{{< alert >}}
NOTA: El DNS externo actualizará automáticamente los registros DNS si reutiliza el nombre de dominio, por lo que si elimina un clúster antiguo y crea uno nuevo, conservará la misma configuración de dominio para el nuevo clúster.
{{< /alert >}}

Para configurar DNS Externo:

1. Elija un nombre DNS único; puede usar dominios anidados (por ejemplo, cluster1.acmecorp.example). Ingrese el nombre en el campo Nombre DNS

2. Ejecute el comando `jx create domain` contra su nombre de dominio, por ejemplo:

```
jx create domain gke --domain cluster1.acmecorp.example
```

    Se le preguntará la información que se necesite para la configuración:

    1. Seleccione su proyecto Google Cloud Platform del listado disponible.

    2. Actualice sus servidores administrados existentes para usar la lista que se muestra de los servidores de nombres DNS en la nube. Copie la lista para usar en los próximos pasos.

El siguiente paso es configurar GCP:

1. Desde la página [Zonas](https://console.cloud.google.com/net-services/dns/zones) de Google Cloud Platform, cambie el *Resource Record Type* a `NS`) y use los valores predeterminados para su dominio para *TTL* (`5`) y *TTL Unit* (`minutos`).

2. Agregue el primer servidor de nombres al campo *Servidor de nombres*

3. Clic en `Add item` y adicione cualquier servidor de nombre.

4. Clic en `Create`.

Finalmente, configure Jenkins X para los nuevos nombres de dominio:

1. Edite el fichero `jx-requirements.yml` y actualice el campo `dominio` (en `Ingress`) a su nombre de dominio, por ejemplo `cluster1.acmecorp.example`.

2. En la configuración *tls*, habilite TLS con `enabled: true`.

El fichero `jx-requirements.yml` quedaría de la siguiente forma si utilizamos las configuraciones mencionadas:

```yaml
gitops: true
ingress:
  domain: cluster1.acmecorp.example
  externalDNS: true
  namespaceSubDomain: -jx.
  tls:
    email: certifiable@acmecorp.example
    enabled: true
    production: true
secretStorage: vault
```

{{< alert >}}
Recuerde ejecutar el comando `jx boot` para que los cambios tengan efecto en su entorno.
{{< /alert >}}

# Crear un Vault

De forma predeterminada, se crea un servicio Vault utilizando [jx boot](/getting-started/boot/) para crear su clúster, a menos que haya especificado durante la configuración del clúster no cree Vault. En este caso, puede crear una instalación posterior con la interfaz de línea de comandos `jx create`:

```
jx create vault
```

1. El programa le preguntará el nombre para su Vault (p.ej `acmevault`)

2. El programa le pedirá su Google Cloud Zone de elección. Consulte [Regiones y zonas](https://cloud.google.com/compute/docs/regions-zones/) en la documentación de Google Cloud para obtener más información. En este ejemplo, `us-east1-c` se elige por su proximidad a la sede de Acme.

3. Si tiene una cuenta de depósito de almacenamiento configurada desde la creación de un clúster con `jx boot`, entonces el comando `jx create vault` analizará su instalación en busca de depósitos de almacenamiento relacionados con Vault y, si se encuentra, le pedirá que apruebe eliminar y volver a crear el Vault desde cero.

4. El programa le preguntará por el *Expose type* para el Vault para crear reglas y rutas para el balanceo de carga del clúster y otros servicios. El valor predeterminado es `Ingress`.

5. El programa solicitará un dominio de clúster. El valor predeterminado es el creado en [el proceso de creación de Cluster](/docs/getting-started/setup/boot/), como 192.168.1.100.nip.io.

6. El programa le pedirá una `URLTemplate`. Presione `Enter` para usar el valor predeterminado.

7. El programa verificará sus respuestas a las preguntas anteriores en resumen y le pedirá que apruebe la creación de Vault (el valor predeterminado es `Yes`).
