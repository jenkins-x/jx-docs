---
title: Benefits
linktitle: Benefits
description: Benefits of the new helm 3 based boot
weight: 7
---


* We can use vanilla helm 3 now to install, update or delete charts in any namespace without needing tiller or custom code to manage `helm template`
  * We can avoid all the complexities of the `jx step helm apply` logic using our own helm template generation + post processing logic. We can also move away from boot's use of `{{ .Requirements.foo }}` and `{{ .Parameters.bar }}` expressions
* It opens the door to a flexible [multi-cluster support](/docs/labs/boot/multi-cluster/) so that every cluster/environment can be managed in the same canonical GitOps approach (as each cluster can use `jx boot` whether its a dev environment or remote staging/production environment)
* We can use the `helm list` command line to view versions of each chart/app nicely in the CLI.
  * we can avoid composite charts to simplfiy configuration and upgrades
* Everything is now an app. So if you want to remove our `nginx-ingress` chart and replace it with another ingress solution (knative / istio / gloo / ambassador / linkerd or whatever) just go ahead and use the [apps commands](/docs/labs/boot/apps/) to add/remove apps and have boot manage everything in a consistent way
    * e.g. here's [an example](https://github.com/jstrachan/environment-bucketrepo-dev/blob/master/jx-apps.yml#L2-L5) of removing `nginx`, `chartmusem` and `nexus` and adding in `istio`, `flagger` and some other tools like `bucketrepo` and `kuberhealthy` via a single simple yaml change. Incidentally to replace the use of `Ingress` resources with istio's `Gateway` and `VirtualService` you also need to add the `kind: istio` flag in the [jx-requirements.yml](https://github.com/jstrachan/environment-bucketrepo-dev/blob/master/jx-requirements.yml#L57) file
* You can install an app in a specific namespace if you wish
    * This also opens the door to using boot to setup multi-team installations where multiple teams use different namespaces but share services in the same cluster
* The new [jxl boot run](/docs/labs/boot/getting-started/run/) command runs the boot pipeline as a `Job` inside the Kubernetes cluster. This ensures consistency in tooling used and also improves security by avoiding having the secrets on a developers laptop.
* The boot git repository is much smaller and simpler; less to keep in sync/rebase/merge with the upstream git repository. Its mostly just 2 YAML files now `jx-requirements.yml` and `jx-apps.yml` which are both pretty much specific to your cluster installation. The `jenkins-x.yml` pipeline is configured inside the build pack so usually is 1 simple line long. So there's no need for all the git merge/rebase/cherry pick logic in jx 2.x
  * we rely more instead on the [version stream](https://jenkins-x.io/docs/concepts/version-stream/) which can be shared across installations
* the boot process is split up into [separate phases](/docs/labs/boot/getting-started/) which makes things easier to iterate and configure:
  * [setting up the cloud resources](/docs/labs/boot/getting-started/cloud/)
  * [creating the git repository](/docs/labs/boot/getting-started/repository/)
  * [setting up secrets](/docs/labs/boot/getting-started/secrets/)
  * [running the boot Job](/docs/labs/boot/getting-started/run/)
* we no longer use `exposecontroller` and use regular helm configuration to create `Ingress` resources and [override domain names](/docs/labs/boot/faq/#how-do-i-configure-the-ingress-domain-in-dev-staging-or-production)
* secret handling is currently much simpler:
  * You can specify all the secrets [setup up the secrets](/docs/labs/boot/getting-started/secrets/) before [running the boot Job](/docs/labs/boot/getting-started/run/) by importing a `secrets.yaml` or entering them directly  
  * we support Google Secret Manager or a Kubernetes Secret current; but this simple [SecretManager](https://github.com/jenkins-x-labs/helmboot/blob/master/pkg/secretmgr/interface.go#L5) interface should be super easy to implement for other cloud secrets providers or managed vault installations.
  * the simpler secrets handling means we can run the [running the boot Job](/docs/labs/boot/getting-started/run/) inside the kubernetes cluster for better security
