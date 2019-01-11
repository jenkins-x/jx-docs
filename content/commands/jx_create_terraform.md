---
date: 2019-01-11T18:20:02Z
title: "jx create terraform"
slug: jx_create_terraform
url: /commands/jx_create_terraform/
---
## jx create terraform

Creates a Jenkins X Terraform plan

### Synopsis

Creates a Jenkins X Terraform plan

```
jx create terraform [flags]
```

### Examples

```
  jx create terraform
  
  # to specify the clusters via flags
  jx create terraform -c dev=gke -c stage=gke -c prod=gke
```

### Options

```
  -b, --batch-mode                             In batch mode the command never prompts for user input
      --buildpack string                       The name of the build pack to use for the Team
      --cleanup-temp-files                     Cleans up any temporary values.yaml used by helm install [default true] (default true)
      --cloud-environment-repo string          Cloud Environments Git repo (default "https://github.com/jenkins-x/cloud-environments")
  -c, --cluster stringArray                    Name and Kubernetes provider (gke, aks, eks) of clusters to be created in the form --cluster foo=gke
      --default-admin-password string          the default admin password to access Jenkins, Kubernetes Dashboard, ChartMuseum and Nexus
      --default-environment-prefix string      Default environment repo prefix, your Git repos will be of the form 'environment-$prefix-$envName'
      --docker-registry string                 The Docker Registry host or host:port which is used when tagging and pushing images. If not specified it defaults to the internal registry unless there is a better provider default (e.g. ECR on AWS/EKS)
      --domain string                          Domain to expose ingress endpoints.  Example: jenkinsx.io
      --draft-client-only                      Only install draft client
      --environment-git-owner string           The Git provider organisation to create the environment Git repositories in
      --exposecontroller-pathmode path         The ExposeController path mode for how services should be exposed as URLs. Defaults to using subnets. Use a value of path to use relative paths within the domain host such as when using AWS ELB host names
      --exposer string                         Used to describe which strategy exposecontroller should use to access applications (default "Ingress")
      --external-ip string                     The external IP used to access ingress endpoints from outside the Kubernetes cluster. For bare metal on premise clusters this is often the IP of the Kubernetes master. For cloud installations this is often the external IP of the ingress LoadBalancer.
  -f, --fork-git-repo string                   The Git repository used as the fork when creating new Organisation Git repos (default "https://github.com/jenkins-x/default-organisation.git")
      --git-api-token string                   The Git API token to use for creating new Git repositories
      --git-private                            Create new Git repositories as private
      --git-provider-kind string               Kind of Git server. If not specified, kind of server will be autodetected from Git provider URL. Possible values: bitbucketcloud, bitbucketserver, gitea, gitlab, github, fakegit
      --git-provider-url string                The Git server URL to create new Git repositories inside (default "https://github.com")
      --git-username string                    The Git username to use for creating new Git repositories
      --gitops                                 Sets up the local file system for GitOps so that the current installation can be configured or upgraded at any time via GitOps
      --gke-disk-size string                   Size in GB for node VM boot disks. Defaults to 100GB (default "100")
      --gke-enable-autorepair                  Sets autorepair feature for a cluster's default node-pool(s) (default true)
      --gke-enable-autoupgrade                 Sets autoupgrade feature for a cluster's default node-pool(s)
      --gke-machine-type string                The type of machine to use for nodes
      --gke-max-num-nodes string               The maximum number of nodes to be created in each of the cluster's zones
      --gke-min-num-nodes string               The minimum number of nodes to be created in each of the cluster's zones
      --gke-project-id string                  Google Project ID to create cluster in
      --gke-service-account string             The service account to use to connect to GKE
      --gke-zone string                        The compute zone (e.g. us-central1-a) for the cluster
      --global-tiller                          Whether or not to use a cluster global tiller (default true)
      --headless                               Enable headless operation if using browser automation
      --helm-client-only                       Only install helm client
      --helm-tls                               Whether to use TLS with helm
      --helm3                                  Use helm3 to install Jenkins X which does not use Tiller
  -h, --help                                   help for terraform
      --http string                            Toggle creating http or https ingress rules (default "true")
      --ignore-terraform-warnings              Ignore any warnings about the Terraform plan being potentially destructive
      --ingress-cluster-role string            The cluster role for the Ingress controller (default "cluster-admin")
      --ingress-deployment string              The name of the Ingress controller Deployment (default "jxing-nginx-ingress-controller")
      --ingress-namespace string               The namespace for the Ingress controller (default "kube-system")
      --ingress-service string                 The name of the Ingress controller Service (default "jxing-nginx-ingress-controller")
      --install-dependencies                   Should any required dependencies be installed automatically
      --install-only                           Force the install command to fail if there is already an installation. Otherwise lets update the installation
      --jx-environment string                  The cluster name to install jx inside (default "dev")
      --keep-exposecontroller-job              Prevents Helm deleting the exposecontroller Job and Pod after running.  Useful for debugging exposecontroller logs but you will need to manually delete the job if you update an environment
      --local-cloud-environment                Ignores default cloud-environment-repo and uses current directory 
      --local-helm-repo-name string            The name of the helm repository for the installed ChartMuseum (default "releases")
      --local-organisation-repository string   Rather than cloning from a remote Git server, the local directory to use for the organisational folder
      --log-level string                       Logging level. Possible values - panic, fatal, error, warning, info, debug. (default "info")
      --namespace string                       The namespace the Jenkins X platform should be installed into (default "jx")
      --no-brew                                Disables the use of brew on macOS to install or upgrade command line dependencies
      --no-default-environments                Disables the creation of the default Staging and Production environments
      --no-gitops-env-apply                    When using GitOps to create the source code for the development environment and installation, don't run 'jx step env apply' to perform the install
      --no-gitops-env-repo                     When using GitOps to create the source code for the development environment this flag disables the creation of a git repository for the source code
      --no-gitops-vault                        When using GitOps to create the source code for the development environment this flag disables the creation of a vault
      --no-tiller                              Whether to disable the use of tiller with helm. If disabled we use 'helm template' to generate the YAML from helm charts then we use 'kubectl apply' to install it to avoid using tiller completely.
      --on-premise                             If installing on an on premise cluster then lets default the 'external-ip' to be the Kubernetes master IP address
  -o, --organisation-name string               The organisation name that will be used as the Git repo containing cluster details, the repo will be organisation-<org name>
      --prow                                   Enable Prow
      --pull-secrets string                    The pull secrets the service account created should have (useful when deploying to your own private registry): provide multiple pull secrets by providing them in a singular block of quotes e.g. --pull-secrets "foo, bar, baz"
      --recreate-existing-draft-repos          Delete existing helm repos used by Jenkins X under ~/draft/packs
      --register-local-helmrepo                Registers the Jenkins X ChartMuseum registry with your helm client [default false]
      --remote-tiller                          If enabled and we are using tiller for helm then run tiller remotely in the kubernetes cluster. Otherwise we run the tiller process locally. (default true)
      --skip-auth-secrets-merge                Skips merging a local git auth yaml file with any pipeline secrets that are found
      --skip-ingress                           Don't install an ingress controller
      --skip-login                             Skip Google auth if already logged in via gcloud auth
      --skip-setup-tiller                      Don't setup the Helm Tiller service - lets use whatever tiller is already setup for us.
      --skip-terraform-apply                   Skip applying the generated Terraform plans
      --tiller-cluster-role string             The cluster role for Helm's tiller (default "cluster-admin")
      --tiller-namespace string                The namespace for the Tiller when using a global tiller (default "kube-system")
      --timeout string                         The number of seconds to wait for the helm install to complete (default "6000")
      --tls-acme string                        Used to enable automatic TLS for ingress
      --user-cluster-role string               The cluster role for the current user to be able to administer helm (default "cluster-admin")
      --username string                        The Kubernetes username used to initialise helm. Usually your email address for your Kubernetes account
      --vault                                  Sets up a Hashicorp Vault for storing secrets during installation (supported only for GKE)
      --verbose                                Enable verbose logging
      --version string                         The specific platform version to install
```

### SEE ALSO

* [jx create](/commands/jx_create/)	 - Create a new resource

###### Auto generated by spf13/cobra on 11-Jan-2019
