---
title: Using
linktitle: Using
type: docs
description: Questions on using Jenkins X
weight: 150
---

## How do I list the apps that have been deployed?

There is a handy HTML report in your cluster dev git repository at **docs/README.md** which lists all the charts deployed in every namespace with their version.

You can see the helm charts that are installed along with their version, namespaces and any configuration values by looking at the `releases` section of your `helmfile.yaml` and `helmfile/*/helmfile.yaml` files in your cluster git repository.

You can browse all the kubernetes resources in each namespace using the canonical layout in the `config-root` folder. e.g. all charts are versioned in git as follows:

```bash
config-root/
  namespaces/
   jx/
     lighthouse/
       lighthouse-webhooks-deploy.yaml    
```

You can see the above kubernetes resource, a `Deployment` with name `lighthouse-webhooks` in the namespace `jx` which comes from the `lighthouse` chart.

There could be some additional charts installed via Terraform for the [git operator](/v3/guides/operator/) and [health subsystem](/v3/guides/health/) which can be viewed via:

```bash
helm list --all-namespaces
```

## How do I delete an application?

There is a [jx application delete](/v3/develop/reference/jx/application/delete/) command to remove a repository from the source configuration and for removing any deployed instances of the application.

e.g.

```bash
jx application delete --name myapp
```

Or you can remove an application or helm chart from an environment by removing the entry in the `releases:` list in the `helmfiles/$namespace/helmfile.yaml` file in your dev git repository and peforming a git commit and pushing the change (usually via a Pull Request).

Once the pull request is merged, the [boot job will trigger](/v3/about/how-it-works/#boot-job) which will remove the application from kubernetes.

### Stopping new releases

If the application you are removing was released via Jenkins X then the next time there is a change committed to your applications git repsitory a new release will be triggered which will be promoted again.

So to stop new releases you need to remove the application from the `.jx/gitops/source-config.yaml` repository.

You should also ensure that the `SourceRepository` has been deleted. Unfortunately when using `kubectl apply` this doesn't usually get removed (though it does with `kapp`) so you may want to do:

```bash
# view all the SourceRepository resources:
kubectl get sr

# find the one that you want to remove then:
kubectl delete sr $theNameToDelete
````

This will stop Jenkins X creating webhooks and firing pipelines when you make changes.

You may also want to remove the webhook from the repository to be safe.

## How do I stop jx asking for git credentials

When you run commands like [jx project](/v3/develop/reference/jx/project/) to create/import repositories or [jx application](/v3/develop/reference/jx/application/) to list applications need to be able to access git repositories using tokens.

You can define the git credentials so that you can do `git clone` of your private git repositories via...

```bash
mkdir -p ~/git 
echo "https://$USERNAME:$TOKEN@github.com" >> ~/git/credentials

# enable git credential store
git config --global credential.helper store
```

## How do I use dev pods?

See the [inner loop documentation](/v3/develop/pipelines/inner-loop/)

## How do I use Testcontainers?

If you want to use a container, such as a database, inside your pipeline so that you can run tests against your database inside your pipeline then use a [sidecar container in Tekton](https://tekton.dev/vault/pipelines-v0.16.3/tasks/#specifying-sidecars).

Here is [another example of a sidecar in a pipeline](https://tekton.dev/vault/pipelines-v0.16.3/tasks/#using-a-sidecar-in-a-task)

If you want to use a separate container inside a preview environment then add [charts or resources](/v3/develop/apps/#adding-charts) to the `preview/helmfile.yaml`
