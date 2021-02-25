---
title: Charts and resources
linktitle: Charts and resources
type: docs
description: Questions on configuring applications, charts and kubernetes resources
weight: 150
---

## How do I add a chart?

To add a new chart add to the `helmfiles/mynamespace/helmfile.yaml` file follow the [add chart guide](/v3/develop/apps/#adding-charts).

## How do I customise an App in an Environment?

With the new helm 3 based boot every environment uses boot - so there is a single way to configure anything whether its in the `dev`, `staging` or `production` environment and whether or not you are using [multiple clusters](/v3/guides/multi-cluster/).

See [how to customise a chart](/v3/develop/apps/#customising-charts)


## How do I add a kubernetes resource?

To add a new kubernetes resource [follow the add resources guide](/v3/develop/apps/#adding-resources).

The default `helmfile.yaml` files take references to helm charts.

If you want to deploy one or more kubernetes resources [wrap them in a local chart in your dev cluster git repository](/v3/develop/apps/#adding-resources)

## How do I deploy an app with no chart?
                                       
Some microservices on kubernetes do not yet come packaged as a helm chart.

e.g. if the only instructions on the website of the microservice is something like

```bash
# install this appication via:
kubectl apply -f https://acme.com/foo.yaml
```

If you want you can just install it like the above `kubectl apply` command. 

Though you then lose the benefits of GitOps in that all changes to your cluster are auditted and versioned in git and it's easy to rollback changes.

So another approach is to follow the [create a local chart](/v3/develop/apps/#adding-resources) instructions:

```bash 
mkdir charts/myname/templates
curl -L https://acme.com/foo.yaml > charts/myname/templates/resources.yaml
echo "apiVersion: v1
description: A Helm chart for myname
name: myname
version: 0.0.1" > charts/myname/Chart.yaml
```

Then add the following `chart:` line to your `helmfiles/$namespace/helmfile.yaml` in the `releases:` section for the namespace you want to deploy it in...

```yaml 
releases:
- chart: ./charts/myname
```

If this is a brand new namespace which didn't have a `helmfiles/$namespace/helmfile.yaml` then make sure you also add an entry in the root `helmfile.yaml` file of:

```yaml 
helmfiles:
- path: helmfiles/$namespace/helmfile.yaml
```
            
Note that `$namespace` in the above files should be expanded to the actual namespace you are deploying it to; e.g. `jx` or `jx-staging` or whatever.

The above may seem like a bit of work compared to `kubectl apply` but it does mean at any time you can upgrade the app by re-running the command:

```bash
curl -L https://acme.com/foo.yaml > charts/myname/templates/resources.yaml
```

You can also easily uninstall the application or modify the YAML in git at any time.
