---
title: Apps
linktitle: Apps Framework
description: Extending Jenkins X using the Apps Framework
type: docs
weight: 20
aliases:
    - /docs/contributing/addons/
    - /docs/guides/extending-jx/introduction/
---

## What are Apps

Jenkins X Apps are distributed as Helm Charts via Helm Chart repositories. Any Helm chart can be installed as an app
using `jx add app`, although Jenkins X adds various capabilities to Helm Charts including:

* the ability to interactively ask questions to generate `values.yaml` based on JSON Schema
* the ability to create pull requests against the GitOps repo that manages your team/cluster
* the ability to store secrets in vault
* the ability to upgrade all apps to the latest version

Planned features include:

* integrating [kustomize](https://github.com/kubernetes-sigs/kustomize) to allow existing charts to be modified
* storing Helm repository credentials in vault
* taking existing `values.yaml` as defaults when asking questions based on JSON Schema during app upgrade
* only asking new questions during app upgrade
* integration for bash completion

### Official Apps repositry

Jenkins X provides a lot Apps like: Gloo, Istio, Kubeless and more in https://github.com/jenkins-x-apps.

### CLI Commands

* [jx add app](/commands/jx_add_app/) - Adds an app to Jenkins X
* [jx delete app](/commands/jx_delete_app/) - Deletes one or more apps from Jenkins X
* [jx get apps](/commands/jx_get_apps/) - Display one or more installed apps
* [jx upgrade apps](/commands/jx_upgrade_apps/) - Upgrades one or more apps to a newer release

## Structure of an App chart

In addition to the structure of a regular helm chart a Jenkins X App chart contains the following:

* `values.schema.yaml`: a JSON schema extended with conditions, field values and questions that is used to point out and prompt the user for customizable values the app should be installed with.
* `templates/app.yaml`: a Jenkins X `App` custom resource: allows to define a `values.schema.yaml` transformation which can be used to inject cluster-specific values as for instance its domain and TLS settings (which can be obtained by mounting the ConfigMap `ingress-config`).

When `jx add app` is called the corresponding helm chart is fetched, its `values.schema.yaml` transformed using the `App` resource and the user prompted for the contained questions (non-const fields).
From the user's answers a `values.yaml` is generated and used to install the chart.

## How to test local App chart changes

You can build your app chart locally, upload it in your cluster's chart repository and call `jx add app` referencing your uploaded chart.
This can be done as follows from within your chart's directory:

```sh
CHART_NAME=<YOUR_APP_NAME>
CHART_VERSION=<YOUR_APP_VERSION>
CHART_REPO=<YOUR_CHART_REPO_URL> # listed by `jx get urls`
CHART_REPO_USR=<YOUR_USERNAME>
CHART_REPO_PSW=<YOUR_PASSWORD>
helm init --client-only
helm repo add <DEP_REPO_NAME> <DEP_REPO_URL> # required if dependencies need to be loaded
helm dependency build
sed "s/version: .*/version: $CHART_VERSION/g" -i Chart.yaml # set the app's current version
helm lint .
helm package .
curl --fail -u "$CHART_REPO_USR:$CHART_REPO_PSW" --data-binary "@${CHART_NAME}-${CHART_VERSION}.tgz" ${CHART_REPO}/api/charts
jx add app --repository $CHART_REPO --version $CHART_VERSION $CHART_NAME
```
