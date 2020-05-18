---
title: Common Problems
linktitle: Common Problems
description: Questions on common issues setting up Jenkins X.
weight: 50
aliases:
  - /faq/issues/
---

We have tried to collate common issues here with work arounds. If your issue isn't listed here please [let us know](https://github.com/jenkins-x/jx/issues/new).

## Jenkins X does not startup

If your install fails to start there could be a few different reasons why the Jenkins X pods don't start.

Your cluster could be out of resources. You can check the spare resources on your cluster via [jx status](/commands/jx_status/):

```sh
jx status
```

We also have a diagnostic command that looks for common problems [jx step verify install](/commands/jx_step_verify_install/):

```sh
jx step verify install
```

A common issue for pods not starting is if your cluster does not have a [default storage class](https://kubernetes.io/docs/concepts/storage/storage-classes/) setup so that `Persistent Volume Claims` can be bound to `Persistent Volumes` as described in the [install instructions](/docs/getting-started/install-on-cluster/).

You can check your storage class and persistent volume setup via:

```sh
kubectl get pvc
```

If things are working you should see something like:

```sh
$ kubectl get pvc
NAME                        STATUS    VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
jenkins                     Bound     pvc-680b39b5-94f1-11e8-b93d-42010a840238   30Gi       RWO            standard       12h
jenkins-x-chartmuseum       Bound     pvc-6808fb5e-94f1-11e8-b93d-42010a840238   8Gi        RWO            standard       12h
jenkins-x-docker-registry   Bound     pvc-680a415c-94f1-11e8-b93d-42010a840238   100Gi      RWO            standard       12h
jenkins-x-mongodb           Bound     pvc-680d6fd9-94f1-11e8-b93d-42010a840238   8Gi        RWO            standard       12h
jenkins-x-nexus             Bound     pvc-680fc692-94f1-11e8-b93d-42010a840238   8Gi        RWO            standard       12h
```

If you see `status` of `Pending` then this indicates that you have no [default storage class](https://kubernetes.io/docs/concepts/storage/storage-classes/) setup on your kubnernetes cluster or you have ran out of persistent volume space.

Please try create a [default storage class](https://kubernetes.io/docs/concepts/storage/storage-classes/) for your cluster or contact your operations team or cloud provider.

If the `Persistent Volume Claims` are all `Bound` and things still have not started then try

```sh
kubectl get pod
```

If a pod cannot start try

```sh
kubectl describe pod some-pod-name
```

Maybe that gives you a clue. Is it RBAC related maybe?

If you are still stuck try [create an issue](https://github.com/jenkins-x/jx/issues/new)

## http: server gave HTTP response to HTTPS client

If your pipeline fails with something like this:

```sh
The push refers to a repository [100.71.203.90:5000/lgil3/jx-test-app]
time="2018-07-09T21:18:31Z" level=fatal msg="build step: pushing [100.71.203.90:5000/lgil3/jx-test-app:0.0.2]: Get https://100.71.203.90:5000/v1/_ping: http: server gave HTTP response to HTTPS client"
```

Then this means that you are using the internal docker registry inside Jenkins X for your images but your kubernetes cluster's docker daemons has not been configured for `insecure-registries` so that you can use `http` to talk to the docker registry service `jenkins-x-docker-registry` in your cluster.

By default docker wants all docker registries to be exposed over `https` and to use TLS and certificates. This should be done for all public docker registries. However when using Jenkins X with an internal local docker registry this is hard since its not available at a public DNS name and doesn't have HTTPS or certificates; so we default to requiring `insecure-registry` be configured on all the docker daemons for your kubernetes worker nodes.

We try to automate this setting when using `jx create cluster`  e.g. on AWS we default this value to the IP range `100.64.0.0/10` to match most kubernetes service IP addresses.

On [EKS](/commands/jx_create_cluster_eks/) we default to using ECR to avoid this issue. Similarly we will soon default to GCR and ACR on GKE and AKS respectively.

So a workaround is to use a real [external docker registry](/docs/resources/guides/managing-jx/common-tasks/docker-registry/) or enable `insecure-registry` on your docker daemons on your compute nodes on your Kubernetes cluster.


## Helm fails with Error: UPGRADE FAILED: incompatible versions client[...] server[...]'

Generally speaking this happens when your laptop has a different version of helm to the version used in our build pack docker images and/or the version of tiller thats running in your server.

The simplest fix for this is to just [not use tiller at all](/blog/2018/10/03/helm-without-tiller/) - which actually helps avoid this problem ever happening and solves a raft of security issues too.

However switching from using Tiller to No Tiller does require a re-install of Jenkins X (though you could try do that in separate set of namespaces then move projects across incrementally?).

The manual workaround is to install the [exact same version of helm as used on the server](https://github.com/helm/helm/releases)

Or you can try switch tiller to match your client version:

* run `helm init --upgrade`

Though as soon as a pipeline runs it'll switch the tiller version again so you'll have to keep repeating the above.


## error creating jenkins credential jenkins-x-chartmuseum 500 Server Error

This is a [pending issue](https://github.com/jenkins-x/jx/issues/1234) which we will hopefully fix soon.

It basically happens if you have an old API token in `~/.jx/jenkinsAuth.yaml` for your jenkins server URL. You can either:

* remove it from that file by hand
* run the following command [jx delete jenkins token](/commands/deprecation/):

    jx delete jenkins token admin

## errors with chartmuseum.build.cd.jenkins-x.io

If you see errors like:

```sh
error:failed to add the repository 'jenkins-x' with URL 'https://chartmuseum.build.cd.jenkins-x.io'
```

or

```sh
Looks like "https://chartmuseum.build.cd.jenkins-x.io" is not a valid chart repository or cannot be reached
```

then it looks like you have a reference to an old chart museum URL for Jenkins X charts.

The new URL is: http://chartmuseum.jenkins-x.io

It could be your helm install has an old repository URL installed. You should see...

```sh
$ helm repo list
NAME     	URL
stable   	https://kubernetes-charts.storage.googleapis.com
jenkins-x	http://chartmuseum.jenkins-x.io
```

If you see this...

```sh
$ helm repo list
NAME     	URL
jenkins-x	https://chartmuseum.build.cd.jenkins-x.io
```

then please run...

```sh
helm repo remove jenkins-x
helm repo add jenkins-x	http://chartmuseum.jenkins-x.io
```

and you should be good to go again.


Another possible cause is an old URL in your environment's git repository may have old references to the URL.

So open your `env/requirements.yaml` in your staging/production git repositories and modify them to use the URL http://chartmuseum.jenkins-x.io instead of **chartmuseum.build.cd.jenkins-x.io** like this [env/requirements file](https://github.com/jenkins-x/default-environment-charts/blob/master/env/requirements.yaml)

## git errors: POST 401 Bad credentials

This indicates your git API token either was input incorrectly or has been regenerated and is now incorrect.

To recreate it with a new API token value try the following (changing the git server name to match your git provider):

```sh
jx delete git token -n github <yourUserName>
jx create git token -n github <yourUserName>
```

More details on [using git and Jenkins X here](/docs/resources/guides/managing-jx/common-tasks/git/)


## Invalid git token to scan a project

If you get an error in Jenkins when it tries to scan your repositories for branches something like:

```sh
hudson.AbortException: Invalid scan credentials *****/****** (API Token for acccessing https://github.com git service inside pipelines) to connect to https://api.github.com, skipping
```

Then your git API token was probably wrong or has expired.

To recreate it with a new API token value try the following (changing the git server name to match your git provider):

```sh
jx delete git token -n GitHub admin
jx create git token -n GitHub admin
```

More details on [using git and Jenkins X here](/docs/resources/guides/managing-jx/common-tasks/git/)

## What are the credentials to access core services?

Authenticated core services of Jenkins X include Jenkins, Nexus, ChartMuseum.  The default username is `admin`and the password by default is generated and printed out in the terminal after `jx create cluster` or `jx install`.

### Set Admin Username and Password values for Core Services
You can also set the admin username via the `--default-admin-username=username` flag.

{{< alert >}}
Perhaps you are using the  Active Directory security realm in Jenkins.  It is in this scenario that setting the Admin Username via the `--default-admin-username` based on your existing service accounts makes sense.

You may also pass this value via the `myvalues.yaml`.
{{< /alert >}}

If you would like to set the default password yourself then you can set the flag `--default-admin-password=foo` to the two comamnds above.

If you don't have the terminal console output anymore you can look in the local file `~/.jx/jenkinsAuth.yaml` and find the password that matches your Jenkins server URL for the desired cluster.

## Persistent Volume Claims do not bind

If you notice that the persistent volume claims created when installing Jenkins X don't bind with

    kubectl get pvc

The you should check that you have a cluster default storage class for dynamic persistent volume provisioning.  See [here](https://kubernetes.io/docs/concepts/storage/dynamic-provisioning/) for more details.


## I cannot connect to nodes on AWS

If you don't see any valid nodes returned by `kubectl get node` or you get errors running `jx status` something like:

```sh
Unable to connect to the server: dial tcp: lookup abc.def.regino.eks.amazonaws.com on 10.0.0.2:53: no such host
```

it could be your kube config is stale. Try

```sh
aws eks --region <CLUSTER_REGION> update-kubeconfig --name <CLUSTER_NAME>
```

That should regenerate your local `~/kube/config` file and so `kubectl get node` or `jx status` should find your nodes

## How can I diagnose exposecontroller issues?

When you promote a new version of your application to an environment, such as the Staging Environment a Pull Request is raised on the environment repository.

When the master pipeline runs on an environment a Kubernetes `Job` is created for [exposecontroller](https://github.com/jenkins-x/exposecontroller) which runs a pod until it terminates.

It can be tricky finding the log for temporary jobs since the pod is removed.

One way to diagnose logs in your, say, Staging environment is to [download and install kail](https://github.com/boz/kail) and add it to your `PATH`.

Then run this command:

```sh
kail -l job-name=expose -n jx-staging
```

If you then promote to the Staging environment or retrigger the pipeline on the `master` branch of your Staging git repository (e.g. via [jx start pipeline](/commands/jx_start_pipeline/)) then you should see the output of the [exposecontroller](https://github.com/jenkins-x/exposecontroller) pod.


## Why is promotion really slow?

If you find you get lots of warnings in your pipelines like this...

```sh
"Failed to query the Pull Request last commit status for https://github.com/myorg/environment-mycluster-staging/pull/1 ref xyz Could not find a status for repository myorg/environment-mycluster-staging with ref xyz
```

and promotion takes 30 minutes from a release pipeline on an application starting to the change hitting `Staging` then its mostly probably due to Webhooks.

When we [import projects](/docs/resources/guides/using-jx/creating/import/) or [create quickstarts](/docs/getting-started/first-project/create-quickstart/) we automate the setup of CI/CD pipelines for the git repository. What this does is setup Webhooks on the git repository to trigger Jenkins X to trigger pipelines (either using Prow for [serverless Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) or the static jenkins server if not).

However sometimes your git provider (e.g. [GitHub](https://github.com/) may not be able to do connect to your Jenkins X installation (e.g. due to networking / firewall issues).

The easiest way to diagnose this is opening the git repository (e.g. for your environment repository).

```sh
jx get env
```

Then:

* click on the generated URL for, say, your `Staging`  git repository
* click the `Settings` icon
* select the `Webhooks` tab on the left
* select your Jenkins X webhook URL
* view the last webhook - did it succeed? Try re-trigger it? That should highlight any network issues etc

If you cannot use public webhooks you could look at something like [ultrahook](http://www.ultrahook.com/)

## Cannot create cluster minikube

If you are using a Mac then `hyperkit` is the best VM driver to use - but does require you to install a recent [Docker for Mac](https://docs.docker.com/docker-for-mac/install/) first. Maybe try that then retry `jx create cluster minikube`?

If your minikube is failing to startup then you could try:

```sh
minikube delete
rm -rf ~/.minikube
```

If the `rm` fails you may need to do:

```sh
sudo rm -rf ~/.minikube
```

Now try `jx create cluster minikube` again - did that help? Sometimes there are stale certs or files hanging around from old installations of minikube that can break things.

Sometimes a reboot can help in cases where virtualisation goes wrong ;)

Otherwise you could try follow the minikube instructions

* [install minikube](https://github.com/kubernetes/minikube#installation)
* [run minikube start](https://github.com/kubernetes/minikube#quickstart)

## Minkube and hyperkit: Could not find an IP address

If you are using minikube on a mac with hyperkit and find minikube fails to start with a log like:

```sh
Temporary Error: Could not find an IP address for 46:0:41:86:41:6e
Temporary Error: Could not find an IP address for 46:0:41:86:41:6e
Temporary Error: Could not find an IP address for 46:0:41:86:41:6e
Temporary Error: Could not find an IP address for 46:0:41:86:41:6e
```

It could be you have hit [this issue in minikube and hyperkit](https://github.com/kubernetes/minikube/issues/1926#issuecomment-356378525).

The work around is to try the following:

```sh
rm ~/.minikube/machines/minikube/hyperkit.pid
```

Then try again. Hopefully this time it will work!

## Cannot access services on minikube

When running minikube locally `jx` defaults to using [nip.io](http://nip.io/) as a way of using nice-isn DNS names for services and working around the fact that most laptops can't do wildcard DNS. However sometimes [nip.io](http://nip.io/) has issues and does not work.

To avoid using [nip.io](http://nip.io/) you can do the following:

Edit the file `~/.jx/cloud-environments/env-minikube/myvalues.yaml` and add the following content:

```yaml
expose:
  Args:
    - --exposer
    - NodePort
    - --http
    - "true"
```

Then re-run `jx install` and this will switch the services to be exposed on `node ports` instead of using ingress and DNS.

So if you type:

```sh
jx open
```

You'll see all the URs of the form `http://$(minikube ip):somePortNumber` which then avoids going through [nip.io](http://nip.io/) - it just means the URLs are a little more cryptic using magic port numbers rather than simple host names.

## How do I get the Password and Username for Jenkins?

Install [KSD](https://github.com/mfuentesg/ksd) by running `go get github.com/mfuentesg/ksd` and then run `kubectl get secret jenkins -o yaml | ksd`


## How do I see the log of exposecontroller?

Usually we run the [exposecontroller]() as a post install `Job` when we perform promotion to `Staging` or `Production` to expose services over Ingress and possibly inject external URLs into applications configuration.


So the `Job` will trigger a short lived `Pod` to run in the namespace of your environment, then the pod will be deleted.

If you want to view the logs of the `exposecontroller` you will need to watch for the logs using a selector then trigger the promotion pipeline to capture it.

One way to do that is via the [kail](https://github.com/boz/kail) CLI:


```sh
kail -l  job-name=expose
```

This will watch for exposecontroller logs and then dump them to the console. Now trigger a promotion pipeline and you should see the output within a minute or so.

## Cannot create TLS certificates during Ingress setup

> [cert-manager](https://docs.cert-manager.io/en/latest/index.html) cert-manager is a seperate project from _Jenkins X_.

Newly created GKE clusters or existing cluster running _kubernetes_ **v1.12** or older will encounter the following error when configuring Ingress with site-wide TLS:

```sh
Waiting for TLS certificates to be issued...
Timeout reached while waiting for TLS certificates to be ready
```

This issue is caused by the _cert-manager_ pod not having the `disable-validation` label set, which is a known cert-manager issue which is [documented on their website](https://docs.cert-manager.io/en/latest/getting-started/install/kubernetes.html). The following steps, taken from the [cert-manager/troubleshooting-installation](https://docs.cert-manager.io/en/latest/getting-started/troubleshooting.html#troubleshooting-installation) webpage, should resolve the issue:

Check if the _disable-validation_ label exists on the _cert-manager_ pod.
```sh
kubectl describe namespace cert-manager
```

If you cannot see the `certmanager.k8s.io/disable-validation=true` label on your namespace, you should add it with:
```sh
kubectl label namespace cert-manager certmanager.k8s.io/disable-validation=true
```

Confirm the label has been added to the _cert-manager_ pod.
```sh
kubectl describe namespace cert-manager

Name:         cert-manager
Labels:       certmanager.k8s.io/disable-validation=true
Annotations:  <none>
Status:       Active
...
```

Now rerun _jx_ Ingress setup:
```sh
jx upgrade ingress
```

While the ingress command is running, you can tail the _cert-manager_ logs in another terminal and see what is happening. You will need to find the name of your _cert-manager_ pod using:
```sh
kubectl get pods --namespace cert-manager
```

Then tail the logs of the _cert-manager_ pod.
```sh
kubectl logs YOUR_CERT_MNG_POD --namespace cert-manager -f
```

Your TLS certificates should now be set up and working, otherwise checkout the [official _cert-manager_ troubleshooting](https://docs.cert-manager.io/en/latest/getting-started/troubleshooting.html) instructions.


## Recreating a cluster with the same name

If you want to destroy a cluster that was created with boot and recreate it with the exact same name, there is some clean that needs to be done first.

Make sure you uninstall jx:
```sh
jx uninstall
```

Delete the cluster either from the web console or terminal by using the Kubernetes provider CLI command:
```sh
gcloud container clusters delete <cluster-name> --zone <cluster-zone>
```

After you have successfully done this, remove the `~/.jx` and `~/.kube` directories:
```sh
rm -rf ~/.jx ~/.kube
```

Delete any repositories created by `jx` on your Github organisations account.

Delete the local git `jenkins-x-boot-config` repository.

That should leave your Kubernetes provider and your local environment in a clean state.

## Other issues

Please [let us know](https://github.com/jenkins-x/jx/issues/new) and see if we can help? Good luck!
