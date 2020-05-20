---
date: 2020-05-20T00:55:49Z
title: "jx create cluster gke"
slug: jx_create_cluster_gke
url: /commands/jx_create_cluster_gke/
description: list of jx commands
---
## jx create cluster gke

Create a new Kubernetes cluster on GKE: Runs on Google Cloud

### Synopsis

This command creates a new Kubernetes cluster on GKE, installing required local dependencies and provisions the Jenkins X platform 

You can see a demo of this command here: https://jenkins-x.io/demos/create_cluster_gke/

Google Kubernetes Engine is a managed environment for deploying containerized applications. It brings our latest innovations in developer productivity, resource efficiency, automated operations, and open source flexibility to accelerate your time to market. 

Google has been running production workloads in containers for over 15 years, and we build the best of what we learn into Kubernetes, the industry-leading open source container orchestrator which powers Kubernetes Engine.

```
jx create cluster gke [flags]
```

### Examples

```
  jx create cluster gke
```

### Options

```
      --advanced-mode                         Advanced install options. This will prompt for advanced install options
      --azure-acr-subscription string         The Azure subscription under which the specified docker-registry is located
      --buildpack string                      The name of the build pack to use for the Team
      --cleanup-temp-files                    Cleans up any temporary values.yaml used by helm install [default true] (default true)
      --cloud-environment-repo string         Cloud Environments Git repo (default "https://github.com/jenkins-x/cloud-environments")
      --cluster-ipv4-cidr string              The IP address range for the pods in this cluster in CIDR notation (e.g. 10.0.0.0/14)
  -n, --cluster-name string                   The name of this cluster, default is a random generated name
      --config-file string                    Configuration file used for installation
      --default-admin-password string         the default admin password to access Jenkins, Kubernetes Dashboard, ChartMuseum and Nexus
      --default-admin-username string         the default admin username to access Jenkins, Kubernetes Dashboard, ChartMuseum and Nexus (default "admin")
      --default-environment-prefix string     Default environment repo prefix, your Git repos will be of the form 'environment-$prefix-$envName'
  -d, --disk-size string                      Size in GB for node VM boot disks. Defaults to 100GB
      --docker-registry string                The Docker Registry host or host:port which is used when tagging and pushing images. If not specified it defaults to the internal registry unless there is a better provider default (e.g. ECR on AWS/EKS)
      --docker-registry-org string            The Docker Registry organiation/user to create images inside. On GCP this is typically your Google Project ID.
      --domain string                         Domain to expose ingress endpoints.  Example: jenkinsx.io
      --draft-client-only                     Only install draft client
      --enable-autoupgrade                    Sets autoupgrade feature for a cluster's default node-pool(s)
      --enhanced-apis                         Enable enhanced APIs to utilise Container Registry & Cloud Build
      --enhanced-scopes                       Use enhanced Oauth scopes for access to GCS/GCR
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
  -h, --help                                  help for gke
      --image-type string                     The image type for the nodes in the cluster
      --ingress-class string                  Used to set the ingress.class annotation in exposecontroller created ingress
      --ingress-cluster-role string           The cluster role for the Ingress controller (default "cluster-admin")
      --ingress-deployment string             The name of the Ingress controller Deployment (default "jxing-nginx-ingress-controller")
      --ingress-namespace string              The namespace for the Ingress controller (default "kube-system")
      --ingress-service string                The name of the Ingress controller Service (default "jxing-nginx-ingress-controller")
      --install-dependencies                  Enables automatic dependencies installation when required
      --install-only                          Force the install command to fail if there is already an installation. Otherwise lets update the installation
      --kaniko                                Use Kaniko for building docker images
      --keep-exposecontroller-job             Prevents Helm deleting the exposecontroller Job and Pod after running.  Useful for debugging exposecontroller logs but you will need to manually delete the job if you update an environment
  -v, --kubernetes-version string             The Kubernetes version to use for the master and nodes. Defaults to server-specified
      --labels string                         The labels to add to the cluster being created such as 'foo=bar,whatnot=123'. Label names must begin with a lowercase character ([a-z]), end with a lowercase alphanumeric ([a-z0-9]) with dashes (-), and lowercase alphanumeric ([a-z0-9]) between.
      --local-cloud-environment               Ignores default cloud-environment-repo and uses current directory 
      --local-helm-repo-name string           The name of the helm repository for the installed ChartMuseum (default "releases")
      --long-term-storage                     Enable the Long Term Storage option to save logs and other assets into a GCS bucket (supported only for GKE)
      --lts-bucket string                     The bucket to use for Long Term Storage. If the bucket doesn't exist, an attempt will be made to create it, otherwise random naming will be used
  -m, --machine-type string                   The type of machine to use for nodes
      --max-num-nodes string                  The maximum number of nodes to be created in each of the cluster's zones
      --min-num-nodes string                  The minimum number of nodes to be created in each of the cluster's zones
      --namespace string                      The namespace the Jenkins X platform should be installed into (default "jx")
      --network string                        The Compute Engine Network that the cluster will connect to
      --ng                                    Use the Next Generation Jenkins X features like Prow, Tekton, No Tiller, Vault, Dev GitOps
      --no-brew                               Disables brew package manager on MacOS when installing binary dependencies
      --no-default-environments               Disables the creation of the default Staging and Production environments
      --no-gitops-env-apply                   When using GitOps to create the source code for the development environment and installation, don't run 'jx step env apply' to perform the install
      --no-gitops-env-repo                    When using GitOps to create the source code for the development environment this flag disables the creation of a git repository for the source code
      --no-gitops-env-setup                   When using GitOps to install the development environment this flag skips the post-install setup
      --no-gitops-vault                       When using GitOps to create the source code for the development environment this flag disables the creation of a vault
      --no-tiller                             Whether to disable the use of tiller with helm. If disabled we use 'helm template' to generate the YAML from helm charts then we use 'kubectl apply' to install it to avoid using tiller completely. (default true)
      --on-premise                            If installing on an on premise cluster then lets default the 'external-ip' to be the Kubernetes master IP address
      --preemptible                           Use preemptible VMs in the node-pool
  -p, --project-id string                     Google Project ID to create cluster in
      --prow                                  Enable Prow to implement Serverless Jenkins and support ChatOps on Pull Requests
      --recreate-existing-draft-repos         Delete existing helm repos used by Jenkins X under ~/draft/packs
  -r, --region string                         Compute region (e.g. us-central1) for the cluster
      --register-local-helmrepo               Registers the Jenkins X ChartMuseum registry with your helm client [default false]
      --remote-environments                   Indicates you intend Staging and Production environments to run in remote clusters. See https://jenkins-x.io/getting-started/multi-cluster/
      --remote-tiller                         If enabled and we are using tiller for helm then run tiller remotely in the kubernetes cluster. Otherwise we run the tiller process locally. (default true)
      --scope stringArray                     The OAuth scopes to be added to the cluster
      --service-account string                The service account used to run the cluster
      --skip-auth-secrets-merge               Skips merging the secrets from local files with the secrets from Kubernetes cluster
      --skip-cluster-role                     Don't enable cluster admin role for user
      --skip-ingress                          Skips the installation of ingress controller. Note that a ingress controller must already be installed into the cluster in order for the installation to succeed
      --skip-installation                     Provision cluster only, don't install Jenkins X into it
      --skip-login                            Skip Google auth if already logged in via gcloud auth
      --skip-setup-tiller                     Don't setup the Helm Tiller service - lets use whatever tiller is already setup for us.
      --static-jenkins                        Install a static Jenkins master to use as the pipeline engine. Note this functionality is deprecated in favour of running serverless Tekton builds
      --subnetwork string                     The Google Compute Engine subnetwork to which the cluster is connected
      --tekton                                Enables the Tekton pipeline engine (which used to be called knative build pipeline) along with Prow to provide Serverless Jenkins. Otherwise we default to use Knative Build if you enable Prow
      --tiller-cluster-role string            The cluster role for Helm's tiller (default "cluster-admin")
      --tiller-namespace string               The namespace for the Tiller when using a global tiller (default "kube-system")
      --timeout string                        The number of seconds to wait for the helm install to complete (default "6000")
      --urltemplate string                    For ingress; exposers can set the urltemplate to expose
      --use-stackdriver-monitoring            Enable Stackdriver Kubernetes Engine Monitoring (default true)
      --user-cluster-role string              The cluster role for the current user to be able to administer helm (default "cluster-admin")
      --username string                       The Kubernetes username used to initialise helm. Usually your email address for your Kubernetes account
      --vault                                 Sets up a Hashicorp Vault for storing secrets during installation (supported only for GKE)
      --vault-bucket-recreate                 If the vault bucket already exists delete it then create it empty (default true)
      --version string                        The specific platform version to install
      --versions-ref string                   Jenkins X versions Git repository reference (tag, branch, sha etc)
      --versions-repo string                  Jenkins X versions Git repo (default "https://github.com/jenkins-x/jenkins-x-versions.git")
  -z, --zone string                           The compute zone (e.g. us-central1-a) for the cluster
```

### Options inherited from parent commands

```
  -b, --batch-mode   Runs in batch mode without prompting for user input (default true)
      --verbose      Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warning, info, debug, trace
```

### SEE ALSO

* [jx create cluster](/commands/jx_create_cluster/)	 - Create a new Kubernetes cluster

###### Auto generated by spf13/cobra on 20-May-2020
