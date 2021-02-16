---
title: FAQ
linktitle: FAQ
type: docs
description: Questions on using Jenkins X 3.x and helm 3
weight: 500
aliases:
  - /faq/
  - /v3/guides/faq/
  - /v3/develop/faq/
---


                
## Where do I raise issues?

One of the challenges with Jenkins X 3.x is the [source code is spread across a number of organisations and repositories](/v3/about/overview/source/) since its highly decoupled into many [plugins and microservices](/v3/about/overview/) so it can be confusing 

If you know the specific plugin causing an issue, say [jx-preview](https://github.com/jenkins-x/jx-preview) then just raise the issue there in the issue tracker.

Otherwise use the [issue tracker for Jenkins X 3.x](https://github.com/jenkins-x/issues) and we can triage as required.

## How do I customise an App in an Environment?

With the new helm 3 based boot every environment uses boot - so there is a single way to configure anything whether its in the `dev`, `staging` or `production` environment and whether or not you are using [multiple clusters](/v3/guides/multi-cluster/).

See [how to customise a chart](/v3/develop/apps/#customising-charts)


## How do I deploy kubernetes resources?

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


## How do I list the apps that have been deployed?

You can see the helm charts that are installed along with their version, namespaces and any configuration values by looking at the `releases` section of your `helmfile.yaml` file in your cluster git repository.

You can browse all the kubernetes resources in each namespace using the canonical layout in the `config-root` folder. e.g. all charts are versioned in git as follows:
 
```bash 
config-root/
  namespaces/
    jx/
      lighthouse/
        lighthouse-webhooks-deploy.yaml    
```

You can see the above kubernetes resource, a `Deployment` with name `lighthouse-webhooks` in the namespace `jx` which comes from the `lighthouse` chart.

There could be some additional charts installed via Terraform for the [git operator](/v3/guides/operator/) and [health subsystem](/v3/guides/health/) which can be viewed via:
  
```bash 
helm list --all-namespaces
```                                                                                


## Why does Jenkins X use `helmfile template`?

If you look into the **versionStream/src/Makefile.mk** file in your cluster git repository to see how the boot proccess works you may notice its defined a simple makefile and uses the [jx gitops helmfile template](https://github.com/jenkins-x/jx-gitops/blob/master/docs/cmd/jx-gitops_helmfile_template.md) command to convert the [helmfile](https://github.com/roboll/helmfile) `helmfile.yaml` files referencing helm charts into YAML.

So why don't we use `helmfile sync` instead to apply the kubernetes resources from the charts directly into kubernetes?

The current approach has a [number of benefits](/v3/about/benefits/):

* we want to version all kubernetes resources (apart from `Secrets`) in git so that you can use git tooling to view the history of every kubernetes resource over time. 


  * by checking in all the kubernetes resources (apart from `Secrets`) its very easy to trace (and `git blame`) any change in any kubernetes resource in any chart and namespace to diagnose issues.
  * the upgrade of any tool such as [helm](https://helm.sh/), [helmfile](https://github.com/roboll/helmfile), [kustomize](https://kustomize.io/), [kpt](https://googlecontainertools.github.io/kpt/), [kubectl](https://kubernetes.io/docs/reference/kubectl/kubectl/) or [jx](/v3/guides/jx3/) could result in different YAML being generated changing the behaivour of your applications in Production.


* this approach makes it super easy to review all Pull Requests on all promotions and configuration changes and review what is actually going to change in kubernetes inside the git commit diff.

  * e.g. promoting from `1.2.3` to `1.3.0` of application `cheese` may look innocent enough, but did you notice those new `ClusterRole` and `PersistentVolume` resources that it now brings in?
  
* we can default to using [canonical secret management mechanism](/v3/guides/secrets/) based on [kubernetes external secrets](https://github.com/external-secrets/kubernetes-external-secrets) (see [how it works](/v3/about/how-it-works/#generate-step)) to ensure that:
 
  * no Secret value accidentally gets checked into git by mistake
  * all secrets can be managed, versioned, stored and rotated using vault or your cloud providers native secret storage mechanism
  * the combination of git and your secret store means your cluster becomes ephemeral and can be recreated if required (which often can happen if using tools like Terraform to manage infrastructure and you change significant infrastructure configuration values like node pools, version, location and so forth) 

* its easier for developers to understand what is going on as you can browse all the kubernetes resources in each namespace using the canonical layout in the `config-root` folder. e.g. all charts are versioned in git as follows:
                    
```bash 
config-root/
 namespaces/
   jx/
     lighthouse/
       lighthouse-webhooks-deploy.yaml    
```

   * you can see the above kubernetes resource, a `Deployment` with name `lighthouse-webhooks` in the namespace `jx` which comes from the `lighthouse` chart. 

* its easy to enrich the generated YAML with a combination of any additional tools [kustomize](https://kustomize.io/), [kpt](https://googlecontainertools.github.io/kpt/) or [jx](/v3/guides/jx3/). e.g.

  * its trivial to run [kustomize](https://kustomize.io/) or [kpt](https://googlecontainertools.github.io/kpt/) to modify any resource in any chart before it's applied to Production and to review the generated values first 

  * its easy to use [jx gitops hash](https://github.com/jenkins-x/jx-gitops/blob/master/docs/cmd/jx-gitops_hash.md) to add some hash annotations to cause rolling upgrade to `Deployments` when git changes (when the `Deployment` YAML does not)

  * use [jx gitops annotate](https://github.com/jenkins-x/jx-gitops/blob/master/docs/cmd/jx-gitops_annotate.md) to add add support for tools like [pusher wave](https://github.com/pusher/wave) so that rotating secrets in your underlying secret store can cause rolling upgrades in your `Deployments`

However since the steps to deploy a kubernetes cluster in Jenkins X is defined in a simple makefile stored in your cluster git repository its easy for developers to modify their cluster git repository to add any combination of tools to the makefile to use any permutation of  [helm 3](https://helm.sh/), [helmfile](https://github.com/roboll/helmfile), [kustomize](https://kustomize.io/), [kpt](https://googlecontainertools.github.io/kpt/)  and [kubectl](https://kubernetes.io/docs/reference/kubectl/kubectl/)

So if you really wanted to opt out of the canonical GitOps, resource and secret management model above you can add a `helm upgrade` or `helmfile sync` command to your makefile. The entire boot job is defined in git in **versionStream/git-operator/job.yaml** so you are free to go in whatever direction you prefer. 


## What is the directory layout?

To understand the directory layout see [this document](https://github.com/jenkins-x/jx-gitops/blob/master/docs/git_layout.md)
       

## How do I diagnose a step in a pipeline?

If you are wondering what image, command, environment variables are being used in a step in the pipeline the simplest thing is to [open the octant console](/v3/develop/ui/octant/) via:

```bash 
jx ui
```

Then if you navigate to the pipeline you are interested in and select the envelope icon next to a step name that will take you to the Step details page. e.g. if you click on the icon pointed to by the big red arrow:

<figure>
<img src="/images/developing/octant-step-click.png" />
<figcaption>
<h5>Click on the step icon to see details of a step which then takes you to the step details page</h5>
</figcaption>
</figure>


<figure>
<img src="/images/developing/octant-step.png" />
<figcaption>
<h5>Step details page lets you see the command, image, environment variables and volumes</h5>
</figcaption>
</figure>

If that doesn't help another option is to [edit the pipeline step](/v3/develop/pipelines/#editing-pipelines) via the `.lighthouse/jenkins-x/release.yaml` or  `.lighthouse/jenkins-x/pullrequest.yaml` file to add the command: `sleep infinity` in the `script:` value before the command that is not working.

You can then `kubectl exec` into the pod at that step and look around and try running commands inside the pod/container.

e.g. using the pod name from the above page and the container name you can do something like:

```bash 
kubectl exec -it -c name-of-step-container name-of-pod sh
```
           
## How do I configure pipelines to use GPUs?

You can install the [nvidia k8s device plugin](https://github.com/NVIDIA/k8s-device-plugin) as a daemonset to expose which nodes have GPUs and their status.

You can then view the nodes via:

```bash 
kubectl get nodes "-o=custom-columns=NAME:.metadata.name,GPU:.status.allocatable.nvidia\.com/gpu"  
```
        
You can then use the `resources` on your tekton steps as follows:

```yaml 
- image: gcr.io/kaniko-project/executor:v1.3.0-debug
  name: build-my-image
  resources:
    limits:
      # This job requires an instance with 1 GPU, 4 CPUs and 16GB memory - g4dn.2xlarge
      nvidia.com/gpu: 1
  script: |
    #!/busybox/sh
```

## Does Jenkins X support helmfile hooks?

Helmfile hooks allow programs to be executed during the lifecycle of the application of your helmfiles.

Since we default to using [helmfile template](/v3/develop/faq/#why-does-jenkins-x-use-helmfile-template) helmfile hooks are not supported for cluster git repositories (though you can use them in preview environments).

However its easy to add steps into the **versionStream/src/Makefile.mk** to simulate helmfile hooks.

           
## How do I add a chart?

To add a new chart add to the `helmfiles/mynamespace/helmfile.yaml` file follow the [add chart guide](/v3/develop/apps/#adding-charts).

## How do I add a kubernetes resource?

To add a new kubernetes resource [follow the add resources guide](/v3/develop/apps/#adding-resources).

## How do I add a new Secret?
 
 See [how to add a new Secret](/v3/admin/guides/secrets/#create-a-new-secret)
 

## How do I access a Secret from my pipeline?

Once you have a kubernetes Secret (see [how to create them](/v3/admin/guides/secrets/#create-a-new-secret)) you can access then in a pipeline either:

* as an [environment variable in a step](https://kubernetes.io/docs/concepts/configuration/secret/#using-secrets-as-environment-variables)
* via [a volume mount](https://kubernetes.io/docs/concepts/configuration/secret/#using-secrets-as-files-from-a-pod)


## If I add a file to `config-root` it gets deleted, why?

The `config-root` directory is regenerated on every boot job - basically every time you promote an application or merge a change into the main branch of your git dev cluster git repository.  For background see the [dev git repository layout docs](https://github.com/jenkins-x/jx-gitops/blob/master/docs/git_layout.md))

To add a new chart add to the `helmfiles/mynamespace/helmfile.yaml` file follow the [add chart guide](/v3/develop/apps/#adding-charts).

To add a new kubernetes resource [follow the add resources guide](/v3/develop/apps/#adding-resources).
      
## How do I use testcontainers?

If you want to use a container, such as a database, inside your pipeline so that you can run tests against your database inside your pipeline then use a [sidecar container in Tekton](https://tekton.dev/vault/pipelines-v0.16.3/tasks/#specifying-sidecars).

Here is [another example of a sidecar in a pipeline](https://tekton.dev/vault/pipelines-v0.16.3/tasks/#using-a-sidecar-in-a-task)

If you want to use a separate container inside a preview environment then add [charts or resources](/v3/develop/apps/#adding-charts) to the `preview/helmfile.yaml`

## How do I configure the ingress domain in Dev, Staging or Production?

With the new helm 3 based boot every environment uses boot - so there is a single way to configure anything whether its in the `dev`, `staging` or `production` environment and whether or not you are using [multiple clusters](/v3/guides/multi-cluster/).

You can override the domain name for use in all apps within an environment by modifying the `jx-requirements.yml` in the git repository for the `dev`, `staging` or `production` environment.

```yaml 
ingress:
  domain: mydomain.com 
```

Also by default there is a namespace specific separator added. So if your service is `cheese` the full domain name would be something like `cheese.jx-staging.mydomain.com`.

If you wish to avoid the namespace specific separator if each environment already has its own unique `domain` value then you can specify:

```yaml 
ingress:
  domain: mydomain.com  
  namespaceSubDomain: "."
```

If you wish to change any of these values for a single app only then you can use the [app customisation mechanism](/v3/develop/apps/#customising-charts).

e.g. for an app called `mychart` you can create a file called `apps/mychart/values.yaml` in the git repository for your environment and add the following YAML:

```yaml 
jxRequirements:
  ingress:
    domain: mydomain.com  
    namespaceSubDomain: "."
```



## How do I configure the ingress TLS certificate in Dev, Staging or Production?

You can specify the TLS certificate to use for the `dev`, `staging` or `production` environment by modifying the `jx-requirements.yml` file in the environments git repository:


```yaml 
ingress: 
  tls:
    enabled:
    secretName: my-tls-secret-name
```

This will then be applied to all the Jenkins X ingress resources for things like `lighthouse` or `nexus` - plus any apps you deploy to `dev`, `staging` or `production`.

If you want to override the TLS secret name for a specific app in a specific environment then rather like the [above question](#how-do-i-configure-the-ingress-domain-in-dev-staging-or-production) you can use the [app customisation mechanism](/v3/develop/apps/#customising-charts).
 
e.g. for an app called `mychart` you can create a file called `apps/mychart/values.yaml` in the git repository for your environment and add the following YAML:
                                                                                                                                        
```yaml 
jxRequirements:
  ingress:
    tls:
      enabled:
      secretName: my-tls-secret-name
```


## How do I use a custom container registry?

To allow a pipeline to be able to push to a container registry you can add this secret...

```bash
kubectl create secret generic container-registry-auth  \
  --from-literal=url=myserver.com \
  --from-literal=username=myuser \
  --from-literal=password=mypwd
```

This will then take effect the next time a commit merges on your cluster git repository e.g. next time you [upgrade your cluster](/v3/guides/upgrade/#cluster).

The various container registry secrets get merged into a `Secret` called `tekton-container-registry-auth` in the `jx` namespace which is associated with the default pipeline `ServiceAccount` `tekton-bot`.


If you want all pipelines to use this container registry then modify the `cluster.registry` field in your `jx-requirements.yml` file:

```yaml
cluster:
  registry: myserver.com 
...
```

Otherwise you can enable this new container registry on a specific application/repository by adding this `.jx/variables.sh` file into the git repository if it doesn't exist...
 
```bash
export DOCKER_REGISTRY="myserver.com"
```
    
## How do I change the secret poll period in kubernetes external secrets?

Your cloud provider could charge per read of a secret and so a frequent poll of your secrets could cost $$$. You may want to tone down the poll period.

You can do this via the `POLLER_INTERVAL_MILLISECONDS` setting in the [kubernetes external secrets configuration](https://github.com/external-secrets/kubernetes-external-secrets/tree/master/charts/kubernetes-external-secrets#configuration)

For more details [see how to configure charts](https://jenkins-x.io/v3/develop/apps/#customising-charts)


## Why does Jenkins X fail to download plugins?

When I run a `jx` command I get an error like...

``` Get https://github.com/jenkins-x/jx-..../releases/download/v..../jx-.....tar.gz: dial tcp: i/o timeout```

This sounds like a network problem; the code in `jx` is trying to download from `github.com` and your laptop is having trouble resolving the `github.com` domain.

* do you have a firewall / VPN / HTTP proxy blocking things?
* is your `/etc/resolv.conf` causing issues? e.g. if you have multiple entries for your company VPN?

               
## Why did my quickstart / import not work?

If you are not able to create quickstarts or import projects its most probably webhooks not being setup correctly.

When the `jx project import` or `jx project quickstart` runs it creates a Pull Request on your dev cluster repository. This should [trigger a webhook](/v3/about/how-it-works/#importing--creating-quickstarts) on your git provider which should then trigger a Pipeline (via [lighthouse webhooks](/v3/about/overview/#lighthouse)). The pipeline should then  [create a second commit on the pull request](/v3/about/how-it-works/#importing--creating-quickstarts) to configure your repository which then should get labelled and auto-merge.

If this does not happen its usually your webhooks are not working. You can check on the health of your system and webhooks via the [Health guide](/v3/admin/guides/health/)

Check out the [webhooks troubleshooting guide](/v3/admin/troubleshooting/webhooks/) 

## How do I add an Environment

With v3 everything is done via GitOps - so if in doubt the answer is to modify git. 

You can create new environments by adding to the `environments:` section of [jx-requirements.yml](https://github.com/jx3-gitops-repositories/jx3-kubernetes/blob/master/jx-requirements.yml#L18)
     
## How do I specify DOCKER_REGISTRY_ORG?

If you need to you can override in a specific repository (via a `.jx/settings.yaml` in your repository) but usually its common to all repos and is inherited from your `jx-requirements.yml` in your development environment repository

## How do I switch to bucketrepo?

To switch from `nexus` to `bucketrepo` in V3 there are a few changes you need to make. 

Incidetally the [jx3-kubernetes](https://github.com/jx3-gitops-repositories/jx3-kubernetes/blob/master/) repository is already setup for`bucketrepo`.

Please make the following changes...

* remove your old `nexus` chart from `helmfiles/jx/helmfile.yaml`
* add this to your `jx-requirements.yml` file so its like [this one](https://github.com/jx3-gitops-repositories/jx3-kubernetes/blob/master/jx-requirements.yml#L8)

```yaml 
apiVersion: core.jenkins-x.io/v4beta1
kind: Requirements
spec:
  ...
  cluster:
    chartRepository: http://bucketrepo.jx.svc.cluster.local/bucketrepo/charts
...
  repository: bucketrepo
    
```
* add the `bucketrepo` chart to your `helmfiles/jx/helmfile.yaml` file [like this](https://github.com/jx3-gitops-repositories/jx3-kubernetes/blob/master/helmfiles/jx/helmfile.yaml#L42):

```yaml 
...
releases:
- chart: jenkins-x/bucketrepo
  name: bucketrepo
...
```

then git commit and you should have your cluster switched to bucketrepo


## How do I uninstall Jenkins X?

We don't yet have a nice uninstall command. 

Though if you git clone your development git repository and cd into it you can run:

```bash 
kubectl delete -R -f config-root/namespaces
kubectl delete -R -f config-root/cluster
```


