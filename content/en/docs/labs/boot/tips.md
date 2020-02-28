---
title: Tips
linktitle: Tips
description: Tips and tricks for working with helm 3 and helmfile
weight: 50
---

## Helmfile and helm 3 tips

If you have used Jenkins X before but have not yet used helmfile or helm 3 here are a few tips and tricks.

## Uninstall

From inside a git clone of your (dev) environment you can run: 

``` 
helmfile destroy
```

if you don't have `apps/helmfile.yaml` or `system/helmfile.yaml` files you can run `jx boot` first to generate the files


## Listing the apps that have been deployed.

You can either use [jx get apps](https://jenkins-x.io/commands/jx_get_apps/): 

``` 
jx get app
```

or use the `helm` CLI directly:

``` 
helm list
```