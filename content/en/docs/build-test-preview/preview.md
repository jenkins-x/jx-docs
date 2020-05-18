---
title: Preview Environments
linktitle: Preview Environments
description: Preview pull requests before changes merge to master
weight: 30
aliases:
  - /docs/reference/preview/
---

We highly recommend the use of [Preview Environments](/about/concepts/features/#preview-environments) to get early feedback on changes to applications before the changes are merged into master.

Typically the creation of preview environments is automated inside the Pipelines created by Jenkins X.

### Generating a preview environment

In a typical Jenkins X development scenario, users make changes to an
application that has been imported or created via one of the various
supported methods, such as
[Quickstarts](/docs/getting-started/first-project/create-quickstart/), [imported projects](/docs/resources/guides/using-jx/creating/import/), and [Spring
Boot](/docs/resources/guides/using-jx/creating/create-spring/) applications.

When the developer makes the change to their branch, with the ultimate
goal of merging those branch changes into the `master` branch for
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
The preview environment is created whenever a change is made to the
repository, allowing any relevant user to validate or evaluate features,
bugfixes, or security hotfix.

### Testing the preview environment

The development bot created during the installation process sends a notification email to the developer as well as the designated repository approver that a PR is ready for review. During the approval process, the approver can click on the preview application with the code changes for testing and validation.

When the approver confirms the code and functionality changes, they can
approve the with a simple comment that merges the code changes back to
the master branch and initiate a production build with the new feature:

```sh
    /approve
```

The code is merged to the `master` branch, and the release is pushed to
staging/production or a release created and available from the GitHub
staging environment in the `Releases` tab.

### Manually creating a preview

You can manually create a [Preview Environment](/about/concepts/features/#preview-environments) using [jx](/commands/jx/) via the [jx preview](/commands/jx_preview/) command.

```sh
jx preview
```

## What happens when a Preview environment is created

* a new [Environment](/about/concepts/features/#environments) of kind `Preview` is created along with a [kubernetes namespace](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) which shows up in the [jx get environments](/commands/jx_get_environments/) command along with the [jx environment and jx namespace commands](/developing/kube-context/) so you can see which preview environments are active and switch into them to look around
* the Pull Request is built as a preview docker image and chart and deployed into the preview environment
* a comment is added to the Pull Request to let your team know the preview application is ready for testing with a link to open the application. So in one click your team members can try out the preview!

<img src="/images/pr-comment.png" class="img-thumbnail">



## Adding more resources

Its common when creating, for example, a web front end to need a backend or database to work from to verify that the microservice works.

For each application the preview environment is defined by a helm chart at: `charts/preview/Chart.yaml`.

## Charts

So you can easily add any dependent helm charts to your preview environment by adding new entries in the file `charts/preview/requirements.yaml`.

You can find possible charts to install by searching helm. e.g. to find a `postgresql` chart try:

```
helm search postgres
```

Once you know the chart and the repository its in you can add it to your `charts/preview/requirements.yaml` file (the `postgresql` section in dependencies array):

```yaml
# !! File must end with empty line !!
dependencies:
- alias: expose
  name: exposecontroller
  repository: http://chartmuseum.jenkins-x.io
  version: 2.3.56
- alias: cleanup
  name: exposecontroller
  repository: http://chartmuseum.jenkins-x.io
  version: 2.3.56

  # Ephemeral PostgeSQL created in preview environment.
- name: postgresql
  repository: https://kubernetes-charts.storage.googleapis.com
  version: 2.6.2

  # !! "alias: preview" must be last entry in dependencies array !!
  # !! Place custom dependencies above !!
- alias: preview
  name: demo179
  repository: file://../demo179

```
Note: `- alias: preview` must be last entry in dependecies array and `requirements.yaml` file must end with empty line.

## Service Linking

If you need any additional resources like `ConfigMap`, `Secret` or `Service` resources you can add them to `charts/preview/templates/*.yaml`.

You can always _service link_ from the Preview Environment namespace to other namespaces by creating a `Service` with an `externalName` which links to a `Service` running in another namespace (such as Staging or Production) or to point to a service running outside of the Kubernetes cluster completely.

We have a command [jx step service link](/commands/jx_step_link/) which does this for you:

```
jx step link services --from-namespace jx-staging --includes "*" --excludes "cheese*"
 ```

### Configuration

If you need to tweak your application when running in a Preview Environment you can add custom settings to the `charts/preview/values.yaml`file

## Post preview jobs

One of the extension points of Jenkins X lets you put a hook in after a preview job has been deployed. This hook applies to all apps in a team even existing ones, for all new pull requests/changes. (You don't have to add it to each pipeline by hand - it can be used to enforce best practices).

This means you can run a container Job against the preview app, validating it, before the CI pipeline completes. Should this Job fail, the pull request will be marked as a failure.

Here is an example:

```
jx create post preview job --name owasp --image owasp/zap2docker-weekly:latest -c "zap-baseline.py" -c "-I" -c "-t" -c "\$(JX_PREVIEW_URL)"
```

This creates a post preview job which runs the `zap-baseline.py` command inside the specified docker image (it will pull the image and run it, and then shut it down) which scans the running preview app for any problems.

The `$JX_PREVIEW_URL` environment variable is made available in case the job needs to access the running preview app. Use `-c` to pass commands to the container.

This job runs after the preview has been deployed. If it returns non zero, the PR will be marked as a failure.

You can also run:

```
jx get post preview
```

to list any configured post preview jobs, and:

```
jx delete post preview job --name=NAME_HERE
```

And it will remove that post preview job (for the whole team).


## Further reading

To get more detail on using preview environments check out [this blog post](https://medium.com/@MichalFoksa/jenkins-x-preview-environment-3bf2424a05e4)
