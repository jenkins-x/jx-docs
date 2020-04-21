---
title: Install on Kubernetes
linktitle: Install on Kubernetes
description: How to install Jenkins X on an existing Kubernetes cluster
date: 2016-11-01
publishdate: 2016-11-01
lastmod: 2018-01-02
categories: [getting started]
keywords: [install,kubernetes]
weight: 130
aliases:
  - /getting-started/install-on-cluster
  - /docs/getting-started/install-on-cluster
  - /docs/guides/managing-jx/common-tasks/install-on-cluster
---

Jenkins X can be installed on 1.8 or later of Kubernetes. The requirements are:

* RBAC is enabled
* Your Kubernetes cluster has a [default storage class](https://kubernetes.io/docs/concepts/storage/storage-classes/) setup so that `Persistent Volume Claims` can be bound to `Persistent Volumes`
* If not using the `aws` or `eks` providers, then we need to make sure that insecure Docker registries are enabled. This is so that pipelines can use a Docker registry running inside the Kubernetes cluster (which typically is not public, so no https support). You can modify your pipelines to use other registries later.
* A cluster with at least 4 vCPUs in addition to the master node (e.g. 2 m4.large worker nodes + 1 m4.large master node)

### Validating cluster conformance

You can validate that your cluster is compliant with Jenkins X by executing the following command:

    jx compliance run

It will run the Kubernetes conformance tests provided by [sonobuoy](https://github.com/heptio/sonobuoy). Typically, the execution takes up to an hour.
You can check the status at any time with this command:

    jx compliance status

When the compliance tests are completed, you can see the results with:

    jx compliance results

Ideally, you should not see any failed tests in the output.

All the resources created by the conformance tests can be cleaned up with:

    jx compliance delete

## Using AWS

If you are using AWS, be sure to check out the detailed blog on [Continuous Delivery with Amazon EKS and Jenkins X](https://aws.amazon.com/blogs/opensource/continuous-delivery-eks-jenkins-x/) by [Henryk Konsek](https://twitter.com/hekonsek) which goes into lots of detail on how to setup AWS + EKS with Jenkins X.

<!--
TODO Terraform 
If you want to go further with infrastructure as code you can follow this
[guide](/docs/guides/managing-jx/common-tasks/aws-terraform-install-gitops/) about setting up an EKS cluster and other
requirements in AWS with Terraform and then installing Jenkins X on it using GitOps for the
installation.
-->

### Ingress on AWS

On AWS, the ideal setup is to use a Route 53 DNS wildcard CNAME to point `*.somedomain` at your ELB or NLB host name. Then, when prompted by `jx`, you install `somedomain` (where `somedomain` is an actual DNS domain/subdomain you own).

Then, all the `Ingress` resources for any exposed service in any namespace will appear as `mysvc.myns.somedomain` - whether for things like Jenkins or Nexus or for your own microservices or Preview Environments.

Using wildcard DNS pointing to your ELB/NLB also means you'll be able to use all the availability zones on AWS.

The `jx` command will ask you if you want to automate the setup fo the Route 53 wildcard CNAME. If you want to do it yourself, you need to point to the ELB host name defined via:

```
kubectl get service -n kube-system jxing-nginx-ingress-controller  -oyaml | grep hostname
```

#### Avoiding DNS

If you want to kick the tires of Jenkins X without going to the trouble of getting a DNS domain name to use and setting up wildcard DNS, you can instead use an NLB and use one of the IP addresses of one of the availability zones as your domain via `$IP.ip`.

This is not really intended for real production installations. However, it can be a quick way to get started trying out Jenkins X.

When using `jx install --provider=(aws|eks)`, you are prompted if you want to use DNS and optionally setup a wildcard DNS CNAME record on Route 53. If not, we assume you're going to avoid DNS to kick the tires on a single availability zone IP address by resolving the NLB host name to one of the availability zone IP addresses.

### Getting registries to work on AWS with cluster set up with kops

The default on AWS is to use ECR as the Docker container registry. For this to work, the nodes need permission to upload images to ECR. If you instead want to use the embedded Docker registry of Jenkins X inside your Kubernetes cluster, you will need to enable insecure Docker registries.

#### Give nodes permission to use ECR

Do the following:

```sh
kops edit cluster
```

Then make sure the YAML has this `additionalPolicies` entry inside the `spec` section:

```yaml
...
spec:
  additionalPolicies:
    node: |
      [
        {
        "Effect": "Allow",
        "Action": ["ecr:InitiateLayerUpload", "ecr:UploadLayerPart","ecr:CompleteLayerUpload","ecr:PutImage"],
        "Resource": ["*"]
        }
      ]
```

Now to make this change active on your cluster type:

```sh
kops update cluster --yes
```

You should now be good to go!


#### Enabling insecure registries on kops ####

Do the following:

```sh
kops edit cluster
```

Then make sure the YAML has this `docker` entry inside the `spec` section:

```yaml
...
spec:
  docker:
    insecureRegistry: 100.64.0.0/10
    logDriver: ""
```

That IP range, `100.64.0.0/10`, works on AWS, but you may need to change it on other Kubernetes clusters. It depends on the IP range of Kubernetes services.

Then save the changes. You can verify your changes via:

```sh
kops get cluster -oyaml
```

and looking for the `insecureRegistry` section.

Now to make this change active on your cluster type:

```sh
kops update cluster --yes
kops rolling-update cluster --yes
```

You should now be good to go!

## Installing Jenkins X on a cloud

To install Jenkins X on an existing Kubernetes cluster, you can then use the [jx install](/commands/deprecation/) command:

```sh
jx install
```

If you know the provider, you can specify the provider on the command line. e.g.

```sh
jx install --provider=aws
```

Note: if you wish to use a different Git provider than GitHub for your environments, see [how to use a different Git provider](/docs/reference/components/git/#using-a-different-git-provider-for-environments)

## Installing Jenkins X on premises

__Prerequisits__
- Kubernetes > 1.8
- RBAC enabled
- A default cluster [dynamic storage class](https://kubernetes.io/docs/concepts/storage/dynamic-provisioning/) for provisioning persistent volumes.

When using an on premise Kubernetes cluster, you can use this command line:

```sh
jx install --provider=kubernetes --on-premise
```

This will default the argument for `--external-ip` to access services inside your cluster to use the Kubernetes master IP address.

If you wish to use a different external IP address, you can use:

```sh
jx install --provider=kubernetes --external-ip 1.2.3.4
```

Otherwise, the `jx install` will try and wait for the Ingress Controllers `Service.Status.LoadBalancer.Ingress` to resolve to an IP address - which can fail on premise.

If you already have an ingress controller installed, then try:

```sh
jx install --provider=kubernetes \
  --skip-ingress \
  --external-ip=10.20.30.40 \
  --domain=10.20.30.40.nip.io
```

If you do not know the domain or want it extracted from your Ingress deployment, try

```sh
jx install --provider=kubernetes --external-ip 10.123.0.17 \
  --ingress-service=$(yoursvcname) \
  --ingress-deployment=$(yourdeployname) \
  --ingress-namespace=kube-system
```

If you want an explanation of what the [jx install](/commands/deprecation/) command does, you can read [what happens with the install](../install-on-cluster-what-happens/)

## Installing Jenkins X on IBM Cloud Private

__Prerequisites__
- IBM Cloud Private version 3.1.0 is compatible with Jenkins X version 1.3.572.
- You might have to clean up with the `helm delete --purge jenkins-x` or `jx uninstall` commands. However, the `jx uninstall` command might not correctly pick up Helm releases at the `default` namespace if you point to the `kube-system` Tiller.

IBM Cloud Private includes a Docker registry and ingress controller. You can install Jenkins X into IBM Cloud Private with the following command:

```sh
jx install --provider=icp
```

The installation process prompts for the master IP address in your Kubernetes cluster. The master IP address is the same address that you used to access the IBM Cloud Private dashboard.

Create `ClusterImagePolicies` on IBM Cloud Private version 3.1.0 and set the following permissions:

```txt
- name: docker.io/*
- name: gcr.io/*
- name: quay.io/*
- name: k8s.gcr.io/*
```

Specify the following two `jx install` parameters with the command line or when prompted by the IBM Cloud Private provider:
- The `domain=''` parameter is the domain to expose ingress endpoints, for example, `jenkinsx.io`.
- The `external-ip=''` parameter is the external IP that is used to access ingress endpoints from outside the Kubernetes cluster and for bare metal on premise clusters.

If you don't specify these parameters, then the `jx install --provider=icp` command first prompts you to enter the `external-ip` parameter. Next, it prompts you to enter the `domain` parameter and offers you the `<external-ip>.nip.io` default value. After you enter these values, an ingress endpoint becomes available at `http://jenkins.jx.<your cluster IP>.nip.io`.

A Tiller is set in the default namespace as part of the Jenkins X installation process. To ensure that all Helm commands point to the correct Tiller, enter the `export TILLER_NAMESPACE=default` command when interacting with your Jenkins X installation.

Create registry secrets and patch the default service account in any of the namespaces that Jenkins X creates. Deployments can then pull images from the IBM Cloud Private registry.

If you create environments manually, you can specify `--pull-secrets <secret name>` with the `jx create environment` command. The created service account is automatically configured to use the pull secret that you mention. The pull secret needs to exist in the created namespace.
