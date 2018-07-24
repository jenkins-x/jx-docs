---
title: Install on Kubernetes
linktitle: Install on Kubernetes
description: How to install Jenkins X on an existing Kubernetes cluster
date: 2016-11-01
publishdate: 2016-11-01
lastmod: 2018-01-02
categories: [getting started]
keywords: [install,kubernetes]
menu:
  docs:
    parent: "getting-started"
    weight: 30
weight: 30
sections_weight: 30
draft: false
toc: true
---

Jenkins X can be installed on 1.8 or later of Kubernetes. The requirements are:

* RBAC is enabled
* insecure docker registries are enabled. This is so that pipelines can use a docker registry running inside the kubernetes cluster (which typically is not public so no https support). You can modify your pipelines to use other registries later.
* A cluster with at least 4 vCpus in addition to the master node (e.g. 2 m4.large nodes + m4.large master)

### Validating cluster conformance 

You can validate that your cluster is compliant with Jenkinx X by executing the following command:

    jx compliance run

It will run the Kubernetes conformance tests provided by [sonobuoy](https://github.com/heptio/sonobuoy). Typically, the execution takes up to an hour. 
You can check the status at any time with this command:

    jx compliance status

When the compliance tests are completed, you can see the results with:

    jx compliance results

Ideally, you should not see any failed tests in the output.

All the resources created by the conformance tests can be cleaned up with:

    jx compliance delete


### Ingress on AWS

On AWS the ideal setup is to use a Route 53 DNS wildcard CNAME to point `*.somedomain` at your ELB or NLB host name; then when prompted by `jx` you install `somedomain` (where `somedomain` is an actual DNS domain/subdomain you own). 

Then all the `Ingress` resources for any exposed service in any namespace will appear as `mysvc.myns.somedomain` - whether for things like Jenkins or Nexus or for your own microservices or Preview Environments.

Using wildcard DNS pointing to your ELB/NLB also means you'll be able to use all the availability zones on AWS.

#### Avoiding DNS

If you want to kick the tyres of Jenkins X without going to the trouble of getting a DNS domain name to use and setting up wildcard DNS you can instead use an NLP and use one of the IP addresses of one of the availability zones as your domain via `$IP.ip`.

This is not really intended for real production installations; but can be a quick way to get started trying out Jenkins X.

When using `jx install --provider=(aws|eks)` you are prompted if you want to use DNS and optionally setup a wildcard DNS CNAME record on Route 53; if not we are assuming you're gonna avoid DNS to kick the tyres on a single availability zone IP address by resolving the NLB host name to one of the availability zone IP addresses.


### Enabling insecure registries on kops

This is no longer required as we default to using ECR as the docker container registry now OOTB but if you wish to use the embedded docker registry of Jenkins X inside your kubernetes cluster you will need to enable insecure docker registries.

Note that if you are on AWS you may want to use the [jx create cluster aws](/getting-started/create-cluster/#using-amazon-aws) command which automates all of this for you!

If you created the kubernetes cluster via [kops](https://github.com/kubernetes/kops) then you can do the following:

```
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

That IP range, `100.64.0.0/10`, works on AWS but you may need to change it on other kubernetes clusters; it depends on the IP range of kubernetes services.
 
Then save the changes. You can verify your changes via:

```
kops get cluster -oyaml
```

and looking for the `insecureRegistry` section.

Now to make this change active on your cluster type:

```
kops update cluster --yes
kops rolling-update cluster --yes
```

You should now be good to go!

## Installing Jenkins X on a cloud

To install Jenkins X on an existing kubernetes cluster you can then use the [jx install](/commands/jx_install) command:

    jx install

If you know the provider you can specify that if you prefer on the command line. e.g.

    jx install --provider=aws
    
## Installing Jenkins X on premise

When using an on premise kubernetes cluster you can use this command line:

    jx install --provider=kubernetes --on-premise
    
This will default the argument for `--external-ip` to access services inside your cluster to use the kubernetes master IP address.

If you wish to use a different external IP address you can use:
    
    jx install --provider=kubernetes --external-ip 1.2.3.4
    
Otherwise the `jx install` will try and wait for the Ingress Controllers `Service.Status.LoadBalancer.Ingress` to resolve to an IP address - which can fail on premise.   

If you want an explanation of what the [jx install](/commands/jx_install) command does, you can read [what happens with the install](../install-on-cluster-what-happens)
