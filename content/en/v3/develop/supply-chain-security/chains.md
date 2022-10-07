---
title: chains
linktitle: chains
type: docs
description: Integration with Tekton Chains
weight: 400
---
Securing your supply chain is not just about verifying the dependencies and eliminating vulnerabilities. It also includes ensuring that the building process was not [compromised during operation](https://slsa.dev/spec/v0.1/threats#d-compromise-build-process).
Jenkins X can be integrated with [Tekton Chains](https://tekton.dev/docs/chains/) to sign [TaskRuns](https://tekton.dev/docs/pipelines/taskruns/) and verifying the it was not tampered.

To add it to your cluster, you should do the following:

1. First go to the cluster git repository where you want to add chains. It is integrated in the JX version stream from a [Helm Chart developed by chainguard](https://github.com/chainguard-dev/tekton-helm-charts/tree/main/charts/tekton-chains).

2. Add this line to the `./helmfile.yaml` of the cluster repo

    ```yaml
    helmfiles:
    - path: helmfiles/tekton-chains/helmfile.yaml
    ```

3. Add this line to the `./helmfile.yaml` of the cluster repo

    ```yaml
    helmfiles:
    - path: helmfiles/tekton-chains/helmfile.yaml
    ```

4. Create a `./helmfiles/tekton-chains/helmfile.yaml` file with the following configurations

    ```yaml
    filepath: ""
    environments:
      default:
        values:
        - jx-values.yaml
    namespace: tekton-chains
    repositories:
    - name: tekton
      url: https://chainguard-dev.github.io/tekton-helm-charts/
    releases:
    - chart: tekton/tekton-chains
      version: 0.2.3
      name: tekton-chains
      values:
      - ../../versionStream/charts/chainguard-dev/tekton-chains/values.yaml.gotmpl
      - jx-values.yaml
    templates: {}
    renderedvalues: {}
    ```

    This will update the `versionStream` to include default values from the [jx3-versions](https://github.com/jenkins-x/jx3-versions/tree/master/charts/chainguard-dev/tekton-chains) repository.

5. Create a  `./helmfiles/tekton-chains/jx-values.yaml` to include additional configurations to suit your use.

6. As a final step you need to generate your own encrypted x509 keypair and save it as a Kubernetes secret, install [cosign](https://github.com/sigstore/cosign) and run the following:

    ```bash
    cosign generate-key-pair k8s://tekton-chains/signing-secrets
    #The secret was created by the helm chart but with empty data
    ```

## Extra Configurations

In its default mode of operation, Chains works by observing all `TaskRuns` executions in your cluster. When `TaskRuns` complete, Chains takes a snapshot of them. Chains then converts this snapshot to one or more standard payload formats, signs them and stores them as annotations to `TaskRun` itself.

## Verifying the signature

- To verify the signature of the last `TaskRun`, you can run the following

    ```bash
    export TASKRUN_UID=$(tkn tr describe --last -o  jsonpath='{.metadata.uid}')
    tkn tr describe --last -o jsonpath="{.metadata.annotations.chains\.tekton\.dev/signature-taskrun-$TASKRUN_UID}" > signature
    tkn tr describe --last -o jsonpath="{.metadata.annotations.chains\.tekton\.dev/payload-taskrun-$TASKRUN_UID}" | base64 -d > payload
    ```
