---
title: Security
linktitle: Security
type: docs
description: How to limit privileges
weight: 120
aliases:
- /v3/guides/security
---

Pipeline execution gives almost unlimited possibilities to test, build, publish, scan and not only. Every pipeline allows to execute a shell script.
Misused pipeline can reveal cluster secrets such as git secrets, artifactory secrets, and it can allow manipulating the cluster having access to Kubernetes API.

The risk is high, because Jenkins X is focused on development repositories, where any developer can modify its project pipelines, by modifying them can execute any code using Jenkins X pipeline privileges, where commands are actually executed.
In larger scope, where are development teams from various organizations of different level of security policies working together it may be important to secure CI/CD.

To limit misusing of pipelines Jenkins X implements a pattern called `Pipeline Security Policy`.

Pipeline Security Policies
--------------------------

A policy can match Pipeline by regex pattern on repository organization and repository name.
`LighthousePipelineSecurityPolicies` are mutation policies, which means matched Pipeline will be mutated **to enforce behavior**.

```yaml
apiVersion: lighthouse.jenkins.io/v1alpha1
kind: LighthousePipelineSecurityPolicy
metadata:
  name: my-policy-name
  namespace: jx
spec:
  repositoryPattern: keskad/springboot-(.*)
  enforce:
    maximumPipelineDuration: 5m0s
    namespace: jx-test1
    serviceAccountName: my-account-name
  
```

Behavior
--------
    
- When a pattern matches a repository, then all defined enforcements are applied to `LighthouseJob` and to `PipelineRun` kinds
- If regex pattern is not valid (not compiling), then no any job will be scheduled. Reason: There exists policies, but are broken. Jenkins X cannot know what is allowed to do
- When multiple policies matches single repository, then pipelines from this repository will not be scheduled. Reason: Security must be defined to be unambiguous and simple

Reference
---------

| Attribute               | Example value   | Description                                                                                   | Is optional |
|-------------------------|-----------------|-----------------------------------------------------------------------------------------------|-------------|
| maximumPipelineDuration | 12h5m0s         | If scheduled Pipeline have defined more than defined in policy, then policy value is enforced | Yes         |
| namespace               | my-namespace    | Enforces a Pipeline to be spawned in given namespace                                          | Yes         |
| serviceAccountName      | my-account-name | Enforces a serviceAccountName field, so the Pods will be using a specific service account     | Yes         |   


Use cases
---------

- Limit executed pipelines to not have a possibility to access production, move environments publishing to external component like ArgoCD or FluxCD
- Have a multi-tenant environment for tens of development teams that should not interrupt each other and not expose a Kubernetes cluster to risk
