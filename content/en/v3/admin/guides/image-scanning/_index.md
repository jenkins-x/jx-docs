---
title: Using Image Scanning In Your Pipelines
linktitle: Image Scanning In Jenkins X
type: docs
description: How to configure and maintain image scanning tools within jenkins-x
weight: 120
aliases:
  - /v3/guides/image-scanning
---

Using image scanning tools within your pipelines is a great way to detect vulnerabilities before they reach any environment. Jenkins X maintains a [TrivyDB](https://github.com/jenkins-x/trivydb/) image, which uses the *latest* tag, this is so that you don't have to update your pipelines every day to contain the latest container image.

We also maintain a [TrivyDB pipeline step](https://github.com/jenkins-x/jx3-pipeline-catalog/blob/master/tasks/build-scan-push/build-scan-push.yaml), which means that you can just put this straight into your repo today and start scanning.

To get starteed with scanning, you'll first need to setup a cosign key, which you will generate and upload as a secret to your development cluster. Signing is included with our scanning steps as it's an important part of supply chain security that we expect all users will want.

## Setting up container signing within your pipelines

Eventually, we're going to have an automated way to do this, so you don't have to update all of your pipelines.

For now though, you will have to change it per repo.

Firstly, install the [cosign tool](https://github.com/SigStore/cosign)

Once that's installed, you can run
```
cosign generate-key-pair
```

Make sure to remember the password so that we can create our secret with these details.


Next, we'll want to create our secret.

You can use this as a template and change the certificate and password to what we just generated. Make sure to use the private key here, your public key is only used to verify the image.

```
apiVersion: v1
stringData:
  cosign.key: |-
    -----BEGIN ENCRYPTED COSIGN PRIVATE KEY-----
    abc123....
    -----END ENCRYPTED COSIGN PRIVATE KEY-----
  password: foo
kind: Secret
metadata:
  name: cosign
type: Opaque
```

We can then add this to our *build* cluster in the jx namespace like so: `kubectl apply -f file-from-above.yaml -n jx`

Congratulations, the setup for cosign is now done, let's set it up within our builds now.

## Image scanning with your pipelines

The next step is to add this within our pipelines. So first let's pick a repo. 

I'm going to be demonstrating on this [repository](https://github.com/jenkins-x-quickstarts/golang-http)



## How to help and Improvements planned in future

