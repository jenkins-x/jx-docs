---
title: jx gitops helm template
linktitle: template
type: docs
description: "Generate the kubernetes resources from a helm chart"
aliases:
  - jx-gitops_helm_template
---

### Usage

```
jx gitops helm template
```

### Synopsis

Generate the kubernetes resources from a helm chart

### Examples

  ```bash
  # generates the resources from a helm chart
  jx-gitops step helm template

  ```

### Options

```
  -c, --chart string            the chart name to template. Defaults to 'charts/$name'
      --commit-message string   the git commit message used (default "chore: generated kubernetes resources from helm chart")
      --domain string           the default domain name in the generated ingress (default "cluster.local")
      --git-commit              if set then the template command will git commit any changed files
  -h, --help                    help for template
      --include-crds            if CRDs should be included in the output (default true)
  -n, --name string             the name of the helm release to template. Defaults to $APP_NAME if not specified
      --namespace string        specifies the namespace to use to generate the templates in
      --no-external-secrets     if set then disable converting Secret resources to ExternalSecrets
      --no-split                if set then disable splitting of multiple resources into separate files
      --optional                check if there is a charts dir and if not do nothing if it does not exist
  -o, --output-dir string       the output directory to generate the templates to. Defaults to charts/$name/resources
  -r, --repository string       the helm chart repository to locate the chart
  -f, --values stringArray      the helm values.yaml file used to template values in the generated template
  -v, --version string          the version of the helm chart to use. If not specified then the latest one is used
```

### Source

[jenkins-x-plugins/jx-gitops](https://github.com/jenkins-x-plugins/jx-gitops)
