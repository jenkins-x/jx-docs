---
date: 2019-10-09T02:28:14Z
title: "jx create cluster aws"
slug: jx_create_cluster_aws
url: /commands/jx_create_cluster_aws/
---
## jx create cluster aws

Create a new Kubernetes cluster on AWS with kops

### Synopsis

This command creates a new Kubernetes cluster on Amazon Web Service (AWS) using kops, installing required local dependencies and provisions the Jenkins X platform. 

AWS manages your hosted Kubernetes environment via kops, making it quick and easy to deploy and manage containerized applications without container orchestration expertise. It also eliminates the burden of ongoing operations and maintenance by provisioning, upgrading, and scaling resources on demand, without taking your applications offline.

```
jx create cluster aws [flags]
```

### Examples

```
  # to create a new Kubernetes cluster with Jenkins X in your default zones (from $AWS_AVAILABILITY_ZONES)
  jx create cluster aws
  
  # to specify the zones
  jx create cluster aws --zones us-west-2a,us-west-2b,us-west-2c
  
  # to output terraform configuration
  jx create cluster aws --terraform /Users/jx/jx-infra
```

### Options

```
      --advanced-mode                         Advanced install options. This will prompt for advanced install options
      --azure-acr-subscription string         The Azure subscription under which the specified docker-registry is located
      --buildpack string                      The name of the build pack to use for the Team
      --cleanup-temp-files                    Cleans up any temporary values.yaml used by helm install [default true] (default true)
      --cloud-environment-repo string         Cloud Environments Git repo (default "https://github.com/jenkins-x/cloud-environments")
      --cloudbees-auth string                 Auth used when setting up a letter/tenant cluster, format: 'username:password'
      --cloudbees-domain string               When setting up a letter/tenant cluster, this creates a tenant cluster on the cloudbees domain which is retrieved via the required URL
  -n, --cluster-name string                   The name of this cluster. (default "aws1")
      --config-file string                    Configuration file used for installation
      --default-admin-password string         the default admin password to access Jenkins, Kubernetes Dashboard, ChartMuseum and Nexus
      --default-admin-username string         the default admin username to access Jenkins, Kubernetes Dashboard, ChartMuseum and Nexus (default "admin")
      --default-environment-prefix string     Default environment repo prefix, your Git repos will be of the form 'environment-$prefix-$envName'
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
  -h, --help                                  help for aws
      --ingress-class string                  Used to set the ingress.class annotation in exposecontroller created ingress
      --ingress-cluster-role string           The cluster role for the Ingress controller (default "cluster-admin")
      --ingress-deployment string             The name of the Ingress controller Deployment (default "jxing-nginx-ingress-controller")
      --ingress-namespace string              The namespace for the Ingress controller (default "kube-system")
      --ingress-service string                The name of the Ingress controller Service (default "jxing-nginx-ingress-controller")
      --insecure-registry string              The insecure Docker registries to allow (default "100.64.0.0/10")
      --install-dependencies                  Enables automatic dependencies installation when required
      --install-only                          Force the install command to fail if there is already an installation. Otherwise lets update the installation
      --kaniko                                Use Kaniko for building docker images
      --keep-exposecontroller-job             Prevents Helm deleting the exposecontroller Job and Pod after running.  Useful for debugging exposecontroller logs but you will need to manually delete the job if you update an environment
      --knative-build                         Note this option is deprecated now in favour of tekton. If specified this will keep using the old knative build with Prow instead of the strategic tekton
  -v, --kubernetes-version string             Kubernetes version
      --local-cloud-environment               Ignores default cloud-environment-repo and uses current directory 
      --local-helm-repo-name string           The name of the helm repository for the installed ChartMuseum (default "releases")
      --long-term-storage                     Enable the Long Term Storage option to save logs and other assets into a GCS bucket (supported only for GKE)
      --lts-bucket string                     The bucket to use for Long Term Storage. If the bucket doesn't exist, an attempt will be made to create it, otherwise random naming will be used
      --master-size string                    The size of a master in the kops created cluster.
      --namespace string                      The namespace the Jenkins X platform should be installed into (default "jx")
      --ng                                    Use the Next Generation Jenkins X features like Prow, Tekton, No Tiller, Vault, Dev GitOps
      --no-brew                               Disables brew package manager on MacOS when installing binary dependencies
      --no-default-environments               Disables the creation of the default Staging and Production environments
      --no-gitops-env-apply                   When using GitOps to create the source code for the development environment and installation, don't run 'jx step env apply' to perform the install
      --no-gitops-env-repo                    When using GitOps to create the source code for the development environment this flag disables the creation of a git repository for the source code
      --no-gitops-env-setup                   When using GitOps to install the development environment this flag skips the post-install setup
      --no-gitops-vault                       When using GitOps to create the source code for the development environment this flag disables the creation of a vault
      --no-tiller                             Whether to disable the use of tiller with helm. If disabled we use 'helm template' to generate the YAML from helm charts then we use 'kubectl apply' to install it to avoid using tiller completely. (default true)
      --node-size string                      The size of a node in the kops created cluster.
  -o, --nodes string                          node count
      --on-premise                            If installing on an on premise cluster then lets default the 'external-ip' to be the Kubernetes master IP address
      --profile string                        AWS profile to use.
      --prow                                  Enable Prow to implement Serverless Jenkins and support ChatOps on Pull Requests
  -r, --rbac                                  whether to enable RBAC on the Kubernetes cluster (default true)
      --recreate-existing-draft-repos         Delete existing helm repos used by Jenkins X under ~/draft/packs
      --region string                         AWS region to use. Default: us-west-2
      --register-local-helmrepo               Registers the Jenkins X ChartMuseum registry with your helm client [default false]
      --remote-environments                   Indicates you intend Staging and Production environments to run in remote clusters. See https://jenkins-x.io/getting-started/multi-cluster/
      --remote-tiller                         If enabled and we are using tiller for helm then run tiller remotely in the kubernetes cluster. Otherwise we run the tiller process locally. (default true)
      --skip-auth-secrets-merge               Skips merging the secrets from local files with the secrets from Kubernetes cluster
      --skip-cluster-role                     Don't enable cluster admin role for user
      --skip-ingress                          Skips the installation of ingress controller. Note that a ingress controller must already be installed into the cluster in order for the installation to succeed
      --skip-installation                     Provision cluster only, don't install Jenkins X into it
      --skip-setup-tiller                     Don't setup the Helm Tiller service - lets use whatever tiller is already setup for us.
      --spotinst                              Whether to enable Spotinst integration
      --spotinst-ocean                        Whether to use Spotinst Ocean instance groups
      --ssh-public-key string                 SSH public key to use for nodes (default "~/.ssh/id_rsa.pub").
      --state string                          The S3 bucket used to store the state of the cluster.
      --static-jenkins                        Install a static Jenkins master to use as the pipeline engine. Note this functionality is deprecated in favour of running serverless Tekton builds
      --tags string                           A list of KV pairs used to tag all instance groups in AWS (eg "Owner=John Doe,Team=Some Team").
      --tekton                                Enables the Tekton pipeline engine (which used to be called knative build pipeline) along with Prow to provide Serverless Jenkins. Otherwise we default to use Knative Build if you enable Prow
  -t, --terraform string                      The directory to save Terraform configuration.
      --tiller-cluster-role string            The cluster role for Helm's tiller (default "cluster-admin")
      --tiller-namespace string               The namespace for the Tiller when using a global tiller (default "kube-system")
      --timeout string                        The number of seconds to wait for the helm install to complete (default "6000")
      --urltemplate string                    For ingress; exposers can set the urltemplate to expose
      --user-cluster-role string              The cluster role for the current user to be able to administer helm (default "cluster-admin")
      --username string                       The Kubernetes username used to initialise helm. Usually your email address for your Kubernetes account
      --vault                                 Sets up a Hashicorp Vault for storing secrets during installation (supported only for GKE)
      --vault-bucket-recreate                 If the vault bucket already exists delete it then create it empty (default true)
      --version string                        The specific platform version to install
      --versions-ref string                   Jenkins X versions Git repository reference (tag, branch, sha etc)
      --versions-repo string                  Jenkins X versions Git repo (default "https://github.com/jenkins-x/jenkins-x-versions.git")
  -z, --zones string                          Availability Zones. Defaults to $AWS_AVAILABILITY_ZONES
```

### Options inherited from parent commands

```
  -b, --batch-mode   Runs in batch mode without prompting for user input (default true)
      --verbose      Enables verbose output
```

### SEE ALSO

* [jx create cluster](/commands/jx_create_cluster/)	 - Create a new Kubernetes cluster

###### Auto generated by spf13/cobra on 9-Oct-2019
