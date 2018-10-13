---
date: 2018-10-13T12:14:15Z
title: "jx create cluster iks"
slug: jx_create_cluster_iks
url: /commands/jx_create_cluster_iks/
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
  -c, --account string                      Account
      --apikey string                       The IBM Cloud API Key.
      --cleanup-temp-files                  Cleans up any temporary values.yaml used by helm install [default true] (default true)
      --cloud-environment-repo string       Cloud Environments Git repo (default "https://github.com/jenkins-x/cloud-environments")
      --create-private-vlan                 Automatically create private vlan (default 'true')
      --create-public-vlan                  Automatically create public vlan (default 'true')
      --default-admin-password string       the default admin password to access Jenkins, Kubernetes Dashboard, Chartmuseum and Nexus
      --default-environment-prefix string   Default environment repo prefix, your Git repos will be of the form 'environment-$prefix-$envName'
      --disk-encrypt                        Optional: Disable encryption on a worker node. (default true)
      --docker-registry string              The Docker Registry host or host:port which is used when tagging and pushing images. If not specified it defaults to the internal registry unless there is a better provider default (e.g. ECR on AWS/EKS)
      --domain string                       Domain to expose ingress endpoints.  Example: jenkinsx.io
      --draft-client-only                   Only install draft client
      --environment-git-owner string        The Git provider organisation to create the environment Git repositories in
      --exposecontroller-pathmode path      The ExposeController path mode for how services should be exposed as URLs. Defaults to using subnets. Use a value of path to use relative paths within the domain host such as when using AWS ELB host names
      --exposer string                      Used to describe which strategy exposecontroller should use to access applications (default "Ingress")
      --external-ip string                  The external IP used to access ingress endpoints from outside the Kubernetes cluster. For bare metal on premise clusters this is often the IP of the Kubernetes master. For cloud installations this is often the external IP of the ingress LoadBalancer.
      --git-api-token string                The Git API token to use for creating new Git repositories
      --git-private                         Create new Git repositories as private
      --git-provider-url string             The Git server URL to create new Git repositories inside (default "https://github.com")
      --git-username string                 The Git username to use for creating new Git repositories
      --global-tiller                       Whether or not to use a cluster global tiller (default true)
      --helm-client-only                    Only install helm client
      --helm-tls                            Whether to use TLS with helm
      --helm3                               Use helm3 to install Jenkins X which does not use Tiller
  -h, --help                                help for iks
      --http string                         Toggle creating http or https ingress rules (default "true")
      --ingress-cluster-role string         The cluster role for the Ingress controller (default "cluster-admin")
      --ingress-deployment string           The name of the Ingress controller Deployment (default "jxing-nginx-ingress-controller")
      --ingress-namespace string            The namespace for the Ingress controller (default "kube-system")
      --ingress-service string              The name of the Ingress controller Service (default "jxing-nginx-ingress-controller")
      --install-only                        Force the install command to fail if there is already an installation. Otherwise lets update the installation
      --isolation string                    The level of hardware isolation for your worker node. Use 'private' to have available physical resources dedicated to you only, or 'public' to allow physical resources to be shared with other IBM customers. For IBM Cloud Public accounts, the default value is public. (default "public")
      --keep-exposecontroller-job           Prevents Helm deleting the exposecontroller Job and Pod after running.  Useful for debugging exposecontroller logs but you will need to manually delete the job if you update an environment
  -k, --kube-version string                 Specify the Kubernetes version, including at least the major.minor version. If you do not include this flag, the default version is used. To see available versions, run ‘ibmcloud ks kube-versions’.
      --local-cloud-environment             Ignores default cloud-environment-repo and uses current directory 
      --local-helm-repo-name string         The name of the helm repository for the installed Chart Museum (default "releases")
  -u, --login string                        Username
  -m, --machine-type string                 The machine type of the worker node. To see available machine types, run 'ibmcloud ks machine-types --zone <zone name>'. Default is 'b2c.4x16', 4 cores CPU, 16GB Memory
  -n, --name string                         Set the name of the cluster that will be created.
      --namespace string                    The namespace the Jenkins X platform should be installed into (default "jx")
      --no-default-environments             Disables the creation of the default Staging and Production environments
      --no-subnet                           Optional: Prevent the creation of a portable subnet when creating the cluster. By default, both a public and a private portable subnet are created on the associated VLAN, and this flag prevents that behavior. To add a subnet to the cluster later, run 'ibmcloud ks cluster-subnet-add'.
      --no-tiller                           Whether to disable the use of tiller with helm. If disabled we use 'helm template' to generate the YAML from helm charts then we use 'kubectl apply' to install it to avoid using tiller completely.
      --on-premise                          If installing on an on premise cluster then lets default the 'external-ip' to be the Kubernetes master IP address
  -p, --password string                     Password
      --private-only                        Use this flag to prevent a public VLAN from being created. Required only when you specify the ‘--private-vlan’ flag without specifying the ‘--public-vlan’ flag.
      --private-vlan string                 Conditional: Specify the ID of the private VLAN. To see available VLANs, run 'ibmcloud ks vlans --zone <zone name>'. If you do not have a private VLAN yet, do not specify this option because one will be automatically created for you. When you specify a private VLAN, you must also specify either the ‘--public-vlan’ flag or the ‘--private-only’ flag.
      --prow                                Enable prow
      --public-vlan string                  Conditional: Specify the ID of the public VLAN. To see available VLANs, run 'ibmcloud ks vlans --zone <zone name>'. If you do not have a public VLAN yet, do not specify this option because one will be automatically created for you.
      --recreate-existing-draft-repos       Delete existing helm repos used by Jenkins X under ~/draft/packs
  -r, --region string                       The IBM Cloud Region. Default is 'us-east'
      --register-local-helmrepo             Registers the Jenkins X chartmuseum registry with your helm client [default false]
      --remote-tiller                       If enabled and we are using tiller for helm then run tiller remotely in the kubernetes cluster. Otherwise we run the tiller process locally. (default true)
      --skip-ingress                        Don't install an ingress controller
      --skip-installation                   Provision cluster only, don't install Jenkins X into it
      --skip-login ibmcloud login           Skip login if already logged in using ibmcloud login
      --skip-tiller                         Don't install a Helm Tiller service
      --sso                                 SSO Passcode. See run 'ibmcloud login --sso'
      --tiller-cluster-role string          The cluster role for Helm's tiller (default "cluster-admin")
      --tiller-namespace string             The namespace for the Tiller when using a global tiller (default "kube-system")
      --timeout string                      The number of seconds to wait for the helm install to complete (default "6000")
      --tls-acme string                     Used to enable automatic TLS for ingress (default "false")
      --trusted                             Optional: Enable trusted cluster feature.
      --user-cluster-role string            The cluster role for the current user to be able to administer helm (default "cluster-admin")
      --username string                     The Kubernetes username used to initialise helm. Usually your email address for your Kubernetes account
      --version string                      The specific platform version to install
      --workers string                      The number of cluster worker nodes. Defaults to 3.
  -z, --zone string                         Specify the zone where you want to create the cluster, the options depend on what region that you are logged in to. To see available zones, run 'ibmcloud ks zones'. Default is 'wdc07'
```

### SEE ALSO

* [jx create cluster](/commands/jx_create_cluster/)	 - Create a new Kubernetes cluster

###### Auto generated by spf13/cobra on 13-Oct-2018
