---
date: 2019-01-22T22:19:15Z
title: "jx create cluster oke"
slug: jx_create_cluster_oke
url: /commands/jx_create_cluster_oke/
---
## jx create cluster oke

Create a new Kubernetes cluster on OKE: Runs on Oracle Cloud

### Synopsis

This command creates a new Kubernetes cluster on OKE, installs required local dependencies and provisions the Jenkins X platform 

    Please add your $HOME/bin to $PATH otherwise jx will have issue invoking OCI CLI command. If you have already
  
installed OCI CLI, please make sure it is in $PATH. 

Oracle Cloud Infrastructure Container Engine for Kubernetes is a fully-managed, scalable, and highly available service that you can use to deploy your containerized applications to the cloud. 

Oracle build the best of what we learn into Kubernetes, the industry-leading open source container orchestrator which powers Kubernetes Engine.

```
jx create cluster oke [flags]
```

### Examples

```
  jx create cluster oke
```

### Options

```
  -b, --batch-mode                          In batch mode the command never prompts for user input
      --buildpack string                    The name of the build pack to use for the Team
      --cleanup-temp-files                  Cleans up any temporary values.yaml used by helm install [default true] (default true)
      --cloud-environment-repo string       Cloud Environments Git repo (default "https://github.com/jenkins-x/cloud-environments")
      --clusterMaxWaitSeconds string        The maximum time to wait for the work request to reach the state defined by --wait-for-state. Defaults to 1200 seconds.
      --clusterWaitIntervalSeconds string   Check every --wait-interval-seconds to see whether the work request to see if it has reached the state defined by --wait-for-state.
      --compartmentId string                The OCID of the compartment in which to create the cluster.
      --default-admin-password string       the default admin password to access Jenkins, Kubernetes Dashboard, ChartMuseum and Nexus
      --default-environment-prefix string   Default environment repo prefix, your Git repos will be of the form 'environment-$prefix-$envName'
      --docker-registry string              The Docker Registry host or host:port which is used when tagging and pushing images. If not specified it defaults to the internal registry unless there is a better provider default (e.g. ECR on AWS/EKS)
      --domain string                       Domain to expose ingress endpoints.  Example: jenkinsx.io
      --draft-client-only                   Only install draft client
      --endpoint string                     Endpoint for the environment.
      --environment-git-owner string        The Git provider organisation to create the environment Git repositories in
      --exposecontroller-pathmode path      The ExposeController path mode for how services should be exposed as URLs. Defaults to using subnets. Use a value of path to use relative paths within the domain host such as when using AWS ELB host names
      --exposer string                      Used to describe which strategy exposecontroller should use to access applications (default "Ingress")
      --external-ip string                  The external IP used to access ingress endpoints from outside the Kubernetes cluster. For bare metal on premise clusters this is often the IP of the Kubernetes master. For cloud installations this is often the external IP of the ingress LoadBalancer.
      --git-api-token string                The Git API token to use for creating new Git repositories
      --git-private                         Create new Git repositories as private
      --git-provider-kind string            Kind of Git server. If not specified, kind of server will be autodetected from Git provider URL. Possible values: bitbucketcloud, bitbucketserver, gitea, gitlab, github, fakegit
      --git-provider-url string             The Git server URL to create new Git repositories inside (default "https://github.com")
      --git-username string                 The Git username to use for creating new Git repositories
      --gitops                              Sets up the local file system for GitOps so that the current installation can be configured or upgraded at any time via GitOps
      --global-tiller                       Whether or not to use a cluster global tiller (default true)
      --headless                            Enable headless operation if using browser automation
      --helm-client-only                    Only install helm client
      --helm-tls                            Whether to use TLS with helm
      --helm3                               Use helm3 to install Jenkins X which does not use Tiller
  -h, --help                                help for oke
      --http string                         Toggle creating http or https ingress rules (default "true")
      --ingress-cluster-role string         The cluster role for the Ingress controller (default "cluster-admin")
      --ingress-deployment string           The name of the Ingress controller Deployment (default "jxing-nginx-ingress-controller")
      --ingress-namespace string            The namespace for the Ingress controller (default "kube-system")
      --ingress-service string              The name of the Ingress controller Service (default "jxing-nginx-ingress-controller")
      --initialNodeLabels string            A list of key/value pairs to add to nodes after they join the Kubernetes cluster.
      --install-dependencies                Should any required dependencies be installed automatically
      --install-only                        Force the install command to fail if there is already an installation. Otherwise lets update the installation
      --isKubernetesDashboardEnabled        Is KubernetesDashboard Enabled. (default true)
      --isTillerEnabled                     Is Tiller Enabled.
      --keep-exposecontroller-job           Prevents Helm deleting the exposecontroller Job and Pod after running.  Useful for debugging exposecontroller logs but you will need to manually delete the job if you update an environment
      --kubernetesVersion string            The version of Kubernetes to install into the cluster masters.
      --local-cloud-environment             Ignores default cloud-environment-repo and uses current directory 
      --local-helm-repo-name string         The name of the helm repository for the installed ChartMuseum (default "releases")
      --log-level string                    Logging level. Possible values - panic, fatal, error, warning, info, debug. (default "info")
      --name string                         The name of the cluster. Avoid entering confidential information.
      --namespace string                    The namespace the Jenkins X platform should be installed into (default "jx")
      --no-brew                             Disables the use of brew on macOS to install or upgrade command line dependencies
      --no-default-environments             Disables the creation of the default Staging and Production environments
      --no-gitops-env-apply                 When using GitOps to create the source code for the development environment and installation, don't run 'jx step env apply' to perform the install
      --no-gitops-env-repo                  When using GitOps to create the source code for the development environment this flag disables the creation of a git repository for the source code
      --no-gitops-vault                     When using GitOps to create the source code for the development environment this flag disables the creation of a vault
      --no-tiller                           Whether to disable the use of tiller with helm. If disabled we use 'helm template' to generate the YAML from helm charts then we use 'kubectl apply' to install it to avoid using tiller completely.
      --nodeImageName string                The name of the image running on the nodes in the node pool.
      --nodePoolName string                 The name of the node pool.
      --nodePoolSubnetIds string            The OCIDs of the subnets in which to place nodes for this node pool.
      --nodeShape string                    The name of the node shape of the nodes in the node pool.
      --on-premise                          If installing on an on premise cluster then lets default the 'external-ip' to be the Kubernetes master IP address
      --podsCidr string                     PODS CIDR Block.
      --poolMaxWaitSeconds string           The maximum time to wait for the work request to reach the state defined by --wait-for-state. Defaults to 1200 seconds.
      --poolWaitIntervalSeconds string      Check every --wait-interval-seconds to see whether the work request to see if it has reached the state defined by --wait-for-state.
      --prow                                Enable Prow
      --pull-secrets string                 The pull secrets the service account created should have (useful when deploying to your own private registry): provide multiple pull secrets by providing them in a singular block of quotes e.g. --pull-secrets "foo, bar, baz"
      --quantityPerSubnet string            The number of nodes to create in each subnet.
      --recreate-existing-draft-repos       Delete existing helm repos used by Jenkins X under ~/draft/packs
      --register-local-helmrepo             Registers the Jenkins X ChartMuseum registry with your helm client [default false]
      --remote-tiller                       If enabled and we are using tiller for helm then run tiller remotely in the kubernetes cluster. Otherwise we run the tiller process locally. (default true)
      --serviceLbSubnetIds string           Kubernetes Service LB Subnets. Optional but nice to have it as Jenkins X will create ingress controller based on it.
      --servicesCidr string                 Kubernetes Service CIDR Block.
      --skip-auth-secrets-merge             Skips merging a local git auth yaml file with any pipeline secrets that are found
      --skip-ingress                        Don't install an ingress controller
      --skip-installation                   Provision cluster only, don't install Jenkins X into it
      --skip-setup-tiller                   Don't setup the Helm Tiller service - lets use whatever tiller is already setup for us.
      --sshPublicKey string                 The SSH public key to add to each node in the node pool. Optional but nice to have it as user can access work nodes with it.
      --tiller-cluster-role string          The cluster role for Helm's tiller (default "cluster-admin")
      --tiller-namespace string             The namespace for the Tiller when using a global tiller (default "kube-system")
      --timeout string                      The number of seconds to wait for the helm install to complete (default "6000")
      --tls-acme string                     Used to enable automatic TLS for ingress
      --user-cluster-role string            The cluster role for the current user to be able to administer helm (default "cluster-admin")
      --username string                     The Kubernetes username used to initialise helm. Usually your email address for your Kubernetes account
      --vault                               Sets up a Hashicorp Vault for storing secrets during installation (supported only for GKE)
      --vcnId string                        The OCID of the virtual cloud network (VCN) in which to create the cluster.
      --verbose                             Enable verbose logging
      --version string                      The specific platform version to install
      --waitForState string                 Specify this option to perform the action and then wait until the work request reaches a certain state. (default "SUCCEEDED")
```

### SEE ALSO

* [jx create cluster](/commands/jx_create_cluster/)	 - Create a new Kubernetes cluster

###### Auto generated by spf13/cobra on 22-Jan-2019
