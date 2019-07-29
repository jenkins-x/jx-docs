---
title: Development Questions
linktitle: Development Questions
description: Questions on how to use Kubernetes, Helm and Jenkins X to build cloud native applications
date: 2018-02-10
categories: [faq]
menu:
  docs:
    parent: "faq"
keywords: [faqs]
weight: 15
toc: true
aliases: [/faq/]
---

## How do I inject environment specific configuration?

Each environment in Jenkins X is defined in a git repository; we use GitOps to manage all changes in each environment such as:

* adding/removing apps
* changing the version of an app (up or down)
* configuring any app with environment specific values
   
The first two items are defined in the `env/requirements.yaml`  file in the git repository for your environment. the latter is defined in the `env/values.yaml` file.
  
Helm charts use a [values.yaml file](https://github.com/helm/helm/blob/master/docs/chart_template_guide/values_files.md) so that you can override any configuration inside your Chart to modify settings such as labels or annotations on any resource or configurations of resources (e.g. `replicaCount`) or to pass in things like environment variables into a `Deployment`.

So if you wish to change, say, the `replicaCount` of an app `foo` in `Staging` then find the git repository for the `Staging` environment via [jx get env](/commands/jx_get_environments/) to find the git URL.

Navigate to the `env/values.yaml` file and add/edit a bit of YAML like this:

```yaml 
foo:
  replicaCount: 5  
```

Submit that change as a Pull Request so it can go through the CI tests and any peer review/approval required; then when its merged it master it will modify the `replicaCount` of the `foo` application (assuming there's a chart called `foo` in the `env/requirements.yaml` file)

You can use vanilla helm to do things like injecting the current namespace if you need that.

To see a more complex example of how you can use a `values.yaml` file to inject into charts, see how we use these files to [configure Jenkins X itself](/getting-started/config/) 


## How do I manage secrets in each environment?

We’re using sealed secrets ourselves to manage our production Jenkins X install for all of our CI/CD - so the secrets get encrypted and checked into the git repo of each environment. We use the [helm-secrets](https://github.com/futuresimple/helm-secrets) plugin to do this.
 
Though a nicer approach would be using a Vault operator which we’re investigating now - which would fetch + populate secrets (and recycle them etc) via Vault.


## When do Preview Environments get removed?

We have a background garbage collection job which removes Preview Environments after the Pull Request is closed/merged. You can run it any time you like via the [jx gc previews](/commands/jx_gc_previews/) command

``` 
jx gc previews
```

You can also view the current previews via  [jx get previews](/commands/jx_get_previews/):
                                       
  ``` 
  jx get previews
  ```


and delete a preview by choosing one to delete via [jx delete preview](/commands/jx_delete_preview/):

 ``` 
 jx delete preview
 ```

## How do I add other services into a Preview?

When you create a Pull Request by default Jenkins X creates a new [Preview Environment](/about/features/#preview-environments). Since this is a new dynamic namespace you may want to configure additional microservices in the namespace so you can properly test your preview build.

To find out more see [how to add dependent charts, services or configuration to your preview environment](/developing/preview/#adding-more-resources)


## Can I use my existing release pipeline?

With Jenkins X you are free to create your own pipeline to do the release if you wish; though doing so means you miss out on our [extension model](/extending/) which lets you easily enable various extension Apps like Governance, Compliance, code quality, code coverage, security scanning, vulnerability testing and various other extensions which are being added all the time through our community. 

We've specifically built this extension model to minimise the work your teams have in having to edit + maintain pipelines across many separate microservices; the idea is we're trying to automate both the pipelines and the extensions to the pipelines so teams can focus on their actual code and less on the CI/CD plumbing which is pretty much all undifferentiated heavy lifting these days. 

## How does promotion actually work? 

The kubernetes resources being deployed are defined as YAML files in the source code of your application in `charts/myapp/templates/*.yaml`. If you don't specify anything then Jenkins X creates default resources (a `Service + Deployment`) but you are free to add any k8s resources as YAML into that folder (`PVCs, ConfigMaps, Services`, etc).

Then the Jenkins X release pipeline automatically tars up the YAML files into an immutable versioned tarball (using the same version number as the docker image, git tag and release notes) and deploys it into a chart repository of your choice (defaults to chartmuseum but you can easily switch that to cloud storage/nexus/whatever) so that the immutable release can be easily used by any promotion.

Promotion in Jenkins X is completely separate to Release & we support promoting any releases if packaged as a helm chart. Promotion via [jx promote](/developing/promote/) CLI generates a Pull Request in the git repository for an environment (Staging, Canary, Production or whatever). This is GitOps basically - specifying which versions and configurations of which apps are in each environment using a git repository and configuration as code. 

The PR triggers a CI pipeline to verify the changes are valid (e.g. the helm chart exists and can be downloaded, the docker images exist etc). Whenever the PR gets merged (could be automatically or may require additional reviews/+1s/JIRA/ServiceNow tickets or whatever) - then another pipeline is triggered to apply the helm charts from the master branch to the destination k8s cluster and namespace.

Jenkins X automates all of the above but given both these pipelines are defined in the environments git repository in a `Jenkinsfile` you are free to customise to add your own pre/post steps if you wish. e.g. you could analyse the YAML to pre-provision PVs for any PVCs using some custom disk snapshot tool you may have.  Or you can do that in a pre or post-install helm hook job. Though we'd prefer these tools to be created as part of the Jenkins X [extension model](/extending/) to avoid custom pipeline hacking which could break in future Jenkins X releases - though its not a huge biggie.

## How do I change the owner of a docker image

When using a docker registry like gcr.io then the docker image owner `gcr.io/owner/myname:1.2.3` can be different to your git owner/organisation.

On Google's GCR this is usually your GCP Project ID; which you can have many different projects to group images together.

There's a few options for defining which docker registry owner to use:

* specify it in your `jenkins-x.yml` 

```yaml 
dockerRegistryHost: gcr.io
dockerRegistryOwner: my-gcr-project-id
```
* specify it in the [Environment CRD](https://jenkins-x.io/architecture/custom-resources/) called `dev` at `env.spec.teamSettings.dockerRegistryOrg`
* define the environment variable `DOCKER_REGISTRY_ORG`

If none of those are found then the code defaults to the git repository owner. 

For more details the code to resolve it is [here](https://github.com/jenkins-x/jx/blob/65962ff5ef1a6d1c4776daee0163434c9c2cb566/pkg/cmd/opts/docker.go#L14)

## What if my team does not want to use helm?

To help automate CI/CD with GitOps we assume helm charts are created as part of the automated project setup and CI/CD. e.g. just [import your source code](https://jenkins-x.io/developing/import/) and a docker image + helm chart will be generated for you - the developers don't need to know or care if they don't want to use helm:

If a developer wants to specifically create a specific resource (e.g. `Secret, ConfigMap` etc) they can just hack the YAML directly in `charts/myapp/templates/*.yaml`. Increasingly most IDEs now have UI wizards for creating + editing kubernetes resources.

By default things like resource limits are put in `values.yaml` so its easy to customise those as needed in different environments (requests/limits, liveness probe timeouts and the like). 

If you have a developer who is fundamentally opposed to helm's configuration management solution for environment specific configuration you can just opt out of that and just use helm as a way to version and download immutable tarballs of YAML and just stick to vanilla YAML files in, say, `charts/myapp/templates/deployment.yaml`).

Then if you wish to use another configuration management tool you can add it in - e.g. [kustomise support](https://github.com/jenkins-x/jx/issues/2302).

## How do I change the domain of serverless apps?

If you use [serverless apps](/developing/serverless-apps/) with Knative we don't use thee default exposecontroller mechanism for defaulting the `Ingress` resources since knative does not use kubernetes `Service` resources.

You can work around this by manually editing the _knative_ config via:

```
kubectl edit cm config-domain --namespace knative-serving
```

For more help see [using a custom domain with knative](https://knative.dev/docs/serving/using-a-custom-domain/)

## Can I reuse exposecontroller for my apps?

You should be able to use [exposecontroller](https://github.com/jenkins-x/exposecontroller/blob/master/README.md) directly in any app you deploy in any environment (e.g. Staging or Production) as we already trigger exposecontroller on each new release.

We use [exposecontroller](https://github.com/jenkins-x/exposecontroller/blob/master/README.md) for Jenkins X to handle the generation of `Ingress` resources so that we can support wildcard DNS on a domain or automate the setup of HTTPS/TLS along with injecting external endpoints into applications in ConfigMaps via [annotations](https://github.com/jenkins-x/exposecontroller/blob/master/README.md#using-the-expose-url-in-other-resources).

To get [exposecontroller](https://github.com/jenkins-x/exposecontroller/blob/master/README.md) to generate the `Ingress` for a `Service` just [add the label to your Service](https://github.com/jenkins-x/exposecontroller/blob/master/README.md#label). e.g. add this to your `charts/myapp/templates/service.yaml`:

```yaml 
apiVersion: v1
kind: Service
metadata:
  name: myapp
  annotations:
    fabric8.io/expose: "true"  
```

If you want to inject the URL or host name of the external URL or your ingress just [use these annotations](https://github.com/jenkins-x/exposecontroller/blob/master/README.md#using-the-expose-url-in-other-resources).

## How To Add Custom Annotations to Ingress Controller?

There may be times when you need to add your custom annotations to the ingress controller or [exposecontroller](https://github.com/jenkins-x/exposecontroller) which `jx` uses to expose services.

You can add a list of annotations to your application's service Helm Chart, which is found in your app's code repository.

A custom annotation may be added to the `charts/myapp/values.yaml` and it may look as follows:

```yaml
# Default values for node projects.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.
replicaCount: 1
image:
  repository: draft
  tag: dev
  pullPolicy: IfNotPresent
service:
  name: node-app
  type: ClusterIP
  externalPort: 80
  internalPort: 8080
  annotations:
    fabric8.io/expose: "true"
    fabric8.io/ingress.annotations: "kubernetes.io/ingress.class: nginx"

```

To see an example of where we add multiple annotations that the `exposecontroller` adds to generated ingress rules, take a look at this [values.yaml](https://github.com/jenkins-x/jenkins-x-platform/blob/08a304ff03a3e19a8eb270888d320b4336237005/values.yaml#L655)

