---
title: Google
linktitle: Google
description: Cómo crear un clúster de Kubernetes en la Plataforma Google Cloud (GCP)?
weight: 50
---

## Utilizando la Consola de Google Cloud

Puedes crear un clúster de Kubernetes in pocos clics en la [Consolo de Google Cloud](https://console.cloud.google.com/).

Primero garantiza tener creado/seleccionado un proyecto:

<img src="/images/quickstart/gke-select-project.png" class="img-thumbnail">

Luego puedes dar clic en el botón `create cluster` en la página de los [clústeres de Kubernetes](https://console.cloud.google.com/kubernetes/list) o intentar [crear un clúster](https://console.cloud.google.com/kubernetes/add) directamente.

## Utilizando gcloud

La interfaz de líneas de comandos (CLI) para trabajar con Google Cloud es `gcloud`. Si no la tienes instalada entonces por favor [instale gcloud](https://cloud.google.com/sdk/install).

Para crear un cluster con gcloud siga [las siguientes instrucciones](https://cloud.google.com/kubernetes-engine/docs/how-to/creating-a-cluster).

## Utilizando Google Cloud Shell

Si no quieres instalar `gcloud` puedes utilizar [Google Cloud Shell](https://console.cloud.google.com/) porque tiene incluidos la mayoría de los componentes que necesitarás para la instalación (`git, gcloud, kubectl`, etc).

Primero necesitas abrir utilizar el botón de la barra de herramientas para abrir Google Cloud Shell:

<img src="/images/quickstart/gke-start-shell.png" class="img-thumbnail">

Una veza abierto podrás crear el clúster utilizando `gcloud` juanto a [las siguientes instrucciones](https://cloud.google.com/kubernetes-engine/docs/how-to/creating-a-cluster).

## Conectando con el clúster

Una vez creado el clúster vas a necesitar conectarte a él a través de las herramienas `kubectl` o [jx](/es/docs/getting-started/setup/install/).

Para lograrlo, has clic en el botón `Connect` en la página [Kubernetes Engine page](https://console.cloud.google.com/kubernetes/list) en la [Consola de Google](https://console.cloud.google.com/).

<img src="/images/quickstart/gke-connect.png" class="img-thumbnail">

Ahora deberías poder utilizar las herramientas CLI `kubectl` y `jx` desde su laptop para comunicarte con el clúster GKE. Por ejemplo, el siguiente comando debería listar los nodos presentes en su clúster:

```sh
kubectl get node
```
