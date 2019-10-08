---
title: "Install Jenkins X on GKE Properly"
linkTitle: "Install Jenkins X on GKE"
date: 2019-04-25T07:36:00+02:00
description: >
   A comprehensive tutorial on how to install and configure Jenkins X so that you have a Jenkins X Bot working properly.  This ensures your experience as a Developer interacting with Jenkinx X is more realistic.
categories: [blog]
keywords: [jenkins-x-bot,GKE,Install,Tutorial]
slug: "jenkins-x-gke-install-with-bot"
aliases: []
author: Oscar Medina
weight: 20
---

**NOTE:** This tutorial is based on the following jx version

```sh
    NAME               VERSION
    jx                 2.0.33
    jenkins x platform 2.0.108
    Kubernetes cluster v1.11.8-gke.6
    kubectl            v1.14.0
    helm client        Client: v2.13.1+g618447c
    git                git version 2.21.0
    Operating System   Mac OS X 10.14.3 build 18D42
```

# Overview
In this tutorial, we walk you through a full setup of Jenkinx X in GKE, including setup of the Bot.  We will install Jenkins X Serverless topology which also brings Tekton pipelines for us to use in this scenario.  We walk through putting an app via CI/CD and ensuring the Jenkins X Bot is working as expected.

# What You Will Learn

1. Install Jenkins X on GKE including the Jenkins Bot configuration for the full and proper experience
2. Run an application through CI/CD and seeing the bot in action, executing approval commands (as the approver)
3. You wil have a **Serverless Jenkins X** cluster with **Tekton** Pipelines enabled.
4. You will have a cluster that uses **GitOps**

{{% alert %}}
**NOTE:**  If you've provisioned the cluster using Terraform, this should still work.  However you cannot run the command we outline below, instead you will have to run the `jx install --ng=true` command.
{{% /alert %}}

# Prerequisites

1. A GCP account along with a **Project** already created.
2. You should be able to create resources via the `gcloud` CLI
3. You should have `kubectl` installed.
4. The `jx` CLI version `2.0.33` or greater, perferably this specific version.
5. Github Organization
6. Github account - used as the *Jenkins* X Bot [  Github account: `jenkinsx-bot-sposcar` does not have to have high privileges]
7. Github account - used as the *Developer* working on code [  Github account: `sharepointoscar`]
8. Both Github accounts should belong to the Github Organization. [ Github Org: `jenkins-oscar`]

{{% alert color="warning" %}}
Lastly, clean up after yourself!  If you've tried multiple installs, best approach is to remove the `~/.jx` folder as there are sometimes things that are saved and reused for new installs obviously.
{{% /alert %}}

Your Github Organization and user accounts should be setup similar to how it is shown on **Figure 1** below.

<figure>
<img src="/images/getting-started/github_org_settings.png"/>
<figcaption>
<h5>Figure 1 - Github Organization and members</h5>
</figcaption>
</figure>


## Creating GKE Cluster and Installing Jenkins X
The first step we need to take, is execute the command which simultaneously will provision a cluster and install Jenkins X.  The following command should be issued on the terminal.  Change placeholders accordingly.

```sh
jx create cluster gke --default-admin-password=<YOURPASSWORD> -n <CLUSTERNAME> --ng=true
```

{{% alert %}}
**NOTE:** The execution of this command with ONLY the `--ng=true` flag, ensures several things happen.  It ensures the following features are configured **Prow**, **Tekton**, **No Tiller**, **HashiCorp Vault**, Dev **GitOps** on a **Serverless** topology.
{{% /alert %}}

## Output of the Command - lengthy but let's break it down!
The output below is quite insightful, we include it here for you to see all of what happens as the install is happening.

```sh

Using the only Google Cloud Project jenkinsx-dev to create the cluster
Updated property [core/project].
Let's ensure we have container and compute enabled on your project
No apis to enable
? What type of cluster would you like to create Zonal
? Google Cloud Zone: us-west1-a
? Google Cloud Machine Type: n1-standard-2
? Minimum number of Nodes (per zone) 3
? Maximum number of Nodes 5
? Would you like use preemptible VMs? No
? Would you like to access Google Cloud Storage / Google Container Registry? No
? Would you like to enable Kaniko for building container images Yes
Creating cluster...
Initialising cluster ...
Setting the dev namespace to: jx
Namespace jx created

Using helmBinary helm with feature flag: none
Context "gke_jenkinsx-dev_us-west1-a_sposcar" modified.
Storing the kubernetes provider gke in the TeamSettings
Enabling helm template mode in the TeamSettings
Git configured for user: sharepointoscar and email me@sharepointoscar.com
Trying to create ClusterRoleBinding omedina-cloudbees-com-cluster-admin-binding for role: cluster-admin for user omedina@cloudbees.com
 clusterrolebindings.rbac.authorization.k8s.io "omedina-cloudbees-com-cluster-admin-binding" not found
Created ClusterRoleBinding omedina-cloudbees-com-cluster-admin-binding
Using helm2
Skipping tiller
```

### Key Things happened above...
- Basic cluster configuration such as max and min nodes are configured.
- Kubectl context is set to new cluster so you can access cluster via both `kubectl` and `jx`
- Sets cluster admin via ClusterRoleBinding created

```sh
Using helmBinary helm with feature flag: template-mode
Initialising Helm 'init --client-only'
helm installed and configured
? No existing ingress controller found in the kube-system namespace, shall we install one? Yes

Current configuration dir: /Users/omedina/.jx
versionRepository: https://github.com/jenkins-x/jenkins-x-versions.git git ref:
Deleting and cloning the Jenkins X versions repo
Cloning the Jenkins X versions repo https://github.com/jenkins-x/jenkins-x-versions.git with ref refs/heads/master to /Users/omedina/.jx/jenkins-x-versions
Enumerating objects: 206, done.
Counting objects: 100% (206/206), done.
Compressing objects: 100% (89/89), done.
Total 1096 (delta 109), reused 185 (delta 101), pack-reused 890
using stable version 1.3.1 from charts of stable/nginx-ingress from /Users/omedina/.jx/jenkins-x-versions
Installing using helm binary: helm
Current configuration dir: /Users/omedina/.jx
versionRepository: https://github.com/jenkins-x/jenkins-x-versions.git git ref:
Deleting and cloning the Jenkins X versions repo
Cloning the Jenkins X versions repo https://github.com/jenkins-x/jenkins-x-versions.git with ref refs/heads/master to /Users/omedina/.jx/jenkins-x-versions
Enumerating objects: 206, done.
Counting objects: 100% (206/206), done.
Compressing objects: 100% (89/89), done.
Total 1096 (delta 109), reused 185 (delta 101), pack-reused 890
Fetched chart stable/nginx-ingress to dir /var/folders/hb/w23l1cld7pl2h_rjqk_1yyrr0000gn/T/helm-template-workdir-231692500/jxing/chartFiles/nginx-ingress
Generating Chart Template 'template --name jxing --namespace kube-system /var/folders/hb/w23l1cld7pl2h_rjqk_1yyrr0000gn/T/helm-template-workdir-231692500/jxing/chartFiles/nginx-ingress --output-dir /var/folders/hb/w23l1cld7pl2h_rjqk_1yyrr0000gn/T/helm-template-workdir-231692500/jxing/output --debug --set rbac.create=true --set controller.extraArgs.publish-service=kube-system/jxing-nginx-ingress-controller'
Applying generated chart stable/nginx-ingress YAML via kubectl in dir: /var/folders/hb/w23l1cld7pl2h_rjqk_1yyrr0000gn/T/helm-template-workdir-231692500/jxing/output
clusterrole.rbac.authorization.k8s.io/jxing-nginx-ingress created
clusterrolebinding.rbac.authorization.k8s.io/jxing-nginx-ingress created
configmap/jxing-nginx-ingress-controller created
deployment.extensions/jxing-nginx-ingress-controller created
service/jxing-nginx-ingress-controller created
deployment.extensions/jxing-nginx-ingress-default-backend created
service/jxing-nginx-ingress-default-backend created
role.rbac.authorization.k8s.io/jxing-nginx-ingress created
rolebinding.rbac.authorization.k8s.io/jxing-nginx-ingress created
serviceaccount/jxing-nginx-ingress created

Removing Kubernetes resources from older releases using selector: jenkins.io/chart-release=jxing,jenkins.io/version!=1.3.1 from all pvc configmap release sa role rolebinding secret
Removing Kubernetes resources from older releases using selector: jenkins.io/chart-release=jxing,jenkins.io/version!=1.3.1,jenkins.io/namespace=kube-system from clusterrole clusterrolebinding
Waiting for external loadbalancer to be created and update the nginx-ingress-controller service in kube-system namespace
Note: this loadbalancer will fail to be provisioned if you have insufficient quotas, this can happen easily on a GKE free account. To view quotas run: gcloud compute project-info describe
External loadbalancer created
Waiting to find the external host name of the ingress controller Service in namespace kube-system with name jxing-nginx-ingress-controller
You can now configure a wildcard DNS pointing to the new Load Balancer address 34.83.54.46

If you do not have a custom domain setup yet, Ingress rules will be set for magic DNS nip.io.

Once you have a custom domain ready, you can update with the command jx upgrade ingress --cluster
```

{{% alert %}}
At this point, we have already set our DNS settings to point to the IP listed above for the ingress controller and gave it a bit of time to propagate before hitting **enter** `sharepointoscar.com` for the Domain, and letting it configure ingress and other endpoints.
{{% /alert %}}

```sh
If you don't have a wildcard DNS setup then setup a DNS (A) record and point it at: 34.83.54.46 then use the DNS domain in the next input...
? Domain sharepointoscar.com
nginx ingress controller installed and configured
Lets set up a Git user name and API token to be able to perform CI/CD

? local Git user for GitHub server: jenkinsx-bot-sposcar
Select the CI/CD pipelines Git server and user
? Do you wish to use GitHub as the pipelines Git server: Yes
Setting the pipelines Git server https://github.com and user name jenkinsx-bot-sposcar.
Saving the Git authentication configuration
Current configuration dir: /Users/omedina/.jx
versionRepository: https://github.com/jenkins-x/jenkins-x-versions.git git ref:
Deleting and cloning the Jenkins X versions repo
Cloning the Jenkins X versions repo https://github.com/jenkins-x/jenkins-x-versions.git with ref refs/heads/master to /Users/omedina/.jx/jenkins-x-versions
Enumerating objects: 206, done.
Counting objects: 100% (206/206), done.
Compressing objects: 100% (89/89), done.
Total 1096 (delta 109), reused 185 (delta 101), pack-reused 890
Current configuration dir: /Users/omedina/.jx
options.Flags.CloudEnvRepository: https://github.com/jenkins-x/cloud-environments
options.Flags.LocalCloudEnvironment: false
Cloning the Jenkins X cloud environments repo to /Users/omedina/.jx/cloud-environments
? A local Jenkins X cloud environments repository already exists, recreate with latest? Yes
Current configuration dir: /Users/omedina/.jx
options.Flags.CloudEnvRepository: https://github.com/jenkins-x/cloud-environments
options.Flags.LocalCloudEnvironment: false
Cloning the Jenkins X cloud environments repo to /Users/omedina/.jx/cloud-environments
Enumerating objects: 1382, done.
Total 1382 (delta 0), reused 0 (delta 0), pack-reused 1382
? Select Jenkins installation type: Serverless Jenkins X Pipelines with Tekton
```

### Key Things happened above...
- We specified `sharepointoscar.com` as the domain for the ingress controller and endpoints.
- GitHub server account is set to `jenkinsx-bot-sposcar` and which is part of the Organization `jenkins-oscar`
- We were prompted to enter an **API token** for the bot account **(we are signed into Github with the bot account)**
- Jenkins Installation Type is set to **Serverless Jenkins X Pipelines with Tekton**

```sh
Configuring Kaniko service account jxkaniko-sposcar for project jenkinsx-dev
Unable to find service account jxkaniko-sposcar, checking if we have enough permission to create
Creating service account jxkaniko-sposcar
Assigning role roles/storage.admin
Assigning role roles/storage.objectAdmin
Assigning role roles/storage.objectCreator
Downloading service account key
Setting the dev namespace to: jx
Generated helm values /Users/omedina/.jx/extraValues.yaml
Creating Secret jx-install-config in namespace jx
Installing Jenkins X platform helm chart from: /Users/omedina/.jx/cloud-environments/env-gke
Configuring the TeamSettings for Prow with engine Tekton
Setting the current namespace to: jx

Installing knative into namespace jx
Current configuration dir: /Users/omedina/.jx
versionRepository: https://github.com/jenkins-x/jenkins-x-versions.git git ref:
Deleting and cloning the Jenkins X versions repo
Cloning the Jenkins X versions repo https://github.com/jenkins-x/jenkins-x-versions.git with ref refs/heads/master to /Users/omedina/.jx/jenkins-x-versions
Enumerating objects: 206, done.
Counting objects: 100% (206/206), done.
Compressing objects: 100% (89/89), done.
Total 1096 (delta 109), reused 185 (delta 101), pack-reused 890
using stable version 0.0.35 from charts of jenkins-x/tekton from /Users/omedina/.jx/jenkins-x-versions
Updating Helm repository...
Helm repository update done.
Fetched chart jenkins-x/tekton to dir /var/folders/hb/w23l1cld7pl2h_rjqk_1yyrr0000gn/T/helm-template-workdir-231692500/tekton/chartFiles/tekton
Generating Chart Template 'template --name tekton --namespace jx /var/folders/hb/w23l1cld7pl2h_rjqk_1yyrr0000gn/T/helm-template-workdir-231692500/tekton/chartFiles/tekton --output-dir /var/folders/hb/w23l1cld7pl2h_rjqk_1yyrr0000gn/T/helm-template-workdir-231692500/tekton/output --debug --set  --set tillerNamespace= --set auth.git.username=jenkinsx-bot-sposcar --set auth.git.password=04028f1eba8c0091cecd8f2d277e2569046482d9'
Applying generated chart jenkins-x/tekton YAML via kubectl in dir: /var/folders/hb/w23l1cld7pl2h_rjqk_1yyrr0000gn/T/helm-template-workdir-231692500/tekton/output
clusterrole.rbac.authorization.k8s.io/tekton-pipelines created
clusterrolebinding.rbac.authorization.k8s.io/tekton-pipelines-jx created
secret/knative-git-user-pass created
serviceaccount/tekton-pipelines created
serviceaccount/tekton-bot created
customresourcedefinition.apiextensions.k8s.io/clustertasks.tekton.dev created
customresourcedefinition.apiextensions.k8s.io/pipelines.tekton.dev created
customresourcedefinition.apiextensions.k8s.io/pipelineruns.tekton.dev created
customresourcedefinition.apiextensions.k8s.io/pipelineresources.tekton.dev created
customresourcedefinition.apiextensions.k8s.io/tasks.tekton.dev created
customresourcedefinition.apiextensions.k8s.io/taskruns.tekton.dev created
service/tekton-pipelines-controller created
service/tekton-pipelines-webhook created
clusterrole.rbac.authorization.k8s.io/tekton-bot created
clusterrolebinding.rbac.authorization.k8s.io/tekton-bot-jx created
role.rbac.authorization.k8s.io/tekton-bot created
rolebinding.rbac.authorization.k8s.io/tekton-bot created
configmap/config-artifact-bucket created
configmap/config-entrypoint created
configmap/config-logging created
deployment.apps/tekton-pipelines-controller created
deployment.apps/tekton-pipelines-webhook created

Removing Kubernetes resources from older releases using selector: jenkins.io/chart-release=tekton,jenkins.io/version!=0.0.35 from all pvc configmap release sa role rolebinding secret
Removing Kubernetes resources from older releases using selector: jenkins.io/chart-release=tekton,jenkins.io/version!=0.0.35,jenkins.io/namespace=jx from clusterrole clusterrolebinding

Installing Prow into namespace jx
Current configuration dir: /Users/omedina/.jx
versionRepository: https://github.com/jenkins-x/jenkins-x-versions.git git ref:
Deleting and cloning the Jenkins X versions repo
Cloning the Jenkins X versions repo https://github.com/jenkins-x/jenkins-x-versions.git with ref refs/heads/master to /Users/omedina/.jx/jenkins-x-versions
Enumerating objects: 206, done.
Counting objects: 100% (206/206), done.
Compressing objects: 100% (89/89), done.
Total 1096 (delta 109), reused 185 (delta 101), pack-reused 890
using stable version 0.0.540 from charts of jenkins-x/prow from /Users/omedina/.jx/jenkins-x-versions
Updating Helm repository...
Helm repository update done.
Fetched chart jenkins-x/prow to dir /var/folders/hb/w23l1cld7pl2h_rjqk_1yyrr0000gn/T/helm-template-workdir-231692500/jx-prow/chartFiles/prow
Generating Chart Template 'template --name jx-prow --namespace jx /var/folders/hb/w23l1cld7pl2h_rjqk_1yyrr0000gn/T/helm-template-workdir-231692500/jx-prow/chartFiles/prow --output-dir /var/folders/hb/w23l1cld7pl2h_rjqk_1yyrr0000gn/T/helm-template-workdir-231692500/jx-prow/output --debug --set  --set tillerNamespace= --set auth.git.username=jenkinsx-bot-sposcar --set buildnum.enabled=false --set build.enabled=false --set pipelinerunner.enabled=true --set user=jenkinsx-bot-sposcar --set oauthToken=04028f1eba8c0091cecd8f2d277e2569046482d9 --set hmacToken=cfb951f73b3e36557df3f024c1d112351f36a1a2c'
Applying generated chart jenkins-x/prow YAML via kubectl in dir: /var/folders/hb/w23l1cld7pl2h_rjqk_1yyrr0000gn/T/helm-template-workdir-231692500/jx-prow/output
clusterrolebinding.rbac.authorization.k8s.io/cluster-admin-binding-jx created
clusterrole.rbac.authorization.k8s.io/crier created
clusterrolebinding.rbac.authorization.k8s.io/crier-jx created
deployment.extensions/crier created
rolebinding.rbac.authorization.k8s.io/crier created
role.rbac.authorization.k8s.io/crier created
serviceaccount/crier created
deployment.extensions/deck created
rolebinding.rbac.authorization.k8s.io/deck created
role.rbac.authorization.k8s.io/deck created
serviceaccount/deck created
service/deck created
secret/hmac-token created
deployment.extensions/hook created
rolebinding.rbac.authorization.k8s.io/hook created
role.rbac.authorization.k8s.io/hook created
serviceaccount/hook created
service/hook created
deployment.extensions/horologium created
rolebinding.rbac.authorization.k8s.io/horologium created
role.rbac.authorization.k8s.io/horologium created
serviceaccount/horologium created
secret/oauth-token created
clusterrole.rbac.authorization.k8s.io/pipeline created
clusterrolebinding.rbac.authorization.k8s.io/pipeline-jx created
deployment.extensions/pipeline created
serviceaccount/pipeline created
deployment.extensions/pipelinerunner created
rolebinding.rbac.authorization.k8s.io/pipelinerunner created
role.rbac.authorization.k8s.io/pipelinerunner created
serviceaccount/pipelinerunner created
service/pipelinerunner created
deployment.extensions/plank created
rolebinding.rbac.authorization.k8s.io/plank created
role.rbac.authorization.k8s.io/plank created
serviceaccount/plank created
customresourcedefinition.apiextensions.k8s.io/prowjobs.prow.k8s.io created
deployment.extensions/sinker created
rolebinding.rbac.authorization.k8s.io/sinker created
role.rbac.authorization.k8s.io/sinker created
serviceaccount/sinker created
deployment.extensions/tide created
rolebinding.rbac.authorization.k8s.io/tide created
role.rbac.authorization.k8s.io/tide created
serviceaccount/tide created
service/tide created

Removing Kubernetes resources from older releases using selector: jenkins.io/chart-release=jx-prow,jenkins.io/version!=0.0.540 from all pvc configmap release sa role rolebinding secret
Removing Kubernetes resources from older releases using selector: jenkins.io/chart-release=jx-prow,jenkins.io/version!=0.0.540,jenkins.io/namespace=jx from clusterrole clusterrolebinding
? Pick default workload build pack:  Kubernetes Workloads: Automated CI+CD with GitOps Promotion
Setting the team build pack to kubernetes-workloads repo: https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes.git ref: master
Installing jx into namespace jx
using stable version 2.0.108 from charts of jenkins-x/jenkins-x-platform from /Users/omedina/.jx/jenkins-x-versions
Installing jenkins-x-platform version: 2.0.108
Adding values file /Users/omedina/.jx/cloud-environments/env-gke/myvalues.yaml
Adding values file /Users/omedina/.jx/adminSecrets.yaml
Adding values file /Users/omedina/.jx/extraValues.yaml
Adding values file /Users/omedina/.jx/cloud-environments/env-gke/secrets.yaml
Current configuration dir: /Users/omedina/.jx
versionRepository: https://github.com/jenkins-x/jenkins-x-versions.git git ref:
Deleting and cloning the Jenkins X versions repo
Cloning the Jenkins X versions repo https://github.com/jenkins-x/jenkins-x-versions.git with ref refs/heads/master to /Users/omedina/.jx/jenkins-x-versions
Enumerating objects: 206, done.
Counting objects: 100% (206/206), done.
Compressing objects: 100% (89/89), done.
Total 1096 (delta 109), reused 185 (delta 101), pack-reused 890
Fetched chart jenkins-x/jenkins-x-platform to dir /var/folders/hb/w23l1cld7pl2h_rjqk_1yyrr0000gn/T/helm-template-workdir-231692500/jenkins-x/chartFiles/jenkins-x-platform
Generating Chart Template 'template --name jenkins-x --namespace jx /var/folders/hb/w23l1cld7pl2h_rjqk_1yyrr0000gn/T/helm-template-workdir-231692500/jenkins-x/chartFiles/jenkins-x-platform --output-dir /var/folders/hb/w23l1cld7pl2h_rjqk_1yyrr0000gn/T/helm-template-workdir-231692500/jenkins-x/output --debug --values /Users/omedina/.jx/cloud-environments/env-gke/myvalues.yaml --values /Users/omedina/.jx/adminSecrets.yaml --values /Users/omedina/.jx/extraValues.yaml --values /Users/omedina/.jx/cloud-environments/env-gke/secrets.yaml'
Applying generated chart jenkins-x/jenkins-x-platform YAML via kubectl in dir: /var/folders/hb/w23l1cld7pl2h_rjqk_1yyrr0000gn/T/helm-template-workdir-231692500/jenkins-x/output
deployment.extensions/jenkins-x-chartmuseum created
persistentvolumeclaim/jenkins-x-chartmuseum created
secret/jenkins-x-chartmuseum created
service/jenkins-x-chartmuseum created
role.rbac.authorization.k8s.io/cleanup created
rolebinding.rbac.authorization.k8s.io/cleanup created
serviceaccount/cleanup created
clusterrole.rbac.authorization.k8s.io/controllerbuild-jx created
clusterrolebinding.rbac.authorization.k8s.io/controllerbuild-jx created
deployment.apps/jenkins-x-controllerbuild created
role.rbac.authorization.k8s.io/controllerbuild created
rolebinding.rbac.authorization.k8s.io/controllerbuild created
serviceaccount/jenkins-x-controllerbuild created
clusterrole.rbac.authorization.k8s.io/controllercommitstatus-jx created
clusterrolebinding.rbac.authorization.k8s.io/controllercommitstatus-jx created
deployment.apps/jenkins-x-controllercommitstatus created
role.rbac.authorization.k8s.io/controllercommitstatus created
rolebinding.rbac.authorization.k8s.io/controllercommitstatus created
serviceaccount/jenkins-x-controllercommitstatus created
clusterrole.rbac.authorization.k8s.io/controllerrole-jx created
clusterrolebinding.rbac.authorization.k8s.io/controllerrole-jx created
deployment.apps/jenkins-x-controllerrole created
role.rbac.authorization.k8s.io/controllerrole created
rolebinding.rbac.authorization.k8s.io/controllerrole created
serviceaccount/jenkins-x-controllerrole created
clusterrole.rbac.authorization.k8s.io/controllerteam-jx created
clusterrolebinding.rbac.authorization.k8s.io/controllerteam-jx created
deployment.apps/jenkins-x-controllerteam created
role.rbac.authorization.k8s.io/controllerteam created
rolebinding.rbac.authorization.k8s.io/controllerteam created
serviceaccount/jenkins-x-controllerteam created
clusterrole.rbac.authorization.k8s.io/controllerworkflow-jx created
clusterrolebinding.rbac.authorization.k8s.io/controllerworkflow-jx created
deployment.apps/jenkins-x-controllerworkflow created
role.rbac.authorization.k8s.io/controllerworkflow created
rolebinding.rbac.authorization.k8s.io/controllerworkflow created
serviceaccount/jenkins-x-controllerworkflow created
configmap/jenkins-x-docker-registry-config created
deployment.extensions/jenkins-x-docker-registry created
persistentvolumeclaim/jenkins-x-docker-registry created
secret/jenkins-x-docker-registry-secret created
service/jenkins-x-docker-registry created
configmap/exposecontroller created
role.rbac.authorization.k8s.io/expose created
rolebinding.rbac.authorization.k8s.io/expose created
serviceaccount/expose created
clusterrole.rbac.authorization.k8s.io/gcactivities-jx created
clusterrolebinding.rbac.authorization.k8s.io/gcactivities-jx created
cronjob.batch/jenkins-x-gcactivities created
role.rbac.authorization.k8s.io/gcactivities created
rolebinding.rbac.authorization.k8s.io/gcactivities created
serviceaccount/jenkins-x-gcactivities created
cronjob.batch/jenkins-x-gcpods created
role.rbac.authorization.k8s.io/gcpods created
rolebinding.rbac.authorization.k8s.io/gcpods created
serviceaccount/jenkins-x-gcpods created
clusterrole.rbac.authorization.k8s.io/gcpreviews-jx created
clusterrolebinding.rbac.authorization.k8s.io/gcpreviews-jx created
cronjob.batch/jenkins-x-gcpreviews created
role.rbac.authorization.k8s.io/gcpreviews created
rolebinding.rbac.authorization.k8s.io/gcpreviews created
serviceaccount/jenkins-x-gcpreviews created
deployment.extensions/jenkins-x-heapster created
clusterrolebinding.rbac.authorization.k8s.io/jenkins-x-heapster created
role.rbac.authorization.k8s.io/jenkins-x-heapster-pod-nanny created
rolebinding.rbac.authorization.k8s.io/jenkins-x-heapster-pod-nanny created
service/heapster created
serviceaccount/jenkins-x-heapster created
deployment.extensions/jenkins-x-mongodb created
persistentvolumeclaim/jenkins-x-mongodb created
secret/jenkins-x-mongodb created
service/jenkins-x-mongodb created
configmap/jenkins-x-monocular-api-config created
deployment.extensions/jenkins-x-monocular-api created
service/jenkins-x-monocular-api created
deployment.extensions/jenkins-x-monocular-prerender created
service/jenkins-x-monocular-prerender created
configmap/jenkins-x-monocular-ui-config created
deployment.extensions/jenkins-x-monocular-ui created
service/jenkins-x-monocular-ui created
configmap/jenkins-x-monocular-ui-vhost created
configmap/nexus created
deployment.extensions/jenkins-x-nexus created
persistentvolumeclaim/jenkins-x-nexus created
secret/nexus created
service/nexus created
role.rbac.authorization.k8s.io/committer created
clusterrolebinding.rbac.authorization.k8s.io/jenkins-x-team-controller created
configmap/jenkins-x-team-controller created
secret/jenkins-docker-cfg created
configmap/jenkins-x-devpod-config created
configmap/jenkins-x-docker-registry created
configmap/jenkins-x-extensions created
secret/jx-basic-auth created
role.rbac.authorization.k8s.io/jx-view created
secret/kaniko-secret created
secret/jenkins-maven-settings created
secret/jenkins-npm-token created
role.rbac.authorization.k8s.io/owner created
configmap/jenkins-x-pod-template-dlang created
configmap/jenkins-x-pod-template-go created
configmap/jenkins-x-pod-template-python created
configmap/jenkins-x-pod-template-newman created
configmap/jenkins-x-pod-template-terraform created
configmap/jenkins-x-pod-template-maven created
configmap/jenkins-x-pod-template-rust created
configmap/jenkins-x-pod-template-python2 created
configmap/jenkins-x-pod-template-nodejs created
configmap/jenkins-x-pod-template-aws-cdk created
configmap/jenkins-x-pod-template-gradle created
configmap/jenkins-x-pod-template-maven-java11 created
configmap/jenkins-x-pod-template-scala created
configmap/jenkins-x-pod-template-python37 created
configmap/jenkins-x-pod-template-promote created
configmap/jenkins-x-pod-template-maven-nodejs created
configmap/jenkins-x-pod-template-swift created
configmap/jenkins-x-pod-template-jx-base created
configmap/jenkins-x-pod-template-ruby created
secret/jenkins-release-gpg created
secret/jenkins-ssh-config created
role.rbac.authorization.k8s.io/viewer created

Applying Helm hook post-upgrade YAML via kubectl in file: /var/folders/hb/w23l1cld7pl2h_rjqk_1yyrr0000gn/T/helm-template-workdir-231692500/jenkins-x/helmHooks/jenkins-x-platform/charts/expose/templates/job.yaml
job.batch/expose created

Waiting for helm post-upgrade hook Job expose to complete before removing it
Deleting helm hook sources from file: /var/folders/hb/w23l1cld7pl2h_rjqk_1yyrr0000gn/T/helm-template-workdir-231692500/jenkins-x/helmHooks/jenkins-x-platform/charts/expose/templates/job.yaml
job.batch "expose" deleted
Removing Kubernetes resources from older releases using selector: jenkins.io/chart-release=jenkins-x,jenkins.io/version!=2.0.108 from all pvc configmap release sa role rolebinding secret
Removing Kubernetes resources from older releases using selector: jenkins.io/chart-release=jenkins-x,jenkins.io/version!=2.0.108,jenkins.io/namespace=jx from clusterrole clusterrolebinding
WARNING: waiting for install to be ready, if this is the first time then it will take a while to download images
Jenkins X deployments ready in namespace jx
Configuring the TeamSettings for ImportMode YAML


	********************************************************

	     NOTE: Your admin password is: Password1

	********************************************************


Creating default staging and production environments
? Select the organization where you want to create the environment repository: jenkins-oscar
Using Git provider GitHub at https://github.com


About to create repository environment-sposcar-staging on server https://github.com with user jenkinsx-bot-sposcar


Creating repository jenkins-oscar/environment-sposcar-staging
Creating Git repository jenkins-oscar/environment-sposcar-staging
Pushed Git repository to https://github.com/jenkins-oscar/environment-sposcar-staging

Creating staging Environment in namespace jx
Created environment staging
Namespace jx-staging created

Creating GitHub webhook for jenkins-oscar/environment-sposcar-staging for url http://hook.jx.sharepointoscar.com/hook
Using Git provider GitHub at https://github.com


About to create repository environment-sposcar-production on server https://github.com with user jenkinsx-bot-sposcar


Creating repository jenkins-oscar/environment-sposcar-production
Creating Git repository jenkins-oscar/environment-sposcar-production
Pushed Git repository to https://github.com/jenkins-oscar/environment-sposcar-production

Creating production Environment in namespace jx
Created environment production
Namespace jx-production created

Creating GitHub webhook for jenkins-oscar/environment-sposcar-production for url http://hook.jx.sharepointoscar.com/hook

Jenkins X installation completed successfully


	********************************************************

	     NOTE: Your admin password is: Password1

	********************************************************



Your Kubernetes context is now set to the namespace: jx
To switch back to your original namespace use: jx namespace default
Or to use this context/namespace in just one terminal use: jx shell
For help on switching contexts see: https://jenkins-x.io/docs/using/tasks/kube-context/

To import existing projects into Jenkins:       jx import
To create a new Spring Boot microservice:       jx create spring -d web -d actuator
To create a new microservice from a quickstart: jx create quickstart
Fetching cluster endpoint and auth data.
kubeconfig entry generated for sposcar.
Context "gke_jenkinsx-dev_us-west1-a_sposcar" modified.
NAME              HOSTS                                    ADDRESS       PORTS   AGE
chartmuseum       chartmuseum.jx.sharepointoscar.com       34.83.54.46   80      4m
deck              deck.jx.sharepointoscar.com              34.83.54.46   80      4m
docker-registry   docker-registry.jx.sharepointoscar.com   34.83.54.46   80      4m
hook              hook.jx.sharepointoscar.com              34.83.54.46   80      4m
monocular         monocular.jx.sharepointoscar.com         34.83.54.46   80      4m
nexus             nexus.jx.sharepointoscar.com             34.83.54.46   80      4m
tide              tide.jx.sharepointoscar.com              34.83.54.46   80      4m

```

{{% alert %}}
**NOTE:** The final and successful output should always show us the endpoint URLs.  If you see something else, most likely your installation did not finish properly.  Typically, it helps to delete the `~/.jx` folder before trying another install.  Especially if you've run this command multiple times, there are multiple environments created and you should **only** have the ones Jenkins X is actually using to keep things working properly in my opinion.
{{% /alert %}}

So we now have a clean environment, one thing we can do to simply test our endpoints, is do an **nslookup** against any of the urls in the final output.  This helps ensure that at least DNS is setup properly.

# Creating A QuickStart - Let's Pop The Hood!

We are ready to try out the entire CI/CD process, which includes seeing the Bot work properly.  To get started, we will create a `quickstart` based on the `NodeJS` language.

```sh
> $ omedina$ jx create quickstart
Using Git provider GitHub at https://github.com
? Git user name?  [Use arrows to move, space to select, type to filter]
> sharepointoscar
  jenkinsx-bot-sposcar

```
You will select the personal Github account in this step.

{{% alert color="warning" %}}
However, if you get a *warning* message stating that the Github server username is not set, then the setup somehow was not set correctly.

<img src="/images/getting-started/warning_no_username_git_server.png"/>
<figcaption>
<h5>Figure 2 - Github Server username not set</h5>
</figcaption>
You can verify that the bot account is setup by checking the values of the secret called `jx-pipeline-git-github-github`.  In this scenario, it is `jenkinsx-bot-sposcar` as expected.

{{% /alert %}}

```sh
About to create repository  on server https://github.com with user sharepointoscar
? Which organisation do you want to use?  [Use arrows to move, space to select, type to filter]
  SPRWD
  SharePointAce
> jenkins-oscar
  sharepointoscar

```
Select the Github Organization.  In this scenario, it is `jenkins-oscar` where the bot account and the personal github accounts are members.

```sh
Creating repository jenkins-oscar/node-widget-app
? select the quickstart you wish to create  [Use arrows to move, space to select, type to filter]
  golang-http
  jenkins-cwp-quickstart
  jenkins-quickstart
> node-http
  node-http-watch-pipeline-activity
  open-liberty
  python-http

The directory /Users/omedina/git-repos/node-widget-app is not yet using git
? Would you like to initialise git now? Yes
? Commit message:  Initial import
```

Select `node-http` for the quickstart builder type. Hit enter for both of the following questions.

```sh
replacing placeholders in directory /Users/omedina/git-repos/node-widget-app
app name: node-widget-app, git server: github.com, org: jenkins-oscar, Docker registry org: jenkins-oscar
skipping directory "/Users/omedina/git-repos/node-widget-app/.git"
Pushed Git repository to https://github.com/jenkins-oscar/node-widget-app

Automatically adding the pipeline user: jenkinsx-bot-sposcar as a collaborator.
Creating GitHub webhook for jenkins-oscar/node-widget-app for url http://hook.jx.sharepointoscar.com/hook

Watch pipeline activity via:    jx get activity -f node-widget-app -w
Browse the pipeline log via:    jx get build logs jenkins-oscar/node-widget-app/master
Open the Jenkins console via    jx console
You can list the pipelines via: jx get pipelines
When the pipeline is complete:  jx get applications

For more help on available commands see: https://jenkins-x.io/docs/using/tasks/browsing/

Note that your first pipeline may take a few minutes to start while the necessary images get downloaded!
```

Final output from creating the Quickstart should look like above.

##  First Pipeline Run
Since we just created the new app, if we check on the app activtiies, we will see that there is a pull request. `jx get activity -f node-widget-app -w` and the app is now version `0.0.1` and it has been deployed to our **Staging** environment.

### Deployed to Staging

We can also check what applications are deployed, we should have version `0.0.1` in our staging environment.
```sh
APPLICATION        STAGING PODS URL
jx-node-widget-app 0.0.1   1/1  http://node-widget-app.jx-staging.sharepointoscar.com
jx-testapp2        0.0.2   1/1  http://testapp2.jx-staging.sharepointoscar.com
```
Our app is indeed in our Staging environment and accessible at (in this scenario) `http://node-widget-app.jx-staging.sharepointoscar.com`

{{% alert %}}
**NOTE:** There is a command `jx get apps`.  Do not confuse the command we executed with this one.  This command actually obtains `apps` that have been installed.  For example, on our serverless topology, we may opt to install a static jenkins as well by executing `jx add app jx-app-jenkins-x` and this will deploy a static jenkins which can now be used to put some apps thourgh either Tekton or this static jenkins master.
{{% /alert %}}

## Modifying The App
Let's modify the app to trigger a PR and see how the Bot reacts.  To make a change, we create a feature branch as per the usual developer workflow and execute `git checkout -b feature1`.

Next we change the home page verbiabe a bit, then execute `git add . && git commit -m "changed homepage"`.  Next, we push our changes with `git push --set-upstream origin feature1`.

We should now see on Github UI the Pull Request dialog.  Click that familiar Pull Request button and create it!  This triggers a **Tekton** pipeline which you can see status by tailing the `activties` for that app with this command `jx get activity -f node-widget-app -w`

## Preview Environment
Because we made a change to the app via a **Pull Request**, we are now shown the Bot in action, and it is telling us that the **PR needs approval** in addition, it has given us a way to see the changes, how dope is that?

Our PR should look as shown on the video below.

<video id="PR_Before_Approval" width="800" src="/images/getting-started/PR_BeforeApproval.mov" controls></video>

## Approving the PR (as the approver)
We now are ready to approve the PR, because after all, that nice change to the home page pleases our stakeholders after they were able to see the changes.  To approve, we simply comment exactly the following command on the Github comment box: `/approve`.

The **Approver** in this scenario is the `sharepointoscar` Github account, ideally it would be someone other than the developer itself.

<video id="PR_After_Approval" width="800" src="/images/getting-started/PR_AfterApproval.mov" controls></video>


### Bot Activity on Github
We can take a quick look at what the bot has been up to.  Here is all the activity thus far.

<img src="/images/getting-started/bot_in_action.png">

# Conclusion

In this tutorial, we walked through a full setup of Jenkins X on GKE.  We ensured that the bot account was specified at setup time.  We then created an app, and put it through CI/CD which allowed us to see the Bot in action, execute an approval command and deploy the app changes to our Staging environment.

It is always best to properly setup Jenkins with the correct Github accounts and Organization as this will give you the exact experience as a developer when interacting with Jenkins X via Github PRs.

Cheers,

[@SharePointOscar](http://twitter.com/SharePointOscar)

Developer Advocate | Jenkins X


