---
title: Create Quickstart
linktitle: Create Quickstart
description: How to create a new quickstart application and import it into Jenkins X
weight: 10
---

Quickstarts are pre-made applications you can start a project from, instead of starting from scratch.

You can create new applications from our list of curated Quickstart applications via the [jx create quickstart](/commands/jx_create_quickstart/) command.


```sh
jx create quickstart
```

You are then prompted for a list of quickstarts to choose from.

If you know the language you wish to use you can filter the list of quickstarts shown via:

```sh
jx create quickstart -l go
```

Or use a text filter to filter on the project names:

```sh
jx create quickstart -f http
```

### What happens when you create a quickstart

Once you have chosen the project to create and given it a name the following is automated for you:

* creates a new application from the quickstart in a sub directory
* add your source code into a git repository
* create a remote git repository on a git service, such as [GitHub](https://github.com)
* push your code to the remote git service
* adds default files:
  * `Dockerfile` to build your application as a docker image
  * `Jenkinsfile` to implement the CI / CD pipeline
  * Helm chart to run your application inside Kubernetes
* if you are using Jenkins X Pipelines and tekton then:
  * a webhook is registered on the remote git repository which triggers prow/lighthouse to trigger a tekton pipeline
  * add the repository to the prow configuration
* if you are using a Jenkins Server then:  
  * a webhook is registered on the remote git repository which triggers a pipeline in Jenkins
  * create a multi-branch project in your Jenkins server
* trigger the first pipeline

### How do quickstarts work?

The source of these Quickstarts are maintained in [the jenkins-quickstarts GitHub organization](https://github.com/jenkins-x-quickstarts).

When you create a quickstart we use the [Jenkins X build packs](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes) to match the right pack for the project using the source code language kinds to pick the most suitable match.

When you use [jx create](/docs/getting-started/setup/create-cluster/), [jx install](/docs/guides/managing-jx/common-tasks/install-on-cluster/) or [jx init](/commands/deprecation/) the [Jenkins X build packs](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes) are cloned into your `~/.jx/draft/packs` folder.

Depending on your JenkinsX installation type (Serverless Jenkins vs. Static Master Jenkin), you can view all the languages supported via build packs on your machine via:

*Serverless Jenkins*:
```sh
ls -al ~/.jx/draft/packs/github.com/jenkins-x-buildpacks/jenkins-x-kubernetes/packs
```

*Static Master Jenkins*:
```sh
ls -al ~/.jx/draft/packs/github.com/jenkins-x-buildpacks/jenkins-x-classic/packs
```

Then when you create a quickstart, use [jx create spring](/docs/guides/using-jx/common-tasks/create-spring/) or [jx import](/docs/guides/using-jx/creating/import/) the [Jenkins X build packs](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes) are used to:

* find the right language pack. e.g. here are the current [list of language packs](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes/tree/master/packs).
* the language pack is then used to default these files if they don't already exist:
  * `Dockerfile` to package the application as a docker image
  * `Jenkinsfile` to implement the CI / CD pipelines using declarative pipeline as code
  * Helm Charts to deploy the application on Kubernetes and to implement [Preview Environments](/about/concepts/features/#preview-environments)

## Adding your own Quickstarts

If you would like to submit a new Quickstart to Jenkins X please just [raise an issue](https://github.com/jenkins-x/jx/issues/new?labels=quickstart&title=Add%20quickstart&body=Please%20add%20this%20github%20quickstart:) with the URL in GitHub of your quickstart and we can fork it it into the [quickstart organisation](https://github.com/jenkins-x-quickstarts) so it appears in the `jx create quickstart` menu.

Or if you are part of an open source project and wish to curate your own set of quickstarts for your project; you can [raise an issue](https://github.com/jenkins-x/jx/issues/new?labels=quickstart&title=Add%20quickstart&body=Please%20add%20this%20github%20quickstart:) giving us details of the github organisation where the quickstarts live and we'll add that in as a default organisation to include in the [jx create quickstart](/commands/jx_create_quickstart/) command. Its easier for the [jx create quickstart](/commands/jx_create_quickstart/) if you maintain the quickstarts in a separate quickstart organisation on github.

Until we do that you can still use your own Quickstarts in the `jx create quickstart` command via the `-g` or `--organisations` command line argument. e.g.

```sh
jx create quickstart  -l go --organisations my-github-org
```

Then all quickstarts found in `my-github-org` will be listed in addition to the Jenkins X quickstarts.

## Customising your team's quickstarts

You can configure at a team level the quickstarts which are presented to you in the `jx create quickstart` command. These settings are stored in the [Environment Custom Resource](/docs/reference/components/custom-resources/) in Kubernetes.

To add the location of a set of quickstarts you can use the [jx create quickstartlocation](/commands/jx_create_quickstartlocation/) command.


```sh
jx create quickstartlocation --url https://mygit.server.com --owner my-quickstarts
```

If you omit the `--url` argument the command will assume its a [GitHub](https://github.com/) repository. Note that both public and private repositories are supported.

This means you can have your own shared private quickstarts to reuse within your organisation. Of course we'd obviously prefer you to [share your quickstarts with us via open source](https://github.com/jenkins-x/jx/issues/new?labels=quickstart&title=Add%20quickstart&body=Please%20add%20this%20github%20quickstart:) then we can include your quickstart with the entire [community](/community/) - but there may be times you want to curate your own internal quickstarts using proprietary software.

You can also specify `--includes` or `--excludes` patterns to filter the names of the repositories where `*` matches anything and `foo*` matches anything starting with `foo`. e.g. you could just include the languages and technologies your organisation supports and exclude the rest etc.

Also note that you can use the alias of `qsloc` instead of `quickstartlocation` if you like shorter aliases ;)

You can then view the current quickstart locations for your team via the [jx get quickstartlocations](/commands/jx_get_quickstartlocation/) command:

```sh
jx get quickstartlocations
```

Or using an abbreviation

```sh
jx get qsloc
```

There is also [jx delete quickstartlocation](/commands/jx_delete_quickstartlocation/) if you need to remove a git organisation.

