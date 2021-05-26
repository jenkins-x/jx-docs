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

We use [helmfile](https://github.com/roboll/helmfile) to configure helm charts whether its in the `dev`, `staging` or `production` environment and whether you are using [multiple clusters](/v3/guides/multi-cluster/).

See [how to customise a chart](/v3/develop/apps/#customising-charts)
                                                                                
For a given namespace called `ns` there is a folder in the cluster git repository at:

```bash 
helmfiles/ns/
```

which contains the `helmfile.yaml` file to configure all the charts for that namespace.

To override the environment configuration for the namespace `ns` you can create your own `values.yaml` file in this folder (or `values.yaml.gotmpl` if you want to use go templating inside it).

If the configuration only applies to a single chart you could prefix the file with the chart name. 

So create `helmfiles/ns/mychart-values.yaml` and put whatever environment specific configuration changes you need for your helm chart.

To set a custom environment variable try a  `helmfiles/ns/mychart-values.yaml` file of something like:

```yaml 
env:
  MY_ENV: someValue
```

Then you need to reference this YAML file in the `releases:` section in the `helmfiles/ns/helmfile.yaml`.

e.g. your  `helmfiles/ns/helmfile.yaml` should look something like this - see the new `mychart-values.yaml` entry in the `releases.values` section for `mychart`:


```yaml 
filepath: ""
environments:
  default:
    values:
    - jx-values.yaml
namespace: jx-staging
repositories:
- name: dev
  url: http://chartmuseum-$mydomain/
releases:
- chart: dev/mychart
  version: 0.0.12
  name: mychart
  values:
  - jx-values.yaml
  - mychart-values.yaml
templates: {}
renderedvalues: {}
```




## How do I use a chart from a secure repository

Some chart repositories need a username and password to access them.

So to access those chart repositories you can the username and password into the `helmfile.yaml` 

However the username/passwords are probably secret. So you can [create a kubernetes Secret](https://kubernetes.io/docs/tasks/configmap-secret/managing-secret-using-kubectl/) called `jx-boot-job-env-vars` which is automatically used in the [boot Job](/v3/about/how-it-works/#boot-job)
        
e.g. 

```bash
# lets make sure we are in the jx-git-operator namespace
jx ns jx-git-operator

kubectl create secret generic jx-boot-job-env-vars \
  --from-literal=MYREPO_USERNAME=someuser \
  --from-literal=MYREPO_PASSWORD='S!B\*d$zDsb='
```

Any environment variables defined in the `jx-boot-job-env-vars` Secret can then be used in your `helmfile.yaml` as follows:

```yaml
repositories:
- name: myrepo
  url: https://something.com 
  username: '{{ requiredEnv "MYREPO_USERNAME" }}' 
  password: '{{ requiredEnv "MYREPO_PASSWORD" }}'
releases:
- chart: myrepo/mychart 
  name: mychart
  version: 1.2.3
```

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
