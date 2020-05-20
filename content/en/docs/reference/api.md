---
title: API Documentation
linktitle: API Documentation
description: Reference of the Jenkins X REST APIs and custom resources
weight: 10
---
<p>Packages:</p>
<ul>
<li>
<a href="#jenkins.io%2fv1">jenkins.io/v1</a>
</li>
</ul>
<h2 id="jenkins.io/v1">jenkins.io/v1</h2>
<p>
<p>Package v1 is the v1 version of the API.</p>
</p>
Resource Types:
<ul><li>
<a href="#jenkins.io/v1.App">App</a>
</li><li>
<a href="#jenkins.io/v1.BuildPack">BuildPack</a>
</li><li>
<a href="#jenkins.io/v1.CommitStatus">CommitStatus</a>
</li><li>
<a href="#jenkins.io/v1.Environment">Environment</a>
</li><li>
<a href="#jenkins.io/v1.EnvironmentRoleBinding">EnvironmentRoleBinding</a>
</li><li>
<a href="#jenkins.io/v1.Extension">Extension</a>
</li><li>
<a href="#jenkins.io/v1.Fact">Fact</a>
</li><li>
<a href="#jenkins.io/v1.GitService">GitService</a>
</li><li>
<a href="#jenkins.io/v1.PipelineActivity">PipelineActivity</a>
</li><li>
<a href="#jenkins.io/v1.PipelineStructure">PipelineStructure</a>
</li><li>
<a href="#jenkins.io/v1.Plugin">Plugin</a>
</li><li>
<a href="#jenkins.io/v1.Release">Release</a>
</li><li>
<a href="#jenkins.io/v1.Scheduler">Scheduler</a>
</li><li>
<a href="#jenkins.io/v1.SourceRepository">SourceRepository</a>
</li><li>
<a href="#jenkins.io/v1.SourceRepositoryGroup">SourceRepositoryGroup</a>
</li><li>
<a href="#jenkins.io/v1.Team">Team</a>
</li><li>
<a href="#jenkins.io/v1.User">User</a>
</li><li>
<a href="#jenkins.io/v1.Workflow">Workflow</a>
</li></ul>
<h3 id="jenkins.io/v1.App">App
</h3>
<p>
<p>App is the metadata for an App</p>
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
jenkins.io/v1
</code>
</td>
</tr>
<tr>
<td>
<code>kind</code></br>
string
</td>
<td><code>App</code></td>
</tr>
<tr>
<td>
<code>metadata</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#objectmeta-v1-meta">
Kubernetes meta/v1.ObjectMeta
</a>
</em>
</td>
<td>
<em>(Optional)</em>
<p>Standard object&rsquo;s metadata.
More info: <a href="https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata">https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata</a></p>
Refer to the Kubernetes API documentation for the fields of the
<code>metadata</code> field.
</td>
</tr>
<tr>
<td>
<code>spec</code></br>
<em>
<a href="#jenkins.io/v1.AppSpec">
AppSpec
</a>
</em>
</td>
<td>
<br/>
<br/>
<table>
<tr>
<td>
<code>schemaPreprocessor</code></br>
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
<code>schemaPreprocessorRole</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#role-v1-rbac">
Kubernetes rbac/v1.Role
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>pipelineExtension</code></br>
<em>
<a href="#jenkins.io/v1.PipelineExtension">
PipelineExtension
</a>
</em>
</td>
<td>
</td>
</tr>
</table>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.BuildPack">BuildPack
</h3>
<p>
<p>BuildPack represents a set of language specific build packs and associated quickstarts</p>
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
jenkins.io/v1
</code>
</td>
</tr>
<tr>
<td>
<code>kind</code></br>
string
</td>
<td><code>BuildPack</code></td>
</tr>
<tr>
<td>
<code>metadata</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#objectmeta-v1-meta">
Kubernetes meta/v1.ObjectMeta
</a>
</em>
</td>
<td>
<em>(Optional)</em>
<p>Standard object&rsquo;s metadata.
More info: <a href="https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata">https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata</a></p>
Refer to the Kubernetes API documentation for the fields of the
<code>metadata</code> field.
</td>
</tr>
<tr>
<td>
<code>spec</code></br>
<em>
<a href="#jenkins.io/v1.BuildPackSpec">
BuildPackSpec
</a>
</em>
</td>
<td>
<br/>
<br/>
<table>
<tr>
<td>
<code>label</code></br>
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
<tr>
<td>
<code>quickstartLocations</code></br>
<em>
<a href="#jenkins.io/v1.QuickStartLocation">
[]QuickStartLocation
</a>
</em>
</td>
<td>
</td>
</tr>
</table>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.CommitStatus">CommitStatus
</h3>
<p>
<p>CommitStatus represents the commit statuses for a particular pull request</p>
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
jenkins.io/v1
</code>
</td>
</tr>
<tr>
<td>
<code>kind</code></br>
string
</td>
<td><code>CommitStatus</code></td>
</tr>
<tr>
<td>
<code>metadata</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#objectmeta-v1-meta">
Kubernetes meta/v1.ObjectMeta
</a>
</em>
</td>
<td>
<em>(Optional)</em>
<p>Standard object&rsquo;s metadata.
More info: <a href="https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata">https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata</a></p>
Refer to the Kubernetes API documentation for the fields of the
<code>metadata</code> field.
</td>
</tr>
<tr>
<td>
<code>spec</code></br>
<em>
<a href="#jenkins.io/v1.CommitStatusSpec">
CommitStatusSpec
</a>
</em>
</td>
<td>
<br/>
<br/>
<table>
<tr>
<td>
<code>items</code></br>
<em>
<a href="#jenkins.io/v1.CommitStatusDetails">
[]CommitStatusDetails
</a>
</em>
</td>
<td>
</td>
</tr>
</table>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.Environment">Environment
</h3>
<p>
<p>Environment represents an environment like Dev, Test, Staging, Production where code lives</p>
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
jenkins.io/v1
</code>
</td>
</tr>
<tr>
<td>
<code>kind</code></br>
string
</td>
<td><code>Environment</code></td>
</tr>
<tr>
<td>
<code>metadata</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#objectmeta-v1-meta">
Kubernetes meta/v1.ObjectMeta
</a>
</em>
</td>
<td>
<em>(Optional)</em>
<p>Standard object&rsquo;s metadata.
More info: <a href="https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata">https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata</a></p>
Refer to the Kubernetes API documentation for the fields of the
<code>metadata</code> field.
</td>
</tr>
<tr>
<td>
<code>spec</code></br>
<em>
<a href="#jenkins.io/v1.EnvironmentSpec">
EnvironmentSpec
</a>
</em>
</td>
<td>
<br/>
<br/>
<table>
<tr>
<td>
<code>label</code></br>
<em>
string
</em>
</td>
<td>
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
</td>
</tr>
<tr>
<td>
<code>cluster</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>promotionStrategy</code></br>
<em>
<a href="#jenkins.io/v1.PromotionStrategyType">
PromotionStrategyType
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>source</code></br>
<em>
<a href="#jenkins.io/v1.EnvironmentRepository">
EnvironmentRepository
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>order</code></br>
<em>
int32
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>kind</code></br>
<em>
<a href="#jenkins.io/v1.EnvironmentKindType">
EnvironmentKindType
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>pullRequestURL</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>teamSettings</code></br>
<em>
<a href="#jenkins.io/v1.TeamSettings">
TeamSettings
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>previewGitInfo</code></br>
<em>
<a href="#jenkins.io/v1.PreviewGitSpec">
PreviewGitSpec
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>webHookEngine</code></br>
<em>
<a href="#jenkins.io/v1.WebHookEngineType">
WebHookEngineType
</a>
</em>
</td>
<td>
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
<p>RemoteCluster flag indicates if the Environment is deployed in a separate cluster to the Development Environment</p>
</td>
</tr>
</table>
</td>
</tr>
<tr>
<td>
<code>status</code></br>
<em>
<a href="#jenkins.io/v1.EnvironmentStatus">
EnvironmentStatus
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.EnvironmentRoleBinding">EnvironmentRoleBinding
</h3>
<p>
<p>EnvironmentRoleBinding is like a vanilla RoleBinding but applies to a set of Namespaces based on an Environment filter
so that roles can be bound to multiple namespaces easily.</p>
<p>For example to specify the binding of roles on all Preview environments or on all permanent environments.</p>
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
jenkins.io/v1
</code>
</td>
</tr>
<tr>
<td>
<code>kind</code></br>
string
</td>
<td><code>EnvironmentRoleBinding</code></td>
</tr>
<tr>
<td>
<code>metadata</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#objectmeta-v1-meta">
Kubernetes meta/v1.ObjectMeta
</a>
</em>
</td>
<td>
<em>(Optional)</em>
<p>Standard object&rsquo;s metadata.
More info: <a href="https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata">https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata</a></p>
Refer to the Kubernetes API documentation for the fields of the
<code>metadata</code> field.
</td>
</tr>
<tr>
<td>
<code>spec</code></br>
<em>
<a href="#jenkins.io/v1.EnvironmentRoleBindingSpec">
EnvironmentRoleBindingSpec
</a>
</em>
</td>
<td>
<br/>
<br/>
<table>
<tr>
<td>
<code>subjects</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#subject-v1-rbac">
[]Kubernetes rbac/v1.Subject
</a>
</em>
</td>
<td>
<p>Subjects holds references to the objects the role applies to.</p>
</td>
</tr>
<tr>
<td>
<code>roleRef</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#roleref-v1-rbac">
Kubernetes rbac/v1.RoleRef
</a>
</em>
</td>
<td>
<p>RoleRef can reference a Role in the current namespace or a ClusterRole in the global namespace.
If the RoleRef cannot be resolved, the Authorizer must return an error.</p>
</td>
</tr>
<tr>
<td>
<code>environments</code></br>
<em>
<a href="#jenkins.io/v1.EnvironmentFilter">
[]EnvironmentFilter
</a>
</em>
</td>
<td>
<p>specifies which sets of environments this binding applies to</p>
</td>
</tr>
</table>
</td>
</tr>
<tr>
<td>
<code>status</code></br>
<em>
<a href="#jenkins.io/v1.EnvironmentRoleBindingStatus">
EnvironmentRoleBindingStatus
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.Extension">Extension
</h3>
<p>
<p>Extension represents an extension available to this Jenkins X install</p>
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
jenkins.io/v1
</code>
</td>
</tr>
<tr>
<td>
<code>kind</code></br>
string
</td>
<td><code>Extension</code></td>
</tr>
<tr>
<td>
<code>metadata</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#objectmeta-v1-meta">
Kubernetes meta/v1.ObjectMeta
</a>
</em>
</td>
<td>
<em>(Optional)</em>
<p>Standard object&rsquo;s metadata.
More info: <a href="https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata">https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata</a></p>
Refer to the Kubernetes API documentation for the fields of the
<code>metadata</code> field.
</td>
</tr>
<tr>
<td>
<code>spec</code></br>
<em>
<a href="#jenkins.io/v1.ExtensionSpec">
ExtensionSpec
</a>
</em>
</td>
<td>
<br/>
<br/>
<table>
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
<code>description</code></br>
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
<tr>
<td>
<code>script</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>when</code></br>
<em>
<a href="#jenkins.io/v1.ExtensionWhen">
[]ExtensionWhen
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>given</code></br>
<em>
<a href="#jenkins.io/v1.ExtensionGiven">
ExtensionGiven
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>parameters</code></br>
<em>
<a href="#jenkins.io/v1.ExtensionParameter">
[]ExtensionParameter
</a>
</em>
</td>
<td>
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
</td>
</tr>
<tr>
<td>
<code>uuid</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>children</code></br>
<em>
[]string
</em>
</td>
<td>
</td>
</tr>
</table>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.Fact">Fact
</h3>
<p>
<p>Fact represents observed facts. Apps will generate Facts about the system.
A naming schema is required since each Fact has a name that&rsquo;s unique for the whole system.
Apps should prefix their generated Facts with the name of the App, like <app-name>-<fact>.
This makes that different Apps can&rsquo;t possibly have conflicting Fact names.</p>
<p>For an app generating facts on a pipeline, which will be have several different executions, we recommend <app>-<fact>-<pipeline>.</p>
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
jenkins.io/v1
</code>
</td>
</tr>
<tr>
<td>
<code>kind</code></br>
string
</td>
<td><code>Fact</code></td>
</tr>
<tr>
<td>
<code>metadata</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#objectmeta-v1-meta">
Kubernetes meta/v1.ObjectMeta
</a>
</em>
</td>
<td>
<em>(Optional)</em>
<p>The Fact labels will be used to query the API for interesting Facts.
The Apps responsible for creating Facts need to add the relevant labels.
For example, creating Facts on a pipeline would create Facts with the following labels
{
subjectkind: PipelineActivity
pipelineName: my-org-my-app-master-23
org: my-org
repo: my-app
branch: master
buildNumber: 23
}</p>
Refer to the Kubernetes API documentation for the fields of the
<code>metadata</code> field.
</td>
</tr>
<tr>
<td>
<code>spec</code></br>
<em>
<a href="#jenkins.io/v1.FactSpec">
FactSpec
</a>
</em>
</td>
<td>
<br/>
<br/>
<table>
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
<code>factType</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>measurements</code></br>
<em>
<a href="#jenkins.io/v1.Measurement">
[]Measurement
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>statements</code></br>
<em>
<a href="#jenkins.io/v1.Statement">
[]Statement
</a>
</em>
</td>
<td>
<em>(Optional)</em>
</td>
</tr>
<tr>
<td>
<code>original</code></br>
<em>
<a href="#jenkins.io/v1.Original">
Original
</a>
</em>
</td>
<td>
<em>(Optional)</em>
</td>
</tr>
<tr>
<td>
<code>tags</code></br>
<em>
[]string
</em>
</td>
<td>
<em>(Optional)</em>
</td>
</tr>
<tr>
<td>
<code>subject</code></br>
<em>
<a href="#jenkins.io/v1.ResourceReference">
ResourceReference
</a>
</em>
</td>
<td>
</td>
</tr>
</table>
</td>
</tr>
<tr>
<td>
<code>status</code></br>
<em>
<a href="#jenkins.io/v1.FactStatus">
FactStatus
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.GitService">GitService
</h3>
<p>
<p>GitService represents a git provider so we can map the host name to a kinda of git service</p>
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
jenkins.io/v1
</code>
</td>
</tr>
<tr>
<td>
<code>kind</code></br>
string
</td>
<td><code>GitService</code></td>
</tr>
<tr>
<td>
<code>metadata</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#objectmeta-v1-meta">
Kubernetes meta/v1.ObjectMeta
</a>
</em>
</td>
<td>
<em>(Optional)</em>
<p>Standard object&rsquo;s metadata.
More info: <a href="https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata">https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata</a></p>
Refer to the Kubernetes API documentation for the fields of the
<code>metadata</code> field.
</td>
</tr>
<tr>
<td>
<code>spec</code></br>
<em>
<a href="#jenkins.io/v1.GitServiceSpec">
GitServiceSpec
</a>
</em>
</td>
<td>
<br/>
<br/>
<table>
<tr>
<td>
<code>gitKind</code></br>
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
<code>name</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</table>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.PipelineActivity">PipelineActivity
</h3>
<p>
<p>PipelineActivity represents pipeline activity for a particular run of a pipeline</p>
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
jenkins.io/v1
</code>
</td>
</tr>
<tr>
<td>
<code>kind</code></br>
string
</td>
<td><code>PipelineActivity</code></td>
</tr>
<tr>
<td>
<code>metadata</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#objectmeta-v1-meta">
Kubernetes meta/v1.ObjectMeta
</a>
</em>
</td>
<td>
<em>(Optional)</em>
<p>Standard object&rsquo;s metadata.
More info: <a href="https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata">https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata</a></p>
Refer to the Kubernetes API documentation for the fields of the
<code>metadata</code> field.
</td>
</tr>
<tr>
<td>
<code>spec</code></br>
<em>
<a href="#jenkins.io/v1.PipelineActivitySpec">
PipelineActivitySpec
</a>
</em>
</td>
<td>
<br/>
<br/>
<table>
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
<code>build</code></br>
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
<tr>
<td>
<code>status</code></br>
<em>
<a href="#jenkins.io/v1.ActivityStatusType">
ActivityStatusType
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>startedTimestamp</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#time-v1-meta">
Kubernetes meta/v1.Time
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>completedTimestamp</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#time-v1-meta">
Kubernetes meta/v1.Time
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
<a href="#jenkins.io/v1.PipelineActivityStep">
[]PipelineActivityStep
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>buildUrl</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>buildLogsUrl</code></br>
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
<code>gitRepository</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>gitOwner</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>gitBranch</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>author</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>authorAvatarURL</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>authorURL</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>pullTitle</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>releaseNotesURL</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>lastCommitSHA</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>lastCommitMessage</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>lastCommitURL</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>workflow</code></br>
<em>
string
</em>
</td>
<td>
<p>Deprecated - Workflow functionality was removed and is obsolete
Keeping these fields to ensure backwards compatibility
Should be removed when we increment spec version</p>
</td>
</tr>
<tr>
<td>
<code>workflowStatus</code></br>
<em>
<a href="#jenkins.io/v1.ActivityStatusType">
ActivityStatusType
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>workflowMessage</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>postExtensions</code></br>
<em>
<a href="#jenkins.io/v1.ExtensionExecution">
[]ExtensionExecution
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>attachments</code></br>
<em>
<a href="#jenkins.io/v1.Attachment">
[]Attachment
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>batchPipelineActivity</code></br>
<em>
<a href="#jenkins.io/v1.BatchPipelineActivity">
BatchPipelineActivity
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>context</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>baseSHA</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</table>
</td>
</tr>
<tr>
<td>
<code>status</code></br>
<em>
<a href="#jenkins.io/v1.PipelineActivityStatus">
PipelineActivityStatus
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.PipelineStructure">PipelineStructure
</h3>
<p>
<p>PipelineStructure contains references to the Pipeline and PipelineRun, and a list of PipelineStructureStages in the
pipeline. This allows us to map between a running Pod to its TaskRun, to the TaskRun&rsquo;s Task and PipelineRun, and
finally from there to the stage and potential parent stages that the Pod is actually executing, for use with
populating PipelineActivity and providing logs.</p>
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
jenkins.io/v1
</code>
</td>
</tr>
<tr>
<td>
<code>kind</code></br>
string
</td>
<td><code>PipelineStructure</code></td>
</tr>
<tr>
<td>
<code>metadata</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#objectmeta-v1-meta">
Kubernetes meta/v1.ObjectMeta
</a>
</em>
</td>
<td>
<em>(Optional)</em>
<p>Standard object&rsquo;s metadata.
More info: <a href="https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata">https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata</a></p>
Refer to the Kubernetes API documentation for the fields of the
<code>metadata</code> field.
</td>
</tr>
<tr>
<td>
<code>pipelineRef</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>pipelineRunRef</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>stages</code></br>
<em>
<a href="#jenkins.io/v1.PipelineStructureStage">
[]PipelineStructureStage
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.Plugin">Plugin
</h3>
<p>
<p>Plugin represents a binary plugin installed into this Jenkins X team</p>
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
jenkins.io/v1
</code>
</td>
</tr>
<tr>
<td>
<code>kind</code></br>
string
</td>
<td><code>Plugin</code></td>
</tr>
<tr>
<td>
<code>metadata</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#objectmeta-v1-meta">
Kubernetes meta/v1.ObjectMeta
</a>
</em>
</td>
<td>
<em>(Optional)</em>
<p>Standard object&rsquo;s metadata.
More info: <a href="https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata">https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata</a></p>
Refer to the Kubernetes API documentation for the fields of the
<code>metadata</code> field.
</td>
</tr>
<tr>
<td>
<code>spec</code></br>
<em>
<a href="#jenkins.io/v1.PluginSpec">
PluginSpec
</a>
</em>
</td>
<td>
<br/>
<br/>
<table>
<tr>
<td>
<code>subCommand</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>group</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>binaries</code></br>
<em>
<a href="#jenkins.io/v1.Binary">
[]Binary
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>description</code></br>
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
<code>version</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</table>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.Release">Release
</h3>
<p>
<p>Release represents a single version of an app that has been released</p>
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
jenkins.io/v1
</code>
</td>
</tr>
<tr>
<td>
<code>kind</code></br>
string
</td>
<td><code>Release</code></td>
</tr>
<tr>
<td>
<code>metadata</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#objectmeta-v1-meta">
Kubernetes meta/v1.ObjectMeta
</a>
</em>
</td>
<td>
<em>(Optional)</em>
<p>Standard object&rsquo;s metadata.
More info: <a href="https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata">https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata</a></p>
Refer to the Kubernetes API documentation for the fields of the
<code>metadata</code> field.
</td>
</tr>
<tr>
<td>
<code>spec</code></br>
<em>
<a href="#jenkins.io/v1.ReleaseSpec">
ReleaseSpec
</a>
</em>
</td>
<td>
<br/>
<br/>
<table>
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
<tr>
<td>
<code>gitHttpUrl</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>gitCloneUrl</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>commits</code></br>
<em>
<a href="#jenkins.io/v1.CommitSummary">
[]CommitSummary
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>issues</code></br>
<em>
<a href="#jenkins.io/v1.IssueSummary">
[]IssueSummary
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>pullRequests</code></br>
<em>
<a href="#jenkins.io/v1.IssueSummary">
[]IssueSummary
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>dependencyUpdates</code></br>
<em>
<a href="#jenkins.io/v1.DependencyUpdate">
[]DependencyUpdate
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>releaseNotesURL</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>gitRepository</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>gitOwner</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</table>
</td>
</tr>
<tr>
<td>
<code>status</code></br>
<em>
<a href="#jenkins.io/v1.ReleaseStatus">
ReleaseStatus
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.Scheduler">Scheduler
</h3>
<p>
<p>Scheduler is configuration for a pipeline scheduler</p>
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
jenkins.io/v1
</code>
</td>
</tr>
<tr>
<td>
<code>kind</code></br>
string
</td>
<td><code>Scheduler</code></td>
</tr>
<tr>
<td>
<code>metadata</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#objectmeta-v1-meta">
Kubernetes meta/v1.ObjectMeta
</a>
</em>
</td>
<td>
<em>(Optional)</em>
<p>Standard object&rsquo;s metadata.
More info: <a href="https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata">https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata</a></p>
Refer to the Kubernetes API documentation for the fields of the
<code>metadata</code> field.
</td>
</tr>
<tr>
<td>
<code>spec</code></br>
<em>
<a href="#jenkins.io/v1.SchedulerSpec">
SchedulerSpec
</a>
</em>
</td>
<td>
<br/>
<br/>
<table>
<tr>
<td>
<code>schedulerAgent</code></br>
<em>
<a href="#jenkins.io/v1.SchedulerAgent">
SchedulerAgent
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>policy</code></br>
<em>
<a href="#jenkins.io/v1.GlobalProtectionPolicy">
GlobalProtectionPolicy
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>presubmits</code></br>
<em>
<a href="#jenkins.io/v1.Presubmits">
Presubmits
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>postsubmits</code></br>
<em>
<a href="#jenkins.io/v1.Postsubmits">
Postsubmits
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>trigger</code></br>
<em>
<a href="#jenkins.io/v1.Trigger">
Trigger
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>approve</code></br>
<em>
<a href="#jenkins.io/v1.Approve">
Approve
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>lgtm</code></br>
<em>
<a href="#jenkins.io/v1.Lgtm">
Lgtm
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>externalPlugins</code></br>
<em>
<a href="#jenkins.io/v1.ReplaceableSliceOfExternalPlugins">
ReplaceableSliceOfExternalPlugins
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>merger</code></br>
<em>
<a href="#jenkins.io/v1.Merger">
Merger
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>plugins</code></br>
<em>
<a href="#jenkins.io/v1.ReplaceableSliceOfStrings">
ReplaceableSliceOfStrings
</a>
</em>
</td>
<td>
<p>Plugins is a list of plugin names enabled for a repo</p>
</td>
</tr>
<tr>
<td>
<code>configUpdater</code></br>
<em>
<a href="#jenkins.io/v1.ConfigUpdater">
ConfigUpdater
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>welcome</code></br>
<em>
<a href="#jenkins.io/v1.*github.com/jenkins-x/jx/pkg/apis/jenkins.io/v1.Welcome">
[]*github.com/jenkins-x/jx/pkg/apis/jenkins.io/v1.Welcome
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>periodics</code></br>
<em>
<a href="#jenkins.io/v1.Periodics">
Periodics
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>attachments</code></br>
<em>
<a href="#jenkins.io/v1.*github.com/jenkins-x/jx/pkg/apis/jenkins.io/v1.Attachment">
[]*github.com/jenkins-x/jx/pkg/apis/jenkins.io/v1.Attachment
</a>
</em>
</td>
<td>
</td>
</tr>
</table>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.SourceRepository">SourceRepository
</h3>
<p>
<p>SourceRepository is the metadata for an Application/Project/SourceRepository</p>
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
jenkins.io/v1
</code>
</td>
</tr>
<tr>
<td>
<code>kind</code></br>
string
</td>
<td><code>SourceRepository</code></td>
</tr>
<tr>
<td>
<code>metadata</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#objectmeta-v1-meta">
Kubernetes meta/v1.ObjectMeta
</a>
</em>
</td>
<td>
<em>(Optional)</em>
<p>Standard object&rsquo;s metadata.
More info: <a href="https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata">https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata</a></p>
Refer to the Kubernetes API documentation for the fields of the
<code>metadata</code> field.
</td>
</tr>
<tr>
<td>
<code>spec</code></br>
<em>
<a href="#jenkins.io/v1.SourceRepositorySpec">
SourceRepositorySpec
</a>
</em>
</td>
<td>
<br/>
<br/>
<table>
<tr>
<td>
<code>description</code></br>
<em>
string
</em>
</td>
<td>
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
<p>Provider stores the URL of the git provider such as <a href="https://github.com">https://github.com</a></p>
</td>
</tr>
<tr>
<td>
<code>org</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>repo</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>providerName</code></br>
<em>
string
</em>
</td>
<td>
<p>ProviderName is a logical name for the provider without any URL scheme which can be used in a label selector</p>
</td>
</tr>
<tr>
<td>
<code>providerKind</code></br>
<em>
string
</em>
</td>
<td>
<p>ProviderKind is the kind of provider (github / bitbucketcloud / bitbucketserver etc)</p>
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
<p>URL is the web URL of the project page</p>
</td>
</tr>
<tr>
<td>
<code>sshCloneURL</code></br>
<em>
string
</em>
</td>
<td>
<p>SSHCloneURL is the git URL to clone this repository using SSH</p>
</td>
</tr>
<tr>
<td>
<code>httpCloneURL</code></br>
<em>
string
</em>
</td>
<td>
<p>HTTPCloneURL is the git URL to clone this repository using HTTP/HTTPS</p>
</td>
</tr>
<tr>
<td>
<code>scheduler</code></br>
<em>
<a href="#jenkins.io/v1.ResourceReference">
ResourceReference
</a>
</em>
</td>
<td>
<p>Scheduler a reference to a custom scheduler otherwise we default to the Team&rsquo;s Scededuler</p>
</td>
</tr>
</table>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.SourceRepositoryGroup">SourceRepositoryGroup
</h3>
<p>
<p>SourceRepositoryGroup is the metadata for an Application/Project/SourceRepository</p>
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
jenkins.io/v1
</code>
</td>
</tr>
<tr>
<td>
<code>kind</code></br>
string
</td>
<td><code>SourceRepositoryGroup</code></td>
</tr>
<tr>
<td>
<code>metadata</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#objectmeta-v1-meta">
Kubernetes meta/v1.ObjectMeta
</a>
</em>
</td>
<td>
Refer to the Kubernetes API documentation for the fields of the
<code>metadata</code> field.
</td>
</tr>
<tr>
<td>
<code>spec</code></br>
<em>
<a href="#jenkins.io/v1.SourceRepositoryGroupSpec">
SourceRepositoryGroupSpec
</a>
</em>
</td>
<td>
<br/>
<br/>
<table>
<tr>
<td>
<code>metadata</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#objectmeta-v1-meta">
Kubernetes meta/v1.ObjectMeta
</a>
</em>
</td>
<td>
Refer to the Kubernetes API documentation for the fields of the
<code>metadata</code> field.
</td>
</tr>
<tr>
<td>
<code>repositories</code></br>
<em>
<a href="#jenkins.io/v1.ResourceReference">
[]ResourceReference
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>scheduler</code></br>
<em>
<a href="#jenkins.io/v1.ResourceReference">
ResourceReference
</a>
</em>
</td>
<td>
</td>
</tr>
</table>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.Team">Team
</h3>
<p>
<p>Team represents a request to create an actual Team which is a group of users, a development environment and optional other environments</p>
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
jenkins.io/v1
</code>
</td>
</tr>
<tr>
<td>
<code>kind</code></br>
string
</td>
<td><code>Team</code></td>
</tr>
<tr>
<td>
<code>metadata</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#objectmeta-v1-meta">
Kubernetes meta/v1.ObjectMeta
</a>
</em>
</td>
<td>
<em>(Optional)</em>
<p>Standard object&rsquo;s metadata.
More info: <a href="https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata">https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata</a></p>
Refer to the Kubernetes API documentation for the fields of the
<code>metadata</code> field.
</td>
</tr>
<tr>
<td>
<code>spec</code></br>
<em>
<a href="#jenkins.io/v1.TeamSpec">
TeamSpec
</a>
</em>
</td>
<td>
<br/>
<br/>
<table>
<tr>
<td>
<code>label</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>kind</code></br>
<em>
<a href="#jenkins.io/v1.TeamKindType">
TeamKindType
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>members</code></br>
<em>
[]string
</em>
</td>
<td>
</td>
</tr>
</table>
</td>
</tr>
<tr>
<td>
<code>status</code></br>
<em>
<a href="#jenkins.io/v1.TeamStatus">
TeamStatus
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.User">User
</h3>
<p>
<p>User represents a git user so we have a cache to find by email address</p>
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
jenkins.io/v1
</code>
</td>
</tr>
<tr>
<td>
<code>kind</code></br>
string
</td>
<td><code>User</code></td>
</tr>
<tr>
<td>
<code>metadata</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#objectmeta-v1-meta">
Kubernetes meta/v1.ObjectMeta
</a>
</em>
</td>
<td>
<em>(Optional)</em>
<p>Standard object&rsquo;s metadata.
More info: <a href="https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata">https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata</a></p>
Refer to the Kubernetes API documentation for the fields of the
<code>metadata</code> field.
</td>
</tr>
<tr>
<td>
<code>user</code></br>
<em>
<a href="#jenkins.io/v1.UserDetails">
UserDetails
</a>
</em>
</td>
<td>
<p>Deprecated, use Spec</p>
</td>
</tr>
<tr>
<td>
<code>spec</code></br>
<em>
<a href="#jenkins.io/v1.UserDetails">
UserDetails
</a>
</em>
</td>
<td>
<br/>
<br/>
<table>
<tr>
<td>
<code>login</code></br>
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
<code>email</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>creationTimestamp</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#time-v1-meta">
Kubernetes meta/v1.Time
</a>
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
<code>avatarUrl</code></br>
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
<code>accountReference</code></br>
<em>
<a href="#jenkins.io/v1.AccountReference">
[]AccountReference
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>externalUser</code></br>
<em>
bool
</em>
</td>
<td>
</td>
</tr>
</table>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.Workflow">Workflow
</h3>
<p>
<p>Workflow represents pipeline activity for a particular run of a pipeline</p>
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
jenkins.io/v1
</code>
</td>
</tr>
<tr>
<td>
<code>kind</code></br>
string
</td>
<td><code>Workflow</code></td>
</tr>
<tr>
<td>
<code>metadata</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#objectmeta-v1-meta">
Kubernetes meta/v1.ObjectMeta
</a>
</em>
</td>
<td>
<em>(Optional)</em>
<p>Standard object&rsquo;s metadata.
More info: <a href="https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata">https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata</a></p>
Refer to the Kubernetes API documentation for the fields of the
<code>metadata</code> field.
</td>
</tr>
<tr>
<td>
<code>spec</code></br>
<em>
<a href="#jenkins.io/v1.WorkflowSpec">
WorkflowSpec
</a>
</em>
</td>
<td>
<br/>
<br/>
<table>
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
<code>steps</code></br>
<em>
<a href="#jenkins.io/v1.WorkflowStep">
[]WorkflowStep
</a>
</em>
</td>
<td>
</td>
</tr>
</table>
</td>
</tr>
<tr>
<td>
<code>status</code></br>
<em>
<a href="#jenkins.io/v1.WorkflowStatus">
WorkflowStatus
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.AccountReference">AccountReference
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.UserDetails">UserDetails</a>)
</p>
<p>
<p>AccountReference is a reference to a user account in another system that is attached to this user</p>
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
<code>provider</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>id</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.ActivityStatusType">ActivityStatusType
(<code>string</code> alias)</p></h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.CoreActivityStep">CoreActivityStep</a>, 
<a href="#jenkins.io/v1.PipelineActivitySpec">PipelineActivitySpec</a>)
</p>
<p>
<p>ActivityStatusType is the status of an activity; usually succeeded or failed/error on completion</p>
</p>
<h3 id="jenkins.io/v1.ActivityStepKindType">ActivityStepKindType
(<code>string</code> alias)</p></h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.PipelineActivityStep">PipelineActivityStep</a>)
</p>
<p>
<p>ActivityStepKindType is a kind of step</p>
</p>
<h3 id="jenkins.io/v1.AppSpec">AppSpec
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.App">App</a>)
</p>
<p>
<p>AppSpec provides details of the metadata for an App</p>
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
<code>schemaPreprocessor</code></br>
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
<code>schemaPreprocessorRole</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#role-v1-rbac">
Kubernetes rbac/v1.Role
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>pipelineExtension</code></br>
<em>
<a href="#jenkins.io/v1.PipelineExtension">
PipelineExtension
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.Approve">Approve
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.SchedulerSpec">SchedulerSpec</a>)
</p>
<p>
<p>Approve specifies a configuration for a single approve.</p>
<p>The configuration for the approve plugin is defined as a list of these structures.</p>
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
<code>issueRequired</code></br>
<em>
bool
</em>
</td>
<td>
<p>IssueRequired indicates if an associated issue is required for approval in
the specified repos.</p>
</td>
</tr>
<tr>
<td>
<code>requireSelfApproval</code></br>
<em>
bool
</em>
</td>
<td>
<p>RequireSelfApproval requires PR authors to explicitly approve their PRs.
Otherwise the plugin assumes the author of the PR approves the changes in the PR.</p>
</td>
</tr>
<tr>
<td>
<code>lgtmActsAsApprove</code></br>
<em>
bool
</em>
</td>
<td>
<p>LgtmActsAsApprove indicates that the lgtm command should be used to
indicate approval</p>
</td>
</tr>
<tr>
<td>
<code>ignoreReviewState</code></br>
<em>
bool
</em>
</td>
<td>
<p>IgnoreReviewState causes the approve plugin to ignore the GitHub review state. Otherwise:
* an APPROVE github review is equivalent to leaving an &ldquo;/approve&rdquo; message.
* A REQUEST_CHANGES github review is equivalent to leaving an /approve cancel&rdquo; message.</p>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.Attachment">Attachment
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.PipelineActivitySpec">PipelineActivitySpec</a>)
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
<code>urls</code></br>
<em>
[]string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.BatchPipelineActivity">BatchPipelineActivity
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.PipelineActivitySpec">PipelineActivitySpec</a>)
</p>
<p>
<p>BatchPipelineActivity contains information about a batch build, used by both the batch build and its comprising PRs for linking them together</p>
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
<code>batchBuildNumber</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>batchBranchName</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>pullRequestInfo</code></br>
<em>
<a href="#jenkins.io/v1.PullRequestInfo">
[]PullRequestInfo
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.Binary">Binary
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.PluginSpec">PluginSpec</a>)
</p>
<p>
<p>Binary provies the details of a downloadable binary</p>
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
<code>goarch</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>goos</code></br>
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
</tbody>
</table>
<h3 id="jenkins.io/v1.BranchProtectionContextPolicy">BranchProtectionContextPolicy
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.ProtectionPolicy">ProtectionPolicy</a>)
</p>
<p>
<p>BranchProtectionContextPolicy configures required git provider contexts.
Strict determines whether merging to the branch invalidates existing contexts.</p>
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
<code>contexts</code></br>
<em>
<a href="#jenkins.io/v1.ReplaceableSliceOfStrings">
ReplaceableSliceOfStrings
</a>
</em>
</td>
<td>
<p>Contexts appends required contexts that must be green to merge</p>
</td>
</tr>
<tr>
<td>
<code>strict</code></br>
<em>
bool
</em>
</td>
<td>
<p>Strict overrides whether new commits in the base branch require updating the PR if set</p>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.Brancher">Brancher
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.Postsubmit">Postsubmit</a>, 
<a href="#jenkins.io/v1.Presubmit">Presubmit</a>)
</p>
<p>
<p>Brancher is for shared code between jobs that only run against certain
branches. An empty brancher runs against all branches.</p>
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
<code>skipBranches</code></br>
<em>
<a href="#jenkins.io/v1.ReplaceableSliceOfStrings">
ReplaceableSliceOfStrings
</a>
</em>
</td>
<td>
<p>Do not run against these branches. Default is no branches.</p>
</td>
</tr>
<tr>
<td>
<code>branches</code></br>
<em>
<a href="#jenkins.io/v1.ReplaceableSliceOfStrings">
ReplaceableSliceOfStrings
</a>
</em>
</td>
<td>
<p>Only run against these branches. Default is all branches.</p>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.BuildPackSpec">BuildPackSpec
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.BuildPack">BuildPack</a>)
</p>
<p>
<p>BuildPackSpec is the specification of an BuildPack</p>
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
<tr>
<td>
<code>quickstartLocations</code></br>
<em>
<a href="#jenkins.io/v1.QuickStartLocation">
[]QuickStartLocation
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.ChartRef">ChartRef
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.ExtensionRepositoryReference">ExtensionRepositoryReference</a>)
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
<code>repo</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>repoName</code></br>
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
</tbody>
</table>
<h3 id="jenkins.io/v1.CommitStatusCommitReference">CommitStatusCommitReference
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.CommitStatusDetails">CommitStatusDetails</a>)
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
<code>pullRequest</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>sha</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.CommitStatusDetails">CommitStatusDetails
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.CommitStatusSpec">CommitStatusSpec</a>)
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
<code>pipelineActivity</code></br>
<em>
<a href="#jenkins.io/v1.ResourceReference">
ResourceReference
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>Items</code></br>
<em>
<a href="#jenkins.io/v1.CommitStatusItem">
[]CommitStatusItem
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>checked</code></br>
<em>
bool
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>commit</code></br>
<em>
<a href="#jenkins.io/v1.CommitStatusCommitReference">
CommitStatusCommitReference
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>context</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.CommitStatusItem">CommitStatusItem
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.CommitStatusDetails">CommitStatusDetails</a>)
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
<code>description</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>pass</code></br>
<em>
bool
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.CommitStatusSpec">CommitStatusSpec
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.CommitStatus">CommitStatus</a>)
</p>
<p>
<p>CommitStatusSpec provides details of a particular commit status</p>
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
<code>items</code></br>
<em>
<a href="#jenkins.io/v1.CommitStatusDetails">
[]CommitStatusDetails
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.CommitSummary">CommitSummary
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.ReleaseSpec">ReleaseSpec</a>)
</p>
<p>
<p>CommitSummary is the summary of a commit</p>
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
<code>message</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>sha</code></br>
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
<code>author</code></br>
<em>
<a href="#jenkins.io/v1.UserDetails">
UserDetails
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>committer</code></br>
<em>
<a href="#jenkins.io/v1.UserDetails">
UserDetails
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>branch</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>issueIds</code></br>
<em>
[]string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.ConfigMapSpec">ConfigMapSpec
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.ConfigUpdater">ConfigUpdater</a>)
</p>
<p>
<p>ConfigMapSpec contains configuration options for the configMap being updated
by the config-updater plugin.</p>
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
<p>Name of ConfigMap</p>
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
<p>Key is the key in the ConfigMap to update with the file contents.
If no explicit key is given, the basename of the file will be used.</p>
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
<p>Namespace in which the configMap needs to be deployed. If no namespace is specified
it will be deployed to the ProwJobNamespace.</p>
</td>
</tr>
<tr>
<td>
<code>additional_namespaces</code></br>
<em>
[]string
</em>
</td>
<td>
<p>Namespaces in which the configMap needs to be deployed, in addition to the above
namespace provided, or the default if it is not set.</p>
</td>
</tr>
<tr>
<td>
<code>-</code></br>
<em>
[]string
</em>
</td>
<td>
<p>Namespaces is the fully resolved list of Namespaces to deploy the ConfigMap in</p>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.ConfigUpdater">ConfigUpdater
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.SchedulerSpec">SchedulerSpec</a>)
</p>
<p>
<p>ConfigUpdater holds configuration for the config updater plugin</p>
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
<code>map</code></br>
<em>
<a href="#jenkins.io/v1.ConfigMapSpec">
map[string]github.com/jenkins-x/jx/pkg/apis/jenkins.io/v1.ConfigMapSpec
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>configFile</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>pluginFile</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>ConfigMap</code></br>
<em>
<a href="#jenkins.io/v1.ConfigMapSpec">
ConfigMapSpec
</a>
</em>
</td>
<td>
<em>(Optional)</em>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.ContextPolicy">ContextPolicy
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.Merger">Merger</a>, 
<a href="#jenkins.io/v1.RepoContextPolicy">RepoContextPolicy</a>)
</p>
<p>
<p>ContextPolicy configures options about how to handle various contexts.</p>
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
<code>skipUnknownContexts</code></br>
<em>
bool
</em>
</td>
<td>
<p>whether to consider unknown contexts optional (skip) or required.</p>
</td>
</tr>
<tr>
<td>
<code>requiredContexts</code></br>
<em>
<a href="#jenkins.io/v1.ReplaceableSliceOfStrings">
ReplaceableSliceOfStrings
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>requiredIfPresentContexts</code></br>
<em>
<a href="#jenkins.io/v1.ReplaceableSliceOfStrings">
ReplaceableSliceOfStrings
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>optionalContexts</code></br>
<em>
<a href="#jenkins.io/v1.ReplaceableSliceOfStrings">
ReplaceableSliceOfStrings
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>fromBranchProtection</code></br>
<em>
bool
</em>
</td>
<td>
<p>Infer required and optional jobs from Branch Protection configuration</p>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.CoreActivityStep">CoreActivityStep
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.PreviewActivityStep">PreviewActivityStep</a>, 
<a href="#jenkins.io/v1.PromoteActivityStep">PromoteActivityStep</a>, 
<a href="#jenkins.io/v1.PromotePullRequestStep">PromotePullRequestStep</a>, 
<a href="#jenkins.io/v1.PromoteUpdateStep">PromoteUpdateStep</a>, 
<a href="#jenkins.io/v1.StageActivityStep">StageActivityStep</a>)
</p>
<p>
<p>CoreActivityStep is a base step included in Stages of a pipeline or other kinds of step</p>
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
<code>description</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>status</code></br>
<em>
<a href="#jenkins.io/v1.ActivityStatusType">
ActivityStatusType
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>startedTimestamp</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#time-v1-meta">
Kubernetes meta/v1.Time
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>completedTimestamp</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#time-v1-meta">
Kubernetes meta/v1.Time
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.DependencyUpdate">DependencyUpdate
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.ReleaseSpec">ReleaseSpec</a>)
</p>
<p>
<p>DependencyUpdate describes an dependency update message from the commit log</p>
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
<code>DependencyUpdateDetails</code></br>
<em>
<a href="#jenkins.io/v1.DependencyUpdateDetails">
DependencyUpdateDetails
</a>
</em>
</td>
<td>
<p>
(Members of <code>DependencyUpdateDetails</code> are embedded into this type.)
</p>
</td>
</tr>
<tr>
<td>
<code>paths</code></br>
<em>
<a href="#jenkins.io/v1.DependencyUpdatePath">
[]DependencyUpdatePath
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.DependencyUpdateDetails">DependencyUpdateDetails
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.DependencyUpdate">DependencyUpdate</a>)
</p>
<p>
<p>DependencyUpdateDetails are the details of a dependency update</p>
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
<code>host</code></br>
<em>
string
</em>
</td>
<td>
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
</td>
</tr>
<tr>
<td>
<code>repo</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>component, omitempty</code></br>
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
<code>fromVersion</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>fromReleaseHTMLURL</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>fromReleaseName</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>toVersion</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>toReleaseHTMLURL</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>toReleaseName</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.DependencyUpdatePath">DependencyUpdatePath
(<code>[]github.com/jenkins-x/jx/pkg/apis/jenkins.io/v1.DependencyUpdateDetails</code> alias)</p></h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.DependencyUpdate">DependencyUpdate</a>)
</p>
<p>
<p>DependencyUpdatePath is the path of a dependency update</p>
</p>
<h3 id="jenkins.io/v1.DeployOptions">DeployOptions
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.TeamSettings">TeamSettings</a>)
</p>
<p>
<p>DeployOptions configures options for how to deploy applications by default such as using progressive delivery or using horizontal pod autoscaler</p>
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
<code>canary</code></br>
<em>
bool
</em>
</td>
<td>
<p>Canary should we enable canary rollouts (progressive delivery) for apps by default</p>
</td>
</tr>
<tr>
<td>
<code>hpa</code></br>
<em>
bool
</em>
</td>
<td>
<p>should we use the horizontal pod autoscaler on new apps by default?</p>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.EnvironmentFilter">EnvironmentFilter
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.EnvironmentRoleBindingSpec">EnvironmentRoleBindingSpec</a>)
</p>
<p>
<p>EnvironmentFilter specifies the environments to apply the role binding to</p>
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
<a href="#jenkins.io/v1.EnvironmentKindType">
EnvironmentKindType
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>includes</code></br>
<em>
[]string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>excludes</code></br>
<em>
[]string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.EnvironmentKindType">EnvironmentKindType
(<code>string</code> alias)</p></h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.EnvironmentFilter">EnvironmentFilter</a>, 
<a href="#jenkins.io/v1.EnvironmentSpec">EnvironmentSpec</a>)
</p>
<p>
<p>EnvironmentKindType is the kind of an environment</p>
</p>
<h3 id="jenkins.io/v1.EnvironmentRepository">EnvironmentRepository
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.EnvironmentSpec">EnvironmentSpec</a>)
</p>
<p>
<p>EnvironmentRepository is the repository for an environment using GitOps</p>
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
<a href="#jenkins.io/v1.EnvironmentRepositoryType">
EnvironmentRepositoryType
</a>
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
<code>ref</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.EnvironmentRepositoryType">EnvironmentRepositoryType
(<code>string</code> alias)</p></h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.EnvironmentRepository">EnvironmentRepository</a>)
</p>
<p>
<p>EnvironmentRepositoryType is the repository type</p>
</p>
<h3 id="jenkins.io/v1.EnvironmentRoleBindingSpec">EnvironmentRoleBindingSpec
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.EnvironmentRoleBinding">EnvironmentRoleBinding</a>)
</p>
<p>
<p>EnvironmentRoleBindingSpec is the specification of an EnvironmentRoleBinding</p>
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
<code>subjects</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#subject-v1-rbac">
[]Kubernetes rbac/v1.Subject
</a>
</em>
</td>
<td>
<p>Subjects holds references to the objects the role applies to.</p>
</td>
</tr>
<tr>
<td>
<code>roleRef</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#roleref-v1-rbac">
Kubernetes rbac/v1.RoleRef
</a>
</em>
</td>
<td>
<p>RoleRef can reference a Role in the current namespace or a ClusterRole in the global namespace.
If the RoleRef cannot be resolved, the Authorizer must return an error.</p>
</td>
</tr>
<tr>
<td>
<code>environments</code></br>
<em>
<a href="#jenkins.io/v1.EnvironmentFilter">
[]EnvironmentFilter
</a>
</em>
</td>
<td>
<p>specifies which sets of environments this binding applies to</p>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.EnvironmentRoleBindingStatus">EnvironmentRoleBindingStatus
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.EnvironmentRoleBinding">EnvironmentRoleBinding</a>)
</p>
<p>
<p>EnvironmentRoleBindingStatus is the status for an EnvironmentRoleBinding resource</p>
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
<h3 id="jenkins.io/v1.EnvironmentSpec">EnvironmentSpec
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.Environment">Environment</a>)
</p>
<p>
<p>EnvironmentSpec is the specification of an Environment</p>
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
</td>
</tr>
<tr>
<td>
<code>cluster</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>promotionStrategy</code></br>
<em>
<a href="#jenkins.io/v1.PromotionStrategyType">
PromotionStrategyType
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>source</code></br>
<em>
<a href="#jenkins.io/v1.EnvironmentRepository">
EnvironmentRepository
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>order</code></br>
<em>
int32
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>kind</code></br>
<em>
<a href="#jenkins.io/v1.EnvironmentKindType">
EnvironmentKindType
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>pullRequestURL</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>teamSettings</code></br>
<em>
<a href="#jenkins.io/v1.TeamSettings">
TeamSettings
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>previewGitInfo</code></br>
<em>
<a href="#jenkins.io/v1.PreviewGitSpec">
PreviewGitSpec
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>webHookEngine</code></br>
<em>
<a href="#jenkins.io/v1.WebHookEngineType">
WebHookEngineType
</a>
</em>
</td>
<td>
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
<p>RemoteCluster flag indicates if the Environment is deployed in a separate cluster to the Development Environment</p>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.EnvironmentStatus">EnvironmentStatus
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.Environment">Environment</a>)
</p>
<p>
<p>EnvironmentStatus is the status for an Environment resource</p>
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
<h3 id="jenkins.io/v1.EnvironmentVariable">EnvironmentVariable
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.ExtensionExecution">ExtensionExecution</a>)
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
<code>value</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.ExtensionConfig">ExtensionConfig
</h3>
<p>
<p>ExtensionConfig is the configuration and enablement for an extension inside an app</p>
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
<code>namespace</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>parameters</code></br>
<em>
<a href="#jenkins.io/v1.ExtensionParameterValue">
[]ExtensionParameterValue
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.ExtensionDefinition">ExtensionDefinition
</h3>
<p>
<p>ExtensionDefinition defines an Extension</p>
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
<code>namespace</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>uuid</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>description</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>when</code></br>
<em>
<a href="#jenkins.io/v1.ExtensionWhen">
[]ExtensionWhen
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>given</code></br>
<em>
<a href="#jenkins.io/v1.ExtensionGiven">
ExtensionGiven
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>children</code></br>
<em>
<a href="#jenkins.io/v1.ExtensionDefinitionChildReference">
[]ExtensionDefinitionChildReference
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>scriptFile</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>parameters</code></br>
<em>
<a href="#jenkins.io/v1.ExtensionParameter">
[]ExtensionParameter
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.ExtensionDefinitionChildReference">ExtensionDefinitionChildReference
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.ExtensionDefinition">ExtensionDefinition</a>)
</p>
<p>
<p>ExtensionDefinitionChildReference provides a reference to a child</p>
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
<code>uuid</code></br>
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
<code>namespace</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>remote</code></br>
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
<h3 id="jenkins.io/v1.ExtensionDefinitionReference">ExtensionDefinitionReference
</h3>
<p>
<p>ExtensionRepositoryReference references a GitHub repo that contains extension definitions</p>
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
<code>remote</code></br>
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
<h3 id="jenkins.io/v1.ExtensionExecution">ExtensionExecution
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.PipelineActivitySpec">PipelineActivitySpec</a>)
</p>
<p>
<p>ExtensionExecution is an executable instance of an extension which can be attached into a pipeline for later execution.
It differs from an Extension as it cannot have children and parameters have been resolved to environment variables</p>
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
<code>description</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>script</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>environmentVariables</code></br>
<em>
<a href="#jenkins.io/v1.EnvironmentVariable">
[]EnvironmentVariable
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>given</code></br>
<em>
<a href="#jenkins.io/v1.ExtensionGiven">
ExtensionGiven
</a>
</em>
</td>
<td>
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
</td>
</tr>
<tr>
<td>
<code>uuid</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.ExtensionGiven">ExtensionGiven
(<code>string</code> alias)</p></h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.ExtensionDefinition">ExtensionDefinition</a>, 
<a href="#jenkins.io/v1.ExtensionExecution">ExtensionExecution</a>, 
<a href="#jenkins.io/v1.ExtensionSpec">ExtensionSpec</a>)
</p>
<p>
<p>ExtensionGiven specifies the condition (if the extension is executing in a pipeline on which the extension should execute. By default Always.</p>
</p>
<h3 id="jenkins.io/v1.ExtensionParameter">ExtensionParameter
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.ExtensionDefinition">ExtensionDefinition</a>, 
<a href="#jenkins.io/v1.ExtensionSpec">ExtensionSpec</a>)
</p>
<p>
<p>ExtensionParameter describes a parameter definition for an extension</p>
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
<code>description</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>environmentVariableName</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>defaultValue</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.ExtensionParameterValue">ExtensionParameterValue
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.ExtensionConfig">ExtensionConfig</a>)
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
<code>value</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.ExtensionRepositoryReference">ExtensionRepositoryReference
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
<code>github</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>chart</code></br>
<em>
<a href="#jenkins.io/v1.ChartRef">
ChartRef
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.ExtensionSpec">ExtensionSpec
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.Extension">Extension</a>)
</p>
<p>
<p>ExtensionSpec provides details of an extension available for a team</p>
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
<code>description</code></br>
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
<tr>
<td>
<code>script</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>when</code></br>
<em>
<a href="#jenkins.io/v1.ExtensionWhen">
[]ExtensionWhen
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>given</code></br>
<em>
<a href="#jenkins.io/v1.ExtensionGiven">
ExtensionGiven
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>parameters</code></br>
<em>
<a href="#jenkins.io/v1.ExtensionParameter">
[]ExtensionParameter
</a>
</em>
</td>
<td>
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
</td>
</tr>
<tr>
<td>
<code>uuid</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>children</code></br>
<em>
[]string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.ExtensionWhen">ExtensionWhen
(<code>string</code> alias)</p></h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.ExtensionDefinition">ExtensionDefinition</a>, 
<a href="#jenkins.io/v1.ExtensionSpec">ExtensionSpec</a>)
</p>
<p>
<p>ExtensionWhen specifies when in the lifecycle an extension should execute. By default Post.</p>
</p>
<h3 id="jenkins.io/v1.ExternalPlugin">ExternalPlugin
</h3>
<p>
<p>ExternalPlugin holds configuration for registering an external
plugin.</p>
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
<p>Name of the plugin.</p>
</td>
</tr>
<tr>
<td>
<code>endpoint</code></br>
<em>
string
</em>
</td>
<td>
<p>Endpoint is the location of the external plugin. Defaults to
the name of the plugin, ie. &ldquo;http://{{name}}&rdquo;.</p>
</td>
</tr>
<tr>
<td>
<code>events</code></br>
<em>
<a href="#jenkins.io/v1.ReplaceableSliceOfStrings">
ReplaceableSliceOfStrings
</a>
</em>
</td>
<td>
<p>ReplaceableSliceOfStrings are the events that need to be demuxed by the hook
server to the external plugin. If no events are specified,
everything is sent.</p>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.FactSpec">FactSpec
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.Fact">Fact</a>)
</p>
<p>
<p>FactSpec is the specification of a Fact</p>
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
<code>factType</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>measurements</code></br>
<em>
<a href="#jenkins.io/v1.Measurement">
[]Measurement
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>statements</code></br>
<em>
<a href="#jenkins.io/v1.Statement">
[]Statement
</a>
</em>
</td>
<td>
<em>(Optional)</em>
</td>
</tr>
<tr>
<td>
<code>original</code></br>
<em>
<a href="#jenkins.io/v1.Original">
Original
</a>
</em>
</td>
<td>
<em>(Optional)</em>
</td>
</tr>
<tr>
<td>
<code>tags</code></br>
<em>
[]string
</em>
</td>
<td>
<em>(Optional)</em>
</td>
</tr>
<tr>
<td>
<code>subject</code></br>
<em>
<a href="#jenkins.io/v1.ResourceReference">
ResourceReference
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.FactStatus">FactStatus
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.Fact">Fact</a>)
</p>
<p>
<p>FactStatus is the status for an Fact resource</p>
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
<h3 id="jenkins.io/v1.GitServiceSpec">GitServiceSpec
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.GitService">GitService</a>)
</p>
<p>
<p>GitServiceSpec is the specification of an GitService</p>
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
<code>gitKind</code></br>
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
<code>name</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.GitStatus">GitStatus
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.PromoteUpdateStep">PromoteUpdateStep</a>)
</p>
<p>
<p>GitStatus the status of a git commit in terms of CI/CD</p>
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
</td>
</tr>
<tr>
<td>
<code>status</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.GlobalProtectionPolicy">GlobalProtectionPolicy
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.SchedulerSpec">SchedulerSpec</a>)
</p>
<p>
<p>GlobalProtectionPolicy defines the default branch protection policy for the scheduler</p>
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
<code>ProtectionPolicy</code></br>
<em>
<a href="#jenkins.io/v1.ProtectionPolicy">
ProtectionPolicy
</a>
</em>
</td>
<td>
<em>(Optional)</em>
</td>
</tr>
<tr>
<td>
<code>protectTested</code></br>
<em>
bool
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.ImportModeType">ImportModeType
(<code>string</code> alias)</p></h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.TeamSettings">TeamSettings</a>)
</p>
<p>
<p>ImportModeType is the type of import mode for new projects in a team</p>
</p>
<h3 id="jenkins.io/v1.IssueLabel">IssueLabel
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.IssueSummary">IssueSummary</a>)
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
<code>color</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.IssueSummary">IssueSummary
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.ReleaseSpec">ReleaseSpec</a>)
</p>
<p>
<p>IssueSummary is the summary of an issue</p>
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
<code>id</code></br>
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
<code>title</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>body</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>state</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>message</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>user</code></br>
<em>
<a href="#jenkins.io/v1.UserDetails">
UserDetails
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>assignees</code></br>
<em>
<a href="#jenkins.io/v1.UserDetails">
[]UserDetails
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>closedBy</code></br>
<em>
<a href="#jenkins.io/v1.UserDetails">
UserDetails
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>creationTimestamp</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#time-v1-meta">
Kubernetes meta/v1.Time
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>labels</code></br>
<em>
<a href="#jenkins.io/v1.IssueLabel">
[]IssueLabel
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.JobBase">JobBase
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.Periodic">Periodic</a>, 
<a href="#jenkins.io/v1.Postsubmit">Postsubmit</a>, 
<a href="#jenkins.io/v1.Presubmit">Presubmit</a>)
</p>
<p>
<p>JobBase contains attributes common to all job types</p>
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
<p>The name of the job. Must match regex [A-Za-z0-9-._]+
e.g. pull-test-infra-bazel-build</p>
</td>
</tr>
<tr>
<td>
<code>labels</code></br>
<em>
<a href="#jenkins.io/v1.ReplaceableMapOfStringString">
ReplaceableMapOfStringString
</a>
</em>
</td>
<td>
<p>ReplaceableMapOfStringString are added to jobs and pods created for this job.</p>
</td>
</tr>
<tr>
<td>
<code>maxConcurrency</code></br>
<em>
int
</em>
</td>
<td>
<p>MaximumConcurrency of this job, 0 implies no limit.</p>
</td>
</tr>
<tr>
<td>
<code>agent</code></br>
<em>
string
</em>
</td>
<td>
<p>Agent that will take care of running this job.</p>
</td>
</tr>
<tr>
<td>
<code>cluster</code></br>
<em>
string
</em>
</td>
<td>
<p>Cluster is the alias of the cluster to run this job in.
(Default: kube.DefaultClusterAlias)</p>
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
<p>Namespace is the namespace in which pods schedule.
empty: results in scheduler.DefaultNamespace</p>
</td>
</tr>
<tr>
<td>
<code>spec</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#podspec-v1-core">
Kubernetes core/v1.PodSpec
</a>
</em>
</td>
<td>
<p>Spec is the Kubernetes pod spec used if Agent is kubernetes.</p>
<br/>
<br/>
<table>
</table>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.Lgtm">Lgtm
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.SchedulerSpec">SchedulerSpec</a>)
</p>
<p>
<p>Lgtm specifies a configuration for a single lgtm.
The configuration for the lgtm plugin is defined as a list of these structures.</p>
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
<code>reviewActsAsLgtm</code></br>
<em>
bool
</em>
</td>
<td>
<p>ReviewActsAsLgtm indicates that a Github review of &ldquo;approve&rdquo; or &ldquo;request changes&rdquo;
acts as adding or removing the lgtm label</p>
</td>
</tr>
<tr>
<td>
<code>storeTreeHash</code></br>
<em>
bool
</em>
</td>
<td>
<p>StoreTreeHash indicates if tree_hash should be stored inside a comment to detect
squashed commits before removing lgtm labels</p>
</td>
</tr>
<tr>
<td>
<code>trustedTeamForStickyLgtm</code></br>
<em>
string
</em>
</td>
<td>
<p>WARNING: This disables the security mechanism that prevents a malicious member (or
compromised GitHub account) from merging arbitrary code. Use with caution.</p>
<p>StickyLgtmTeam specifies the Github team whose members are trusted with sticky LGTM,
which eliminates the need to re-lgtm minor fixes/updates.</p>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.Measurement">Measurement
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.FactSpec">FactSpec</a>)
</p>
<p>
<p>Measurement is a percentage or a count, something measured that the system will capture within a fact</p>
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
<code>measurementType</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>measurementValue</code></br>
<em>
int
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>tags</code></br>
<em>
[]string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.Merger">Merger
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.SchedulerSpec">SchedulerSpec</a>)
</p>
<p>
<p>Merger defines the options used to merge the PR</p>
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
<code>-</code></br>
<em>
time.Duration
</em>
</td>
<td>
<p>SyncPeriod specifies how often Merger will sync jobs with Github. Defaults to 1m.</p>
</td>
</tr>
<tr>
<td>
<code>-</code></br>
<em>
time.Duration
</em>
</td>
<td>
<p>StatusUpdatePeriod</p>
</td>
</tr>
<tr>
<td>
<code>targetUrl</code></br>
<em>
string
</em>
</td>
<td>
<p>URL for status contexts.</p>
</td>
</tr>
<tr>
<td>
<code>prStatusBaseUrl</code></br>
<em>
string
</em>
</td>
<td>
<p>PRStatusBaseURL is the base URL for the PR status page.
This is used to link to a merge requirements overview
in the status context.</p>
</td>
</tr>
<tr>
<td>
<code>blockerLabel</code></br>
<em>
string
</em>
</td>
<td>
<p>BlockerLabel is an optional label that is used to identify merge blocking
Git Provider issues.
Leave this blank to disable this feature and save 1 API token per sync loop.</p>
</td>
</tr>
<tr>
<td>
<code>squashLabel</code></br>
<em>
string
</em>
</td>
<td>
<p>SquashLabel is an optional label that is used to identify PRs that should
always be squash merged.
Leave this blank to disable this feature.</p>
</td>
</tr>
<tr>
<td>
<code>maxGoroutines</code></br>
<em>
int
</em>
</td>
<td>
<p>MaxGoroutines is the maximum number of goroutines spawned inside the
controller to handle org/repo:branch pools. Defaults to 20. Needs to be a
positive number.</p>
</td>
</tr>
<tr>
<td>
<code>mergeMethod</code></br>
<em>
string
</em>
</td>
<td>
<p>Override the default method of merge. Valid options are squash, rebase, and merge.</p>
</td>
</tr>
<tr>
<td>
<code>policy</code></br>
<em>
<a href="#jenkins.io/v1.ContextPolicy">
ContextPolicy
</a>
</em>
</td>
<td>
<p>ContextOptions defines the default merge options. If not set it will infer
the required and optional contexts from the jobs configured and use the Git Provider
combined status; otherwise it may apply the branch protection setting or let user
define their own options in case branch protection is not used.</p>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.Original">Original
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.FactSpec">FactSpec</a>)
</p>
<p>
<p>Original contains the report</p>
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
<code>mimetype</code></br>
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
<code>tags</code></br>
<em>
[]string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.Periodic">Periodic
</h3>
<p>
<p>Periodic defines a job to be run periodically</p>
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
<code>JobBase</code></br>
<em>
<a href="#jenkins.io/v1.JobBase">
JobBase
</a>
</em>
</td>
<td>
<em>(Optional)</em>
</td>
</tr>
<tr>
<td>
<code>interval</code></br>
<em>
string
</em>
</td>
<td>
<p>Interval to wait between two runs of the job.</p>
</td>
</tr>
<tr>
<td>
<code>cron</code></br>
<em>
string
</em>
</td>
<td>
<p>Cron representation of job trigger time</p>
</td>
</tr>
<tr>
<td>
<code>tags</code></br>
<em>
<a href="#jenkins.io/v1.ReplaceableSliceOfStrings">
ReplaceableSliceOfStrings
</a>
</em>
</td>
<td>
<p>Tags for config entries</p>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.Periodics">Periodics
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.SchedulerSpec">SchedulerSpec</a>)
</p>
<p>
<p>Periodics is a list of jobs to be run periodically</p>
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
<code>entries</code></br>
<em>
<a href="#jenkins.io/v1.*github.com/jenkins-x/jx/pkg/apis/jenkins.io/v1.Periodic">
[]*github.com/jenkins-x/jx/pkg/apis/jenkins.io/v1.Periodic
</a>
</em>
</td>
<td>
<p>Items are the post submit configurations</p>
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
<p>Replace the existing entries</p>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.PipelineActivitySpec">PipelineActivitySpec
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.PipelineActivity">PipelineActivity</a>)
</p>
<p>
<p>PipelineActivitySpec is the specification of the pipeline activity</p>
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
<code>build</code></br>
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
<tr>
<td>
<code>status</code></br>
<em>
<a href="#jenkins.io/v1.ActivityStatusType">
ActivityStatusType
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>startedTimestamp</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#time-v1-meta">
Kubernetes meta/v1.Time
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>completedTimestamp</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#time-v1-meta">
Kubernetes meta/v1.Time
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
<a href="#jenkins.io/v1.PipelineActivityStep">
[]PipelineActivityStep
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>buildUrl</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>buildLogsUrl</code></br>
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
<code>gitRepository</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>gitOwner</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>gitBranch</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>author</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>authorAvatarURL</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>authorURL</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>pullTitle</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>releaseNotesURL</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>lastCommitSHA</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>lastCommitMessage</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>lastCommitURL</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>workflow</code></br>
<em>
string
</em>
</td>
<td>
<p>Deprecated - Workflow functionality was removed and is obsolete
Keeping these fields to ensure backwards compatibility
Should be removed when we increment spec version</p>
</td>
</tr>
<tr>
<td>
<code>workflowStatus</code></br>
<em>
<a href="#jenkins.io/v1.ActivityStatusType">
ActivityStatusType
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>workflowMessage</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>postExtensions</code></br>
<em>
<a href="#jenkins.io/v1.ExtensionExecution">
[]ExtensionExecution
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>attachments</code></br>
<em>
<a href="#jenkins.io/v1.Attachment">
[]Attachment
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>batchPipelineActivity</code></br>
<em>
<a href="#jenkins.io/v1.BatchPipelineActivity">
BatchPipelineActivity
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>context</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>baseSHA</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.PipelineActivityStatus">PipelineActivityStatus
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.PipelineActivity">PipelineActivity</a>)
</p>
<p>
<p>PipelineActivityStatus is the status for an Environment resource</p>
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
<h3 id="jenkins.io/v1.PipelineActivityStep">PipelineActivityStep
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.PipelineActivitySpec">PipelineActivitySpec</a>)
</p>
<p>
<p>PipelineActivityStep represents a step in a pipeline activity</p>
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
<a href="#jenkins.io/v1.ActivityStepKindType">
ActivityStepKindType
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>stage</code></br>
<em>
<a href="#jenkins.io/v1.StageActivityStep">
StageActivityStep
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
<a href="#jenkins.io/v1.PromoteActivityStep">
PromoteActivityStep
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
<a href="#jenkins.io/v1.PreviewActivityStep">
PreviewActivityStep
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.PipelineExtension">PipelineExtension
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.AppSpec">AppSpec</a>)
</p>
<p>
<p>PipelineExtension defines the image and command of an app which wants to modify/extend the pipeline</p>
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
<p>Name of the container specified as a DNS_LABEL.</p>
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
<p>Docker image name.</p>
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
<p>Entrypoint array. Not executed within a shell.</p>
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
<p>Arguments to the entrypoint.</p>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.PipelineStageAndChildren">PipelineStageAndChildren
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.PipelineStageAndChildren">PipelineStageAndChildren</a>)
</p>
<p>
<p>PipelineStageAndChildren represents a single stage and its children.</p>
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
<code>Stage</code></br>
<em>
<a href="#jenkins.io/v1.PipelineStructureStage">
PipelineStructureStage
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>Parallel</code></br>
<em>
<a href="#jenkins.io/v1.PipelineStageAndChildren">
[]PipelineStageAndChildren
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>Stages</code></br>
<em>
<a href="#jenkins.io/v1.PipelineStageAndChildren">
[]PipelineStageAndChildren
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.PipelineStructureStage">PipelineStructureStage
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.PipelineStructure">PipelineStructure</a>, 
<a href="#jenkins.io/v1.PipelineStageAndChildren">PipelineStageAndChildren</a>)
</p>
<p>
<p>PipelineStructureStage contains the stage&rsquo;s name, one of either a reference to the Task corresponding
to the stage if it has steps, a list of sequential stage names nested within this stage, or a list of parallel stage
names nested within this stage, and information on this stage&rsquo;s depth within the PipelineStructure as a whole, the
name of its parent stage, if any, the name of the stage before it in execution order, if any, and the name of the
stage after it in execution order, if any.</p>
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
<code>taskRef</code></br>
<em>
string
</em>
</td>
<td>
<em>(Optional)</em>
<p>Must have one of TaskRef+TaskRunRef, Stages, or Parallel</p>
</td>
</tr>
<tr>
<td>
<code>taskRunRef</code></br>
<em>
string
</em>
</td>
<td>
<em>(Optional)</em>
<p>Populated during pod discovery, not at initial creation time.</p>
</td>
</tr>
<tr>
<td>
<code>stages</code></br>
<em>
[]string
</em>
</td>
<td>
<em>(Optional)</em>
</td>
</tr>
<tr>
<td>
<code>parallel</code></br>
<em>
[]string
</em>
</td>
<td>
<em>(Optional)</em>
</td>
</tr>
<tr>
<td>
<code>depth</code></br>
<em>
byte
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>parent</code></br>
<em>
string
</em>
</td>
<td>
<em>(Optional)</em>
</td>
</tr>
<tr>
<td>
<code>previous</code></br>
<em>
string
</em>
</td>
<td>
<em>(Optional)</em>
</td>
</tr>
<tr>
<td>
<code>next</code></br>
<em>
string
</em>
</td>
<td>
<em>(Optional)</em>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.PluginSpec">PluginSpec
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.Plugin">Plugin</a>)
</p>
<p>
<p>PluginSpec provides details of a binary plugin available for a team</p>
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
<code>subCommand</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>group</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>binaries</code></br>
<em>
<a href="#jenkins.io/v1.Binary">
[]Binary
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>description</code></br>
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
<h3 id="jenkins.io/v1.Postsubmit">Postsubmit
</h3>
<p>
<p>Postsubmit runs on push events.</p>
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
<code>JobBase</code></br>
<em>
<a href="#jenkins.io/v1.JobBase">
JobBase
</a>
</em>
</td>
<td>
<em>(Optional)</em>
</td>
</tr>
<tr>
<td>
<code>RegexpChangeMatcher</code></br>
<em>
<a href="#jenkins.io/v1.RegexpChangeMatcher">
RegexpChangeMatcher
</a>
</em>
</td>
<td>
<em>(Optional)</em>
</td>
</tr>
<tr>
<td>
<code>Brancher</code></br>
<em>
<a href="#jenkins.io/v1.Brancher">
Brancher
</a>
</em>
</td>
<td>
<em>(Optional)</em>
</td>
</tr>
<tr>
<td>
<code>context</code></br>
<em>
string
</em>
</td>
<td>
<p>Context is the name of the GitHub status context for the job.</p>
</td>
</tr>
<tr>
<td>
<code>report</code></br>
<em>
bool
</em>
</td>
<td>
<p>Report will comment and set status on GitHub.</p>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.Postsubmits">Postsubmits
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.SchedulerSpec">SchedulerSpec</a>)
</p>
<p>
<p>Postsubmits is a list of Postsubmit job configurations that can optionally completely replace the Postsubmit job
configurations in the parent scheduler</p>
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
<code>entries</code></br>
<em>
<a href="#jenkins.io/v1.*github.com/jenkins-x/jx/pkg/apis/jenkins.io/v1.Postsubmit">
[]*github.com/jenkins-x/jx/pkg/apis/jenkins.io/v1.Postsubmit
</a>
</em>
</td>
<td>
<p>Items are the post submit configurations</p>
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
<p>Replace the existing entries</p>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.Presubmit">Presubmit
</h3>
<p>
<p>Presubmit defines a job configuration for pull requests</p>
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
<code>JobBase</code></br>
<em>
<a href="#jenkins.io/v1.JobBase">
JobBase
</a>
</em>
</td>
<td>
<em>(Optional)</em>
</td>
</tr>
<tr>
<td>
<code>Brancher</code></br>
<em>
<a href="#jenkins.io/v1.Brancher">
Brancher
</a>
</em>
</td>
<td>
<em>(Optional)</em>
</td>
</tr>
<tr>
<td>
<code>RegexpChangeMatcher</code></br>
<em>
<a href="#jenkins.io/v1.RegexpChangeMatcher">
RegexpChangeMatcher
</a>
</em>
</td>
<td>
<em>(Optional)</em>
</td>
</tr>
<tr>
<td>
<code>alwaysRun</code></br>
<em>
bool
</em>
</td>
<td>
<p>AlwaysRun automatically for every PR, or only when a comment triggers it. By default true.</p>
</td>
</tr>
<tr>
<td>
<code>context</code></br>
<em>
string
</em>
</td>
<td>
<p>Context is the name of the Git Provider status context for the job.</p>
</td>
</tr>
<tr>
<td>
<code>optional</code></br>
<em>
bool
</em>
</td>
<td>
<p>Optional indicates that the job&rsquo;s status context should not be required for merge. By default false.</p>
</td>
</tr>
<tr>
<td>
<code>report</code></br>
<em>
bool
</em>
</td>
<td>
<p>Report enables reporting the job status on the git provider</p>
</td>
</tr>
<tr>
<td>
<code>trigger</code></br>
<em>
string
</em>
</td>
<td>
<p>Trigger is the regular expression to trigger the job.
e.g. <code>@k8s-bot e2e test this</code>
RerunCommand must also be specified if this field is specified.
(Default: <code>(?m)^/test (?:.*? )?&lt;job name&gt;(?: .*?)?$</code>)</p>
</td>
</tr>
<tr>
<td>
<code>rerunCommand</code></br>
<em>
string
</em>
</td>
<td>
<p>The RerunCommand to give users. Must match Trigger.
Trigger must also be specified if this field is specified.
(Default: <code>/test &lt;job name&gt;</code>)</p>
</td>
</tr>
<tr>
<td>
<code>mergeMethod</code></br>
<em>
string
</em>
</td>
<td>
<p>Override the default method of merge. Valid options are squash, rebase, and merge.</p>
</td>
</tr>
<tr>
<td>
<code>queries</code></br>
<em>
<a href="#jenkins.io/v1.*github.com/jenkins-x/jx/pkg/apis/jenkins.io/v1.Query">
[]*github.com/jenkins-x/jx/pkg/apis/jenkins.io/v1.Query
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>policy</code></br>
<em>
<a href="#jenkins.io/v1.ProtectionPolicies">
ProtectionPolicies
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>context_options</code></br>
<em>
<a href="#jenkins.io/v1.RepoContextPolicy">
RepoContextPolicy
</a>
</em>
</td>
<td>
<p>ContextOptions defines the merge options. If not set it will infer
the required and optional contexts from the jobs configured and use the Git Provider
combined status; otherwise it may apply the branch protection setting or let user
define their own options in case branch protection is not used.</p>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.Presubmits">Presubmits
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.SchedulerSpec">SchedulerSpec</a>)
</p>
<p>
<p>Presubmits is a list of Presubmit job configurations that can optionally completely replace the Presubmit job
configurations in the parent scheduler</p>
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
<code>entries</code></br>
<em>
<a href="#jenkins.io/v1.*github.com/jenkins-x/jx/pkg/apis/jenkins.io/v1.Presubmit">
[]*github.com/jenkins-x/jx/pkg/apis/jenkins.io/v1.Presubmit
</a>
</em>
</td>
<td>
<p>Items are the Presubmit configurtations</p>
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
<p>Replace the existing entries</p>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.PreviewActivityStep">PreviewActivityStep
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.PipelineActivityStep">PipelineActivityStep</a>)
</p>
<p>
<p>PreviewActivityStep is the step of creating a preview environment as part of a Pull Request pipeline</p>
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
<code>CoreActivityStep</code></br>
<em>
<a href="#jenkins.io/v1.CoreActivityStep">
CoreActivityStep
</a>
</em>
</td>
<td>
<p>
(Members of <code>CoreActivityStep</code> are embedded into this type.)
</p>
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
<code>pullRequestURL</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>applicationURL</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.PreviewGitSpec">PreviewGitSpec
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.EnvironmentSpec">EnvironmentSpec</a>)
</p>
<p>
<p>PreviewGitSpec is the preview git branch/pull request details</p>
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
<code>user</code></br>
<em>
<a href="#jenkins.io/v1.UserSpec">
UserSpec
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>title</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>description</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>buildStatus</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>buildStatusUrl</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>appName</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>applicationURL</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.PromoteActivityStep">PromoteActivityStep
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.PipelineActivityStep">PipelineActivityStep</a>)
</p>
<p>
<p>PromoteActivityStep is the step of promoting a version of an application to an environment</p>
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
<code>CoreActivityStep</code></br>
<em>
<a href="#jenkins.io/v1.CoreActivityStep">
CoreActivityStep
</a>
</em>
</td>
<td>
<p>
(Members of <code>CoreActivityStep</code> are embedded into this type.)
</p>
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
<code>pullRequest</code></br>
<em>
<a href="#jenkins.io/v1.PromotePullRequestStep">
PromotePullRequestStep
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>update</code></br>
<em>
<a href="#jenkins.io/v1.PromoteUpdateStep">
PromoteUpdateStep
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>applicationURL</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.PromotePullRequestStep">PromotePullRequestStep
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.PromoteActivityStep">PromoteActivityStep</a>)
</p>
<p>
<p>PromotePullRequestStep is the step for promoting a version to an environment by raising a Pull Request on the
git repository of the environment</p>
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
<code>CoreActivityStep</code></br>
<em>
<a href="#jenkins.io/v1.CoreActivityStep">
CoreActivityStep
</a>
</em>
</td>
<td>
<p>
(Members of <code>CoreActivityStep</code> are embedded into this type.)
</p>
</td>
</tr>
<tr>
<td>
<code>pullRequestURL</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>mergeCommitSHA</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.PromoteUpdateStep">PromoteUpdateStep
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.PromoteActivityStep">PromoteActivityStep</a>)
</p>
<p>
<p>PromoteUpdateStep is the step for updating a promotion after the Pull Request merges to master</p>
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
<code>CoreActivityStep</code></br>
<em>
<a href="#jenkins.io/v1.CoreActivityStep">
CoreActivityStep
</a>
</em>
</td>
<td>
<p>
(Members of <code>CoreActivityStep</code> are embedded into this type.)
</p>
</td>
</tr>
<tr>
<td>
<code>statuses</code></br>
<em>
<a href="#jenkins.io/v1.GitStatus">
[]GitStatus
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.PromoteWorkflowStep">PromoteWorkflowStep
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.WorkflowStep">WorkflowStep</a>)
</p>
<p>
<p>PromoteWorkflowStep is the step of promoting a version of an application to an environment</p>
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
<code>environment</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.PromotionEngineType">PromotionEngineType
(<code>string</code> alias)</p></h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.TeamSettings">TeamSettings</a>)
</p>
<p>
<p>PromotionEngineType is the type of promotion implementation the team uses</p>
</p>
<h3 id="jenkins.io/v1.PromotionStrategyType">PromotionStrategyType
(<code>string</code> alias)</p></h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.EnvironmentSpec">EnvironmentSpec</a>)
</p>
<p>
<p>PromotionStrategyType is the type of a promotion strategy</p>
</p>
<h3 id="jenkins.io/v1.ProtectionPolicies">ProtectionPolicies
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.Presubmit">Presubmit</a>)
</p>
<p>
<p>ProtectionPolicies defines the branch protection policies</p>
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
<code>ProtectionPolicy</code></br>
<em>
<a href="#jenkins.io/v1.ProtectionPolicy">
ProtectionPolicy
</a>
</em>
</td>
<td>
<em>(Optional)</em>
</td>
</tr>
<tr>
<td>
<code>Replace</code></br>
<em>
bool
</em>
</td>
<td>
<em>(Optional)</em>
</td>
</tr>
<tr>
<td>
<code>entries</code></br>
<em>
<a href="#jenkins.io/v1.*github.com/jenkins-x/jx/pkg/apis/jenkins.io/v1.ProtectionPolicy">
map[string]*github.com/jenkins-x/jx/pkg/apis/jenkins.io/v1.ProtectionPolicy
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.ProtectionPolicy">ProtectionPolicy
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.GlobalProtectionPolicy">GlobalProtectionPolicy</a>, 
<a href="#jenkins.io/v1.ProtectionPolicies">ProtectionPolicies</a>)
</p>
<p>
<p>ProtectionPolicy for merging.</p>
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
<code>protect</code></br>
<em>
bool
</em>
</td>
<td>
<p>Protect overrides whether branch protection is enabled if set.</p>
</td>
</tr>
<tr>
<td>
<code>requiredStatusChecks</code></br>
<em>
<a href="#jenkins.io/v1.BranchProtectionContextPolicy">
BranchProtectionContextPolicy
</a>
</em>
</td>
<td>
<p>RequiredStatusChecks configures github contexts</p>
</td>
</tr>
<tr>
<td>
<code>enforceAdmins</code></br>
<em>
bool
</em>
</td>
<td>
<p>Admins overrides whether protections apply to admins if set.</p>
</td>
</tr>
<tr>
<td>
<code>restrictions</code></br>
<em>
<a href="#jenkins.io/v1.Restrictions">
Restrictions
</a>
</em>
</td>
<td>
<p>Restrictions limits who can merge</p>
</td>
</tr>
<tr>
<td>
<code>requiredPullRequestReviews</code></br>
<em>
<a href="#jenkins.io/v1.ReviewPolicy">
ReviewPolicy
</a>
</em>
</td>
<td>
<p>RequiredPullRequestReviews specifies approval/review criteria.</p>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.ProwConfigType">ProwConfigType
(<code>string</code> alias)</p></h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.TeamSettings">TeamSettings</a>)
</p>
<p>
<p>ProwConfigType is the type of prow configuration</p>
</p>
<h3 id="jenkins.io/v1.ProwEngineType">ProwEngineType
(<code>string</code> alias)</p></h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.TeamSettings">TeamSettings</a>)
</p>
<p>
<p>ProwEngineType is the type of prow execution engine</p>
</p>
<h3 id="jenkins.io/v1.PullRequestInfo">PullRequestInfo
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.BatchPipelineActivity">BatchPipelineActivity</a>)
</p>
<p>
<p>PullRequestInfo contains information about a PR included in a batch, like its PR number, the last build number, and SHA</p>
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
<code>pullRequestNumber</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>lastBuildNumberForCommit</code></br>
<em>
string
</em>
</td>
<td>
<p>LastBuildNumberForCommit is the number of the last successful build of this PR outside of a batch</p>
</td>
</tr>
<tr>
<td>
<code>lastBuildSHA</code></br>
<em>
string
</em>
</td>
<td>
<p>LastBuildSHA is the commit SHA in the last successful build of this PR outside of a batch.</p>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.PullRequestMergeType">PullRequestMergeType
(<code>string</code> alias)</p></h3>
<p>
<p>PullRequestMergeType enumerates the types of merges the Git Provider API can
perform
<a href="https://developer.github.com/v3/pulls/#merge-a-pull-request-merge-button">https://developer.github.com/v3/pulls/#merge-a-pull-request-merge-button</a></p>
</p>
<h3 id="jenkins.io/v1.Query">Query
</h3>
<p>
<p>Query is turned into a Git Provider search query. See the docs for details:
<a href="https://help.github.com/articles/searching-issues-and-pull-requests/">https://help.github.com/articles/searching-issues-and-pull-requests/</a></p>
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
<code>excludedBranches</code></br>
<em>
<a href="#jenkins.io/v1.ReplaceableSliceOfStrings">
ReplaceableSliceOfStrings
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>includedBranches</code></br>
<em>
<a href="#jenkins.io/v1.ReplaceableSliceOfStrings">
ReplaceableSliceOfStrings
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>labels</code></br>
<em>
<a href="#jenkins.io/v1.ReplaceableSliceOfStrings">
ReplaceableSliceOfStrings
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>missingLabels</code></br>
<em>
<a href="#jenkins.io/v1.ReplaceableSliceOfStrings">
ReplaceableSliceOfStrings
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>milestone</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>reviewApprovedRequired</code></br>
<em>
bool
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.QuickStartLocation">QuickStartLocation
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.BuildPackSpec">BuildPackSpec</a>, 
<a href="#jenkins.io/v1.TeamSettings">TeamSettings</a>)
</p>
<p>
<p>QuickStartLocation</p>
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
<code>gitKind</code></br>
<em>
string
</em>
</td>
<td>
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
</td>
</tr>
<tr>
<td>
<code>includes</code></br>
<em>
[]string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>excludes</code></br>
<em>
[]string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.RegexpChangeMatcher">RegexpChangeMatcher
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.Postsubmit">Postsubmit</a>, 
<a href="#jenkins.io/v1.Presubmit">Presubmit</a>)
</p>
<p>
<p>RegexpChangeMatcher is for code shared between jobs that run only when certain files are changed.</p>
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
<code>runIfChanged</code></br>
<em>
string
</em>
</td>
<td>
<p>RunIfChanged defines a regex used to select which subset of file changes should trigger this job.
If any file in the changeset matches this regex, the job will be triggered</p>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.ReleaseSpec">ReleaseSpec
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.Release">Release</a>)
</p>
<p>
<p>ReleaseSpec is the specification of the Release</p>
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
<tr>
<td>
<code>gitHttpUrl</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>gitCloneUrl</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>commits</code></br>
<em>
<a href="#jenkins.io/v1.CommitSummary">
[]CommitSummary
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>issues</code></br>
<em>
<a href="#jenkins.io/v1.IssueSummary">
[]IssueSummary
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>pullRequests</code></br>
<em>
<a href="#jenkins.io/v1.IssueSummary">
[]IssueSummary
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>dependencyUpdates</code></br>
<em>
<a href="#jenkins.io/v1.DependencyUpdate">
[]DependencyUpdate
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>releaseNotesURL</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>gitRepository</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>gitOwner</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.ReleaseStatus">ReleaseStatus
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.Release">Release</a>)
</p>
<p>
<p>ReleaseStatus is the status of a release</p>
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
<code>status</code></br>
<em>
<a href="#jenkins.io/v1.ReleaseStatusType">
ReleaseStatusType
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.ReleaseStatusType">ReleaseStatusType
(<code>string</code> alias)</p></h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.ReleaseStatus">ReleaseStatus</a>)
</p>
<p>
<p>ReleaseStatusType is the status of a release; usually deployed or failed at completion</p>
</p>
<h3 id="jenkins.io/v1.ReplaceableMapOfStringContextPolicy">ReplaceableMapOfStringContextPolicy
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.RepoContextPolicy">RepoContextPolicy</a>)
</p>
<p>
<p>ReplaceableMapOfStringContextPolicy is a map of context policies that can optionally completely replace any
context policies defined in the parent scheduler</p>
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
<code>replace</code></br>
<em>
bool
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>Items</code></br>
<em>
<a href="#jenkins.io/v1.*github.com/jenkins-x/jx/pkg/apis/jenkins.io/v1.ContextPolicy">
map[string]*github.com/jenkins-x/jx/pkg/apis/jenkins.io/v1.ContextPolicy
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.ReplaceableMapOfStringString">ReplaceableMapOfStringString
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.JobBase">JobBase</a>)
</p>
<p>
<p>ReplaceableMapOfStringString is a map of strings that can optionally completely replace the map of strings in the
parent scheduler</p>
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
<code>entries</code></br>
<em>
map[string]string
</em>
</td>
<td>
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
<p>Replace the existing entries</p>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.ReplaceableSliceOfExternalPlugins">ReplaceableSliceOfExternalPlugins
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.SchedulerSpec">SchedulerSpec</a>)
</p>
<p>
<p>ReplaceableSliceOfExternalPlugins is a list of external plugins that can optionally completely replace the plugins
in any parent SchedulerSpec</p>
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
<code>Replace</code></br>
<em>
bool
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>entries</code></br>
<em>
<a href="#jenkins.io/v1.*github.com/jenkins-x/jx/pkg/apis/jenkins.io/v1.ExternalPlugin">
[]*github.com/jenkins-x/jx/pkg/apis/jenkins.io/v1.ExternalPlugin
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.ReplaceableSliceOfStrings">ReplaceableSliceOfStrings
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.BranchProtectionContextPolicy">BranchProtectionContextPolicy</a>, 
<a href="#jenkins.io/v1.Brancher">Brancher</a>, 
<a href="#jenkins.io/v1.ContextPolicy">ContextPolicy</a>, 
<a href="#jenkins.io/v1.ExternalPlugin">ExternalPlugin</a>, 
<a href="#jenkins.io/v1.Periodic">Periodic</a>, 
<a href="#jenkins.io/v1.Query">Query</a>, 
<a href="#jenkins.io/v1.Restrictions">Restrictions</a>, 
<a href="#jenkins.io/v1.SchedulerSpec">SchedulerSpec</a>)
</p>
<p>
<p>ReplaceableSliceOfStrings is a slice of strings that can optionally completely replace the slice of strings
defined in the parent scheduler</p>
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
<code>entries</code></br>
<em>
[]string
</em>
</td>
<td>
<p>Items is the string values</p>
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
<p>Replace the existing entries</p>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.RepoContextPolicy">RepoContextPolicy
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.Presubmit">Presubmit</a>)
</p>
<p>
<p>RepoContextPolicy overrides the policy for repo, and any branch overrides.</p>
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
<code>ContextPolicy</code></br>
<em>
<a href="#jenkins.io/v1.ContextPolicy">
ContextPolicy
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>branches</code></br>
<em>
<a href="#jenkins.io/v1.ReplaceableMapOfStringContextPolicy">
ReplaceableMapOfStringContextPolicy
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.ResourceReference">ResourceReference
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.CommitStatusDetails">CommitStatusDetails</a>, 
<a href="#jenkins.io/v1.FactSpec">FactSpec</a>, 
<a href="#jenkins.io/v1.SourceRepositoryGroupSpec">SourceRepositoryGroupSpec</a>, 
<a href="#jenkins.io/v1.SourceRepositorySpec">SourceRepositorySpec</a>, 
<a href="#jenkins.io/v1.TeamSettings">TeamSettings</a>)
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
<code>apiVersion</code></br>
<em>
string
</em>
</td>
<td>
<p>API version of the referent.</p>
</td>
</tr>
<tr>
<td>
<code>kind</code></br>
<em>
string
</em>
</td>
<td>
<p>Kind of the referent.
More info: <a href="https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds">https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds</a></p>
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
<p>Name of the referent.
More info: <a href="http://kubernetes.io/docs/user-guide/identifiers#names">http://kubernetes.io/docs/user-guide/identifiers#names</a></p>
</td>
</tr>
<tr>
<td>
<code>uid</code></br>
<em>
k8s.io/apimachinery/pkg/types.UID
</em>
</td>
<td>
<p>UID of the referent.
More info: <a href="http://kubernetes.io/docs/user-guide/identifiers#uids">http://kubernetes.io/docs/user-guide/identifiers#uids</a></p>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.Restrictions">Restrictions
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.ProtectionPolicy">ProtectionPolicy</a>, 
<a href="#jenkins.io/v1.ReviewPolicy">ReviewPolicy</a>)
</p>
<p>
<p>Restrictions limits who can merge
Users and Teams entries are appended to parent lists.</p>
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
<code>users</code></br>
<em>
<a href="#jenkins.io/v1.ReplaceableSliceOfStrings">
ReplaceableSliceOfStrings
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>teams</code></br>
<em>
<a href="#jenkins.io/v1.ReplaceableSliceOfStrings">
ReplaceableSliceOfStrings
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.ReviewPolicy">ReviewPolicy
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.ProtectionPolicy">ProtectionPolicy</a>)
</p>
<p>
<p>ReviewPolicy specifies git provider approval/review criteria.
Any nil values inherit the policy from the parent, otherwise bool/ints are overridden.
Non-empty lists are appended to parent lists.</p>
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
<code>dismissalRestrictions</code></br>
<em>
<a href="#jenkins.io/v1.Restrictions">
Restrictions
</a>
</em>
</td>
<td>
<p>Restrictions appends users/teams that are allowed to merge</p>
</td>
</tr>
<tr>
<td>
<code>dismissStaleReviews</code></br>
<em>
bool
</em>
</td>
<td>
<p>DismissStale overrides whether new commits automatically dismiss old reviews if set</p>
</td>
</tr>
<tr>
<td>
<code>requireCodeOwnerReviews</code></br>
<em>
bool
</em>
</td>
<td>
<p>RequireOwners overrides whether CODEOWNERS must approve PRs if set</p>
</td>
</tr>
<tr>
<td>
<code>requiredApprovingReviewCount</code></br>
<em>
int
</em>
</td>
<td>
<p>Approvals overrides the number of approvals required if set (set to 0 to disable)</p>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.SchedulerAgent">SchedulerAgent
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.SchedulerSpec">SchedulerSpec</a>)
</p>
<p>
<p>SchedulerAgent defines the scheduler agent configuration</p>
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
string
</em>
</td>
<td>
<p>Agent defines the agent used to schedule jobs, by default Prow</p>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.SchedulerSpec">SchedulerSpec
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.Scheduler">Scheduler</a>)
</p>
<p>
<p>SchedulerSpec defines the pipeline scheduler (e.g. Prow) configuration</p>
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
<code>schedulerAgent</code></br>
<em>
<a href="#jenkins.io/v1.SchedulerAgent">
SchedulerAgent
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>policy</code></br>
<em>
<a href="#jenkins.io/v1.GlobalProtectionPolicy">
GlobalProtectionPolicy
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>presubmits</code></br>
<em>
<a href="#jenkins.io/v1.Presubmits">
Presubmits
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>postsubmits</code></br>
<em>
<a href="#jenkins.io/v1.Postsubmits">
Postsubmits
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>trigger</code></br>
<em>
<a href="#jenkins.io/v1.Trigger">
Trigger
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>approve</code></br>
<em>
<a href="#jenkins.io/v1.Approve">
Approve
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>lgtm</code></br>
<em>
<a href="#jenkins.io/v1.Lgtm">
Lgtm
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>externalPlugins</code></br>
<em>
<a href="#jenkins.io/v1.ReplaceableSliceOfExternalPlugins">
ReplaceableSliceOfExternalPlugins
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>merger</code></br>
<em>
<a href="#jenkins.io/v1.Merger">
Merger
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>plugins</code></br>
<em>
<a href="#jenkins.io/v1.ReplaceableSliceOfStrings">
ReplaceableSliceOfStrings
</a>
</em>
</td>
<td>
<p>Plugins is a list of plugin names enabled for a repo</p>
</td>
</tr>
<tr>
<td>
<code>configUpdater</code></br>
<em>
<a href="#jenkins.io/v1.ConfigUpdater">
ConfigUpdater
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>welcome</code></br>
<em>
<a href="#jenkins.io/v1.*github.com/jenkins-x/jx/pkg/apis/jenkins.io/v1.Welcome">
[]*github.com/jenkins-x/jx/pkg/apis/jenkins.io/v1.Welcome
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>periodics</code></br>
<em>
<a href="#jenkins.io/v1.Periodics">
Periodics
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>attachments</code></br>
<em>
<a href="#jenkins.io/v1.*github.com/jenkins-x/jx/pkg/apis/jenkins.io/v1.Attachment">
[]*github.com/jenkins-x/jx/pkg/apis/jenkins.io/v1.Attachment
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.SourceRepositoryGroupSpec">SourceRepositoryGroupSpec
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.SourceRepositoryGroup">SourceRepositoryGroup</a>)
</p>
<p>
<p>SourceRepositoryGroupSpec is the metadata for an Application/Project/SourceRepository</p>
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
<code>metadata</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#objectmeta-v1-meta">
Kubernetes meta/v1.ObjectMeta
</a>
</em>
</td>
<td>
Refer to the Kubernetes API documentation for the fields of the
<code>metadata</code> field.
</td>
</tr>
<tr>
<td>
<code>repositories</code></br>
<em>
<a href="#jenkins.io/v1.ResourceReference">
[]ResourceReference
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>scheduler</code></br>
<em>
<a href="#jenkins.io/v1.ResourceReference">
ResourceReference
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.SourceRepositorySpec">SourceRepositorySpec
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.SourceRepository">SourceRepository</a>)
</p>
<p>
<p>SourceRepositorySpec provides details of the metadata for an App</p>
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
<code>description</code></br>
<em>
string
</em>
</td>
<td>
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
<p>Provider stores the URL of the git provider such as <a href="https://github.com">https://github.com</a></p>
</td>
</tr>
<tr>
<td>
<code>org</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>repo</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>providerName</code></br>
<em>
string
</em>
</td>
<td>
<p>ProviderName is a logical name for the provider without any URL scheme which can be used in a label selector</p>
</td>
</tr>
<tr>
<td>
<code>providerKind</code></br>
<em>
string
</em>
</td>
<td>
<p>ProviderKind is the kind of provider (github / bitbucketcloud / bitbucketserver etc)</p>
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
<p>URL is the web URL of the project page</p>
</td>
</tr>
<tr>
<td>
<code>sshCloneURL</code></br>
<em>
string
</em>
</td>
<td>
<p>SSHCloneURL is the git URL to clone this repository using SSH</p>
</td>
</tr>
<tr>
<td>
<code>httpCloneURL</code></br>
<em>
string
</em>
</td>
<td>
<p>HTTPCloneURL is the git URL to clone this repository using HTTP/HTTPS</p>
</td>
</tr>
<tr>
<td>
<code>scheduler</code></br>
<em>
<a href="#jenkins.io/v1.ResourceReference">
ResourceReference
</a>
</em>
</td>
<td>
<p>Scheduler a reference to a custom scheduler otherwise we default to the Team&rsquo;s Scededuler</p>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.StageActivityStep">StageActivityStep
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.PipelineActivityStep">PipelineActivityStep</a>)
</p>
<p>
<p>StageActivityStep represents a stage of zero to more sub steps in a jenkins pipeline</p>
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
<code>CoreActivityStep</code></br>
<em>
<a href="#jenkins.io/v1.CoreActivityStep">
CoreActivityStep
</a>
</em>
</td>
<td>
<p>
(Members of <code>CoreActivityStep</code> are embedded into this type.)
</p>
</td>
</tr>
<tr>
<td>
<code>steps</code></br>
<em>
<a href="#jenkins.io/v1.CoreActivityStep">
[]CoreActivityStep
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.Statement">Statement
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.FactSpec">FactSpec</a>)
</p>
<p>
<p>Statement represents a decision that was made, for example that a promotion was approved or denied</p>
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
<code>statementType</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>measurementValue</code></br>
<em>
bool
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>tags</code></br>
<em>
[]string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.StorageLocation">StorageLocation
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.TeamSettings">TeamSettings</a>)
</p>
<p>
<p>StorageLocation</p>
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
<code>classifier</code></br>
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
<code>gitBranch</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>bucketUrl</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.TeamKindType">TeamKindType
(<code>string</code> alias)</p></h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.TeamSpec">TeamSpec</a>)
</p>
<p>
<p>TeamKindType is the kind of an Team</p>
</p>
<h3 id="jenkins.io/v1.TeamProvisionStatusType">TeamProvisionStatusType
(<code>string</code> alias)</p></h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.TeamStatus">TeamStatus</a>)
</p>
<p>
<p>TeamProvisionStatusType is the kind of an Team</p>
</p>
<h3 id="jenkins.io/v1.TeamSettings">TeamSettings
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.EnvironmentSpec">EnvironmentSpec</a>)
</p>
<p>
<p>TeamSettings the default settings for a team</p>
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
<code>useGitOps</code></br>
<em>
bool
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>askOnCreate</code></br>
<em>
bool
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>branchPatterns</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>forkBranchPatterns</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>quickstartLocations</code></br>
<em>
<a href="#jenkins.io/v1.QuickStartLocation">
[]QuickStartLocation
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>buildPackUrl</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>buildPackRef</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>helmBinary</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>postPreviewJobs</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#job-v1-batch">
[]Kubernetes batch/v1.Job
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>promotionEngine</code></br>
<em>
<a href="#jenkins.io/v1.PromotionEngineType">
PromotionEngineType
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>noTiller</code></br>
<em>
bool
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>helmTemplate</code></br>
<em>
bool
</em>
</td>
<td>
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
</td>
</tr>
<tr>
<td>
<code>organisation</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>envOrganisation</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>pipelineUsername</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>pipelineUserEmail</code></br>
<em>
string
</em>
</td>
<td>
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
</td>
</tr>
<tr>
<td>
<code>kubeProvider</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>appsRepository</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>buildPackName</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>storageLocations</code></br>
<em>
<a href="#jenkins.io/v1.StorageLocation">
[]StorageLocation
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>deployKind</code></br>
<em>
string
</em>
</td>
<td>
<p>DeployKind what kind of deployment (&ldquo;default&rdquo; uses regular Kubernetes Services and Deployments, &ldquo;knative&rdquo; uses the Knative Service resource instead)</p>
</td>
</tr>
<tr>
<td>
<code>importMode</code></br>
<em>
<a href="#jenkins.io/v1.ImportModeType">
ImportModeType
</a>
</em>
</td>
<td>
<p>ImportMode indicates what kind of</p>
</td>
</tr>
<tr>
<td>
<code>prowEngine</code></br>
<em>
<a href="#jenkins.io/v1.ProwEngineType">
ProwEngineType
</a>
</em>
</td>
<td>
<p>ProwEngine is the kind of prow engine used such as knative build or build pipeline</p>
</td>
</tr>
<tr>
<td>
<code>versionStreamUrl</code></br>
<em>
string
</em>
</td>
<td>
<p>VersionStreamURL contains the git clone URL for the Version Stream which is the set of versions to use for charts, images, packages etc</p>
</td>
</tr>
<tr>
<td>
<code>versionStreamRef</code></br>
<em>
string
</em>
</td>
<td>
<p>VersionStreamRef contains the git ref (tag or branch) in the VersionStreamURL repository to use as the version stream</p>
</td>
</tr>
<tr>
<td>
<code>appPrefixes</code></br>
<em>
[]string
</em>
</td>
<td>
<p>AppsPrefixes is the list of prefixes for appNames</p>
</td>
</tr>
<tr>
<td>
<code>defaultScheduler</code></br>
<em>
<a href="#jenkins.io/v1.ResourceReference">
ResourceReference
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>prowConfig</code></br>
<em>
<a href="#jenkins.io/v1.ProwConfigType">
ProwConfigType
</a>
</em>
</td>
<td>
<p>ProwConfig is the way we manage prow configurations</p>
</td>
</tr>
<tr>
<td>
<code>profile</code></br>
<em>
string
</em>
</td>
<td>
<p>Profile is the profile in use (see jx profile)</p>
</td>
</tr>
<tr>
<td>
<code>bootRequirements</code></br>
<em>
string
</em>
</td>
<td>
<p>BootRequirements is a marshaled string of the jx-requirements.yml used in the most recent run for this cluster</p>
</td>
</tr>
<tr>
<td>
<code>deployOptions</code></br>
<em>
<a href="#jenkins.io/v1.DeployOptions">
DeployOptions
</a>
</em>
</td>
<td>
<p>DeployOptions configures options for how to deploy applications by default such as using canary rollouts (progressive delivery) or using horizontal pod autoscaler</p>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.TeamSpec">TeamSpec
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.Team">Team</a>)
</p>
<p>
<p>TeamSpec is the specification of an Team</p>
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
</td>
</tr>
<tr>
<td>
<code>kind</code></br>
<em>
<a href="#jenkins.io/v1.TeamKindType">
TeamKindType
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>members</code></br>
<em>
[]string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.TeamStatus">TeamStatus
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.Team">Team</a>)
</p>
<p>
<p>TeamStatus is the status for an Team resource</p>
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
<code>provisionStatus</code></br>
<em>
<a href="#jenkins.io/v1.TeamProvisionStatusType">
TeamProvisionStatusType
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>message</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.Trigger">Trigger
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.SchedulerSpec">SchedulerSpec</a>)
</p>
<p>
<p>Trigger specifies a configuration for a single trigger.</p>
<p>The configuration for the trigger plugin is defined as a list of these structures.</p>
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
<code>trustedOrg</code></br>
<em>
string
</em>
</td>
<td>
<p>TrustedOrg is the org whose members&rsquo; PRs will be automatically built
for PRs to the above repos. The default is the PR&rsquo;s org.</p>
</td>
</tr>
<tr>
<td>
<code>joinOrgUrl</code></br>
<em>
string
</em>
</td>
<td>
<p>JoinOrgURL is a link that redirects users to a location where they
should be able to read more about joining the organization in order
to become trusted members. Defaults to the Github link of TrustedOrg.</p>
</td>
</tr>
<tr>
<td>
<code>onlyOrgMembers</code></br>
<em>
bool
</em>
</td>
<td>
<p>OnlyOrgMembers requires PRs and/or /ok-to-test comments to come from org members.
By default, trigger also include repo collaborators.</p>
</td>
</tr>
<tr>
<td>
<code>ignoreOkToTest</code></br>
<em>
bool
</em>
</td>
<td>
<p>IgnoreOkToTest makes trigger ignore /ok-to-test comments.
This is a security mitigation to only allow testing from trusted users.</p>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.UserDetails">UserDetails
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.User">User</a>, 
<a href="#jenkins.io/v1.CommitSummary">CommitSummary</a>, 
<a href="#jenkins.io/v1.IssueSummary">IssueSummary</a>)
</p>
<p>
<p>UserDetails containers details of a user</p>
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
<code>login</code></br>
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
<code>email</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>creationTimestamp</code></br>
<em>
<a href="https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#time-v1-meta">
Kubernetes meta/v1.Time
</a>
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
<code>avatarUrl</code></br>
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
<code>accountReference</code></br>
<em>
<a href="#jenkins.io/v1.AccountReference">
[]AccountReference
</a>
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>externalUser</code></br>
<em>
bool
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.UserSpec">UserSpec
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.PreviewGitSpec">PreviewGitSpec</a>)
</p>
<p>
<p>UserSpec is the user details</p>
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
<code>linkUrl</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>imageUrl</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.WebHookEngineType">WebHookEngineType
(<code>string</code> alias)</p></h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.EnvironmentSpec">EnvironmentSpec</a>)
</p>
<p>
<p>WebHookEngineType is the type of webhook processing implementation the team uses</p>
</p>
<h3 id="jenkins.io/v1.Welcome">Welcome
</h3>
<p>
<p>Welcome welcome plugin config</p>
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
<code>message_template</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.WorkflowPreconditions">WorkflowPreconditions
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.WorkflowStep">WorkflowStep</a>)
</p>
<p>
<p>WorkflowPreconditions is the trigger to start a step</p>
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
<code>environments</code></br>
<em>
[]string
</em>
</td>
<td>
<p>the names of the environments which need to have promoted before this step can be triggered</p>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.WorkflowSpec">WorkflowSpec
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.Workflow">Workflow</a>)
</p>
<p>
<p>WorkflowSpec is the specification of the pipeline activity</p>
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
<code>steps</code></br>
<em>
<a href="#jenkins.io/v1.WorkflowStep">
[]WorkflowStep
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.WorkflowStatus">WorkflowStatus
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.Workflow">Workflow</a>)
</p>
<p>
<p>WorkflowStatus is the status for an Environment resource</p>
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
<h3 id="jenkins.io/v1.WorkflowStatusType">WorkflowStatusType
(<code>string</code> alias)</p></h3>
<p>
<p>WorkflowStatusType is the status of an activity; usually succeeded or failed/error on completion</p>
</p>
<h3 id="jenkins.io/v1.WorkflowStep">WorkflowStep
</h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.WorkflowSpec">WorkflowSpec</a>)
</p>
<p>
<p>WorkflowStep represents a step in a pipeline activity</p>
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
<a href="#jenkins.io/v1.WorkflowStepKindType">
WorkflowStepKindType
</a>
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
<code>description</code></br>
<em>
string
</em>
</td>
<td>
</td>
</tr>
<tr>
<td>
<code>trigger</code></br>
<em>
<a href="#jenkins.io/v1.WorkflowPreconditions">
WorkflowPreconditions
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
<a href="#jenkins.io/v1.PromoteWorkflowStep">
PromoteWorkflowStep
</a>
</em>
</td>
<td>
</td>
</tr>
</tbody>
</table>
<h3 id="jenkins.io/v1.WorkflowStepKindType">WorkflowStepKindType
(<code>string</code> alias)</p></h3>
<p>
(<em>Appears on:</em>
<a href="#jenkins.io/v1.WorkflowStep">WorkflowStep</a>)
</p>
<p>
<p>WorkflowStepKindType is a kind of step</p>
</p>
<hr/>
<p><em>
Generated with <code>gen-crd-api-reference-docs</code>
on git commit <code>830820e33</code>.
</em></p>
