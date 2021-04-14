---
title: OAuth
linktitle: OAuth
type: docs
description: How to protect Pipeline Visualizer with OAuth
weight: 200
---
 
By default Jenkins X installs a publically accessible GUI for viewing pipelines.  This is automatically linked to via the "details" on pull requests.
 
![Pull Request](/images/v3/gui-link1.png)
 
The initial installation will protect this GUI with basic auth however if you want to share access then you might prefer to configure OAuth using Google or GitHub for example instead. 
 
This guide will use [oauth2-proxy](https://github.com/oauth2-proxy/oauth2-proxy) to protect the Pipeline Visualizer UI with OAuth.  There are more advanced configuration settings and provider examples in the documentation [here](https://github.com/oauth2-proxy/oauth2-proxy/blob/7def4bf/docs/docs/configuration/auth.md)
 
__NOTE__ There is a limitation of using oauth2-proxy with this configuration at the moment where only one service can be protected via one running oauth2-proxy deployment.  This is because the redirect URL that is configured in the OAuth providers can only map to a single oauth2-proxy callback URL.  If you would like a more generic SSO solution then you could look at integrating with [Dex](https://github.com/dexidp/dex#dex---a-federated-openid-connect-provider) or [Keycloak](https://www.keycloak.org/).
 
# Prerequisites

__IMPORTANT__ 

1. TLS and DNS is required, please follow [this](/v3/admin/setup/ingress/tls_dns) guide if they not already setup
 
2. Choose your OAuth provider and get the client ID and client secret using this (https://github.com/oauth2-proxy/oauth2-proxy/blob/7def4bf/docs/docs/configuration/auth.md)
 
As an example here are two screenshots for using Google and GitHub
 
### GitHub example
 
![GitHub](/images/v3/oauth_gh.png)
 
### Google example

![Google](/images/v3/oauth_google.png)
 
# Setup
 
We will be editing helmfiles so clone your cluster git repository and move into the root directory.
 
Add the oauth2 proxy helm chart, this will redirect requests to to the configured OAuth provider:
```bash
jx gitops helmfile add --chart k8s-at-home/oauth2-proxy
jx gitops helmfile resolve
```
you should see the new chart added to the end of the file `./helmfiles/jx/helmfile.yaml`
 
```bash
git add ./helmfiles/jx/helmfile.yaml
git commit -m 'chore: add oauth2 proxy'
```
 
By default Jenkins X is configured to use GitHub as the OAuth provider, to change this edit the file `./helmfiles/jx/helmfile.yaml` and add __extraArgs__ config like the google example here:
```yaml
- chart: k8s-at-home/oauth2-proxy
 version: 5.0.3
 name: oauth2-proxy
 values:
 - ../../versionStream/charts/k8s-at-home/oauth2-proxy/values.yaml
 - jx-values.yaml
 - extraArgs:
     provider: google
```
 
For a full list of supported providers see [here](https://github.com/oauth2-proxy/oauth2-proxy/blob/7def4bf/docs/docs/configuration/auth.md)
 
By default this configuration works with the Pipeline Visualizer however you can override the default Jenkins X oauth2-proxy helm config to be any ingress if you prefer instead. 
i.e. this is the default so you could override the helm value from `dashboard` to be `nexus` if you wanted OAuth on Nexus instead.  No need to do anything if it is the Pipeline Visualizer you want OAuth for.
```yaml
ingress:
 hosts:
 - dashboard{{ .Values.jxRequirements.ingress.namespaceSubDomain }}{{ .Values.jxRequirements.ingress.domain }}
 ```
 
Next we need to tell the Kubernetes Ingress that it needs to use our new OAuth provider.
 
Create a file `./helmfiles/jx/pv-values.yaml` with the following contents, this also unsets the basic auth config which was enabled during the initial installation:
 
```yaml
ingress:
 annotations:
   nginx.ingress.kubernetes.io/auth-secret: ""
   nginx.ingress.kubernetes.io/auth-type: ""
   nginx.ingress.kubernetes.io/auth-signin: https://$host/oauth2/start?rd=$escaped_request_uri
   nginx.ingress.kubernetes.io/auth-url: https://$host/oauth2/auth
```
 
Now reference the new `pv-values.yaml` file for the pipeline visualizer chart in `./helmfiles/jx/helmfile.yaml`
 
i.e.
 
```yaml
- chart: jx3/jx-pipelines-visualizer
 name: jx-pipelines-visualizer
 values:
 - ../../versionStream/charts/jx3/jx-pipelines-visualizer/values.yaml.gotmpl
 - jx-values.yaml
 - pv-values.yaml
```
 
Now add, commit and push the changes
```bash
git add --all
git commit -m 'chore: enable OAuth for pipeline visualizer'
git push
```
This will trigger the boot pipeline which you can follow with
```
jx admin logs
```
Once the logs start applying the generated Kubernetes resources you can CTRL+C to stop following the logs and populate the secrets in you secret store such as Vault, or Google Secrets Manager for example:
```bash
jx secret edit -i
```
filter for `oauth` and select `client id` and `client secret` options using the space bar

![jx secret edit -i](/images/v3/oauth_secret_edit.png)

Now enter the client id and secret you got from the Prerequisites step above.
 
Once entered you can wait to see the oauth2-proxy pod become Available using
```
kubectl get deploy/oauth2-proxy -w
```
When `Ready` you can access the pipeline visualizer using the hostname from
```
kubectl get ing jx-pipelines-visualizer
```