---
title: Progressive Delivery
linktitle: Progressive Delivery
description: How to use progressive delivery with helm 3 and helmfile
weight: 7
---

Progressive delivery allows you to gradually rollout new versions of your application to an environment using _canaries_ and gradually giving traffic to the new version until you are happy to fully rollover to the new version.

Our recommendation for using progressive delivery with Jenkins X is to use: 

* [flagger](https://flagger.app/) as the progressive delivery controller 
* [istio](https://istio.io/) as the service mesh to provider advanced load balancing capabilities across internal or external networking

## Configuring Progressive Delivery

Please follow the usual [Getting Started Guide for boot and helm 3](/docs/labs/boot/getting-started/) but before [running boot](docs/labs/boot/getting-started/run/) please make sure you make the following configuration:

### Add the istio and flagger apps

Please make sure your `jx-apps.yml` has the necessary apps for using [flagger](https://flagger.app/) and [istio](https://istio.io/). Your `jx-apps.yml` in your development environment git repository should look something like this:

```yaml 
apps:
- name: jx-labs/istio
- name: flagger/flagger
- name: flagger/grafana
- name: jx-labs/flagger-metrics
- name: stable/kuberhealthy
...
```

So that you remove `stable/nginx-ingress` from your `jx-apps.yml` file and ensure the above apps are added at the top of the file.

### Enable istio based ingress

To avoid having 2 `LoadBalancer` services for both `istio` and `nginx` (which costs more money) its easier to switch to pure istio for both internal and external load balancing. This also results in a smaller footprint. 

To do that ensure that `kind: istio` is added to the `jx-requirements.yml` file in the top level `ingress:` section like this:


```yaml 
ingress:
  domain: ""
  kind: istio
...
```


### Enable istio in staging/production

If you wish to use a Canary with [flagger](https://flagger.app/) and [istio](https://istio.io/) in your staging or production namespace you need to make sure you have labelled the namespace correctly to enable istio injection.

e.g. run the following command in staging:

```bash 
kubectl label namespace jx-staging istio-injection=enabled
```

or in production:

```bash 
kubectl label namespace jx-production istio-injection=enabled
```

### Defaulting to use Canary

Run the following command to default to using canary deployments and horizontal pod autoscaling...

```bash 
jx edit deploy --team --canary --hpa
```

This will enable all new quickstarts and imported projects to use canary rollouts.

You can switch the defaults back again at any time or configure any app to change its defaults by running `jx edit deploy` inside a git clone of an application.


### Enabling/Disabling Canary/HPA in an Environment

If you want to enable/disable canary or horizontal pod autoscaling for a specific app in an environment then you can [follow the app customisation approach](/docs/labs/boot/apps/#customising-charts).

Assuming your app is called `myapp` then in the git repository for the environment (e.g. `Staging`) you can add/edit a file called `apps/mychart/values.yaml` to look like this:

```yaml 
canary:
  enabled: true

hpa:
  enabled: true
``` 

you can enable/disable those 2 flags for canary releases and horizontal pod autoscaler at any point in any environment.


## Using Progressive Delivery

Once you have followed the above steps create a [quickstart application](docs/getting-started/first-project/create-quickstart/) in the usual way.

As you merge changes to the master branch of your application Jenkins X will create a new release and [promote it to the staging environment](/docs/using-jx/faq/#how-does-promotion-actually-work). 

However if Canary deployment is enabled your new version will gradually be rolled out progressively: 

* the defaults are that 20% of the traffic will go to the new version
* flagger will keep monitoring the metrics used in the Canary resource to determine if the canary is good
* after the configured time period is over the traffic will be increased to 40% then 60%
* eventually if things look good the new version will fully rollout to 100% traffic
* if anything goes bad during the rollout time period the old version is restored
 


