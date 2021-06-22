---
title: Previews
linktitle: Previews
type: docs
description: Preview Environments
weight: 450
aliases:
  - /docs/reference/preview/
---


Jenkins X lets you spin up Preview Environments for your Pull Requests so you can get fast feedback before changes are merged to the main branch. This gives you faster feedback for your changes before they are merged and released and allows you to avoid having human approval inside your release pipeline to speed up delivery of changes merged to master.

When the Preview Environment is up and running Jenkins X will comment on your Pull Request with a link so in one click your team members can try out the preview!

<img src="/images/pr-comment.png" class="img-thumbnail">


## Demo

To see how to create a Preview Environment on a Pull Request see this demo:

<iframe width="560" height="315" src="https://www.youtube.com/embed/x-GtKmmhDSI" title="Demo of creating Preview Environments on Pull Requestss with Jenkins X" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

### Generating a preview environment

In a typical Jenkins X development scenario, users make changes to an  application that has been [imported or created via a quickstart](/v3/develop/create-project/).

When the developer makes the change to their branch, with the ultimate
goal of merging those branch changes into the `main` branch for
deployment to production, they save their changes from within their
integrated development environment (IDE) and commit it to the source
repository, such as GitHub. The process to generate a preview
environment is typically like committing code in a traditional
development environment:

1. A developer makes a branch to their local cloned source repository to create a new feature:

```sh
git checkout -b acme-feature1
```

2.  The developer makes changes to the source code in their branch and adds the affected files to the commit queue:

```sh
git add index.html server.js
```


3. The developer commits the files adding a comment about what has changed:

```sh
    git commit -m "nifty new image added to the index file"
```

4. The developer runs `git push` to send the code back to the remote  repository and create a pull request:

```sh
    git push origin acme-feature1
```
5. The program displays a link to a pull request. The developer can highlight the URL, right-click and choose *Open URL* to see the GitHub page in their browser.

6. Jenkins X creates a preview environment in the PR for the application changes and displays a link to evaluate the new feature:
<div class="row">
  <div class="col col-lg-9">
    <img src="/images/pr-comment.png"/>
  </div>
</div>
The preview environment is created whenever a pull request to the main branch is created in the
repository, allowing any relevant user to validate or evaluate features,
bugfixes, or security hotfix. Then, as additional commits are added to the PR branch
the preview environment is automatically updated.

### Reviewing the preview environment

The development bot created during the installation process sends a notification email to the developer as well as the designated repository approver that a PR is ready for review. During the approval process, the approver can click on the preview application with the code changes for testing and validation.

When the approver confirms the code and functionality changes, they can
approve with a simple comment on the Pull Request that merges the code changes back to
the main branch and initiate a release candidate build with the new feature:

```sh
    /approve
```

The code is merged to the `main` branch, and the release is created and will appear in the `Releases` tab of the git repository along with any associated images or helm charts. Usually this then triggers [Promotion](/v3/develop/environments/promotion/) to other environments.


## How it works
    
the [jx preview create](/v3/develop/reference/jx/preview/create) command creates a new [Preview](https://github.com/jenkins-x/jx-preview/blob/master/docs/crds/github-com-jenkins-x-jx-preview-pkg-apis-preview-v1alpha1.md#Preview) custom resource for each Pull Request on each repository so that we can track the resources and cleanly remove them when you run [jx preview destroy](/v3/develop/reference/jx/preview/destroy) pr [jx preview gc](/v3/develop/reference/jx/preview/gc)

For reference see the [Preview.Spec](https://github.com/jenkins-x/jx-preview/blob/master/docs/crds/github-com-jenkins-x-jx-preview-pkg-apis-preview-v1alpha1.md#PreviewSpec) documentation

Once the  [Preview](https://github.com/jenkins-x/jx-preview/blob/master/docs/crds/github-com-jenkins-x-jx-preview-pkg-apis-preview-v1alpha1.md#Preview) resource is created with its associated preview namespace the  [jx preview create](/v3/develop/reference/jx/preview/create)  command will execute `helmfile sync` of the **preview/helmfile.yaml** file to deploy all of the associated helm charts to the preview namespace. 

When the `helmfile sync` is complete a comment is added to the Pull Request that the preview has been created. If a URL can be detected in the preview namespace it is added to the Pull Request as a comment so that your team can try it out and give fast feedback. 

<img src="/images/pr-comment.png" class="img-thumbnail">


When the Pull Request is merged or closed the [jx preview gc](/v3/develop/reference/jx/preview/gc) command kicks in periodically to remove any old preview environments.


## When previews fail

A preview can fail to create for a multitude of reasons; bad helm charts, missing secrets/volumes, invalid configuration in `jx-requirements.yml`, bad image names, no capacity on the server to name but a few. Unfortunately `helmfile sync` does not give much information other than it succeeded of failed which can be confusing. 

To improve feedback on why some previews can fail we have added additional output in the [jx preview create](/v3/develop/reference/jx/preview/create) command to tail the kubernetes events in the preview namespace. This basically runs `kubectl exec get event -n $PREVIEW_NAMESPACE -w` and adds the output to the pipeline output (prefixed with `$PREVIEW_NAMESPACE:`      

This means the reason for why a preview fails should appear as a kubernetes event in the pipeline log.

e.g. if you make a mistake configuraing the helm chart on your preview you should see the error in the pipeline log. To fix the error just modify the code and git commit and push the fix and you should see the new results in the pipeline log.


## Adding more resources

Its common when creating, for example, a web front end to need a backend or database to work from to verify that the microservice works.

For each application the preview environment is defined by [helmfile](https://github.com/roboll/helmfile) at **preview/helmfile.yaml**.

You can modify the **preview/helmfile.yaml** file to add any helm chart dependencies you require.

You can find possible charts to install by searching helm. e.g. to find a `postgresql` chart try:

```bash
helm search repo postgres
```

Once you know the chart and the repository its in you can add it to your `repositories` and `releases` section of the  `preview/helmfile.yaml` file (the `postgresql` section in dependencies array):

```yaml
repositories:
- name: stable
  url: https://charts.helm.sh/stable
...  

releases:
- chart: stable/postgresql
  name: mydb
  version: 2.6.2

...
```


## Additional preview steps

It's common to want to test out previews using system tests or integration tests. Or you may wish to run some kind of [cypress](https://www.cypress.io/) or [selenium tests](https://www.selenium.dev/)

You can do this by [adding additional steps](/v3/develop/pipelines/editing/) in the **.lighthouse/jenkins-x/pullrequest.yaml** file.

To interact with the preview environment you will need to know its namespace and URL. So the additional step should source the `.jx/variables.sh` file to setup the environment variables (which are defined below).

e.g. here is an additional step to curl the preview URL after the `jx preview create` step:

```yaml
... 
- name: test-preview
  image: golang:1.15
  script: |
    #!/usr/bin/env sh
    source .jx/variables.sh
    curl -v $PREVIEW_URL
```
           
### Environment variables

The following variables are added to the `.jx/variables.sh` file by the [jx preview create](/v3/develop/reference/jx/preview/create) command:
   
* `PREVIEW_URL` the URL of the preview environment if it can be discovered
* `PREVIEW_NAME` the name of the `Preview` custom resource which has the full metadata
* `PREVIEW_NAMESPACE` the namespace of the preview environment which you can use via `myservice.$PREVIEW_NAMESPACE.svc.cluster.local` to access services in your preview

## Scaling Preview Environments

A classic issue with preview environments is the number of pods that will grow with the number of applications, pull requests and dependencies. One solution is to use [Osiris](https://github.com/dailymotion-oss/osiris) to automatically scale down the preview environments which are idle. You can read the [admin guide on scaling preview environments](/v3/guides/preview-environments) to install Osiris in your cluster.

## Further reading

To get more detail on using preview environments check out [this blog post](https://medium.com/@MichalFoksa/jenkins-x-preview-environment-3bf2424a05e4)
