---
date: 2020-05-20T00:55:49Z
title: "jx create cluster iks"
slug: jx_create_cluster_iks
url: /commands/jx_create_cluster_iks/
description: list of jx commands
---
## jx create cluster iks

Create a new kubernetes cluster on IBM Cloud Kubernetes Services

### Synopsis

This command creates a new kubernetes cluster on IKS, installing required local dependencies and provisions the Jenkins X platform 

IBM® Cloud Kubernetes Service delivers powerful tools by combining Docker containers, the Kubernetes technology, an intuitive user experience, and built-in security and isolation to automate the deployment, operation, scaling, and monitoring of containerized apps in a cluster of compute hosts. 

Important: In order to create a "standard cluster" required for jenkins-x, you must have a Trial, Pay-As-You-Go, or Subscription IBM Cloud account (https://console.bluemix.net/registration/). "Free cluster"s are currently not supported.

```
jx create cluster iks [flags]
```

### Examples

```
  jx create cluster iks
```

### Options

```
  -c, --account string                        Account
      --advanced-mode                         Advanced install options. This will prompt for advanced install options
      --apikey string                         The IBM Cloud API Key.
      --azure-acr-subscription string         The Azure subscription under which the specified docker-registry is located
      --buildpack string                      The name of the build pack to use for the Team
      --cleanup-temp-files                    Cleans up any temporary values.yaml used by helm install [default true] (default true)
      --cloud-environment-repo string         Cloud Environments Git repo (default "https://github.com/jenkins-x/cloud-environments")
      --config-file string                    Configuration file used for installation
      --create-private-vlan                   Automatically create private vlan (default 'true')
      --create-public-vlan                    Automatically create public vlan (default 'true')
      --default-admin-password string         the default admin password to access Jenkins, Kubernetes Dashboard, ChartMuseum and Nexus
      --default-admin-username string         the default admin username to access Jenkins, Kubernetes Dashboard, ChartMuseum and Nexus (default "admin")
      --default-environment-prefix string     Default environment repo prefix, your Git repos will be of the form 'environment-$prefix-$envName'
      --disk-encrypt                          Optional: Disable encryption on a worker node. (default true)
      --docker-registry string                The Docker Registry host or host:port which is used when tagging and pushing images. If not specified it defaults to the internal registry unless there is a better provider default (e.g. ECR on AWS/EKS)
      --docker-registry-org string            The Docker Registry organiation/user to create images inside. On GCP this is typically your Google Project ID.
      --domain string                         Domain to expose ingress endpoints.  Example: jenkinsx.io
      --draft-client-only                     Only install draft client
      --environment-git-owner string          The Git provider organisation to create the environment Git repositories in
      --exposecontroller-pathmode path        The ExposeController path mode for how services should be exposed as URLs. Defaults to using subnets. Use a value of path to use relative paths within the domain host such as when using AWS ELB host names
      --exposecontroller-urltemplate string   The ExposeController urltemplate for how services should be exposed as URLs. Defaults to being empty, which in turn defaults to "{{.Service}}.{{.Namespace}}.{{.Domain}}".
      --exposer string                        Used to describe which strategy exposecontroller should use to access applications (default "Ingress")
      --external-dns                          Installs external-dns into the cluster. ExternalDNS manages service DNS records for your cluster, providing you've setup your domain record
      --external-ip string                    The external IP used to access ingress endpoints from outside the Kubernetes cluster. For bare metal on premise clusters this is often the IP of the Kubernetes master. For cloud installations this is often the external IP of the ingress LoadBalancer.
      --git-api-token string                  The Git API token to use for creating new Git repositories
      --git-provider-kind string              Kind of Git server. If not specified, kind of server will be autodetected from Git provider URL. Possible values: bitbucketcloud, bitbucketserver, gitea, gitlab, github, fakegit
      --git-provider-url string               The Git server URL to create new Git repositories inside (default "https://github.com")
      --git-public                            Create new Git repositories as public
      --git-username string                   The Git username to use for creating new Git repositories
      --gitops                                Creates a git repository for the Dev environment to manage the installation, configuration, upgrade and addition of Apps in Jenkins X all via GitOps
      --global-tiller                         Whether or not to use a cluster global tiller (default true)
      --helm-client-only                      Only install helm client
      --helm-tls                              Whether to use TLS with helm
      --helm3                                 Use helm3 to install Jenkins X which does not use Tiller
  -h, --help                                  help for iks
      --ingress-class string                  Used to set the ingress.class annotation in exposecontroller created ingress
      --ingress-cluster-role string           The cluster role for the Ingress controller (default "cluster-admin")
      --ingress-deployment string             The name of the Ingress controller Deployment (default "jxing-nginx-ingress-controller")
      --ingress-namespace string              The namespace for the Ingress controller (default "kube-system")
      --ingress-service string                The name of the Ingress controller Service (default "jxing-nginx-ingress-controller")
      --install-dependencies                  Enables automatic dependencies installation when required
      --install-only                          Force the install command to fail if there is already an installation. Otherwise lets update the installation
      --isolation string                      The level of hardware isolation for your worker node. Use 'private' to have available physical resources dedicated to you only, or 'public' to allow physical resources to be shared with other IBM customers. For IBM Cloud Public accounts, the default value is public. (default "public")
      --kaniko                                Use Kaniko for building docker images
      --keep-exposecontroller-job             Prevents Helm deleting the exposecontroller Job and Pod after running.  Useful for debugging exposecontroller logs but you will need to manually delete the job if you update an environment
  -k, --kube-version string                   Specify the Kubernetes version, including at least the major.minor version. If you do not include this flag, the default version is used. To see available versions, run ‘ibmcloud ks kube-versions’.
      --local-cloud-environment               Ignores default cloud-environment-repo and uses current directory 
      --local-helm-repo-name string           The name of the helm repository for the installed ChartMuseum (default "releases")
  -u, --login string                          Username
      --long-term-storage                     Enable the Long Term Storage option to save logs and other assets into a GCS bucket (supported only for GKE)
      --lts-bucket string                     The bucket to use for Long Term Storage. If the bucket doesn't exist, an attempt will be made to create it, otherwise random naming will be used
  -m, --machine-type string                   The machine type of the worker node. To see available machine types, run 'ibmcloud ks machine-types --zone <zone name>'. Default is 'b2c.4x16', 4 cores CPU, 16GB Memory
  -n, --name string                           Set the name of the cluster that will be created.
      --namespace string                      The namespace the Jenkins X platform should be installed into (default "jx")
      --ng                                    Use the Next Generation Jenkins X features like Prow, Tekton, No Tiller, Vault, Dev GitOps
      --no-brew                               Disables brew package manager on MacOS when installing binary dependencies
      --no-default-environments               Disables the creation of the default Staging and Production environments
      --no-gitops-env-apply                   When using GitOps to create the source code for the development environment and installation, don't run 'jx step env apply' to perform the install
      --no-gitops-env-repo                    When using GitOps to create the source code for the development environment this flag disables the creation of a git repository for the source code
      --no-gitops-env-setup                   When using GitOps to install the development environment this flag skips the post-install setup
      --no-gitops-vault                       When using GitOps to create the source code for the development environment this flag disables the creation of a vault
      --no-subnet                             Optional: Prevent the creation of a portable subnet when creating the cluster. By default, both a public and a private portable subnet are created on the associated VLAN, and this flag prevents that behavior. To add a subnet to the cluster later, run 'ibmcloud ks cluster-subnet-add'.
      --no-tiller                             Whether to disable the use of tiller with helm. If disabled we use 'helm template' to generate the YAML from helm charts then we use 'kubectl apply' to install it to avoid using tiller completely. (default true)
      --on-premise                            If installing on an on premise cluster then lets default the 'external-ip' to be the Kubernetes master IP address
  -p, --password string                       Password
      --private-only                          Use this flag to prevent a public VLAN from being created. Required only when you specify the ‘--private-vlan’ flag without specifying the ‘--public-vlan’ flag.
      --private-vlan string                   Conditional: Specify the ID of the private VLAN. To see available VLANs, run 'ibmcloud ks vlans --zone <zone name>'. If you do not have a private VLAN yet, do not specify this option because one will be automatically created for you. When you specify a private VLAN, you must also specify either the ‘--public-vlan’ flag or the ‘--private-only’ flag.
      --prow                                  Enable Prow to implement Serverless Jenkins and support ChatOps on Pull Requests
      --public-vlan string                    Conditional: Specify the ID of the public VLAN. To see available VLANs, run 'ibmcloud ks vlans --zone <zone name>'. If you do not have a public VLAN yet, do not specify this option because one will be automatically created for you.
      --recreate-existing-draft-repos         Delete existing helm repos used by Jenkins X under ~/draft/packs
  -r, --region string                         The IBM Cloud Region. Default is 'us-east'
      --register-local-helmrepo               Registers the Jenkins X ChartMuseum registry with your helm client [default false]
      --remote-environments                   Indicates you intend Staging and Production environments to run in remote clusters. See https://jenkins-x.io/getting-started/multi-cluster/
      --remote-tiller                         If enabled and we are using tiller for helm then run tiller remotely in the kubernetes cluster. Otherwise we run the tiller process locally. (default true)
      --skip-auth-secrets-merge               Skips merging the secrets from local files with the secrets from Kubernetes cluster
      --skip-cluster-role                     Don't enable cluster admin role for user
      --skip-ingress                          Skips the installation of ingress controller. Note that a ingress controller must already be installed into the cluster in order for the installation to succeed
      --skip-installation                     Provision cluster only, don't install Jenkins X into it
      --skip-login ibmcloud login             Skip login if already logged in using ibmcloud login
      --skip-setup-tiller                     Don't setup the Helm Tiller service - lets use whatever tiller is already setup for us.
      --sso                                   SSO Passcode. See run 'ibmcloud login --sso'
      --static-jenkins                        Install a static Jenkins master to use as the pipeline engine. Note this functionality is deprecated in favour of running serverless Tekton builds
      --tekton                                Enables the Tekton pipeline engine (which used to be called knative build pipeline) along with Prow to provide Serverless Jenkins. Otherwise we default to use Knative Build if you enable Prow
      --tiller-cluster-role string            The cluster role for Helm's tiller (default "cluster-admin")
      --tiller-namespace string               The namespace for the Tiller when using a global tiller (default "kube-system")
      --timeout string                        The number of seconds to wait for the helm install to complete (default "6000")
      --trusted                               Optional: Enable trusted cluster feature.
      --urltemplate string                    For ingress; exposers can set the urltemplate to expose
      --user-cluster-role string              The cluster role for the current user to be able to administer helm (default "cluster-admin")
      --username string                       The Kubernetes username used to initialise helm. Usually your email address for your Kubernetes account
      --vault                                 Sets up a Hashicorp Vault for storing secrets during installation (supported only for GKE)
      --vault-bucket-recreate                 If the vault bucket already exists delete it then create it empty (default true)
      --version string                        The specific platform version to install
      --versions-ref string                   Jenkins X versions Git repository reference (tag, branch, sha etc)
      --versions-repo string                  Jenkins X versions Git repo (default "https://github.com/jenkins-x/jenkins-x-versions.git")
      --workers string                        The number of cluster worker nodes. Defaults to 3.
  -z, --zone string                           Specify the zone where you want to create the cluster, the options depend on what region that you are logged in to. To see available zones, run 'ibmcloud ks zones'. Default is 'wdc07'
```

### Options inherited from parent commands

```
  -b, --batch-mode   Runs in batch mode without prompting for user input (default true)
      --verbose      Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warning, info, debug, trace
```

### SEE ALSO

* [jx create cluster](/commands/jx_create_cluster/)	 - Create a new Kubernetes cluster

###### Auto generated by spf13/cobra on 20-May-2020
