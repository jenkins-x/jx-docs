---
date: 2018-04-23T12:20:58Z
title: "jx create cluster aks"
slug: jx_create_cluster_aks
url: /commands/jx_create_cluster_aks/
---
## jx create cluster aks

Create a new kubernetes cluster on AKS: Runs on Azure

### Synopsis

This command creates a new kubernetes cluster on AKS, installing required local dependencies and provisions the Jenkins X platform 

Azure Container Service (AKS) manages your hosted Kubernetes environment, making it quick and easy to deploy and manage containerized applications without container orchestration expertise. It also eliminates the burden of ongoing operations and maintenance by provisioning, upgrading, and scaling resources on demand, without taking your applications offline. 

Please use a location local to you: you can retrieve this from the Azure portal or by running "az provider list" in your terminal. 

Important: You will need an account on azure, with a storage account (https://portal.azure.com/#create/Microsoft.StorageAccount-ARM) and network (https://portal.azure.com/#create/Microsoft.VirtualNetwork-ARM) - both linked to the resource group you use to create the cluster in.

```
jx create cluster aks [flags]
```

### Examples

```
  jx create cluster aks
```

### Options

```
      --cleanup-temp-files                  Cleans up any temporary values.yaml used by helm install [default true] (default true)
      --cloud-environment-repo string       Cloud Environments git repo (default "https://github.com/jenkins-x/cloud-environments")
  -c, --cluster-name string                 Name of the cluster
      --default-admin-password string       the default admin password to access Jenkins, Kubernetes Dashboard, Chartmuseum and Nexus
      --default-environment-prefix string   Default environment repo prefix, your git repos will be of the form 'environment-$prefix-$envName'
      --domain string                       Domain to expose ingress endpoints.  Example: jenkinsx.io
      --draft-client-only                   Only install draft client
      --environment-git-owner string        The git provider organisation to create the environment git repositories in
      --exposer string                      Used to describe which strategy exposecontroller should use to access applications (default "Ingress")
      --git-api-token string                The git API token to use for creating new git repositories
      --git-provider-url string             The git server URL to create new git repositories inside
      --git-username string                 The git username to use for creating new git repositories
      --global-tiller                       Whether or not to use a cluster global tiller (default true)
      --helm-client-only                    Only install helm client
      --helm-tls                            Whether to use TLS with helm
  -h, --help                                help for aks
      --http string                         Toggle creating http or https ingress rules (default "true")
      --ingress-cluster-role string         The cluster role for the Ingress controller (default "cluster-admin")
      --ingress-deployment string           The namespace for the Ingress controller Deployment (default "jxing-nginx-ingress-controller")
      --ingress-namespace string            The namespace for the Ingress controller (default "kube-system")
      --ingress-service string              The name of the Ingress controller Service (default "jxing-nginx-ingress-controller")
      --keep-exposecontroller-job           Prevents Helm deleting the exposecontroller Job and Pod after running.  Useful for debugging exposecontroller logs but you will need to manually delete the job if you update an environment
  -v, --kubernetes-version string           kubernetes version (default "1.9.1")
      --local-cloud-environment             Ignores default cloud-environment-repo and uses current directory 
      --local-helm-repo-name string         The name of the helm repository for the installed Chart Museum (default "releases")
  -l, --location string                     location to run cluster in
      --namespace string                    The namespace the Jenkins X platform should be installed into (default "jx")
      --no-default-environments             Disables the creation of the default Staging and Production environments
  -o, --nodes string                        node count
  -p, --password string                     password
  -k, --path-To-public-rsa-key string       pathToPublicRSAKey
      --recreate-existing-draft-repos       Delete existing helm repos used by Jenkins X under ~/draft/packs
      --register-local-helmrepo             Registers the Jenkins X chartmuseum registry with your helm client [default false]
  -n, --resource-group-name string          Name of the resource group
      --skip-ingress                        Dont install an ingress controller
      --skip-tiller                         Dont install a Helms Tiller service
      --tiller-cluster-role string          The cluster role for Helm's tiller (default "cluster-admin")
      --tiller-namespace string             The namespace for the Tiller when using a gloabl tiller (default "kube-system")
      --timeout string                      The number of seconds to wait for the helm install to complete (default "6000")
      --tls-acme string                     Used to enable automatic TLS for ingress (default "false")
  -u, --user name string                    user name
      --user-cluster-role string            The cluster role for the current user to be able to administer helm (default "cluster-admin")
      --username string                     The kubernetes username used to initialise helm. Usually your email address for your kubernetes account
```

### SEE ALSO

* [jx create cluster](/commands/jx_create_cluster/)	 - Create a new kubernetes cluster

###### Auto generated by spf13/cobra on 23-Apr-2018
