---
title: Vault
linktitle: Vault
type: docs
description: How to use an on premise kubernetes cluster with vault
weight: 100
---

**NOTE** that in the following instructions it is left to the user to manage, backup and restore the vault installation once it has been installed. 

For production workloads [we recommend you use a cloud provider secret store](/v3/devops/patterns/prefer_cloud_over_kube/) or [Vault as a service](https://www.hashicorp.com/resources/running-vault-as-a-service-on-hashicorp-cloud-platform). Managing on premise vault instances is undifferentiated heavy lifting that should be outsourced to a cloud provider if you can. 

### Prerequisites

The prerequisites are the [same as regular on premise kubernetes](/v3/admin/platforms/on-premise/#prerequisites) around having a kubernetes cluster with ingress and storage

The difference is for vault:

*  <a href="https://github.com/jx3-gitops-repositories/jx3-kubernetes-vault/generate" target="github" class="btn bg-primary text-light">Create the cluster Git Repository</a> based on the [jx3-gitops-repositories/jx3-kubernetes-vault](https://github.com/jx3-gitops-repositories/jx3-kubernetes-vault/generate) template

    * if the above button does not work then please [Login to GitHub](https://github.com/login) first and then retry the button


* make sure you have a recent [helmfile](https://github.com/roboll/helmfile) binary installed on your `$PATH`
  
* setup the Vault instance in your cluster. From inside a git clone of the git repository you have just created above run the following:

```bash 
cd infra
helmfile sync
sleep 20
jx secret vault port-forward&
jx secret vault wait
```

* if that succeeds you should have a vault instance running in the `jx-vault` namespace

* find out what your ingress domain is for your cluster then modify the `jx-requirements.yml` file and modify the `ingress.domain` section...

```yaml
cluster:
...
ingress:
  domain: mydomain.com
...
```

* verify your cluster does not already have an [nginx](https://www.nginx.com/) installation. If it does then please remove the `nginx` line from your `helmfile.yaml` file and remove the `helmfiles/nginx` files. If you are using a custom nginx installation then you will need to figure out your domain by hand and won't be able to let Jenkins X detect the load balancer IP from its included nginx installation.

* git add, commit and push your changes:

```bash
git add *
git commit -a -m "fix: added domain"
git push origin master
```

* ensure you are connected to your cluster so you can run the following [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) commands 

```bash 
kubectl get ns
kubectl get node      
```        

*  <a href="/v3/guides/operator/" 
    target="github" class="btn bg-primary text-light" 
    title="install the git operator to setup Jenkins X in your cluster">
    Install the git operator
  </a> from inside a git clone of the git repository you created above.

* switch to the `jx` namespace

```bash    
jx ns jx
```        

*  <a href="/v3/develop/create-project/" class="btn bg-primary text-light">Create or import projects</a> 

                                                                   
