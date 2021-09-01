---
title: Amazon
linktitle: Amazon
description: ¿Como crear un clúster de Kubernetes? en Amazon (AWS)?
weight: 40
---

Existen deferentes maneras de configurar clústeres en Amazon:

## Utilizando EKS y eksctl

Si deseas EKS en AWS, entonces la herramienta preferida es [eksctl](https://eksctl.io).

Primero debes instalar [eksctl CLI](https://eksctl.io/introduction/installation/).

Luego sigue las instrucciones para [crear un clúster EKS con eksctl](https://eksctl.io/usage/creating-and-managing-clusters/).

## Utilizando EC2 y Kops

Si deseas utilizar EC2 y Kops debes descargar la [liberación de Kops](https://github.com/kubernetes/kops/releases).
Luego debes seguir las instrucciones para [crear un clúster en AWS utilizando Kops](https://kubernetes.io/docs/setup/production-environment/tools/kops/).

## Utilizando jx CLI

Asegúrese de [tener instalado la CLI jx](/es/docs/getting-started/setup/install/) para luego poder utilizar Kops:

```sh
jx create cluster aws --skip-installation
```

o puedes utilizar el servicio EKS:

```sh
jx create cluster eks --skip-installation
```
