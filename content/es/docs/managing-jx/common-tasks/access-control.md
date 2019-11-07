---
title: Control de Acceso
linktitle: Control de Acceso
aliases: [/rbac/]
description: Gestionar el Control de Acceso
weight: 10
---

Jenkins X utiliza políticas de control de acceso basado en roles - en inglés Role-Based Access Control (RBAC) - para controlar el acceso a sus diversos recursos. La aplicación de las políticas es proporcionada por el [RBAC de Kubernetes](https://kubernetes.io/docs/reference/access-authn-authz/rbac/).

Los [Equipos](/docs/concepts/features/#teams) pueden tener varios [Entornos](/docs/concepts/features/#environments) (p.ej, Dev, Staging, Production) junto con dinámicos [Entornos de Vista Previa](/docs/reference/preview/). Mantener sincronizados los recursos [`Role`](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) y [`RoleBinding`](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) pertenecientes al mecanismo RBAC de Kubernetes con todos los namespaces y miembros de su equipo puede ser un desafío.

Para facilitar esta gestión, Jenkins X crea un nuevo [Recurso Personalizado](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) llamado [`EnvironmentRoleBinding`](/docs/reference/components/custom-resources/#environmentrolebinding) que le permite asociar un `Role` etiquetado con `jenkins.io/kind=EnvironmentRole` con tantos `Users` o `ServiceAccounts` como desee. Luego, el [controlador de roles](/commands/jx_controller_role/#jx-controller-role) tiene la misión de mantener la información replicada y consistente a través de todos los namespaces y entornos. El controlador de roles garantiza esta tarea actualizando constantemente los recursos `Role` y `RoleBinding` de cada namespace.

Los roles son por equipo, por lo que es posible tener roles especiales por equipo o utilizar nombres comunes para los roles, pero personalizarlos para cada equipo.

## Implicaciones de Seguridad para el namespace admin

Jenkins X almacena varias configuraciones y ajustes (por ejemplo, `Users`,` Teams`) en el namespace de administración principal (`jx`). Tenga cuidado al otorgar roles en el equipo `jx` predeterminado, ya que permitir a los usuarios editar algunos de estos archivos puede permitirles escalar sus permisos.
En lugar de otorgar a los usuarios que no son administradores acceso al espacio de nombres `jx`, cree equipos y otorgue acceso a los usuarios cuando usen un clúster compartido.

## Roles Predeterminados

Jenkins X incluye una colección de objetos `Role` predeterminados que puede utilizar en la plantilla `jenkins-x-platform`. Puede crear el suyo si lo desea, pero cualquier edición puede perderse cuando se actualiza Jenkins X.

[viewer](https://github.com/jenkins-x/jenkins-x-platform/blob/master/jenkins-x-platform/templates/viewer-role.yaml)
: El rol `viewer` permite el acceso de lectura a proyectos, construcciones y logs. No permite el acceso a información confidencial.

[committer](https://github.com/jenkins-x/jenkins-x-platform/blob/master/jenkins-x-platform/templates/committer-role.yaml)
: El role `committer` proporciona los mismos permisos que el `viewer` y permite al usuario iniciar construcciones e importar nuevos proyectos.

[owner](https://github.com/jenkins-x/jenkins-x-platform/blob/master/jenkins-x-platform/templates/owner-role.yaml)
: El rol `owner` permite a los usuarios modificar todos los recursos del equipo.

## Adicionar Usuarios

Para adicionar usuarios utilice el comando [jx create user](/commands/jx_create_user/), p.ej:

```sh
jx create user --email "joe@example.com" --login joe --name "Joe Bloggs"
```

## Modificar Roles del Usuario

Para modificar los roles de un usuario utilice el comando [jx edit userroles](/commands/jx_edit_userroles/), p.ej:

```sh
jx edit userrole --login joe
```
Si no utiliza el parámetro `--login` (`-l`) en la línea de comando el sistema le pedirá que elija el usuario a editar.

Por ejemplo, para asignarle a `joe` el role `committer` (y elimine cualquier otro rol existente):

```sh
jx edit userrole --login joe --role committer
```

Si tiene roles específicos y desea otorgar múltiples roles a un usuario, puede especificar los roles como una lista separada por comas:
```sh
jx edit userrole --login joe --role committer,viewer
```

La modificación de los roles de un usuario cambia el `EnvironmentRoleBinding`. El [controlador de roles](/commands/jx_controller_role/#jx-controller-role) replicará estos cambios en todos los namespaces de entorno subyacentes.