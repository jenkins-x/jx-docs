---
title: Add sbom generation step to release pipelines
linktitle: Add sbom generation step to release pipelines
description: As part of increasing supply chain security, here are steps to add SBOM generation to JX repositories release pipelines
weight: 400
type: docs
no_list: true
---
## Introduction

Jenkins X started to support supply chain security through different steps.
Till now we support:

- SBOM generation
- Uploading SBOMs to the release page and to our [container-registry](https://github.com/orgs/jenkins-x/packages)

## How we do it?

There are two types of artifacts we deal with:

### Zipped binaries

For `.tar.gz` artifacts, we use `goreleaser` to generate the artifacts themselves and to generate SBOMs for them. (Both get released on the release page on github of the repository). See Assets at the [release-page](https://github.com/jenkins-x/jx/releases) for example.

To generate SBOMs, add this to the `.goreleaser` file

```bash
sboms:
  - artifacts: archive
```

But `goreleaser` requires [syft](https://github.com/anchore/syft) to be installed for SBOM generation. Refer to [goreleaser documentation](https://goreleaser.com/customization/sbom/) to know more details.

**How to install syft**

- There are some of JX repositories that uses github actions for the release pipeline ([jx](https://github.com/jenkins-x/jx) for example). So, we're installing syft in the `upload-binaries.sh` [script](https://github.com/jenkins-x/jx/blob/49b8f966a16d2935f3e4dfff1089d421a81bc77d/.github/workflows/jenkins-x/upload-binaries.sh) executed by github actions before using `goreleaser release`. Add this to the script to install
  ```bash
  curl -sSfL https://raw.githubusercontent.com/anchore/syft/main/install.sh | \
  sh -s -- -b /usr/local/bin v0.54.0
  chmod +x /usr/local/bin/syft
  ```
- Other repositories use JX itself to release different artifacts ([jx-pipeline](https://github.com/jenkins-x-plugins/jx-pipeline) for example). Installing syft is done through this [step](https://github.com/jenkins-x/jx3-pipeline-catalog/blob/4debb1ef44ad846088ce48d7921dd57510b9eda2/tasks/supply-chain-security/task.yaml#L8) in the [jx3-pipeline-catalog](https://github.com/jenkins-x/jx3-pipeline-catalog). To include it, you add this block before the `upload-binaries` step in the [release pipeline](https://github.com/jenkins-x-plugins/jx-pipeline/blob/main/.lighthouse/jenkins-x/release.yaml)
  ```bash
  - image: uses:jenkins-x/jx3-pipeline-catalog/tasks/supply-chain-security/task.yaml@versionStream
    name: download-syft
  ```

### Container images

For container images, We use `syft` to generate SBOMs from the container images (syft is already installed to be used by `goreleaser` and it's not an additional step). After that, we use [oras](https://oras.land/) to push the generated SBOM as an OCI artifact in the same container registry with the container image.

**How to generate and push**

- For JX repositories that uses github actions for the release pipeline ([jx](https://github.com/jenkins-x/jx) for example), we're using oras as the base image for a separate github action.

  - Add this block at the end of the release job
    ```bash
      - env:
          GITHUB_TOKEN: ${{ secrets.GIT_BOT_TOKEN }}
          GIT_USERNAME: jenkins-x
          DOCKER_REGISTRY_ORG: jenkins-x
          REPO_NAME: ${{ github.event.repository.name }}
          VERSION: ${{ steps.prep.outputs.version }}
        name: Generate and Push SBOM
        uses: docker://ghcr.io/oras-project/oras:v0.13.0
        with:
          entrypoint: .github/workflows/jenkins-x/sbom-container.sh
    ```
  - Add this script `.github/workflows/jenkins-x/sbom-container.sh`
    ```bash
    #!/bin/sh

    # Install syft in this script
    apk add --no-cache curl unzip
    curl -sSfL https://raw.githubusercontent.com/anchore/syft/main/install.sh | \
    sh -s -- -b /usr/local/bin v0.55.0
    chmod +x /usr/local/bin/syft

    # Generate SBOM
    syft ghcr.io/$DOCKER_REGISTRY_ORG/$REPO_NAME:$VERSION --scope all-layers \
    -o spdx-json > sbom.json

    #Push SBOM with oras
    echo $GITHUB_TOKEN | oras push -u $GIT_USERNAME --password-stdin  \
    ghcr.io/$DOCKER_REGISTRY_ORG/$REPO_NAME:$VERSION-sbom sbom.json
    echo $GITHUB_TOKEN | oras push -u $GIT_USERNAME --password-stdin  \
    ghcr.io/$DOCKER_REGISTRY_ORG/$REPO_NAME:latest-sbom sbom.json

    ```
- For repositories that use JX itself to release ([jx-pipeline](https://github.com/jenkins-x-plugins/jx-pipeline) for example):

  - First, replace the `build-and-push-image` step here:
    ```bash
      - name: build-and-push-image
        resources: {}
    ```

  with those two steps which use kaniko to build the image and crane to push it (image.tar is required for syft to generate SBOM)

  ```bash
    - image: uses:jenkins-x/jx3-pipeline-catalog/tasks/build-scan-push/build-scan-push.yaml@versionStream
      name: build-container
    - image: uses:jenkins-x/jx3-pipeline-catalog/tasks/build-scan-push/build-scan-push.yaml@versionStream
      name: push-container
  ```

  - We created this [step](https://github.com/jenkins-x/jx3-pipeline-catalog/blob/4debb1ef44ad846088ce48d7921dd57510b9eda2/tasks/supply-chain-security/task.yaml#L17) in the [jx3-pipeline-catalog](https://github.com/jenkins-x/jx3-pipeline-catalog) which uses syft to generate the SBOM from the container image `image.tar` (built with kaniko) and then uploads the SBOM using oras. Since installing syft is done through this [step](https://github.com/jenkins-x/jx3-pipeline-catalog/blob/4debb1ef44ad846088ce48d7921dd57510b9eda2/tasks/supply-chain-security/task.yaml#L8) in the [jx3-pipeline-catalog](https://github.com/jenkins-x/jx3-pipeline-catalog), you add this block before the `upload-binaries` step in the [release pipeline](https://github.com/jenkins-x-plugins/jx-pipeline/blob/main/.lighthouse/jenkins-x/release.yaml)
    ```bash
      - image: uses:jenkins-x/jx3-pipeline-catalog/tasks/supply-chain-security/task.yaml@versionStream
        name: build-and-push-sbom
        resources: {}
    ```
  - At the end add this step
    ```bash
    - name: cleanup-image-tar
      image: alpine:3.16
      resources: {}
      script: |
        #!/bin/sh
        rm -f /workspace/source/image.tar
    ```

**Edit the .gitignore**

Don't forget to include those in the `.gitignore` file

```bash
# image tar files
image.tar

# docker credential binaries
docker-credential-*

# sbom json created by syft
sbom.json
```
