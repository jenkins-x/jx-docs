---
title: Docker Registry
linktitle: Docker Registry
description: Configuring your docker registry
weight: 90
aliases:
  - /docs/resources/guides/managing-jx/common-tasks/docker-registry
---

To be able to create and publish Docker images, we use a Docker Registry.
If you want to change the default registry, you need to:

1. tell Jenkins X, which Docker registry host to use.
1. ensure `env/parameters.yaml` contains the required authentication parameters
1. ensure your secret store contains the necessary secret
1. ensure `values.tmpl.yaml` for your Kubernetes provider contains the correct _DockerConfig_ configuration

The following sections provide more details around these steps.

{{% alert %}}
This guide assumes that you already have a Jenkins X cluster using the default registry and you want to switch to a custom, non-default one.
If you are installing Jenkins X on a fresh cluster, not all steps are necessary and handled interactively after you answer _yes_ to the question: "Do you want to configure an external Docker Registry?".
{{% /alert  %}}

{{% alert %}}
You need a checkout of your Boot configuration repository in which you run `jx boot` locally or create a pull request.
For more information refer to [Changing your installation](/docs/install-setup/boot/#changing-your-installation) in the Boot documentation.
{{% /alert %}}

## Configure Docker registry

To change the default Docker registry, you need set the registry host in the `registry` property of your `jx-requirements.yml` file.
In case you want to use Docker Hub, the configuration would look like this:

```yaml
cluster:
  registry: docker.io
```

## Ensure authentication parameters

Next, you have to check the file `env/parameters.yaml` in your checkout of the Boot repository.
It needs to contain a _docker_ configuration section, similar to this:

```yaml
enableDocker: true
docker:
  email: <email>
  password: vault:<cluster-name>/docker:password
  url: <url>
  username: <username>
```

If you have been using the default registry your `env/parameters.yaml` might not contain a _docker_ section at all.
If so, add the required configuration and make sure to set `enableDocker: true`.

The password uses a special format which allows to reference secrets from your configured [secret store](/docs/install-setup/boot/secrets/).
[Injecting secrets into the parameters](/docs/install-setup/boot/how-it-works/#injecting-secrets-into-the-parameters) describes in more detail how secrets work in conjunction with `env/parameters.yaml`.

{{% alert %}}
An alternative approach is to just set `enableDocker: true` and run `jx boot` locally.
In this case, it will interactively ask for the required parameters again and persist them into `env/parameters.yaml` and the underlying secret store.
{{% /alert  %}}

## Update secret store

The next step is to make sure the password is stored in the secret store.
Assuming you are using [Vault](/docs/install-setup/boot/secrets/) as the secret store, you need to make sure the secret identified by the URI _vault:\<cluster-name\>/docker:password_ exists.
This can be achieved by running (you need the `vault` CLI installed for that):

```sh
eval $(jx get vault-config)
vault kv put /secret/<cluster-name>/docker password=<my-password>
```

You can find more information on how to interact with Vault secrets in the [Manage your secrets](/docs/reference/components/vault/) section.

## Update Kubernetes provider configuration

Finally, you need to make sure that the correct Docker authentication `config.json` gets generated and stored in the Kubernetes Secret `jenkins-docker-cfg` (within your development namespace).
Ultimately, this secret is mounted into the Pod executing the `docker push` and is responsible for authenticating against the configured Docker registry.

{{% alert %}}
If you are running an old `jx install` based cluster, changing your Docker registry credentials comes just down to changing the `jenkins-docker-cfg` Secret.

```sh
kubectl delete secret jenkins-docker-cfg -n jx
kubectl create secret generic jenkins-docker-cfg -n jx --from-file=./config.json
```

{{% /alert  %}}

With Jenkins X Boot, the `jenkins-docker-cfg` Secret is created in the Kubernetes provider-specific file `values.tmpl.yaml`.
You can find this file in the [_kubeProviders_](https://github.com/jenkins-x/jenkins-x-boot-config/tree/master/kubeProviders) subdirectory of your Boot configuration repository.
The Docker specific configuration in `values.tmpl.yaml` for GKE looks like this:

```yaml
jenkins-x-platform:
  PipelineSecrets:

{{- if eq .Parameters.enableDocker true }}
    DockerConfig: |-
      {
        "auths":{
          {{ .Parameters.docker.url | quote }}:
            {
              "auth": {{ printf "%s:%s" .Parameters.docker.username .Parameters.docker.password | b64enc | quote}},
              "email": {{ .Parameters.docker.email | quote}}
            }
        }
      }
{{- else}}
    # lets enable GCR Docker builds
    DockerConfig: |-
      {
          "credHelpers": {
              "gcr.io": "gcr",
              "us.gcr.io": "gcr",
              "eu.gcr.io": "gcr",
              "asia.gcr.io": "gcr",
              "staging-k8s.gcr.io": "gcr"
          }
      }
{{- end}}
```

You can see how the _enableDocker_ parameter discussed in [Ensure authentication parameters](/docs/reference/components/docker-registry/#ensure-authentication-parameters) is used to switch between the different formats of `config.json`.
You need to ensure that the enabled _DockerConfig_ matches your requirements.
If that is not the case adjust `values.tmpl.yaml` to match the format required by your registry.

The following sections describe some of the typical `config.json` formats used by various Docker registries.

### Google Container Registry (GCR)

If you want to use GCR, you can create your `config.json` by running:

```sh
gcloud auth configure-docker
```

The above command will ask you to confirm writing a _credHelpers_ section to your `config.json` in your home directory under `.docker/config.json`.
It is sufficient to place the _credHelpers_ section into a new `config.json`.
The content should look similar to:

```json
 {
  "credHelpers": {
    "gcr.io": "gcloud",
    "marketplace.gcr.io": "gcloud",
    "eu.gcr.io": "gcloud",
    "us.gcr.io": "gcloud",
    "staging-k8s.gcr.io": "gcloud",
    "asia.gcr.io": "gcloud"
  }
}
```

### Elastic Container Registry (ECR)

For AWS and its  Elastic Container Registry (ECR), the `config.json` looks like:

```json
{
    "credsStore": "ecr-login"
}
```

### Docker Hub

If you want to publish images to Docker Hub, then you need a `config.json` with and _auth_ section containing your Docker Hub auth token.
For example:

```json
{
    "auths": {
        "https://index.docker.io/v1/": {
            "auth": "MyDockerHubToken"
        }
    }
}
```

Check `.docker/config.json` in your home directory to see whether it contains the required configuration.

If you don't have a `.docker/config.json`, you can run:

```sh
docker login -u <username> -p <password>
```

On macOS you might find something like this:

```json
"credsStore": "osxkeychain"
```

in `.docker/config.json` without an _auths_ section.
In this case, you can edit the _credsStore_ line and set the value of this property to "".
Then run:

```sh
docker logout
docker login -u <username> -p <password>
```

### jFrog BinTray (Artifactory)

It is also possible to use jFrog BinTray as a private registry.
The content should look similar to:

```json
{
    "auths": {
        "https://private-reg.bintray.io": {
            "auth": "username:password (base64 encoded)",
            "email": "myemail@acme.com"
        }
    }
}
```
