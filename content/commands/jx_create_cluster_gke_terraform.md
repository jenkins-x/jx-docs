---
date: 2018-12-11T12:13:51Z
title: "jx create cluster gke terraform"
slug: jx_create_cluster_gke_terraform
url: /commands/jx_create_cluster_gke_terraform/
---
## jx create cluster gke terraform

Create a new Kubernetes cluster on GKE using Terraform: Runs on Google Cloud

### Synopsis

This command creates a new Kubernetes cluster on GKE, installing required local dependencies and provisions the Jenkins X platform 

You can see a demo of this command here: https://jenkins-x.io/demos/create_cluster_gke/

Google Kubernetes Engine is a managed environment for deploying containerized applications. It brings our latest innovations in developer productivity, resource efficiency, automated operations, and open source flexibility to accelerate your time to market. 

Google has been running production workloads in containers for over 15 years, and we build the best of what we learn into Kubernetes, the industry-leading open source container orchestrator which powers Kubernetes Engine.

```
jx create cluster gke terraform [flags]
```

### Examples

```
  jx create cluster gke terraform
```

### Options

```
  -b, --batch-mode                          In batch mode the command never prompts for user input
      --buildpack string                    The name of the build pack to use for the Team
      --cleanup-temp-files                  Cleans up any temporary values.yaml used by helm install [default true] (default true)
      --cloud-environment-repo string       Cloud Environments Git repo (default "https://github.com/jenkins-x/cloud-environments")
  -n, --cluster-name string                 The name of this cluster, default is a random generated name
      --default-admin-password string       the default admin password to access Jenkins, Kubernetes Dashboard, Chartmuseum and Nexus
      --default-environment-prefix string   Default environment repo prefix, your Git repos will be of the form 'environment-$prefix-$envName'
  -d, --disk-size string                    Size in GB for node VM boot disks. Defaults to 100GB (default "100")
      --docker-registry string              The Docker Registry host or host:port which is used when tagging and pushing images. If not specified it defaults to the internal registry unless there is a better provider default (e.g. ECR on AWS/EKS)
      --domain string                       Domain to expose ingress endpoints.  Example: jenkinsx.io
      --draft-client-only                   Only install draft client
      --enable-autoupgrade                  Sets autoupgrade feature for a cluster's default node-pool(s)
      --environment-git-owner string        The Git provider organisation to create the environment Git repositories in
      --exposecontroller-pathmode path      The ExposeController path mode for how services should be exposed as URLs. Defaults to using subnets. Use a value of path to use relative paths within the domain host such as when using AWS ELB host names
      --exposer string                      Used to describe which strategy exposecontroller should use to access applications (default "Ingress")
      --external-ip string                  The external IP used to access ingress endpoints from outside the Kubernetes cluster. For bare metal on premise clusters this is often the IP of the Kubernetes master. For cloud installations this is often the external IP of the ingress LoadBalancer.
      --git-api-token string                The Git API token to use for creating new Git repositories
      --git-private                         Create new Git repositories as private
      --git-provider-url string             The Git server URL to create new Git repositories inside (default "https://github.com")
      --git-username string                 The Git username to use for creating new Git repositories
      --gitops                              Sets up the local file system for GitOps so that the current installation can be configured or upgraded at any time via GitOps
      --global-tiller                       Whether or not to use a cluster global tiller (default true)
      --headless                            Enable headless operation if using browser automation
      --helm-client-only                    Only install helm client
      --helm-tls                            Whether to use TLS with helm
      --helm3                               Use helm3 to install Jenkins X which does not use Tiller
  -h, --help                                help for terraform
      --http string                         Toggle creating http or https ingress rules (default "true")
      --ingress-cluster-role string         The cluster role for the Ingress controller (default "cluster-admin")
      --ingress-deployment string           The name of the Ingress controller Deployment (default "jxing-nginx-ingress-controller")
      --ingress-namespace string            The namespace for the Ingress controller (default "kube-system")
      --ingress-service string              The name of the Ingress controller Service (default "jxing-nginx-ingress-controller")
      --install-dependencies                Should any required dependencies be installed automatically
      --install-only                        Force the install command to fail if there is already an installation. Otherwise lets update the installation
      --keep-exposecontroller-job           Prevents Helm deleting the exposecontroller Job and Pod after running.  Useful for debugging exposecontroller logs but you will need to manually delete the job if you update an environment
      --labels string                       The labels to add to the cluster being created such as 'foo=bar,whatnot=123'. Label names must begin with a lowercase character ([a-z]), end with a lowercase alphanumeric ([a-z0-9]) with dashes (-), and lowercase alphanumeric ([a-z0-9]) between.
      --local-cloud-environment             Ignores default cloud-environment-repo and uses current directory 
      --local-helm-repo-name string         The name of the helm repository for the installed Chart Museum (default "releases")
      --log-level string                    Logging level. Possible values - panic, fatal, error, warning, info, debug. (default "info")
  -m, --machine-type string                 The type of machine to use for nodes
      --max-num-nodes string                The maximum number of nodes to be created in each of the cluster's zones
      --min-num-nodes string                The minimum number of nodes to be created in each of the cluster's zones
      --namespace string                    The namespace the Jenkins X platform should be installed into (default "jx")
      --no-brew                             Disables the use of brew on macOS to install or upgrade command line dependencies
      --no-default-environments             Disables the creation of the default Staging and Production environments
      --no-gitops-env-apply                 When using GitOps to create the source code for the development environment and installation, don't run 'jx step env apply' to perform the install
      --no-gitops-env-repo                  When using GitOps to create the source code for the development environment this flag disables the creation of a git repository for the source code
      --no-gitops-vault                     When using GitOps to create the source code for the development environment this flag disables the creation of a vault
      --no-tiller                           Whether to disable the use of tiller with helm. If disabled we use 'helm template' to generate the YAML from helm charts then we use 'kubectl apply' to install it to avoid using tiller completely.
      --on-premise                          If installing on an on premise cluster then lets default the 'external-ip' to be the Kubernetes master IP address
  -p, --project-id string                   Google Project ID to create cluster in
      --prow                                Enable Prow
      --pull-secrets string                 The pull secrets the service account created should have (useful when deploying to your own private registry): provide multiple pull secrets by providing them in a singular block of quotes e.g. --pull-secrets "foo, bar, baz"
      --recreate-existing-draft-repos       Delete existing helm repos used by Jenkins X under ~/draft/packs
      --register-local-helmrepo             Registers the Jenkins X ChartMuseum registry with your helm client [default false]
      --remote-tiller                       If enabled and we are using tiller for helm then run tiller remotely in the kubernetes cluster. Otherwise we run the tiller process locally. (default true)
      --service-account string              Use a service account to login to GCE
      --skip-auth-secrets-merge             Skips merging a local git auth yaml file with any pipeline secrets that are found
      --skip-ingress                        Don't install an ingress controller
      --skip-installation                   Provision cluster only, don't install Jenkins X into it
      --skip-login                          Skip Google auth if already logged in via gcloud auth
      --skip-setup-tiller                   Don't setup the Helm Tiller service - lets use whatever tiller is already setup for us.
      --tiller-cluster-role string          The cluster role for Helm's tiller (default "cluster-admin")
      --tiller-namespace string             The namespace for the Tiller when using a global tiller (default "kube-system")
      --timeout string                      The number of seconds to wait for the helm install to complete (default "6000")
      --tls-acme string                     Used to enable automatic TLS for ingress
      --user-cluster-role string            The cluster role for the current user to be able to administer helm (default "cluster-admin")
      --username string                     The Kubernetes username used to initialise helm. Usually your email address for your Kubernetes account
      --vault                               Sets up a Hashicorp Vault for storing secrets during installation
      --verbose                             Enable verbose logging
      --version string                      The specific platform version to install
  -z, --zone string                         The compute zone (e.g. us-central1-a) for the cluster
```

### SEE ALSO

* [jx create cluster gke](/commands/jx_create_cluster_gke/)	 - Create a new Kubernetes cluster on GKE: Runs on Google Cloud

###### Auto generated by spf13/cobra on 11-Dec-2018
