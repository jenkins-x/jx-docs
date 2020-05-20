---
title: Configuration Reference
linktitle: Reference
weight: 9
---
<p>Packages:</p>
<ul>
<li>
<a href="#config.jenkins.io%2fv1">config.jenkins.io/v1</a>
</li>
</ul>
<h2 id="config.jenkins.io/v1">config.jenkins.io/v1</h2>
<p>
<p>Package v1 is the v1 version of the API.</p>
</p>
Resource Types:
<ul><li>
<a href="#config.jenkins.io/v1.ProjectConfig">ProjectConfig</a>
</li></ul>
<h3 id="config.jenkins.io/v1.ProjectConfig">ProjectConfig
</h3>
<p>
<p>ProjectConfig defines Jenkins X Pipelines usually stored inside the <code>jenkins-x.yml</code> file in projects</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>apiVersion</code></br>
string</td>
<td>
<code>
config.jenkins.io/v1
</code>
</td>
</tr>
<tr>
<td>
<code>kind</code></br>
string
</td>
<td><code>ProjectConfig</code></td>
</tr>
<tr>
<td>
<code>env</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#envvar-v1-core">
[]Kubernetes core/v1.EnvVar
</a>
</em>
</td>
<td>
<p>List of global environment variables to add to each branch build and each step</p>
</td>
</tr>
<tr>
<td>
<code>previewEnvironments</code></br>
<em>
<a href="#config.jenkins.io/v1.PreviewEnvironmentConfig">
PreviewEnvironmentConfig
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>issueTracker</code></br>
<em>
<a href="#config.jenkins.io/v1.IssueTrackerConfig">
IssueTrackerConfig
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>chat</code></br>
<em>
<a href="#config.jenkins.io/v1.ChatConfig">
ChatConfig
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>wiki</code></br>
<em>
<a href="#config.jenkins.io/v1.WikiConfig">
WikiConfig
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>addons</code></br>
<em>
<a href="#config.jenkins.io/v1.*github.com/jenkins-x/jx/pkg/config.AddonConfig">
[]*github.com/jenkins-x/jx/pkg/config.AddonConfig
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>buildPack</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>buildPackGitURL</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>buildPackGitRef</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>pipelineConfig</code></br>
<em>
<a href="#config.jenkins.io/v1.PipelineConfig">
PipelineConfig
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>noReleasePrepare</code></br>
<em>
bool
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>dockerRegistryHost</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>dockerRegistryOwner</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.AddonConfig">AddonConfig
</h3>
<p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>name</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>version</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.AdminSecretsConfig">AdminSecretsConfig
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.AdminSecretsService">AdminSecretsService</a>)
</p>
<p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>JXBasicAuth</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>chartmuseum</code></br>
<em>
<a href="#config.jenkins.io/v1.ChartMuseum">
ChartMuseum
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>grafana</code></br>
<em>
<a href="#config.jenkins.io/v1.Grafana">
Grafana
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>jenkins</code></br>
<em>
<a href="#config.jenkins.io/v1.Jenkins">
Jenkins
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>nexus</code></br>
<em>
<a href="#config.jenkins.io/v1.Nexus">
Nexus
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>PipelineSecrets</code></br>
<em>
<a href="#config.jenkins.io/v1.PipelineSecrets">
PipelineSecrets
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>KanikoSecret</code></br>
<em>
<a href="#config.jenkins.io/v1.KanikoSecret">
KanikoSecret
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.AdminSecretsFlags">AdminSecretsFlags
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.AdminSecretsService">AdminSecretsService</a>)
</p>
<p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>DefaultAdminUsername</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>DefaultAdminPassword</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>KanikoSecret</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.AdminSecretsService">AdminSecretsService
</h3>
<p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>FileName</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>Secrets</code></br>
<em>
<a href="#config.jenkins.io/v1.AdminSecretsConfig">
AdminSecretsConfig
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>Flags</code></br>
<em>
<a href="#config.jenkins.io/v1.AdminSecretsFlags">
AdminSecretsFlags
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>ingressAuth</code></br>
<em>
<a href="#config.jenkins.io/v1.BasicAuth">
BasicAuth
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.Agent">Agent
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.ParsedPipeline">ParsedPipeline</a>, 
<a href="#config.jenkins.io/v1.PipelineConfig">PipelineConfig</a>, 
<a href="#config.jenkins.io/v1.PipelineOverride">PipelineOverride</a>, 
<a href="#config.jenkins.io/v1.Stage">Stage</a>, 
<a href="#config.jenkins.io/v1.Step">Step</a>)
</p>
<p>
<p>Agent defines where the pipeline, stage, or step should run.</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>label</code></br>
<em>
string
</em>
</td>
<td>
<p>One of label or image is required.</p>
</td>
</tr>
<tr>
<td>
<code>image</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>container</code></br>
<em>
string
</em>
</td>
<td>
<p>Legacy fields from jenkinsfile.PipelineAgent</p>
</td>
</tr>
<tr>
<td>
<code>dir</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.Application">Application
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.ApplicationConfig">ApplicationConfig</a>)
</p>
<p>
<p>Application is an application to install during boot</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>name</code></br>
<em>
string
</em>
</td>
<td>
<p>Name of the application / helm chart</p>
</td>
</tr>
<tr>
<td>
<code>repository</code></br>
<em>
string
</em>
</td>
<td>
<p>Repository the helm repository</p>
</td>
</tr>
<tr>
<td>
<code>namespace</code></br>
<em>
string
</em>
</td>
<td>
<p>Namespace to install the application into</p>
</td>
</tr>
<tr>
<td>
<code>phase</code></br>
<em>
<a href="#config.jenkins.io/v1.Phase">
Phase
</a>
</em>
</td>
<td>
<p>Phase of the pipeline to install application</p>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.ApplicationConfig">ApplicationConfig
</h3>
<p>
<p>ApplicationConfig contains applications to install during boot</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>applications</code></br>
<em>
<a href="#config.jenkins.io/v1.Application">
[]Application
</a>
</em>
</td>
<td>
<p>Applications of applications</p>
</td>
</tr>
<tr>
<td>
<code>defaultNamespace</code></br>
<em>
string
</em>
</td>
<td>
<p>DefaultNamespace the default namespace to install applications into</p>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.AutoUpdateConfig">AutoUpdateConfig
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.RequirementsConfig">RequirementsConfig</a>)
</p>
<p>
<p>AutoUpdateConfig contains auto update config</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>enabled</code></br>
<em>
bool
</em>
</td>
<td>
<p>Enabled autoupdate</p>
</td>
</tr>
<tr>
<td>
<code>schedule</code></br>
<em>
string
</em>
</td>
<td>
<p>Schedule cron of auto updates</p>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.AzureConfig">AzureConfig
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.ClusterConfig">ClusterConfig</a>)
</p>
<p>
<p>AzureConfig contains Azure specific requirements</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>registrySubscription</code></br>
<em>
string
</em>
</td>
<td>
<p>RegistrySubscription the registry subscription for defaulting the container registry.
Not used if you specify a Registry explicitly</p>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.BasicAuth">BasicAuth
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.AdminSecretsService">AdminSecretsService</a>)
</p>
<p>
<p>BasicAuth keeps the credentials for basic authentication</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>username</code></br>
<em>
string
</em>
</td>
<td>
<p>Username stores the basic authentication user name</p>
</td>
</tr>
<tr>
<td>
<code>password</code></br>
<em>
string
</em>
</td>
<td>
<p>Password stores the basic authentication password</p>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.CRDsFromPipelineParams">CRDsFromPipelineParams
</h3>
<p>
<p>CRDsFromPipelineParams is how the parameters to GenerateCRDs are specified</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>PipelineIdentifier</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>BuildIdentifier</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>Namespace</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>PodTemplates</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#*k8s.io/api/core/v1.pod--">
map[string]*k8s.io/api/core/v1.Pod
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>VersionsDir</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>TaskParams</code></br>
<em>
[]github.com/tektoncd/pipeline/pkg/apis/pipeline/v1alpha1.ParamSpec
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>SourceDir</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>Labels</code></br>
<em>
map[string]string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>DefaultImage</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>InterpretMode</code></br>
<em>
bool
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.ChartMuseum">ChartMuseum
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.AdminSecretsConfig">AdminSecretsConfig</a>)
</p>
<p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>env</code></br>
<em>
<a href="#config.jenkins.io/v1.ChartMuseumEnv">
ChartMuseumEnv
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.ChartMuseumEnv">ChartMuseumEnv
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.ChartMuseum">ChartMuseum</a>)
</p>
<p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>secret</code></br>
<em>
<a href="#config.jenkins.io/v1.ChartMuseumSecret">
ChartMuseumSecret
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.ChartMuseumSecret">ChartMuseumSecret
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.ChartMuseumEnv">ChartMuseumEnv</a>)
</p>
<p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>BASIC_AUTH_USER</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>BASIC_AUTH_PASS</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.ChatConfig">ChatConfig
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.ProjectConfig">ProjectConfig</a>)
</p>
<p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>kind</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>url</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>developerChannel</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>userChannel</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.ClusterConfig">ClusterConfig
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.RequirementsConfig">RequirementsConfig</a>)
</p>
<p>
<p>ClusterConfig contains cluster specific requirements</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>azure</code></br>
<em>
<a href="#config.jenkins.io/v1.AzureConfig">
AzureConfig
</a>
</em>
</td>
<td>
<p>AzureConfig the azure specific configuration</p>
</td>
</tr>
<tr>
<td>
<code>chartRepository</code></br>
<em>
string
</em>
</td>
<td>
<p>ChartRepository the repository URL to deploy charts to</p>
</td>
</tr>
<tr>
<td>
<code>gke</code></br>
<em>
<a href="#config.jenkins.io/v1.GKEConfig">
GKEConfig
</a>
</em>
</td>
<td>
<p>GKEConfig the gke specific configuration</p>
</td>
</tr>
<tr>
<td>
<code>environmentGitOwner</code></br>
<em>
string
</em>
</td>
<td>
<p>EnvironmentGitOwner the default git owner for environment repositories if none is specified explicitly</p>
</td>
</tr>
<tr>
<td>
<code>environmentGitPublic</code></br>
<em>
bool
</em>
</td>
<td>
<p>EnvironmentGitPublic determines whether jx boot create public or private git repos for the environments</p>
</td>
</tr>
<tr>
<td>
<code>gitPublic</code></br>
<em>
bool
</em>
</td>
<td>
<p>GitPublic determines whether jx boot create public or private git repos for the applications</p>
</td>
</tr>
<tr>
<td>
<code>provider</code></br>
<em>
string
</em>
</td>
<td>
<p>Provider the kubernetes provider (e.g. gke)</p>
</td>
</tr>
<tr>
<td>
<code>namespace</code></br>
<em>
string
</em>
</td>
<td>
<p>Namespace the namespace to install the dev environment</p>
</td>
</tr>
<tr>
<td>
<code>project</code></br>
<em>
string
</em>
</td>
<td>
<p>ProjectID the cloud project ID e.g. on GCP</p>
</td>
</tr>
<tr>
<td>
<code>clusterName</code></br>
<em>
string
</em>
</td>
<td>
<p>ClusterName the logical name of the cluster</p>
</td>
</tr>
<tr>
<td>
<code>vaultName</code></br>
<em>
string
</em>
</td>
<td>
<p>VaultName the name of the vault if using vault for secrets
Deprecated</p>
</td>
</tr>
<tr>
<td>
<code>region</code></br>
<em>
string
</em>
</td>
<td>
<p>Region the cloud region being used</p>
</td>
</tr>
<tr>
<td>
<code>zone</code></br>
<em>
string
</em>
</td>
<td>
<p>Zone the cloud zone being used</p>
</td>
</tr>
<tr>
<td>
<code>gitName</code></br>
<em>
string
</em>
</td>
<td>
<p>GitName is the name of the default git service</p>
</td>
</tr>
<tr>
<td>
<code>gitKind</code></br>
<em>
string
</em>
</td>
<td>
<p>GitKind is the kind of git server (github, bitbucketserver etc)</p>
</td>
</tr>
<tr>
<td>
<code>gitServer</code></br>
<em>
string
</em>
</td>
<td>
<p>GitServer is the URL of the git server</p>
</td>
</tr>
<tr>
<td>
<code>externalDNSSAName</code></br>
<em>
string
</em>
</td>
<td>
<p>ExternalDNSSAName the service account name for external dns</p>
</td>
</tr>
<tr>
<td>
<code>registry</code></br>
<em>
string
</em>
</td>
<td>
<p>Registry the host name of the container registry</p>
</td>
</tr>
<tr>
<td>
<code>vaultSAName</code></br>
<em>
string
</em>
</td>
<td>
<p>VaultSAName the service account name for vault
Deprecated</p>
</td>
</tr>
<tr>
<td>
<code>kanikoSAName</code></br>
<em>
string
</em>
</td>
<td>
<p>KanikoSAName the service account name for kaniko</p>
</td>
</tr>
<tr>
<td>
<code>helmMajorVersion</code></br>
<em>
string
</em>
</td>
<td>
<p>HelmMajorVersion contains the major helm version number. Assumes helm 2.x with no tiller if no value specified</p>
</td>
</tr>
<tr>
<td>
<code>devEnvApprovers</code></br>
<em>
[]string
</em>
</td>
<td>
<p>DevEnvApprovers contains an optional list of approvers to populate the initial OWNERS file in the dev env repo</p>
</td>
</tr>
<tr>
<td>
<code>dockerRegistryOrg</code></br>
<em>
string
</em>
</td>
<td>
<p>DockerRegistryOrg the default organisation used for container images</p>
</td>
</tr>
<tr>
<td>
<code>strictPermissions</code></br>
<em>
bool
</em>
</td>
<td>
<p>StrictPermissions lets you decide how to boot the cluster when it comes to permissions
If it&rsquo;s false, cluster wide permissions will be used, normal, namespaced permissions will be used otherwise
and extra steps will be necessary to get the cluster working</p>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.CreateJenkinsfileArguments">CreateJenkinsfileArguments
</h3>
<p>
<p>CreateJenkinsfileArguments contains the arguents to generate a Jenkinsfiles dynamically</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>ConfigFile</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>TemplateFile</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>OutputFile</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>IsTekton</code></br>
<em>
bool
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>ClearContainerNames</code></br>
<em>
bool
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.CreatePipelineArguments">CreatePipelineArguments
</h3>
<p>
<p>CreatePipelineArguments contains the arguments to translate a build pack into a pipeline</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>Lifecycles</code></br>
<em>
<a href="#config.jenkins.io/v1.PipelineLifecycles">
PipelineLifecycles
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>PodTemplates</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#*k8s.io/api/core/v1.pod--">
map[string]*k8s.io/api/core/v1.Pod
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>CustomImage</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>DefaultImage</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>WorkspaceDir</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>GitHost</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>GitName</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>GitOrg</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>ProjectID</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>DockerRegistry</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>DockerRegistryOrg</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>KanikoImage</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>UseKaniko</code></br>
<em>
bool
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>NoReleasePrepare</code></br>
<em>
bool
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>StepCounter</code></br>
<em>
int
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.EnabledConfig">EnabledConfig
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.HelmValuesConfig">HelmValuesConfig</a>)
</p>
<p>
<p>EnabledConfig to configure the feature on/off</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>enabled</code></br>
<em>
bool
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.EnvironmentConfig">EnvironmentConfig
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.RequirementsConfig">RequirementsConfig</a>)
</p>
<p>
<p>EnvironmentConfig configures the organisation and repository name of the git repositories for environments</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>key</code></br>
<em>
string
</em>
</td>
<td>
<p>Key is the key of the environment configuration</p>
</td>
</tr>
<tr>
<td>
<code>owner</code></br>
<em>
string
</em>
</td>
<td>
<p>Owner is the git user or organisation for the repository</p>
</td>
</tr>
<tr>
<td>
<code>repository</code></br>
<em>
string
</em>
</td>
<td>
<p>Repository is the name of the repository within the owner</p>
</td>
</tr>
<tr>
<td>
<code>gitServer</code></br>
<em>
string
</em>
</td>
<td>
<p>GitServer is the URL of the git server</p>
</td>
</tr>
<tr>
<td>
<code>gitKind</code></br>
<em>
string
</em>
</td>
<td>
<p>GitKind is the kind of git server (github, bitbucketserver etc)</p>
</td>
</tr>
<tr>
<td>
<code>ingress</code></br>
<em>
<a href="#config.jenkins.io/v1.IngressConfig">
IngressConfig
</a>
</em>
</td>
<td>
<p>Ingress contains ingress specific requirements</p>
</td>
</tr>
<tr>
<td>
<code>remoteCluster</code></br>
<em>
bool
</em>
</td>
<td>
<p>RemoteCluster specifies this environment runs on a remote cluster to the development cluster</p>
</td>
</tr>
<tr>
<td>
<code>promotionStrategy</code></br>
<em>
github.com/jenkins-x/jx/pkg/apis/jenkins.io/v1.PromotionStrategyType
</em>
</td>
<td>
<p>PromotionStrategy what kind of promotion strategy to use</p>
</td>
</tr>
<tr>
<td>
<code>urlTemplate</code></br>
<em>
string
</em>
</td>
<td>
<p>URLTemplate is the template to use for your environment&rsquo;s exposecontroller generated URLs</p>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.ExposeController">ExposeController
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.HelmValuesConfig">HelmValuesConfig</a>, 
<a href="#config.jenkins.io/v1.PreviewValuesConfig">PreviewValuesConfig</a>)
</p>
<p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>config</code></br>
<em>
<a href="#config.jenkins.io/v1.ExposeControllerConfig">
ExposeControllerConfig
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>Annotations</code></br>
<em>
map[string]string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>production</code></br>
<em>
bool
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.ExposeControllerConfig">ExposeControllerConfig
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.ExposeController">ExposeController</a>)
</p>
<p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>domain</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>exposer</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>http</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>tlsacme</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>pathMode</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>urltemplate</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>ingressClass</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>tlsSecretName</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.GKEConfig">GKEConfig
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.ClusterConfig">ClusterConfig</a>)
</p>
<p>
<p>GKEConfig contains GKE specific requirements</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>projectNumber</code></br>
<em>
string
</em>
</td>
<td>
<p>ProjectNumber the unique project number GKE assigns to a project (required for workload identity).</p>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.GithubAppConfig">GithubAppConfig
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.RequirementsConfig">RequirementsConfig</a>)
</p>
<p>
<p>GithubAppConfig contains github app config</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>enabled</code></br>
<em>
bool
</em>
</td>
<td>
<p>Enabled this determines whether this install should use the jenkins x github app for access tokens</p>
</td>
</tr>
<tr>
<td>
<code>schedule</code></br>
<em>
string
</em>
</td>
<td>
<p>Schedule cron of the github app token refresher</p>
</td>
</tr>
<tr>
<td>
<code>url</code></br>
<em>
string
</em>
</td>
<td>
<p>URL contains a URL to the github app</p>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.Grafana">Grafana
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.AdminSecretsConfig">AdminSecretsConfig</a>)
</p>
<p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>server</code></br>
<em>
<a href="#config.jenkins.io/v1.GrafanaSecret">
GrafanaSecret
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.GrafanaSecret">GrafanaSecret
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.Grafana">Grafana</a>)
</p>
<p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>adminUser</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>adminPassword</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.HelmValuesConfig">HelmValuesConfig
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.HelmValuesConfigService">HelmValuesConfigService</a>)
</p>
<p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>expose</code></br>
<em>
<a href="#config.jenkins.io/v1.ExposeController">
ExposeController
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>jenkins</code></br>
<em>
<a href="#config.jenkins.io/v1.JenkinsValuesConfig">
JenkinsValuesConfig
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>prow</code></br>
<em>
<a href="#config.jenkins.io/v1.ProwValuesConfig">
ProwValuesConfig
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>PipelineSecrets</code></br>
<em>
<a href="#config.jenkins.io/v1.JenkinsPipelineSecretsValuesConfig">
JenkinsPipelineSecretsValuesConfig
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>controllerbuild</code></br>
<em>
<a href="#config.jenkins.io/v1.EnabledConfig">
EnabledConfig
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>controllerworkflow</code></br>
<em>
<a href="#config.jenkins.io/v1.EnabledConfig">
EnabledConfig
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>docker-registry</code></br>
<em>
<a href="#config.jenkins.io/v1.EnabledConfig">
EnabledConfig
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>dockerRegistry</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.HelmValuesConfigService">HelmValuesConfigService
</h3>
<p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>FileName</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>Config</code></br>
<em>
<a href="#config.jenkins.io/v1.HelmValuesConfig">
HelmValuesConfig
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.Image">Image
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.Preview">Preview</a>)
</p>
<p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>repository</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>tag</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.ImportFile">ImportFile
</h3>
<p>
<p>ImportFile represents an import of a file from a module (usually a version of a git repo)</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>Import</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>File</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.ImportFileResolver">ImportFileResolver
</h3>
<p>
<p>ImportFileResolver resolves a build pack file resolver strategy</p>
</p>
<h3 id="config.jenkins.io/v1.IngressConfig">IngressConfig
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.EnvironmentConfig">EnvironmentConfig</a>, 
<a href="#config.jenkins.io/v1.RequirementsConfig">RequirementsConfig</a>)
</p>
<p>
<p>IngressConfig contains dns specific requirements</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>externalDNS</code></br>
<em>
bool
</em>
</td>
<td>
<p>DNS is enabled</p>
</td>
</tr>
<tr>
<td>
<code>cloud_dns_secret_name</code></br>
<em>
string
</em>
</td>
<td>
<p>CloudDNSSecretName secret name which contains the service account for external-dns and cert-manager issuer to
access the Cloud DNS service to resolve a DNS challenge</p>
</td>
</tr>
<tr>
<td>
<code>domain</code></br>
<em>
string
</em>
</td>
<td>
<p>Domain to expose ingress endpoints</p>
</td>
</tr>
<tr>
<td>
<code>ignoreLoadBalancer</code></br>
<em>
bool
</em>
</td>
<td>
<p>IgnoreLoadBalancer if the nginx-controller LoadBalancer service should not be used to detect and update the
domain if you are using a dynamic domain resolver like <code>.nip.io</code> rather than a real DNS configuration.
With this flag enabled the <code>Domain</code> value will be used and never re-created based on the current LoadBalancer IP address.</p>
</td>
</tr>
<tr>
<td>
<code>exposer</code></br>
<em>
string
</em>
</td>
<td>
<p>Exposer the exposer used to expose ingress endpoints. Defaults to &ldquo;Ingress&rdquo;</p>
</td>
</tr>
<tr>
<td>
<code>namespaceSubDomain</code></br>
<em>
string
</em>
</td>
<td>
<p>NamespaceSubDomain the sub domain expression to expose ingress. Defaults to &ldquo;.jx.&rdquo;</p>
</td>
</tr>
<tr>
<td>
<code>tls</code></br>
<em>
<a href="#config.jenkins.io/v1.TLSConfig">
TLSConfig
</a>
</em>
</td>
<td>
<p>TLS enable automated TLS using certmanager</p>
</td>
</tr>
<tr>
<td>
<code>domainIssuerURL</code></br>
<em>
string
</em>
</td>
<td>
<p>DomainIssuerURL contains a URL used to retrieve a Domain</p>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.IssueTrackerConfig">IssueTrackerConfig
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.ProjectConfig">ProjectConfig</a>)
</p>
<p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>kind</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>url</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>project</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.Jenkins">Jenkins
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.AdminSecretsConfig">AdminSecretsConfig</a>)
</p>
<p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>Master</code></br>
<em>
<a href="#config.jenkins.io/v1.JenkinsAdminSecret">
JenkinsAdminSecret
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.JenkinsAdminSecret">JenkinsAdminSecret
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.Jenkins">Jenkins</a>)
</p>
<p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>AdminPassword</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.JenkinsGiteaServersValuesConfig">JenkinsGiteaServersValuesConfig
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.JenkinsServersValuesConfig">JenkinsServersValuesConfig</a>)
</p>
<p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>Name</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>Url</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>Credential</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.JenkinsGithubServersValuesConfig">JenkinsGithubServersValuesConfig
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.JenkinsServersValuesConfig">JenkinsServersValuesConfig</a>)
</p>
<p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>Name</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>Url</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.JenkinsPipelineSecretsValuesConfig">JenkinsPipelineSecretsValuesConfig
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.HelmValuesConfig">HelmValuesConfig</a>)
</p>
<p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>DockerConfig,flow</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.JenkinsServersGlobalConfig">JenkinsServersGlobalConfig
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.JenkinsServersValuesConfig">JenkinsServersValuesConfig</a>)
</p>
<p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>EnvVars</code></br>
<em>
map[string]string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.JenkinsServersValuesConfig">JenkinsServersValuesConfig
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.JenkinsValuesConfig">JenkinsValuesConfig</a>)
</p>
<p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>Gitea</code></br>
<em>
<a href="#config.jenkins.io/v1.JenkinsGiteaServersValuesConfig">
[]JenkinsGiteaServersValuesConfig
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>GHE</code></br>
<em>
<a href="#config.jenkins.io/v1.JenkinsGithubServersValuesConfig">
[]JenkinsGithubServersValuesConfig
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>Global</code></br>
<em>
<a href="#config.jenkins.io/v1.JenkinsServersGlobalConfig">
JenkinsServersGlobalConfig
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.JenkinsValuesConfig">JenkinsValuesConfig
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.HelmValuesConfig">HelmValuesConfig</a>)
</p>
<p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>Servers</code></br>
<em>
<a href="#config.jenkins.io/v1.JenkinsServersValuesConfig">
JenkinsServersValuesConfig
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>enabled</code></br>
<em>
bool
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.JxInstallProfile">JxInstallProfile
</h3>
<p>
<p>JxInstallProfile contains the jx profile info</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>InstallType</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.KanikoSecret">KanikoSecret
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.AdminSecretsConfig">AdminSecretsConfig</a>)
</p>
<p>
<p>KanikoSecret store the kaniko service account</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>Data</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.Loop">Loop
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.Step">Step</a>)
</p>
<p>
<p>Loop is a special step that defines a variable, a list of possible values for that variable, and a set of steps to
repeat for each value for the variable, with the variable set with that value in the environment for the execution of
those steps.</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>variable</code></br>
<em>
string
</em>
</td>
<td>
<p>The variable name.</p>
</td>
</tr>
<tr>
<td>
<code>values</code></br>
<em>
[]string
</em>
</td>
<td>
<p>The list of values to iterate over</p>
</td>
</tr>
<tr>
<td>
<code>steps</code></br>
<em>
<a href="#config.jenkins.io/v1.Step">
[]Step
</a>
</em>
</td>
<td>
<p>The steps to run</p>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.Module">Module
</h3>
<p>
<p>Module defines a dependent module for a build pack</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>name</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>gitUrl</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>gitRef</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.Modules">Modules
</h3>
<p>
<p>Modules defines the dependent modules for a build pack</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>modules</code></br>
<em>
<a href="#config.jenkins.io/v1.*github.com/jenkins-x/jx/pkg/jenkinsfile.Module">
[]*github.com/jenkins-x/jx/pkg/jenkinsfile.Module
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.NamedLifecycle">NamedLifecycle
</h3>
<p>
<p>NamedLifecycle a lifecycle and its name</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>Name</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>Lifecycle</code></br>
<em>
<a href="#config.jenkins.io/v1.PipelineLifecycle">
PipelineLifecycle
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.Nexus">Nexus
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.AdminSecretsConfig">AdminSecretsConfig</a>)
</p>
<p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>defaultAdminPassword</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.ParsedPipeline">ParsedPipeline
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.PipelineLifecycles">PipelineLifecycles</a>, 
<a href="#config.jenkins.io/v1.Pipelines">Pipelines</a>)
</p>
<p>
<p>ParsedPipeline is the internal representation of the Pipeline, used to validate and create CRDs</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>agent</code></br>
<em>
<a href="#config.jenkins.io/v1.Agent">
Agent
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>env</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#envvar-v1-core">
[]Kubernetes core/v1.EnvVar
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>options</code></br>
<em>
<a href="#config.jenkins.io/v1.RootOptions">
RootOptions
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>stages</code></br>
<em>
<a href="#config.jenkins.io/v1.Stage">
[]Stage
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>post</code></br>
<em>
<a href="#config.jenkins.io/v1.Post">
[]Post
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>dir</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>environment</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#envvar-v1-core">
[]Kubernetes core/v1.EnvVar
</a>
</em>
</td>
<td>
<p>Replaced by Env, retained for backwards compatibility</p>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.Phase">Phase
(<code>string</code> alias)</p></h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.Application">Application</a>)
</p>
<p>
<p>Phase of the pipeline to install application</p>
</p>
<h3 id="config.jenkins.io/v1.PipelineConfig">PipelineConfig
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.ProjectConfig">ProjectConfig</a>)
</p>
<p>
<p>PipelineConfig defines the pipeline configuration</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>extends</code></br>
<em>
<a href="#config.jenkins.io/v1.PipelineExtends">
PipelineExtends
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>agent</code></br>
<em>
<a href="#config.jenkins.io/v1.Agent">
Agent
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>env</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#envvar-v1-core">
[]Kubernetes core/v1.EnvVar
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>environment</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>pipelines</code></br>
<em>
<a href="#config.jenkins.io/v1.Pipelines">
Pipelines
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>containerOptions</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#container-v1-core">
Kubernetes core/v1.Container
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.PipelineExtends">PipelineExtends
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.PipelineConfig">PipelineConfig</a>)
</p>
<p>
<p>PipelineExtends defines the extension (e.g. parent pipeline which is overloaded</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>import</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>file</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.PipelineLifecycle">PipelineLifecycle
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.NamedLifecycle">NamedLifecycle</a>, 
<a href="#config.jenkins.io/v1.PipelineLifecycles">PipelineLifecycles</a>, 
<a href="#config.jenkins.io/v1.Pipelines">Pipelines</a>)
</p>
<p>
<p>PipelineLifecycle defines the steps of a lifecycle section</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>steps</code></br>
<em>
<a href="#config.jenkins.io/v1.*github.com/jenkins-x/jx/pkg/tekton/syntax.Step">
[]*github.com/jenkins-x/jx/pkg/tekton/syntax.Step
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>preSteps</code></br>
<em>
<a href="#config.jenkins.io/v1.*github.com/jenkins-x/jx/pkg/tekton/syntax.Step">
[]*github.com/jenkins-x/jx/pkg/tekton/syntax.Step
</a>
</em>
</td>
<td>
<p>PreSteps if using inheritance then invoke these steps before the base steps</p>
</td>
</tr>
<tr>
<td>
<code>replace</code></br>
<em>
bool
</em>
</td>
<td>
<p>Replace if using inheritance then replace steps from the base pipeline</p>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.PipelineLifecycleArray">PipelineLifecycleArray
(<code>[]github.com/jenkins-x/jx/pkg/jenkinsfile.NamedLifecycle</code> alias)</p></h3>
<p>
<p>PipelineLifecycleArray an array of named lifecycle pointers</p>
</p>
<h3 id="config.jenkins.io/v1.PipelineLifecycles">PipelineLifecycles
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.CreatePipelineArguments">CreatePipelineArguments</a>, 
<a href="#config.jenkins.io/v1.Pipelines">Pipelines</a>)
</p>
<p>
<p>PipelineLifecycles defines the steps of a lifecycle section</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>setup</code></br>
<em>
<a href="#config.jenkins.io/v1.PipelineLifecycle">
PipelineLifecycle
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>setVersion</code></br>
<em>
<a href="#config.jenkins.io/v1.PipelineLifecycle">
PipelineLifecycle
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>preBuild</code></br>
<em>
<a href="#config.jenkins.io/v1.PipelineLifecycle">
PipelineLifecycle
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>build</code></br>
<em>
<a href="#config.jenkins.io/v1.PipelineLifecycle">
PipelineLifecycle
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>postBuild</code></br>
<em>
<a href="#config.jenkins.io/v1.PipelineLifecycle">
PipelineLifecycle
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>promote</code></br>
<em>
<a href="#config.jenkins.io/v1.PipelineLifecycle">
PipelineLifecycle
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>pipeline</code></br>
<em>
<a href="#config.jenkins.io/v1.ParsedPipeline">
ParsedPipeline
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.PipelineOverride">PipelineOverride
</h3>
<p>
<p>PipelineOverride allows for overriding named steps, stages, or pipelines in the build pack or default pipeline</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>pipeline</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>stage</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>name</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>step</code></br>
<em>
<a href="#config.jenkins.io/v1.Step">
Step
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>steps</code></br>
<em>
<a href="#config.jenkins.io/v1.*github.com/jenkins-x/jx/pkg/tekton/syntax.Step">
[]*github.com/jenkins-x/jx/pkg/tekton/syntax.Step
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>type</code></br>
<em>
<a href="#config.jenkins.io/v1.StepOverrideType">
StepOverrideType
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>agent</code></br>
<em>
<a href="#config.jenkins.io/v1.Agent">
Agent
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>containerOptions</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#container-v1-core">
Kubernetes core/v1.Container
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>volumes</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#*k8s.io/api/core/v1.volume--">
[]*k8s.io/api/core/v1.Volume
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.PipelineSecrets">PipelineSecrets
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.AdminSecretsConfig">AdminSecretsConfig</a>)
</p>
<p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>MavenSettingsXML</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.Pipelines">Pipelines
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.PipelineConfig">PipelineConfig</a>)
</p>
<p>
<p>Pipelines contains all the different kinds of pipeline for different branches</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>pullRequest</code></br>
<em>
<a href="#config.jenkins.io/v1.PipelineLifecycles">
PipelineLifecycles
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>release</code></br>
<em>
<a href="#config.jenkins.io/v1.PipelineLifecycles">
PipelineLifecycles
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>feature</code></br>
<em>
<a href="#config.jenkins.io/v1.PipelineLifecycles">
PipelineLifecycles
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>post</code></br>
<em>
<a href="#config.jenkins.io/v1.PipelineLifecycle">
PipelineLifecycle
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>overrides</code></br>
<em>
<a href="#config.jenkins.io/v1.*github.com/jenkins-x/jx/pkg/tekton/syntax.PipelineOverride">
[]*github.com/jenkins-x/jx/pkg/tekton/syntax.PipelineOverride
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>default</code></br>
<em>
<a href="#config.jenkins.io/v1.ParsedPipeline">
ParsedPipeline
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.Post">Post
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.ParsedPipeline">ParsedPipeline</a>, 
<a href="#config.jenkins.io/v1.Stage">Stage</a>)
</p>
<p>
<p>Post contains a PostCondition and one more actions to be executed after a pipeline or stage if the condition is met.</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>condition</code></br>
<em>
<a href="#config.jenkins.io/v1.PostCondition">
PostCondition
</a>
</em>
</td>
<td>
<p>TODO: Conditional execution of something after a Task or Pipeline completes is not yet implemented</p>
</td>
</tr>
<tr>
<td>
<code>actions</code></br>
<em>
<a href="#config.jenkins.io/v1.PostAction">
[]PostAction
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.PostAction">PostAction
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.Post">Post</a>)
</p>
<p>
<p>PostAction contains the name of a built-in post action and options to pass to that action.</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>name</code></br>
<em>
string
</em>
</td>
<td>
<p>TODO: Notifications are not yet supported in Build Pipeline per se.</p>
</td>
</tr>
<tr>
<td>
<code>options</code></br>
<em>
map[string]string
</em>
</td>
<td>
<p>Also, we&rsquo;ll need to do some magic to do type verification during translation - i.e., this action wants a number
for this option, so translate the string value for that option to a number.</p>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.PostCondition">PostCondition
(<code>string</code> alias)</p></h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.Post">Post</a>)
</p>
<p>
<p>PostCondition is used to specify under what condition a post action should be executed.</p>
</p>
<h3 id="config.jenkins.io/v1.Preview">Preview
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.PreviewValuesConfig">PreviewValuesConfig</a>)
</p>
<p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>image</code></br>
<em>
<a href="#config.jenkins.io/v1.Image">
Image
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.PreviewEnvironmentConfig">PreviewEnvironmentConfig
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.ProjectConfig">ProjectConfig</a>)
</p>
<p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>disabled</code></br>
<em>
bool
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>maximumInstances</code></br>
<em>
int
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.PreviewValuesConfig">PreviewValuesConfig
</h3>
<p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>expose</code></br>
<em>
<a href="#config.jenkins.io/v1.ExposeController">
ExposeController
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>preview</code></br>
<em>
<a href="#config.jenkins.io/v1.Preview">
Preview
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.ProwValuesConfig">ProwValuesConfig
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.HelmValuesConfig">HelmValuesConfig</a>)
</p>
<p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>user</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>hmacToken</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>oauthToken</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.RepositoryType">RepositoryType
(<code>string</code> alias)</p></h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.RequirementsConfig">RequirementsConfig</a>)
</p>
<p>
<p>RepositoryType is the type of a repository we use to store artifacts (jars, tarballs, npm packages etc)</p>
</p>
<h3 id="config.jenkins.io/v1.RequirementsConfig">RequirementsConfig
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.RequirementsValues">RequirementsValues</a>)
</p>
<p>
<p>RequirementsConfig contains the logical installation requirements in the <code>jx-requirements.yml</code> file when
installing, configuring or upgrading Jenkins X via <code>jx boot</code></p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>autoUpdate</code></br>
<em>
<a href="#config.jenkins.io/v1.AutoUpdateConfig">
AutoUpdateConfig
</a>
</em>
</td>
<td>
<p>AutoUpdate contains auto update config</p>
</td>
</tr>
<tr>
<td>
<code>bootConfigURL</code></br>
<em>
string
</em>
</td>
<td>
<p>BootConfigURL contains the url to which the dev environment is associated with</p>
</td>
</tr>
<tr>
<td>
<code>cluster</code></br>
<em>
<a href="#config.jenkins.io/v1.ClusterConfig">
ClusterConfig
</a>
</em>
</td>
<td>
<p>Cluster contains cluster specific requirements</p>
</td>
</tr>
<tr>
<td>
<code>environments</code></br>
<em>
<a href="#config.jenkins.io/v1.EnvironmentConfig">
[]EnvironmentConfig
</a>
</em>
</td>
<td>
<p>Environments the requirements for the environments</p>
</td>
</tr>
<tr>
<td>
<code>githubApp</code></br>
<em>
<a href="#config.jenkins.io/v1.GithubAppConfig">
GithubAppConfig
</a>
</em>
</td>
<td>
<p>GithubApp contains github app config</p>
</td>
</tr>
<tr>
<td>
<code>gitops</code></br>
<em>
bool
</em>
</td>
<td>
<p>GitOps if enabled we will setup a webhook in the boot configuration git repository so that we can
re-run &lsquo;jx boot&rsquo; when changes merge to the master branch</p>
</td>
</tr>
<tr>
<td>
<code>helmfile</code></br>
<em>
bool
</em>
</td>
<td>
<p>Indicates if we are using helmfile and helm 3 to spin up environments. This is currently an experimental
feature flag used to implement better Multi-Cluster support. See <a href="https://github.com/jenkins-x/jx/issues/6442">https://github.com/jenkins-x/jx/issues/6442</a></p>
</td>
</tr>
<tr>
<td>
<code>kaniko</code></br>
<em>
bool
</em>
</td>
<td>
<p>Kaniko whether to enable kaniko for building docker images</p>
</td>
</tr>
<tr>
<td>
<code>ingress</code></br>
<em>
<a href="#config.jenkins.io/v1.IngressConfig">
IngressConfig
</a>
</em>
</td>
<td>
<p>Ingress contains ingress specific requirements</p>
</td>
</tr>
<tr>
<td>
<code>repository</code></br>
<em>
<a href="#config.jenkins.io/v1.RepositoryType">
RepositoryType
</a>
</em>
</td>
<td>
<p>Repository specifies what kind of artifact repository you wish to use for storing artifacts (jars, tarballs, npm modules etc)</p>
</td>
</tr>
<tr>
<td>
<code>secretStorage</code></br>
<em>
<a href="#config.jenkins.io/v1.SecretStorageType">
SecretStorageType
</a>
</em>
</td>
<td>
<p>SecretStorage how should we store secrets for the cluster</p>
</td>
</tr>
<tr>
<td>
<code>storage</code></br>
<em>
<a href="#config.jenkins.io/v1.StorageConfig">
StorageConfig
</a>
</em>
</td>
<td>
<p>Storage contains storage requirements</p>
</td>
</tr>
<tr>
<td>
<code>terraform</code></br>
<em>
bool
</em>
</td>
<td>
<p>Terraform specifies if  we are managing the kubernetes cluster and cloud resources with Terraform</p>
</td>
</tr>
<tr>
<td>
<code>vault</code></br>
<em>
<a href="#config.jenkins.io/v1.VaultConfig">
VaultConfig
</a>
</em>
</td>
<td>
<p>Vault the configuration for vault</p>
</td>
</tr>
<tr>
<td>
<code>velero</code></br>
<em>
<a href="#config.jenkins.io/v1.VeleroConfig">
VeleroConfig
</a>
</em>
</td>
<td>
<p>Velero the configuration for running velero for backing up the cluster resources</p>
</td>
</tr>
<tr>
<td>
<code>versionStream</code></br>
<em>
<a href="#config.jenkins.io/v1.VersionStreamConfig">
VersionStreamConfig
</a>
</em>
</td>
<td>
<p>VersionStream contains version stream info</p>
</td>
</tr>
<tr>
<td>
<code>webhook</code></br>
<em>
<a href="#config.jenkins.io/v1.WebhookType">
WebhookType
</a>
</em>
</td>
<td>
<p>Webhook specifies what engine we should use for webhooks</p>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.RequirementsValues">RequirementsValues
</h3>
<p>
<p>RequirementsValues contains the logical installation requirements in the <code>jx-requirements.yml</code> file as helm values</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>jxRequirements</code></br>
<em>
<a href="#config.jenkins.io/v1.RequirementsConfig">
RequirementsConfig
</a>
</em>
</td>
<td>
<p>RequirementsConfig contains the logical installation requirements</p>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.RootOptions">RootOptions
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.ParsedPipeline">ParsedPipeline</a>, 
<a href="#config.jenkins.io/v1.StageOptions">StageOptions</a>)
</p>
<p>
<p>RootOptions contains options that can be configured on either a pipeline or a stage</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>timeout</code></br>
<em>
<a href="#config.jenkins.io/v1.Timeout">
Timeout
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>retry</code></br>
<em>
byte
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>containerOptions</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#container-v1-core">
Kubernetes core/v1.Container
</a>
</em>
</td>
<td>
<p>ContainerOptions allows for advanced configuration of containers for a single stage or the whole
pipeline, adding to configuration that can be configured through the syntax already. This includes things
like CPU/RAM requests/limits, secrets, ports, etc. Some of these things will end up with native syntax approaches
down the road.</p>
</td>
</tr>
<tr>
<td>
<code>volumes</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#*k8s.io/api/core/v1.volume--">
[]*k8s.io/api/core/v1.Volume
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>distributeParallelAcrossNodes</code></br>
<em>
bool
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>tolerations</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#toleration-v1-core">
[]Kubernetes core/v1.Toleration
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>podLabels</code></br>
<em>
map[string]string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.SecretStorageType">SecretStorageType
(<code>string</code> alias)</p></h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.RequirementsConfig">RequirementsConfig</a>)
</p>
<p>
<p>SecretStorageType is the type of storage used for secrets</p>
</p>
<h3 id="config.jenkins.io/v1.Stage">Stage
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.ParsedPipeline">ParsedPipeline</a>, 
<a href="#config.jenkins.io/v1.Stage">Stage</a>)
</p>
<p>
<p>Stage is a unit of work in a pipeline, corresponding either to a Task or a set of Tasks to be run sequentially or in
parallel with common configuration.</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>name</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>agent</code></br>
<em>
<a href="#config.jenkins.io/v1.Agent">
Agent
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>env</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#envvar-v1-core">
[]Kubernetes core/v1.EnvVar
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>options</code></br>
<em>
<a href="#config.jenkins.io/v1.StageOptions">
StageOptions
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>steps</code></br>
<em>
<a href="#config.jenkins.io/v1.Step">
[]Step
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>stages</code></br>
<em>
<a href="#config.jenkins.io/v1.Stage">
[]Stage
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>parallel</code></br>
<em>
<a href="#config.jenkins.io/v1.Stage">
[]Stage
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>post</code></br>
<em>
<a href="#config.jenkins.io/v1.Post">
[]Post
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>dir</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>environment</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#envvar-v1-core">
[]Kubernetes core/v1.EnvVar
</a>
</em>
</td>
<td>
<p>Replaced by Env, retained for backwards compatibility</p>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.StageOptions">StageOptions
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.Stage">Stage</a>)
</p>
<p>
<p>StageOptions contains both options that can be configured on either a pipeline or a stage, via
RootOptions, or stage-specific options.</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>RootOptions</code></br>
<em>
<a href="#config.jenkins.io/v1.RootOptions">
RootOptions
</a>
</em>
</td>
<td>
<p>
(Members of <code>RootOptions</code> are embedded into this type.)
</p>
</td>
</tr>
<tr>
<td>
<code>stash</code></br>
<em>
<a href="#config.jenkins.io/v1.Stash">
Stash
</a>
</em>
</td>
<td>
<p>TODO: Not yet implemented in build-pipeline</p>
</td>
</tr>
<tr>
<td>
<code>unstash</code></br>
<em>
<a href="#config.jenkins.io/v1.Unstash">
Unstash
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>workspace</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.Stash">Stash
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.StageOptions">StageOptions</a>)
</p>
<p>
<p>Stash defines files to be saved for use in a later stage, marked with a name</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>name</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>files</code></br>
<em>
string
</em>
</td>
<td>
<p>Eventually make this optional so that you can do volumes instead</p>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.Step">Step
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.Loop">Loop</a>, 
<a href="#config.jenkins.io/v1.PipelineOverride">PipelineOverride</a>, 
<a href="#config.jenkins.io/v1.Stage">Stage</a>)
</p>
<p>
<p>Step defines a single step, from the author&rsquo;s perspective, to be executed within a stage.</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>name</code></br>
<em>
string
</em>
</td>
<td>
<p>An optional name to give the step for reporting purposes</p>
</td>
</tr>
<tr>
<td>
<code>command</code></br>
<em>
string
</em>
</td>
<td>
<p>One of command, step, or loop is required.</p>
</td>
</tr>
<tr>
<td>
<code>args</code></br>
<em>
[]string
</em>
</td>
<td>
<p>args is optional, but only allowed with command</p>
</td>
</tr>
<tr>
<td>
<code>dir</code></br>
<em>
string
</em>
</td>
<td>
<p>dir is optional, but only allowed with command. Refers to subdirectory of workspace</p>
</td>
</tr>
<tr>
<td>
<code>step</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>options</code></br>
<em>
map[string]string
</em>
</td>
<td>
<p>options is optional, but only allowed with step
Also, we&rsquo;ll need to do some magic to do type verification during translation - i.e., this step wants a number
for this option, so translate the string value for that option to a number.</p>
</td>
</tr>
<tr>
<td>
<code>loop</code></br>
<em>
<a href="#config.jenkins.io/v1.Loop">
Loop
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>agent</code></br>
<em>
<a href="#config.jenkins.io/v1.Agent">
Agent
</a>
</em>
</td>
<td>
<p>agent can be overridden on a step</p>
</td>
</tr>
<tr>
<td>
<code>image</code></br>
<em>
string
</em>
</td>
<td>
<p>Image alows the docker image for a step to be specified</p>
</td>
</tr>
<tr>
<td>
<code>env</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#envvar-v1-core">
[]Kubernetes core/v1.EnvVar
</a>
</em>
</td>
<td>
<p>env allows defining per-step environment variables</p>
</td>
</tr>
<tr>
<td>
<code>comment</code></br>
<em>
string
</em>
</td>
<td>
<p>Legacy fields from jenkinsfile.PipelineStep before it was eliminated.</p>
</td>
</tr>
<tr>
<td>
<code>groovy</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>steps</code></br>
<em>
<a href="#config.jenkins.io/v1.*github.com/jenkins-x/jx/pkg/tekton/syntax.Step">
[]*github.com/jenkins-x/jx/pkg/tekton/syntax.Step
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>when</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>container</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>sh</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.StepOverrideType">StepOverrideType
(<code>string</code> alias)</p></h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.PipelineOverride">PipelineOverride</a>)
</p>
<p>
<p>StepOverrideType is used to specify whether the existing step should be replaced (default), new step(s) should be
prepended before the existing step, or new step(s) should be appended after the existing step.</p>
</p>
<h3 id="config.jenkins.io/v1.StepPlaceholderReplacementArgs">StepPlaceholderReplacementArgs
</h3>
<p>
<p>StepPlaceholderReplacementArgs specifies the arguments required for replacing placeholders in build pack directories.</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>WorkspaceDir</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>GitName</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>GitOrg</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>GitHost</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>DockerRegistry</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>DockerRegistryOrg</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>ProjectID</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>KanikoImage</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>UseKaniko</code></br>
<em>
bool
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.StorageConfig">StorageConfig
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.RequirementsConfig">RequirementsConfig</a>)
</p>
<p>
<p>StorageConfig contains dns specific requirements</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>logs</code></br>
<em>
<a href="#config.jenkins.io/v1.StorageEntryConfig">
StorageEntryConfig
</a>
</em>
</td>
<td>
<p>Logs for storing build logs</p>
</td>
</tr>
<tr>
<td>
<code>reports</code></br>
<em>
<a href="#config.jenkins.io/v1.StorageEntryConfig">
StorageEntryConfig
</a>
</em>
</td>
<td>
<p>Tests for storing test results, coverage + code quality reports</p>
</td>
</tr>
<tr>
<td>
<code>repository</code></br>
<em>
<a href="#config.jenkins.io/v1.StorageEntryConfig">
StorageEntryConfig
</a>
</em>
</td>
<td>
<p>Repository for storing repository artifacts</p>
</td>
</tr>
<tr>
<td>
<code>backup</code></br>
<em>
<a href="#config.jenkins.io/v1.StorageEntryConfig">
StorageEntryConfig
</a>
</em>
</td>
<td>
<p>Backup for backing up kubernetes resource</p>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.StorageEntryConfig">StorageEntryConfig
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.StorageConfig">StorageConfig</a>)
</p>
<p>
<p>StorageEntryConfig contains dns specific requirements for a kind of storage</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>enabled</code></br>
<em>
bool
</em>
</td>
<td>
<p>Enabled if the storage is enabled</p>
</td>
</tr>
<tr>
<td>
<code>url</code></br>
<em>
string
</em>
</td>
<td>
<p>URL the cloud storage bucket URL such as &lsquo;gs://mybucket&rsquo; or &lsquo;s3://foo&rsquo; or `azblob://thingy&rsquo;
see <a href="https://jenkins-x.io/architecture/storage/">https://jenkins-x.io/architecture/storage/</a></p>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.TLSConfig">TLSConfig
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.IngressConfig">IngressConfig</a>)
</p>
<p>
<p>TLSConfig contains TLS specific requirements</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>enabled</code></br>
<em>
bool
</em>
</td>
<td>
<p>TLS enabled</p>
</td>
</tr>
<tr>
<td>
<code>email</code></br>
<em>
string
</em>
</td>
<td>
<p>Email address to register with services like LetsEncrypt</p>
</td>
</tr>
<tr>
<td>
<code>production</code></br>
<em>
bool
</em>
</td>
<td>
<p>Production false uses self-signed certificates from the LetsEncrypt staging server, true enables the production
server which incurs higher rate limiting <a href="https://letsencrypt.org/docs/rate-limits/">https://letsencrypt.org/docs/rate-limits/</a></p>
</td>
</tr>
<tr>
<td>
<code>secretName</code></br>
<em>
string
</em>
</td>
<td>
<p>SecretName the name of the secret which contains the TLS certificate</p>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.Timeout">Timeout
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.RootOptions">RootOptions</a>)
</p>
<p>
<p>Timeout defines how long a stage or pipeline can run before timing out.</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>time</code></br>
<em>
int64
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>unit</code></br>
<em>
<a href="#config.jenkins.io/v1.TimeoutUnit">
TimeoutUnit
</a>
</em>
</td>
<td>
<p>Has some sane default - probably seconds</p>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.TimeoutUnit">TimeoutUnit
(<code>string</code> alias)</p></h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.Timeout">Timeout</a>)
</p>
<p>
<p>TimeoutUnit is used for calculating timeout duration</p>
</p>
<h3 id="config.jenkins.io/v1.Unstash">Unstash
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.StageOptions">StageOptions</a>)
</p>
<p>
<p>Unstash defines a previously-defined stash to be copied into this stage&rsquo;s workspace</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>name</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>dir</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.VaultAWSConfig">VaultAWSConfig
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.VaultConfig">VaultConfig</a>)
</p>
<p>
<p>VaultAWSConfig contains all the Vault configuration needed by Vault to be deployed in AWS</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>VaultAWSUnsealConfig</code></br>
<em>
<a href="#config.jenkins.io/v1.VaultAWSUnsealConfig">
VaultAWSUnsealConfig
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>autoCreate</code></br>
<em>
bool
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>dynamoDBTable</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>dynamoDBRegion</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>iamUserName</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.VaultAWSUnsealConfig">VaultAWSUnsealConfig
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.VaultAWSConfig">VaultAWSConfig</a>)
</p>
<p>
<p>VaultAWSUnsealConfig contains references to existing AWS resources that can be used to install Vault</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>kmsKeyId</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>kmsRegion</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>s3Bucket</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>s3Prefix</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>s3Region</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.VaultConfig">VaultConfig
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.RequirementsConfig">RequirementsConfig</a>)
</p>
<p>
<p>VaultConfig contains Vault configuration for boot</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>name</code></br>
<em>
string
</em>
</td>
<td>
<p>Name the name of the vault if using vault for secrets</p>
</td>
</tr>
<tr>
<td>
<code>bucket</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>keyring</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>key</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>serviceAccount</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>recreateBucket</code></br>
<em>
bool
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>disableURLDiscovery</code></br>
<em>
bool
</em>
</td>
<td>
<p>Optionally allow us to override the default lookup of the Vault URL, could be incluster service or external ingress</p>
</td>
</tr>
<tr>
<td>
<code>aws</code></br>
<em>
<a href="#config.jenkins.io/v1.VaultAWSConfig">
VaultAWSConfig
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.VeleroConfig">VeleroConfig
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.RequirementsConfig">RequirementsConfig</a>)
</p>
<p>
<p>VeleroConfig contains the configuration for velero</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>namespace</code></br>
<em>
string
</em>
</td>
<td>
<p>Namespace the namespace to install velero into</p>
</td>
</tr>
<tr>
<td>
<code>serviceAccount</code></br>
<em>
string
</em>
</td>
<td>
<p>ServiceAccount the cloud service account used to run velero</p>
</td>
</tr>
<tr>
<td>
<code>schedule</code></br>
<em>
string
</em>
</td>
<td>
<p>Schedule of backups</p>
</td>
</tr>
<tr>
<td>
<code>ttl</code></br>
<em>
string
</em>
</td>
<td>
<p>TimeToLive period for backups to be retained</p>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.VersionStreamConfig">VersionStreamConfig
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.RequirementsConfig">RequirementsConfig</a>)
</p>
<p>
<p>VersionStreamConfig contains version stream config</p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>url</code></br>
<em>
string
</em>
</td>
<td>
<p>URL of the version stream to use</p>
</td>
</tr>
<tr>
<td>
<code>ref</code></br>
<em>
string
</em>
</td>
<td>
<p>Ref of the version stream to use</p>
</td>
</tr>
</tbody>
</table>
<h3 id="config.jenkins.io/v1.WebhookType">WebhookType
(<code>string</code> alias)</p></h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.RequirementsConfig">RequirementsConfig</a>)
</p>
<p>
<p>WebhookType is the type of a webhook strategy</p>
</p>
<h3 id="config.jenkins.io/v1.WikiConfig">WikiConfig
</h3>
<p>
(<em>Appears on:</em>
<a href="#config.jenkins.io/v1.ProjectConfig">ProjectConfig</a>)
</p>
<p>
</p>
<table>
<thead>
<tr>
<th>Field</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<code>kind</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>url</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>space</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<hr/>
<p><em>
Generated with <code>gen-crd-api-reference-docs</code>
on git commit <code>830820e33</code>.
</em></p>
