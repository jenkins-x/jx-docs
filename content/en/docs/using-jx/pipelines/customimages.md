---
title: "Custom images in steps"
linkTitle: "Custom Images"
weight: 5
description: >
  Using custom docker images in your steps
---
Jenkins X supports various types of Docker builder images, as long as the image is published in an accessible registry. 

One example is to re-use Google’s fairly small [cloud builder images](https://github.com/GoogleCloudPlatform/cloud-builders) to perform quick tasks:
```yaml
         - image: gcr.io/cloud-builders/npm
           name: install-dependencies
           command: npm
           args: ['install']
```

Or you can use your own published images like this:
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

The main requirement is that the image is available, either with or without authentication.
