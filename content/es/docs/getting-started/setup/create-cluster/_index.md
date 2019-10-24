---
title: Crear clúster
linktitle: Crear clúster
description: ¿Como crear un clúster de Kubernetes?
categories: [getting started]
keywords: [cluster]
weight: 1
aliases:
  - /getting-started/create-cluster
---

Jenkins X necesita que exista un clúster de Kubernetes para que pueda instalarse mediante el [jx boot](/docs/getting-started/setup/boot/).

Existen varios enfoques para crear grupos de Kubernetes.

Nuestra recomendación es usar [Terraform](https://www.terraform.io) para configurar toda su infraestructura en la nube (clúster de kubernetes, cuentas de servicio, almacenamiento, registro, etc.) y utilizar un proveedor de la nube para crear y administrar sus clústeres de kubernetes.

O puede utilizar un enfoque específico de proveedor de kubernetes: