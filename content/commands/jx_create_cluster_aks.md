---
date: 2019-01-16T14:31:07Z
title: "jx create cluster aks"
slug: jx_create_cluster_aks
url: /commands/jx_create_cluster_aks/
---
## jx create cluster aks

Create a new Kubernetes cluster on AKS: Runs on Azure

### Synopsis

This command creates a new Kubernetes cluster on AKS, installing required local dependencies and provisions the Jenkins X platform 

Azure Container Service (AKS) manages your hosted Kubernetes environment, making it quick and easy to deploy and manage containerized applications without container orchestration expertise. It also eliminates the burden of ongoing operations and maintenance by provisioning, upgrading, and scaling resources on demand, without taking your applications offline. 

Please use a location local to you: you can retrieve this from the Azure portal or by running "az provider list" in your terminal. 

Important: You will need an account on Azure, with a storage account (https://portal.azure.com/#create/Microsoft.StorageAccount-ARM) and network (https://portal.azure.com/#create/Microsoft.VirtualNetwork-ARM) - both linked to the resource group you use to create the cluster in.

```
jx create cluster aks [flags]
```

### Examples

```
  jx create cluster aks
```

### Options

```
      --aad-client-app-id string                 The ID of an Azure Active Directory client application
      --aad-server-app-id string                 The ID of an Azure Active Directory server application
      --aad-server-app-secret string             The secret of an Azure Active Directory server application
      --aad-tenant-id string                     The ID of an Azure Active Directory tenant
      --admin-username string                    User account to create on node VMs for SSH access
  -b, --batch-mode                               In batch mode the command never prompts for user input
      --buildpack string                         The name of the build pack to use for the Team
      --cleanup-temp-files                       Cleans up any temporary values.yaml used by helm install [default true] (default true)
      --client-secret string                     Azure AD client secret to use an existing SP
      --cloud-environment-repo string            Cloud Environments Git repo (default "https://github.com/jenkins-x/cloud-environments")
  -c, --cluster-name string                      Name of the cluster
      --default-admin-password string            the default admin password to access Jenkins, Kubernetes Dashboard, ChartMuseum and Nexus
      --default-environment-prefix string        Default environment repo prefix, your Git repos will be of the form 'environment-$prefix-$envName'
      --disk-size string                         Size in GB of the OS disk for each node in the node pool.
      --dns-name-prefix string                   Prefix for hostnames that are created
      --dns-service-ip string                    IP address assigned to the Kubernetes DNS service
      --docker-bridge-address string             An IP address and netmask assigned to the Docker bridge
      --docker-registry string                   The Docker Registry host or host:port which is used when tagging and pushing images. If not specified it defaults to the internal registry unless there is a better provider default (e.g. ECR on AWS/EKS)
      --domain string                            Domain to expose ingress endpoints.  Example: jenkinsx.io
      --draft-client-only                        Only install draft client
      --environment-git-owner string             The Git provider organisation to create the environment Git repositories in
      --exposecontroller-pathmode path           The ExposeController path mode for how services should be exposed as URLs. Defaults to using subnets. Use a value of path to use relative paths within the domain host such as when using AWS ELB host names
      --exposer string                           Used to describe which strategy exposecontroller should use to access applications (default "Ingress")
      --external-ip string                       The external IP used to access ingress endpoints from outside the Kubernetes cluster. For bare metal on premise clusters this is often the IP of the Kubernetes master. For cloud installations this is often the external IP of the ingress LoadBalancer.
      --git-api-token string                     The Git API token to use for creating new Git repositories
      --git-private                              Create new Git repositories as private
      --git-provider-kind string                 Kind of Git server. If not specified, kind of server will be autodetected from Git provider URL. Possible values: bitbucketcloud, bitbucketserver, gitea, gitlab, github, fakegit
      --git-provider-url string                  The Git server URL to create new Git repositories inside (default "https://github.com")
      --git-username string                      The Git username to use for creating new Git repositories
      --gitops                                   Sets up the local file system for GitOps so that the current installation can be configured or upgraded at any time via GitOps
      --global-tiller                            Whether or not to use a cluster global tiller (default true)
      --headless                                 Enable headless operation if using browser automation
      --helm-client-only                         Only install helm client
      --helm-tls                                 Whether to use TLS with helm
      --helm3                                    Use helm3 to install Jenkins X which does not use Tiller
  -h, --help                                     help for aks
      --http string                              Toggle creating http or https ingress rules (default "true")
      --ingress-cluster-role string              The cluster role for the Ingress controller (default "cluster-admin")
      --ingress-deployment string                The name of the Ingress controller Deployment (default "jxing-nginx-ingress-controller")
      --ingress-namespace string                 The namespace for the Ingress controller (default "kube-system")
      --ingress-service string                   The name of the Ingress controller Service (default "jxing-nginx-ingress-controller")
      --install-dependencies                     Should any required dependencies be installed automatically
      --install-only                             Force the install command to fail if there is already an installation. Otherwise lets update the installation
      --keep-exposecontroller-job                Prevents Helm deleting the exposecontroller Job and Pod after running.  Useful for debugging exposecontroller logs but you will need to manually delete the job if you update an environment
  -v, --kubernetes-version az aks get-versions   Version of Kubernetes to use for creating the cluster, such as '1.8.11' or '1.9.6'.  Values from: az aks get-versions.
      --local-cloud-environment                  Ignores default cloud-environment-repo and uses current directory 
      --local-helm-repo-name string              The name of the helm repository for the installed ChartMuseum (default "releases")
  -l, --location string                          Location to run cluster in
      --log-level string                         Logging level. Possible values - panic, fatal, error, warning, info, debug. (default "info")
      --namespace string                         The namespace the Jenkins X platform should be installed into (default "jx")
      --no-brew                                  Disables the use of brew on macOS to install or upgrade command line dependencies
      --no-default-environments                  Disables the creation of the default Staging and Production environments
      --no-gitops-env-apply                      When using GitOps to create the source code for the development environment and installation, don't run 'jx step env apply' to perform the install
      --no-gitops-env-repo                       When using GitOps to create the source code for the development environment this flag disables the creation of a git repository for the source code
      --no-gitops-vault                          When using GitOps to create the source code for the development environment this flag disables the creation of a vault
      --no-tiller                                Whether to disable the use of tiller with helm. If disabled we use 'helm template' to generate the YAML from helm charts then we use 'kubectl apply' to install it to avoid using tiller completely.
  -s, --node-vm-size string                      Size of Virtual Machines to create as Kubernetes nodes
  -o, --nodes string                             Number of node
      --on-premise                               If installing on an on premise cluster then lets default the 'external-ip' to be the Kubernetes master IP address
  -p, --password string                          Azure password
  -k, --path-To-public-rsa-key string            Path to public RSA key
      --pod-cidr string                          A CIDR notation IP range from which to assign pod IPs
      --prow                                     Enable Prow
      --pull-secrets string                      The pull secrets the service account created should have (useful when deploying to your own private registry): provide multiple pull secrets by providing them in a singular block of quotes e.g. --pull-secrets "foo, bar, baz"
      --recreate-existing-draft-repos            Delete existing helm repos used by Jenkins X under ~/draft/packs
      --register-local-helmrepo                  Registers the Jenkins X ChartMuseum registry with your helm client [default false]
      --remote-tiller                            If enabled and we are using tiller for helm then run tiller remotely in the kubernetes cluster. Otherwise we run the tiller process locally. (default true)
  -n, --resource-group-name string               Name of the resource group
      --service-cidr string                      A CIDR notation IP range from which to assign service cluster IPs
      --service-principal string                 Azure AD service principal to use an existing SP
      --skip-auth-secrets-merge                  Skips merging a local git auth yaml file with any pipeline secrets that are found
      --skip-ingress                             Don't install an ingress controller
      --skip-installation                        Provision cluster only, don't install Jenkins X into it
      --skip-login az login                      Skip login if already logged in using az login
      --skip-provider-registration               Skip provider registration
      --skip-resource-group-creation             Skip resource group creation
      --skip-setup-tiller                        Don't setup the Helm Tiller service - lets use whatever tiller is already setup for us.
      --subscription string                      Azure subscription to be used if not default one
      --tags string                              Space-separated tags in 'key[=value]' format. Use '' to clear existing tags.
      --tiller-cluster-role string               The cluster role for Helm's tiller (default "cluster-admin")
      --tiller-namespace string                  The namespace for the Tiller when using a global tiller (default "kube-system")
      --timeout string                           The number of seconds to wait for the helm install to complete (default "6000")
      --tls-acme string                          Used to enable automatic TLS for ingress
      --user-cluster-role string                 The cluster role for the current user to be able to administer helm (default "cluster-admin")
  -u, --user-name string                         Azure user name
      --username string                          The Kubernetes username used to initialise helm. Usually your email address for your Kubernetes account
      --vault                                    Sets up a Hashicorp Vault for storing secrets during installation (supported only for GKE)
      --verbose                                  Enable verbose logging
      --version string                           The specific platform version to install
      --vnet-subnet-id string                    The ID of a subnet in an existing VNet into which to deploy the cluster
      --workspace-resource-id string             The resource ID of an existing Log Analytics Workspace
```

### SEE ALSO

* [jx create cluster](/commands/jx_create_cluster/)	 - Create a new Kubernetes cluster

###### Auto generated by spf13/cobra on 16-Jan-2019
