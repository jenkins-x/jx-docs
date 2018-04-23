---
date: 2018-04-23T12:20:58Z
title: "jx install"
slug: jx_install
url: /commands/jx_install/
---
## jx install

Install Jenkins X in the current Kubernetes cluster

### Synopsis

Installs the Jenkins X platform on a Kubernetes cluster 

Requires a --git-username and --git-api-token that can be used to create a new token. This is so the Jenkins X platform can git tag your releases 

For more documentation see: http://jenkins-x.io/getting-started/install-on-cluster/

The current requirements are:  * RBAC is enabled on the cluster  * insecure docker registry is enabled for docker registries running locally inside kubernetes on the service IP range. See the above documentation for more detail

```
jx install [flags]
```

### Examples

```
  # Default installer which uses interactive prompts to generate git secrets
  jx install
  
  # Install with a GitHub personal access token
  jx install --git-username jenkins-x-bot --git-api-token 9fdbd2d070cd81eb12bca87861bcd850
  
  # If you know the cloud provider you can pass this as a CLI argument. E.g. for AWS
  jx install --provider=aws
```

### Options

```
  -b, --batch-mode                          In batch mode the command never prompts for user input
      --cleanup-temp-files                  Cleans up any temporary values.yaml used by helm install [default true] (default true)
      --cloud-environment-repo string       Cloud Environments git repo (default "https://github.com/jenkins-x/cloud-environments")
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
      --headless                            Enable headless operation if using browser automation
      --helm-client-only                    Only install helm client
      --helm-tls                            Whether to use TLS with helm
  -h, --help                                help for install
      --http string                         Toggle creating http or https ingress rules (default "true")
      --ingress-cluster-role string         The cluster role for the Ingress controller (default "cluster-admin")
      --ingress-deployment string           The namespace for the Ingress controller Deployment (default "jxing-nginx-ingress-controller")
      --ingress-namespace string            The namespace for the Ingress controller (default "kube-system")
      --ingress-service string              The name of the Ingress controller Service (default "jxing-nginx-ingress-controller")
      --keep-exposecontroller-job           Prevents Helm deleting the exposecontroller Job and Pod after running.  Useful for debugging exposecontroller logs but you will need to manually delete the job if you update an environment
      --local-cloud-environment             Ignores default cloud-environment-repo and uses current directory 
      --local-helm-repo-name string         The name of the helm repository for the installed Chart Museum (default "releases")
      --namespace string                    The namespace the Jenkins X platform should be installed into (default "jx")
      --no-brew                             Disables the use of brew on MacOS to install or upgrade command line dependencies
      --no-default-environments             Disables the creation of the default Staging and Production environments
      --provider string                     Cloud service providing the kubernetes cluster.  Supported providers: aks, aws, eks, gke, jx-infra, kubernetes, minikube, minishift, openshift
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
```

### SEE ALSO

* [jx](/commands/jx/)	 - jx is a command line tool for working with Jenkins X

###### Auto generated by spf13/cobra on 23-Apr-2018
