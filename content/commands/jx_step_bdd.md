---
date: 2019-02-06T18:05:54Z
title: "jx step bdd"
slug: jx_step_bdd
url: /commands/jx_step_bdd/
---
## jx step bdd

Performs the BDD tests on the current cluster, new clusters or teams

### Synopsis

This pipeline step lets you run the BDD tests in the current team in a current cluster or create a new cluster/team run tests there then tear things down again.

```
jx step bdd [flags]
```

### Examples

```
  # run the BDD tests in the current team
  jx step bdd --use-current-team --git-provider-url=https://my.git.server.com
  
  # create a new team for the tests, run the tests then tear everything down again
  jx step bdd -b --provider=gke --git-provider=ghe --git-provider-url=https://my.git.server.com --default-admin-password=myadminpwd --git-username myuser --git-api-token mygittoken
```

### Options

```
  -b, --batch-mode                          In batch mode the command never prompts for user input
      --binary string                       the binary location of the 'jx' executable for creating clusters (default "jx")
      --buildpack string                    The name of the build pack to use for the Team
      --cleanup-temp-files                  Cleans up any temporary values.yaml used by helm install [default true] (default true)
      --cloud-environment-repo string       Cloud Environments Git repo (default "https://github.com/jenkins-x/cloud-environments")
  -c, --config string                       the config YAML file containing the clusters to create
      --default-admin-password string       the default admin password to access Jenkins, Kubernetes Dashboard, ChartMuseum and Nexus
      --default-environment-prefix string   Default environment repo prefix, your Git repos will be of the form 'environment-$prefix-$envName'
      --delete-team                         Whether we should delete the Team we create for each Git Provider (default true)
      --dir string                          the git clone of the jenkins-x/jenkins-x-versions git repository. Used to default the version of jenkins-x-platform when creating clusters if no --version option is supplied
      --docker-registry string              The Docker Registry host or host:port which is used when tagging and pushing images. If not specified it defaults to the internal registry unless there is a better provider default (e.g. ECR on AWS/EKS)
      --domain string                       Domain to expose ingress endpoints.  Example: jenkinsx.io
      --draft-client-only                   Only install draft client
      --environment-git-owner string        The Git provider organisation to create the environment Git repositories in
      --exposecontroller-pathmode path      The ExposeController path mode for how services should be exposed as URLs. Defaults to using subnets. Use a value of path to use relative paths within the domain host such as when using AWS ELB host names
      --exposer string                      Used to describe which strategy exposecontroller should use to access applications (default "Ingress")
      --external-ip string                  The external IP used to access ingress endpoints from outside the Kubernetes cluster. For bare metal on premise clusters this is often the IP of the Kubernetes master. For cloud installations this is often the external IP of the ingress LoadBalancer.
      --git-api-token string                The Git API token to use for creating new Git repositories
      --git-owner string                    the git owner of new git repositories created by the tests
      --git-private                         Create new Git repositories as private
  -g, --git-provider string                 the git provider kind
      --git-provider-kind string            Kind of Git server. If not specified, kind of server will be autodetected from Git provider URL. Possible values: bitbucketcloud, bitbucketserver, gitea, gitlab, github, fakegit
      --git-provider-url string             The Git server URL to create new Git repositories inside (default "https://github.com")
      --git-username string                 The Git username to use for creating new Git repositories
      --gitops                              Sets up the local file system for GitOps so that the current installation can be configured or upgraded at any time via GitOps
      --global-tiller                       Whether or not to use a cluster global tiller (default true)
      --gopath string                       the GOPATH directory where the BDD test git repository will be cloned
      --headless                            Enable headless operation if using browser automation
      --helm-client-only                    Only install helm client
      --helm-tls                            Whether to use TLS with helm
      --helm3                               Use helm3 to install Jenkins X which does not use Tiller
  -h, --help                                help for bdd
  -i, --ignore-fail                         Ignores test failures so that a BDD test run can capture the output and report on the test passes/failures
      --ingress-cluster-role string         The cluster role for the Ingress controller (default "cluster-admin")
      --ingress-deployment string           The name of the Ingress controller Deployment (default "jxing-nginx-ingress-controller")
      --ingress-namespace string            The namespace for the Ingress controller (default "kube-system")
      --ingress-service string              The name of the Ingress controller Service (default "jxing-nginx-ingress-controller")
      --install-dependencies                Should any required dependencies be installed automatically
      --install-only                        Force the install command to fail if there is already an installation. Otherwise lets update the installation
      --kaniko                              Use Kaniko for building docker images
      --keep-exposecontroller-job           Prevents Helm deleting the exposecontroller Job and Pod after running.  Useful for debugging exposecontroller logs but you will need to manually delete the job if you update an environment
      --knative-pipeline                    Enables Knative Build Pipeline. Otherwise we default to use Knative Build
      --local-cloud-environment             Ignores default cloud-environment-repo and uses current directory 
      --local-helm-repo-name string         The name of the helm repository for the installed ChartMuseum (default "releases")
      --log-level string                    Logging level. Possible values - panic, fatal, error, warning, info, debug. (default "info")
      --namespace string                    The namespace the Jenkins X platform should be installed into (default "jx")
      --no-brew                             Disables the use of brew on macOS to install or upgrade command line dependencies
      --no-default-environments             Disables the creation of the default Staging and Production environments
      --no-delete-app                       Disables deleting the created app after the test
      --no-delete-repo                      Disables deleting the created repository after the test
      --no-gitops-env-apply                 When using GitOps to create the source code for the development environment and installation, don't run 'jx step env apply' to perform the install
      --no-gitops-env-repo                  When using GitOps to create the source code for the development environment this flag disables the creation of a git repository for the source code
      --no-gitops-vault                     When using GitOps to create the source code for the development environment this flag disables the creation of a vault
      --no-tiller                           Whether to disable the use of tiller with helm. If disabled we use 'helm template' to generate the YAML from helm charts then we use 'kubectl apply' to install it to avoid using tiller completely.
      --on-premise                          If installing on an on premise cluster then lets default the 'external-ip' to be the Kubernetes master IP address
      --parallel                            Should we process each cluster configuration in parallel
      --provider string                     Cloud service providing the Kubernetes cluster.  Supported providers: aks, aws, eks, gke, icp, iks, jx-infra, kubernetes, minikube, minishift, oke, openshift, pks
      --prow                                Enable Prow
      --pull-secrets string                 The pull secrets the service account created should have (useful when deploying to your own private registry): provide multiple pull secrets by providing them in a singular block of quotes e.g. --pull-secrets "foo, bar, baz"
      --recreate-existing-draft-repos       Delete existing helm repos used by Jenkins X under ~/draft/packs
      --register-local-helmrepo             Registers the Jenkins X ChartMuseum registry with your helm client [default false]
      --remote-tiller                       If enabled and we are using tiller for helm then run tiller remotely in the kubernetes cluster. Otherwise we run the tiller process locally. (default true)
      --reports-dir string                  the directory used to copy in any generated report files (default "reports")
      --skip-auth-secrets-merge             Skips merging a local git auth yaml file with any pipeline secrets that are found
      --skip-ingress                        Don't install an ingress controller
      --skip-setup-tiller                   Don't setup the Helm Tiller service - lets use whatever tiller is already setup for us.
      --test-git-branch string              the git repository branch to use for the BDD tests (default "master")
      --test-git-pr-number string           the Pull Request number to fetch from the repository for the BDD tests
  -r, --test-git-repo string                the git repository to clone for the BDD tests (default "https://github.com/jenkins-x/bdd-jx.git")
  -t, --tests stringArray                   the list of the test cases to run (default [test-quickstart-node-http])
      --tiller-cluster-role string          The cluster role for Helm's tiller (default "cluster-admin")
      --tiller-namespace string             The namespace for the Tiller when using a global tiller (default "kube-system")
      --timeout string                      The number of seconds to wait for the helm install to complete (default "6000")
      --urltemplate string                  For ingress; exposers can set the urltemplate to expose
      --use-current-team                    If enabled lets use the current Team to run the tests
      --user-cluster-role string            The cluster role for the current user to be able to administer helm (default "cluster-admin")
      --username string                     The Kubernetes username used to initialise helm. Usually your email address for your Kubernetes account
      --vault                               Sets up a Hashicorp Vault for storing secrets during installation (supported only for GKE)
      --verbose                             Enable verbose logging
      --version string                      The specific platform version to install
      --versions-repo string                Jenkins X versions Git repo (default "https://github.com/jenkins-x/jenkins-x-versions")
```

### SEE ALSO

* [jx step](/commands/jx_step/)	 - pipeline steps

###### Auto generated by spf13/cobra on 6-Feb-2019
