---
title: "Create MLquickstart"
linktitle: Create MLquickstart
description: How to create a new machine-learning quickstart application and import it into Jenkins X
weight: 30
aliases:
  - /docs/resources/guides/using-jx/creating/create-mlquickstart/
---

Machine learning quickstarts are pre-made machine-learning applications you can leverage to start your own projects.

You can create new applications from our list of curated machine learning quickstart applications via the [jx create mlquickstart](/commands/jx_create_mlquickstart/) command.


```sh
jx create mlquickstart
```

You are then prompted for a list of quickstarts to choose from.

You will see that these come in groups of three:

```sh
? select the quickstart you wish to create  [Use arrows to move, space to select, type to filter]
> machine-learning-quickstarts/ML-python-pytorch-cpu
  machine-learning-quickstarts/ML-python-pytorch-cpu-service
  machine-learning-quickstarts/ML-python-pytorch-cpu-training
  machine-learning-quickstarts/ML-python-pytorch-mlpc-cpu
  machine-learning-quickstarts/ML-python-pytorch-mlpc-cpu-service
  machine-learning-quickstarts/ML-python-pytorch-mlpc-cpu-training
  machine-learning-quickstarts/ML-python-pytorch-mlpc-gpu
  machine-learning-quickstarts/ML-python-pytorch-mlpc-gpu-service
  machine-learning-quickstarts/ML-python-pytorch-mlpc-gpu-training
```

Each machine learning quickstart consists of two projects, a training project which manages the training script for your model and a service project that allows you to wrap your trained model instances with service APIs ready for integration into your application.

If you want to create just the `-service` or `-training` project on its own, you can do so by selecting the option with the matching name suffix.

Most of the time, however, what you want to do is to select the *project set*, which is the first option with the same prefix name and no suffix. That will create a matched pair of projects that are linked. For example, if you call your project repository `my-first-ml-project` and select the `ML-python-pytorch-cpu` project set, you will create two independent projects in the current folder, `my-first-ml-project-training` and `my-first-ml-project-service`.

If you create these individually, it is important that your projects share the same root name and that they end with the suffixes `-training` and `-service` so that they can automatically integrate during the build process.

You can use a text filter to filter on the project names:

```sh
jx create mlquickstart -f gpu
```

### What happens when you create a quickstart

Once you have chosen the project to create and given it a name the following is automated for you:

* creates a pair of new projects from the quickstart in sub directories
* adds the source code for both into a pair of git repositories
* creates matching remote git repositories on a git service, such as [GitHub](https://github.com)
* pushes your code to the remote git service
* adds default files:
  * `Dockerfile` to build your -service application as a docker image
  * `jenkins-x.yml` to implement the CI / CD pipelines for training and service builds
  * Helm charts to run your applications inside Kubernetes
* registers webhooks on the remote git repositories to your teams Jenkins X server
* triggers the pipelines to train and deploy your service

Once you create a machine learning quickstart, both the training and service projects will build simultaneously. The service project will deploy but first time around, it will fail to start, because it doesn't yet have a trained model to work with.

Meanwhile the training project will start work on training the model and once trained, will run some acceptance tests to verify that the trained model instance is sufficiently accurate to be worth promoting for further testing. If the model has not learned well enough, the training build will fail at this point.

You can restart training with the command:

```sh
jx start pipeline
```
and then select the name of the training project you wish to run again, or you may edit your training script, commit your changes and push them to automatically trigger another training run.

Once training has completed successfully, the version of your model that has just been trained and the metrics associated with this run will be passed to your `-service` project using a pull request. You now need to review the `-service` project repository and check the training metrics for suitability. The `-service` project will automatically rebuild using the newly trained model instance and deploy into a preview environment where you can test it using its API.

If all QA checks pass you may then sign-off the release in the same way you would do for any other build within Jenkins X (have approvers and reviewers issue /approve and /lgtm comments in the pull request thread).

Once signed off, the trained model instance is merged into the master branch of your -service project, rebuilt and deployed into staging for further testing and integration.

Each time you restart the traing project, you will get a new model instance that you can chose to promote in the same way. All models are versioned via Git, so you can keep track of each instance and its metrics.

### How do quickstarts work?

The source of these Quickstarts are maintained in [the machine-learning-quickstarts GitHub organisation](https://github.com/machine-learning-quickstarts).

As with conventional Jenkins X quickstarts, we use the [Jenkins X build packs](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes) to match the right pack for the project using the source code language and machine learning framework kinds to pick the most suitable match.

When you use [jx create](/docs/getting-started/setup/create-cluster/), [jx install](/docs/resources/guides/managing-jx/common-tasks/install-on-cluster/) or [jx init](/commands/deprecation/) the [Jenkins X build packs](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes) are cloned into your `~/.jx/draft/packs` folder.

Then when you create a machine learning quickstart, the [Jenkins X build packs](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes) are used to:

* find the right language pack. e.g. here are the current [list of language packs](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes/tree/master/packs).
* the language pack is then used to default these files if they don't already exist:
  * `Dockerfile` to package the application as a docker image
  * `jenkins-x.yml` to implement the CI / CD pipelines using declarative pipeline as code
  * Helm Charts to deploy the application on Kubernetes and to implement [Preview Environments](/about/concepts/features/#preview-environments)

## Adding your own Quickstarts

If you would like to submit a new Quickstart to Jenkins X please just [raise an issue](https://github.com/jenkins-x/jx/issues/new?labels=quickstart&title=Add%20mlquickstart&body=Please%20add%20this%20github%20mlquickstart:) with the URL in GitHub of your quickstart and we can fork it it into the [quickstart organisation](https://github.com/machine-learning-quickstarts) so it appears in the `jx create mlquickstart` menu.

Or if you are part of an open source project and wish to curate your own set of quickstarts for your project; you can [raise an issue](https://github.com/jenkins-x/jx/issues/new?labels=quickstart&title=Add%20mlquickstart&body=Please%20add%20this%20github%20mlquickstart:) giving us details of the github organisation where the quickstarts live and we'll add that in as a default organisation to include in the [jx create mlquickstart](/commands/jx_create_mlquickstart/) command. Its easier for the [jx create mlquickstart](/commands/jx_create_mlquickstart/) if you maintain the quickstarts in a separate quickstart organisation on github.

Until we do that you can still use your own Quickstarts in the `jx create mlquickstart` command via the `-g` or `--organisations` command line argument. e.g.

```sh
jx create mlquickstart  --organisations my-github-org
```

Then all machine learning quickstarts found in `my-github-org` will be listed in addition to the defaults.

Note there are some standards for creating machine learning quickstarts:

* All quickstart names must start with the letters `ML-` to distinguish it from a conventional quickstart
* Training projects must be suffixed `-training`
* Service projects must be suffixed `-service`
* All components of a project set must share the same root prefix to their name

To create a machine learning project set, create a new repository in your quickstart organisation such that the name is the shared prefix for your quickstart, for example: `machine-learning-quickstarts/ML-python-pytorch-cpu`

Try to pick explanatory names so that it is clear what language, frameworks and hardware are associated with this project set.

Inside your project set repository, create a single file named `projectset` which has the following format:

```yaml
[
   {
      "Repo":"ML-python-pytorch-cpu-service",
      "Tail":"-service"
   },
   {
      "Repo":"ML-python-pytorch-cpu-training",
      "Tail":"-training"
   }
]
```

## Customising your teams quickstarts

You can configure at a team level the quickstarts which are presented to you in the `jx create mlquickstart` command. These settings are stored in the [Environment Custom Resource](/docs/reference/components/custom-resources/) in Kubernetes.

To add the location of a set of machine learning quickstarts you can use the [jx create quickstartlocation](/commands/jx_create_quickstartlocation/) command.


```sh
jx create quickstartlocation --url https://mygit.server.com --owner my-mlquickstarts --includes=[ML-*]
```

Note that you MUST specify the `--includes=[ML-*]` option or your quickstarts will be added to the conventional quickstart list rather than the machine learning list.

If you omit the `--url` argument the command will assume its a [GitHub](https://github.com/) repository. Note that both public and private repositories are supported.

This means you can have your own shared private quickstarts to reuse within your organisation. Of course we'd obviously prefer you to [share your quickstarts with us via open source](https://github.com/jenkins-x/jx/issues/new?labels=quickstart&title=Add%20mlquickstart&body=Please%20add%20this%20github%20mlquickstart:) then we can include your quickstart with the entire [community](/community/) - but there may be times you want to curate your own internal quickstarts using proprietary software.

You can also specify other `--includes` or `--excludes` patterns to filter the names of the repositories where `*` matches anything and `foo*` matches anything starting with `foo`. e.g. you could just include the languages and technologies your organisation supports and exclude the rest etc.

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

