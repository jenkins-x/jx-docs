---
title: "Custom images in steps"
linkTitle: "Custom Images"
weight: 5
description: >
  Using custom docker images in your steps
---
You’re not restricted to the builder images available from Jenkins X, but can use any Docker image you’d like; as long as Jenkins X can access the registry where they’re published.

One example is to re-use Google’s fairly small [cloud builder images](https://github.com/GoogleCloudPlatform/cloud-builders) to perform quick tasks:
```yaml
         - image: gcr.io/cloud-builders/npm
           name: install-dependencies
           command: npm
           args: ['install']
```

Or your own published images like this:
```yaml
          - image: gcr.io/jenkinsxio/hugo-extended:0.60.1-3
            name: build-website
            command: hugo
            args:
            - -d
            - tmp-website
            - --enableGitInfo
            - --baseURL http://${APP_NAME}.jx-${REPO_OWNER}-${REPO_NAME}-pr-${PULL_NUMBER}.${DOMAIN}/
```

The main requirement is that the image is available, either with or without authentication
