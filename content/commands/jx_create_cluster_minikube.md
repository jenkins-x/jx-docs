---
date: 2018-07-24T11:38:45Z
title: "jx create cluster minikube"
slug: jx_create_cluster_minikube
url: /commands/jx_create_cluster_minikube/
---
## jx create cluster minikube

Create a new kubernetes cluster with minikube: Runs locally

### Synopsis

This command creates a new kubernetes cluster, installing required local dependencies and provisions the Jenkins X platform 

Minikube is a tool that makes it easy to run Kubernetes locally. Minikube runs a single-node Kubernetes cluster inside a VM on your laptop for users looking to try out Kubernetes or develop with it day-to-day.

```
jx create cluster minikube [flags]
```

### Examples

```
  jx create cluster minikube
```

### Options

```
  -b, --batch-mode                          In batch mode the command never prompts for user input
      --cleanup-temp-files                  Cleans up any temporary values.yaml used by helm install [default true] (default true)
      --cloud-environment-repo string       Cloud Environments git repo (default "https://github.com/jenkins-x/cloud-environments")
  -c, --cpu string                          Number of CPUs allocated to the minikube VM. Defaults to 3.
      --default-admin-password string       the default admin password to access Jenkins, Kubernetes Dashboard, Chartmuseum and Nexus
      --default-environment-prefix string   Default environment repo prefix, your git repos will be of the form 'environment-$prefix-$envName'
      --docker-registry string              The Docker Registry host or host:port which is used when tagging and pushing images. If not specified it defaults to the internal registry unless there is a better provider default (e.g. ECR on AWS/EKS)
      --domain string                       Domain to expose ingress endpoints.  Example: jenkinsx.io
      --draft-client-only                   Only install draft client
      --environment-git-owner string        The git provider organisation to create the environment git repositories in
      --exposecontroller-pathmode path      The ExposeController path mode for how services should be exposed as URLs. Defaults to using subnets. Use a value of path to use relative paths within the domain host such as when using AWS ELB host names
      --exposer string                      Used to describe which strategy exposecontroller should use to access applications (default "Ingress")
      --external-ip string                  The external IP used to access ingress endpoints from outside the kubernetes cluster. For bare metal on premise clusters this is often the IP of the kubernetes master. For cloud installations this is often the external IP of the ingress LoadBalancer.
      --git-api-token string                The git API token to use for creating new git repositories
      --git-provider-url string             The git server URL to create new git repositories inside
      --git-username string                 The git username to use for creating new git repositories
      --global-tiller                       Whether or not to use a cluster global tiller (default true)
      --headless                            Enable headless operation if using browser automation
      --helm-client-only                    Only install helm client
      --helm-tls                            Whether to use TLS with helm
      --helm3                               Use helm3 to install Jenkins X which does not use Tiller
  -h, --help                                help for minikube
      --http string                         Toggle creating http or https ingress rules (default "true")
  -v, --hyperv-virtual-switch string        Additional options for using HyperV with minikube
      --ingress-cluster-role string         The cluster role for the Ingress controller (default "cluster-admin")
      --ingress-deployment string           The namespace for the Ingress controller Deployment (default "jxing-nginx-ingress-controller")
      --ingress-namespace string            The namespace for the Ingress controller (default "kube-system")
      --ingress-service string              The name of the Ingress controller Service (default "jxing-nginx-ingress-controller")
      --install-dependencies                Should any required dependencies be installed automatically
      --install-only                        Force the install comand to fail if there is already an installation. Otherwise lets update the installation
      --keep-exposecontroller-job           Prevents Helm deleting the exposecontroller Job and Pod after running.  Useful for debugging exposecontroller logs but you will need to manually delete the job if you update an environment
      --kubernetes-version string           kubernetes version
      --local-cloud-environment             Ignores default cloud-environment-repo and uses current directory 
      --local-helm-repo-name string         The name of the helm repository for the installed Chart Museum (default "releases")
  -m, --memory string                       Amount of RAM allocated to the minikube VM in MB. Defaults to 4096 MB.
      --namespace string                    The namespace the Jenkins X platform should be installed into (default "jx")
      --no-brew                             Disables the use of brew on MacOS to install or upgrade command line dependencies
      --no-default-environments             Disables the creation of the default Staging and Production environments
      --on-premise                          If installing on an on premise cluster then lets default the 'external-ip' to be the kubernetes master IP address
      --recreate-existing-draft-repos       Delete existing helm repos used by Jenkins X under ~/draft/packs
      --register-local-helmrepo             Registers the Jenkins X chartmuseum registry with your helm client [default false]
      --skip-ingress                        Dont install an ingress controller
      --skip-tiller                         Dont install a Helms Tiller service
      --tiller-cluster-role string          The cluster role for Helm's tiller (default "cluster-admin")
      --tiller-namespace string             The namespace for the Tiller when using a gloabl tiller (default "kube-system")
      --timeout string                      The number of seconds to wait for the helm install to complete (default "6000")
      --tls-acme string                     Used to enable automatic TLS for ingress (default "false")
      --user-cluster-role string            The cluster role for the current user to be able to administer helm (default "cluster-admin")
      --username string                     The kubernetes username used to initialise helm. Usually your email address for your kubernetes account
      --verbose                             Enable verbose logging
      --version string                      The specific platform version to install
  -d, --vm-driver string                    VM driver is one of: [hyperkit hyperv kvm kvm2 virtualbox vmwarefusion xhyve]
```

### SEE ALSO

* [jx create cluster](/commands/jx_create_cluster/)	 - Create a new kubernetes cluster

###### Auto generated by spf13/cobra on 24-Jul-2018
