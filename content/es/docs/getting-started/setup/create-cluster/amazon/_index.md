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

Luego sigue las instruciones para [crear un clúster EKS con eksctl](https://eksctl.io/usage/creating-and-managing-clusters/).

## Using EC2 and kops

If you wish to use EC2 and kops then you will need to download a [kops release](https://github.com/kubernetes/kops/releases).
Then follow the instructions to [create a cluster on AWS with kops](https://kubernetes.io/docs/setup/production-environment/tools/kops/).


## Using the jx CLI

Ensure you [have installed the jx CLI](/docs/getting-started/setup/install/) then for kops use:


```sh
jx create cluster aws --skip-installation
```

or for EKS use:

```sh
jx create cluster eks --skip-installation
```
