---
title: Multiple domains
linktitle: Multiple domains
type: docs
description: Setting up environment-specific domains with TLS 
weight: 270
---

**Example: Use different domains for production and staging environments**

Add `acme` chart to _helmfiles/jx-production/helmfile.yaml_

```yaml
- chart: jx3/acme
  version: 0.0.19
  condition: jxRequirementsIngressTLS.enabled
  name: acme-jx
  namespace: jx-production
  values:
  - jx-values.yaml
  - acme-values.yaml
```

Create a file _helmfiles/jx-production/acme-values.yaml_

```yaml
issuer:
  enabled: true
  cluster: false
```

Do the same for other environments, e.g. staging. Make sure the correct namespace is set.

Add ingress and tls configuration to the environments in _jx-requirements.yaml_

```yaml
  environments:
    - ingress:
        domain: staging.foo.io
        externalDNS: true
        tls:
          email: admin@foo.com
          enabled: true
          production: true
          secretName: tls-staging-foo-io-p
      key: staging
    - ingress:
        domain: foo.io
        externalDNS: true
        tls:
          email: admin@foo.com
          enabled: true
          production: true
          secretName: tls-foo-io-p
      key: production
```

Make sure to use the correct `secretName`, as it's being generated ([production](https://github.com/jenkins-x/acme/blob/00eab12ab28eb726544885cd471f10b99d420198/charts/acme/templates/cert-manager-prod-certificate.yaml#L10) or [staging](https://github.com/jenkins-x/acme/blob/00eab12ab28eb726544885cd471f10b99d420198/charts/acme/templates/cert-manager-staging-certificate.yaml#L10)) by the `acme` chart.

Since you don't need `namespaceSubDomain` any more, set it to `.` in the root ingress config.

Commit and push the changes

```bash
git commit -m 'chore: update ingress config'
git push
```

After the pipeline has successfully run, you should have

- a `ClusterIssuer` for the dev domain
- a `Issuer` for production in the namespace `jx-production`
- a `Issuer` for staging in the namespace `jx-staging`

Applications should pick up the secret name from `jx-values.yaml` and use the correct certificate.
