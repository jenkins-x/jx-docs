---
title: FAQ
linktitle: FAQ
description: Questions on how to develop cloud native application with Jenkins X
weight: 40
aliases:
  - /faq/
---

## How do I enable bash completion?

Using bash completion really helps using the `jx` command line letting you `TAB`-complete commands and command line arguments.

To see how to enable bash completion check out the [jx completion](/commands/jx_completion/)

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

To see a more complex example of how you can use a `values.yaml` file to inject into charts, see how we use these files to [configure Jenkins X itself](/docs/guides/managing-jx/common-tasks/config/)


## How do I inject preview specific configuration?

See the [above question on how to inject environment specific configuration into environments](#how-do-i-inject-environment-specific-configuration)

Preview Environments are similar to other environments like `Staging` and `Production` only instead of storing the environments in a separate git repository the preview environment is defined inside each applications `charts/preview` folder.

So to inject any custom configuration into your Preview environment you can modify the `charts/preview/values.yaml` file in your applications git repository to override any helm template parameters defined in your chart (in the `charts/myapp` folder).

You may need to modify your helm charts to add extra helm configuration if the configuration you wish to configure is not easily changed via the `values.yaml` file.

## How do I manage secrets in each environment?

We’re using sealed secrets ourselves to manage our production Jenkins X install for all of our CI/CD - so the secrets get encrypted and checked into the git repo of each environment. We use the [helm-secrets](https://github.com/futuresimple/helm-secrets) plugin to do this.

Though a nicer approach would be using a Vault operator which we’re investigating now - which would fetch + populate secrets (and recycle them etc) via Vault.


## When do Preview Environments get removed?

We have a background garbage collection job which removes Preview Environments after the Pull Request is closed/merged. You can run it any time you like via the [jx gc previews](/commands/jx_gc_previews/) command

```sh
jx gc previews
```

You can also view the current previews via  [jx get previews](/commands/jx_get_previews/):

```sh
jx get previews
```


and delete a preview by choosing one to delete via [jx delete preview](/commands/jx_delete_preview/):

```sh
jx delete preview
```

## How do I add other services into a Preview?

When you create a Pull Request by default Jenkins X creates a new [Preview Environment](/about/concepts/features/#preview-environments). Since this is a new dynamic namespace you may want to configure additional microservices in the namespace so you can properly test your preview build.

To find out more see [how to add dependent charts, services or configuration to your preview environment](/docs/reference/preview/#adding-more-resources)


## Can I use my existing release pipeline?

With Jenkins X you are free to create your own pipeline to do the release if you wish; though doing so means you miss out on our [extension model](/docs/contributing/addons/) which lets you easily enable various extension Apps like Governance, Compliance, code quality, code coverage, security scanning, vulnerability testing and various other extensions which are being added all the time through our community.

We've specifically built this extension model to minimise the work your teams have in having to edit + maintain pipelines across many separate microservices; the idea is we're trying to automate both the pipelines and the extensions to the pipelines so teams can focus on their actual code and less on the CI/CD plumbing which is pretty much all undifferentiated heavy lifting these days.

## How can I handle custom branches with tekton?

We don't use `branch patterns` with tekton; they are a jenkins specific configuration.

For Tekton we use the [prow](/docs/reference/components/prow/) / [lighthouse](/docs/reference/components/lighthouse/) configuration to specify which branches trigger which pipeline contexts.

If you are using [boot](/docs/getting-started/setup/boot/) to install Jenkins X then you can create your own custom `Scheduler` custom resource in `env/templates/myscheduler.yaml` based on the [default one that is included](https://github.com/jenkins-x-charts/jxboot-resources/blob/master/jxboot-resources/templates/default-scheduler.yaml).

e.g. here is how we specify the [branches used to create releases](https://github.com/jenkins-x-charts/jxboot-resources/blob/master/jxboot-resources/templates/default-scheduler.yaml#L48).

You can also create additional pipeline contexts; e.g. here's how we add multiple parallel testing pipelines on the [version stream](/about/concepts/version-stream/) via a [custom Scheduler](https://github.com/jenkins-x/environment-tekton-weasel-dev/blob/master/env/templates/jx-versions-scheduler.yaml#L21) so that we can have many integration tests run in parallel on a single PR. Then each named context listed has an associated `jenkins-x-$context.yml` file in the source repository to define the pipeline to run [like this example which defines the `boot-lh` context](https://github.com/jenkins-x/jenkins-x-versions/blob/master/jenkins-x-boot-lh.yml)

You can then associate your `SourceRepository` resources with your custom scheduler by:

* specifying the scheduler name on the `spec.scheduler.name` property of your `SourceRepository` via `kubectl edit sr my-repo-name`)
* specifying the scheduler name when you import a project via `jx import --scheduler myname`
* specifying the default scheduler name in your `dev` `Environment` at `spec.teamSettings.defaultScheduler.name` before you import projects

If you are not using [boot](/docs/getting-started/setup/boot/) then you can use `kubectl edit cm config` and modify the prow configuration by hand - though we highly recommend using [boot](/docs/getting-started/setup/boot/) and GitOps instead; the prow configuration is easy to break if changing it by hand.

## How does promotion actually work?

The kubernetes resources being deployed are defined as YAML files in the source code of your application in `charts/myapp/templates/*.yaml`. If you don't specify anything then Jenkins X creates default resources (a `Service + Deployment`) but you are free to add any k8s resources as YAML into that folder (`PVCs, ConfigMaps, Services`, etc).

Then the Jenkins X release pipeline automatically tars up the YAML files into an immutable versioned tarball (using the same version number as the docker image, git tag and release notes) and deploys it into a chart repository of your choice (defaults to chartmuseum but you can easily switch that to cloud storage/nexus/whatever) so that the immutable release can be easily used by any promotion.

Promotion in Jenkins X is completely separate to Release & we support promoting any releases if packaged as a helm chart. Promotion via [jx promote](/docs/getting-started/promotion/) CLI generates a Pull Request in the git repository for an environment (Staging, Canary, Production or whatever). This is GitOps basically - specifying which versions and configurations of which apps are in each environment using a git repository and configuration as code.

The PR triggers a CI pipeline to verify the changes are valid (e.g. the helm chart exists and can be downloaded, the docker images exist etc). Whenever the PR gets merged (could be automatically or may require additional reviews/+1s/JIRA/ServiceNow tickets or whatever) - then another pipeline is triggered to apply the helm charts from the master branch to the destination k8s cluster and namespace.

Jenkins X automates all of the above but given both these pipelines are defined in the environments git repository in a `Jenkinsfile` you are free to customise to add your own pre/post steps if you wish. e.g. you could analyse the YAML to pre-provision PVs for any PVCs using some custom disk snapshot tool you may have.  Or you can do that in a pre or post-install helm hook job. Though we'd prefer these tools to be created as part of the Jenkins X [extension model](/docs/contributing/addons/) to avoid custom pipeline hacking which could break in future Jenkins X releases - though its not a huge biggie.

## How do I change the owner of a docker image?

When using a docker registry like gcr.io then the docker image owner `gcr.io/owner/myname:1.2.3` can be different to your git owner/organisation.

On Google's GCR this is usually your GCP Project ID; which you can have many different projects to group images together.

There's a few options for defining which docker registry owner to use:

* specify it in your `jenkins-x.yml`

```yaml
dockerRegistryHost: gcr.io
dockerRegistryOwner: my-gcr-project-id
```
* specify it in the [Environment CRD](/docs/reference/components/custom-resources/) called `dev` at `env.spec.teamSettings.dockerRegistryOrg`
* define the environment variable `DOCKER_REGISTRY_ORG`

If none of those are found then the code defaults to the git repository owner.

For more details the code to resolve it is [here](https://github.com/jenkins-x/jx/blob/65962ff5ef1a6d1c4776daee0163434c9c2cb566/pkg/cmd/opts/docker.go#L14)

## What if my team does not want to use helm?

To help automate CI/CD with GitOps we assume helm charts are created as part of the automated project setup and CI/CD. e.g. just [import your source code](/docs/guides/using-jx/creating/import/) and a docker image + helm chart will be generated for you - the developers don't need to know or care if they don't want to use helm:

If a developer wants to specifically create a specific resource (e.g. `Secret, ConfigMap` etc) they can just hack the YAML directly in `charts/myapp/templates/*.yaml`. Increasingly most IDEs now have UI wizards for creating + editing kubernetes resources.

By default things like resource limits are put in `values.yaml` so its easy to customise those as needed in different environments (requests/limits, liveness probe timeouts and the like).

If you have a developer who is fundamentally opposed to helm's configuration management solution for environment specific configuration you can just opt out of that and just use helm as a way to version and download immutable tarballs of YAML and just stick to vanilla YAML files in, say, `charts/myapp/templates/deployment.yaml`).

Then if you wish to use another configuration management tool you can add it in - e.g. [kustomise support](https://github.com/jenkins-x/jx/issues/2302).

## How do I change the domain of serverless apps?

If you use [serverless apps](/docs/guides/tutorials/serverless-apps/) with Knative we don't use thee default exposecontroller mechanism for defaulting the `Ingress` resources since knative does not use kubernetes `Service` resources.

You can work around this by manually editing the _knative_ config via:

```sh
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


## Should I use a monorepo?

We are all trying to [Accelerate](/about/overview/accelerate/) and deliver business value to our customers faster. This is why we often use the 2 pizza teams and microservices as a way to empower teams to go fast; releasing microservices independently with no cross-team coordination required to speed things up.

If you are developing microservices across separate 2 pizza teams then like [others](https://medium.com/@mattklein123/monorepos-please-dont-e9a279be011b) we don't think you should use monorepos - instead use a repository per microservice so that each microservice can release at its own individual release cadence.

Monorepo's generally work better when a single team is working on a monolith that releases everything periodically after changing a single repository.

## How can I use a monorepo?

We have focused the automated CI/CD in Jenkins X around helping teams [Accelerate](/about/overview/accelerate/) using microservices to build cloud native applications. So we assume separate repositories for each microservice.

If you have an existing monorepo you want to import into Jenkins X you can; just be aware that you'll have to create and maintain your own pipelines for your monorepo. So just modify them `jenkins-x.yml` file after you import your monorepo.

See how to [add a custom step to your pipeline](/about/concepts/jenkins-x-pipelines/#customizing-the-pipelines).

## How do I inject Vault secrets into staging/production/preview environments?

### Staging/Production

By default, [enabling Vault](/docs/getting-started/setup/boot/#vault) via `jx boot`'s `jx-requirements.yml` will only activate it in your pipeline and preview environments, not in staging and production. To also activate it in those environments, simply add a `jx-requirements.yml` file to the root of their repo, with at least the following content:

```yaml
secretStorage: vault
```

Note that the file **must** be named with `.yml`, not `.yaml`, or else the requirements loader cannot load the proper file.

Then, assuming you have a secret in Vault with path `secret/path/to/mysecret` containing key `password`, you can inject it into service `myapp` (for instance, as a `PASSWORD` environment variable) by adding the following to your staging repo's `/env/values.yaml`:

```yaml
myapp:
  env:
    PASSWORD: vault:path/to/mysecret:password
```

Notice the prefixing with `vault:` URL scheme and also that we omit first path component (`secret/`), as it gets added automatically. Finally, the key name is separated from path by a colon (`:`).

If your secret is not environment-specific, you can also inject it directly into your app's `/charts/myapp/values.yaml`:

```yaml
env:
  PASSWORD: vault:path/to/mysecret:password
```

However, note that this value would be overriden at the environment level if the same key is also present there.

### Preview

Vault does not need to be explicitly enabled for preview environment. To inject same secret as above into your preview, simply add the following to your app's `/charts/preview/values.yaml`:

```yaml
preview:
  env:
    PASSWORD: vault:path/to/mysecret:password
```

## How do I inject a Vault secret via a Kubernetes Secret?

When you inject secrets directly into environment variables, they appear in Deployment yaml as plain text, which is not advisable. It is recommended to rather inject them into a Secret yaml that will itself be mounted as environment variables.

For example, start by injecting the secret into your staging repo's `/env/values.yaml`:

```yaml
myapp
  mysecrets:
    password: vault:path/to/mysecret:password
```

Then, in your app's `/charts/myapp/templates`, create a `mysecrets.yaml` file, in which you refer to the secret you just added:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: mysecrets
data:
  PASSWORD: {{ .Values.mysecrets.password | b64enc }}
```

Notice how we encode the secret value in Base64, as this is the format expected in a Secret yaml.

Also, make sure to add a default value for the same key in your app's `/charts/myapp/values.yaml`:

```yaml
mysecrets:
  password: ""
```

That allows Helm to resolve to some value during linting of your `mysecrets.yaml`, as linting seems not to consider values from the environment. Otherwise, you might get something like:

```sh
error: failed to build dependencies for chart from directory '.': failed to lint the chart '.': failed to run 'helm lint --values values.yaml' command in directory '.', output: '==> Linting .
[ERROR] templates/: render error in "myapp/templates/secrets.yaml": template: myapp/templates/secrets.yaml:6:21: executing "myapp/templates/secrets.yaml" at <.Values.mysecrets.password>: nil pointer evaluating interface {}.password
```

Finally, mount the Secret yaml as environment variables in your app's `/charts/myapp/templates/deployment.yaml`:

```yaml
...
    spec:
      containers:
      - name: {{ .Chart.Name }}
        envFrom:
        - secretRef:
            name: mysecrets
...
```
