---
title: FAQ
linktitle: FAQ
description: Questions about managing Jenkins X
aliases:
  - /faq/setup/
type: docs
weight: 200
menu:
  docs:
    title: "FAQs"

---

## How do I add a user to my Jenkins X installation?

Jenkins X assumes each user has access to the same development kubernetes cluster that Jenkins X is running on.

If your user does not have access to the kubernetes cluster we need to setup their `~/.kube/config` file so that they can access it.

If you are using Google's GKE then you can browse the [GKE Console](https://console.cloud.google.com) to view all the clusters and click on the `Connect` button next to your development cluster and then that lets you copy/paste the command to connect to the cluster.

For other clusters we are planning on writing some [CLI commands to export and import the kube config](https://github.com/jenkins-x/jx/issues/1406).

Also [CloudBees](https://www.cloudbees.com/) are working on a distribution of Jenkins X which will include single sign on together with an awesome web UI to visualise teams, pipelines, logs, environments, applications, versions and infrastructure. The CloudBees UI provides an easy way for anyone in your team to login to Jenkins X from the command line with the `Connect` button on the `Teams` page which uses [jx login](/commands/deprecation/)

### Once the user has access to the kubernetes cluster

Once your user has access to the kubernetes cluster:

* [install the jx binary](/docs/getting-started/setup/install/)

If Jenkins X was installed in the namespace `jx` then the following should [switch your context](/docs/resources/guides/using-jx/developing/kube-context/) to the `jx` namespace:

    jx ns jx

To test you should be able to type:

    jx get env
    jx open

To view the environments and any development tools like the Jenkins or Nexus consoles.

## How does access control and security work?

See the [access control documentation](/docs/resources/guides/managing-jx/common-tasks/access-control/)

## How do I upgrade my Jenkins X installation?

Our strategic direction for installing, configuring and upgrading Jenkins X is [jx boot](/docs/install-setup/installing/boot/).

If you are using [jx boot](/docs/install-setup/installing/boot/) you can enable [automatic upgrades](/docs/install-setup/installing/boot/#auto-upgrades) or [manually trigger them yourself](/docs/install-setup/installing/boot/#manual-upgrades).

If anything ever goes wrong (e.g. your cluster, namespace or tekton gets deleted), you can always re-run [jx boot](/docs/install-setup/installing/boot/) on your laptop to restore your cluster.

Otherwise the older approach is as follows:

### If not using boot

You can upgrade via the [jx upgrade](/commands/jx_upgrade/) commands. Start with

```sh
jx upgrade cli
```

to get you on the latest CLI then you can upgrade the platform:

```sh
jx upgrade platform
```

## How do I upgrade the jx binary used inside the builds when using serverless jenkins?

We use specific `BuildTemplates` for different programming languages. These `BuildTemplates` describe the steps that will be executed as part of the job, which in case of the Jenkins X BuildTemplates, they all execute the `JenkinsfileRunner` to execute the project's Jenkinsfile.

```sh
$ kubectl get buildtemplates
NAME                        AGE
environment-apply           9d
environment-build           9d
jenkins-base                9d
jenkins-csharp              9d
jenkins-cwp                 9d
jenkins-elixir              9d
jenkins-filerunner          9d
jenkins-go                  9d
jenkins-go-nodocker         9d
jenkins-go-script-bdd       1d
jenkins-go-script-ci        1d
jenkins-go-script-release   1d
jenkins-gradle              9d
jenkins-javascript          9d
jenkins-jenkins             9d
jenkins-maven               9d
jenkins-python              9d
jenkins-rust                9d
jenkins-scala               9d
jenkins-test                9d
knative-chart-ci            9d
knative-chart-release       9d
knative-deploy              9d
knative-maven-ci            9d
knative-maven-release       9d
```

The docker image that has the `Jenkinsfile` runner has also other tools installed, like the `jx` binary. If you need to update jx to a newer version, you need to modify [the base Dockerfile used for the Jenkinsfile runner step of the BuildTemplate](https://github.com/jenkins-x/jenkins-x-serverless/blob/def939f559b6b0e6735c043ce032686397053a6e/Dockerfile.base#L120-L123), so that it uses the jx version that you want. Althought [this is normally done automatically](https://github.com/jenkins-x/jenkins-x-serverless/commits/def939f559b6b0e6735c043ce032686397053a6e/Dockerfile.base).

Once this is done, you need to change the BuildTemplate in your cluster so that it starts using the new version of the docker image. For example, you can see the current version of this image for the Go BuildTemplate in your cluster

```sh
$ kubectl describe buildtemplate jenkins-go | grep Image
Image:       jenkinsxio/jenkins-go:256.0.44
```

If you want to use a different version that uses a newer jx version you could manually change all the BuildTemplates but instead let's jx take care of it

```sh
jx upgrade addon jx-build-templates
```

Check that the change has been done

```sh
$ kubectl describe buildtemplate jenkins-go | grep Image
Image:       jenkinsxio/jenkins-go:256.0.50
```

## How does `--prow` differ from `--gitops`

* `--prow` uses [serverless jenkins](/news/serverless-jenkins/) and uses [prow](https://github.com/kubernetes/test-infra/tree/master/prow) to implement ChatOps on Pull Requests.
*  `--gitops` is still work in progress but will use GitOps to manage the Jenkins X installation (the dev environment) so that the platform installation is all stored in a git repo and upgrading / adding Apps / changing config is all changed via Pull Requests like changes to promotion of applications to the Staging or Production environments

## How do I reuse my existing Ingress controller?

By default when you [install Jenkins X into an existing kubernetes cluster](/docs/getting-started/install-on-cluster/) it prompts you if you want to install an Ingress controller. Jenkins X needs an Ingress controller of some kind so that we can setup `Ingress` resources for each `Service` so we can access web applications via URLs outside of the kubneretes cluster (e.g. inside web browsers).

The [jx install](/commands/deprecation/) command takes a number of CLI arguments starting with `--ingress` where you can point to the namespace, deployment name and service name of the ingress controller you wish to use for the installation.

We do recommend you use the default ingress controller if you can - as we know it works really well and only uses a single LoadBalancer IP for the whole cluster (your cloud provider often charges per IP address). However if you want to point at a different ingress controller just specify those arguments on install:

```sh
jx install \
  --ingress-service=$(yoursvcname) \
  --ingress-deployment=$(yourdeployname) \
  --ingress-namespace=kube-system
```

## How do I enable HTTPS URLs?

In general use the [jx upgrade ingress](/commands/deprecation/) command.

For more detail see these blogs posts:

* [Upgrading Ingress Rules And Adding TLS Certificates With Jenkins X](https://technologyconversations.com/2019/05/31/upgrading-ingress-rules-and-adding-tls-certificates-with-jenkins-x/) by [Viktor Farcic](https://technologyconversations.com)
* [Jenkins X — TLS enabled Previews](https://itnext.io/jenkins-x-tls-enabled-previews-d04fa68c7ce9?source=friends_link&sk=c13828b223f56ed662fd7ec0872c3d1e) by [Steve Boardwell](https://medium.com/@sboardwell)
* [Jenkins X — Securing the Cluster](https://itnext.io/jenkins-x-securing-the-cluster-e1b9fcd8dd05?source=friends_link&sk=e1e46e780908b2e3c8415c3191e82c56) by [Steve Boardwell](https://medium.com/@sboardwell)


## How do I change the URLs in an environment?

We use [exposecontroller](https://github.com/jenkins-x/exposecontroller) to automate the setup of `Ingress` resources for exposed Services, enabling TLS and also injecting external URLs for services into code (e.g. so we can register webhooks).

The default `UrlTemplate` for each environment is of the form: `{{.Service}}.{{.Namespace}}.{{.Domain}}` where `Service` is the name of the service, `Namespace` is the kubernetes namespace and `Domain` is the configured DNS domain.

If you want to modify the URL schemes of your service in an environment then edit the file `env/values.yaml` in your Environments git repository. To find the URLs to each source repository use the [jx get environments](/commands/jx_get_environments/) command.

Then modify the contents of `env/values.yaml` to include the `urlTemplate:` value as follows:

```yaml
expose:
  config:
    urltemplate: "{{.Service}}-{{.Namespace}}.{{.Domain}}"
```

We've left out the other values of `expose:` and `config:` for brevity - the important thing is to ensure you specify a custom `expose.config.urltemplate` value. The default is `{{.Service}}.{{.Namespace}}.{{.Domain}}` if none is specified.

Whenever you modify the git repository for an environment the GitOps pipeline will run to update your Ingress resources to match your `UrlTemplate`.

## Is there a UI available for Jenkins X?

There is one available for the [CloudBees Jenkins X Distribution](https://www.cloudbees.com/products/cloudbees-jenkins-x-distribution/overview). It should normally work on OSS Jenkins X as well, though CloudBees won't support it unless you're also using their distribution. You can read more about it here: [Using the CloudBees Jenkins X Distribution user interface
](https://docs.cloudbees.com/docs/cloudbees-jenkins-x-distribution/latest/user-interface/)
