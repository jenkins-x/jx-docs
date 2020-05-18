---
title: Progressive Delivery
linktitle: Progressive Delivery
description: How to use progressive delivery with helm 3 and helmfile
weight: 7
---
{{% alert %}}
**NOTE: This current experiment is now closed. The work done and feedback we have received will be used to enhance Jenkins X in future versions**

**This code should not be used in production, or be adopted for usage.  It should only be used to provide feedback to the Labs team.**

Thank you for your participation,

-Labs


{{% /alert %}}

Progressive delivery allows you to gradually rollout new versions of your application to an environment using _canaries_ and gradually giving traffic to the new version until you are happy to fully rollover to the new version.

Our recommendation for using progressive delivery with Jenkins X is to use: 

* [flagger](https://flagger.app/) as the progressive delivery controller 
* [istio](https://istio.io/) as the service mesh to provider advanced load balancing capabilities across internal or external networking

## Configuring Progressive Delivery

Please follow the usual [getting started guide for boot and helm 3](/docs/labs/boot/getting-started/) but before [running boot](/docs/labs/boot/getting-started/run/) please make sure you make the following configuration:

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

Also for now I'm afraid you will have to remove the `jenkins-x/jxui` chart as its currently not working yet with istio ingress - but we can hopefully get that working soon.

### Enable istio based ingress

To avoid having 2 `LoadBalancer` services for both `istio` and `nginx` (which costs more money) its easier to switch to pure istio for both internal and external load balancing. This also results in a smaller footprint. 

To do that ensure that `kind: istio` is added to the `jx-requirements.yml` file in the top level `ingress:` section like this:


```yaml 
ingress:
  domain: ""
  kind: istio
...
```

### Now boot 

Now your development git repository should be setup and be ready. Now:

* make sure you have setup [any secrets you need to boot](/docs/labs/boot/getting-started/secrets/)
* now [run boot](/docs/labs/boot/getting-started/run/) to setup your installation

When it is all complete you should see istio, flagger, grafana pods running in the `istio-system` namespace something like this:

```bash 
$ kubectl get pod -n istio-system
NAME                                    READY   STATUS    RESTARTS   AGE
flagger-66dc49cd-g6ptp                  1/1     Running   0          32h
grafana-7d7d7476f6-ff6bm                1/1     Running   0          32h
istio-ingressgateway-598796f4d9-sq8b7   1/1     Running   0          32h
istiod-7d9c7bdd6-vjp9j                  1/1     Running   0          32h
kuberhealthy-f54f7f7df-b5gbf            1/1     Running   2          32h
kuberhealthy-f54f7f7df-j6qwt            1/1     Running   0          32h
prometheus-b47d8c58c-n974m              2/2     Running   0          32h
```                                                                     

From 1.5 onwards istio is pretty small; just 2 pods. Note that those `kuberhealthy` pods are optional and just help with reporting.


### Enable istio in staging/production

If you wish to use a Canary with [flagger](https://flagger.app/) and [istio](https://istio.io/) in your staging or production namespace you need to make sure you have labelled the namespace correctly to enable istio injection.

To enable istio in staging:

```bash 
kubectl label namespace jx-staging istio-injection=enabled
```

To enable istio in production:

```bash 
kubectl label namespace jx-production istio-injection=enabled
```

### Defaulting to use Canary

Run the following command to default to using canary deployments and horizontal pod autoscaling whenever you [create a new quickstart](/docs/getting-started/first-project/create-quickstart/) or [import a project](/docs/resources/guides/using-jx/creating/import/)

```bash 
jxl edit deploy --team --canary --hpa
```

This will enable all new quickstarts and imported projects to use canary rollouts and use horizontal pod autoscaling in all environments.

You can switch the defaults back again at any time or configure any app to change its defaults by running `jxl edit deploy` inside a git clone of an application.


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

Once you have followed the above steps create a [quickstart application](/docs/getting-started/first-project/create-quickstart/) in the usual way.

As you merge changes to the master branch of your application Jenkins X will create a new release and [promote it to the staging environment](/docs/resources/guides/using-jx/faq/#how-does-promotion-actually-work). 

However if Canary deployment is enabled your new version will gradually be rolled out progressively: 

* the defaults are that 20% of the traffic will go to the new version
* flagger will keep monitoring the metrics used in the Canary resource to determine if the canary is good
* after the configured time period is over the traffic will be increased to 40% then 60%
* eventually if things look good the new version will fully rollout to 100% traffic
* if anything goes bad during the rollout time period the old version is restored
 
There is an excellent [video showing this in action](https://youtu.be/7eePqtxW7NM).

