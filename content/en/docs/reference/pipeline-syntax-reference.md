---
title: Jenkins X Pipeline Syntax Reference
linktitle: Pipeline Reference
description: cloud native serverless pipelines
date: 2019-06-20
publishdate: 2019-06-20
keywords: [tekton]
weight: 8
aliases:
  - /architecture/pipeline-syntax-reference
---

# Syntax for `jenkins-x.yml` and build packs

## Where to Define Your Pipelines

Pipelines can either be defined in [build packs](/docs/create-project/build-packs/), used for
multiple projects, or in the `jenkins-x.yml` file in a project's repository.
When defining pipelines in a build pack, the top-level configuration below is
used directly, while in `jenkins-x.yml`, the top-level configuration is under
the `pipelineConfig` key.

## Top-Level Configuration

* **<a id='extends'>`extends`</a>** - A build pack can extend another build pack,
inheriting its configuration and contributing its own additional behavior.
    * **`file`** - The name of the build pack to inherit from.
    * **`import`** - If the build pack to inherit from is not in the same
    repository as this build pack, specify where to import it from.
* **[`agent`](#agent)** - A default agent configuration for all pipelines in the
build pack or project.
* **[`env`](#env)** - Environment variables to be made available for all
pipelines in the build pack or project.
* **[`containerOptions`](#containerOptions)** - Default configuration for step
containers for all pipelines in the build pack or project.
* **<a id='pipelines'>`pipelines`</a>** - The pipeline definitions for this
build pack or project.

## Specifying and Overriding Release, Pull Request, and Feature Pipelines

* **<a id='pullRequest-release-feature'>`pullRequest`, `release`, `feature`</a>** -
The configuration for the three pipeline types for this build pack or project.
    * **[`setup`](#build-pack-stages)** - The first stage to run.
    * **[`setVersion`](#build-pack-stages)** - The second stage to run.
    * **[`preBuild`](#build-pack-stages)** - The third stage to run.
    * **[`build`](#build-pack-stages)** - The fourth stage to run.
    * **[`postBuild`](#build-pack-stages)** - The fifth stage to run.
    * **[`promote`](#build-pack-stages)** - The sixth and final stage to run.
    * **[`pipeline`](#defining-an-individual-pipeline)** - The full definition
    of the pipeline. Mutually exclusive with `setup`, etc.
* **<a id='overrides'>`overrides`</a>** - A list of overriding changes to make
to the inherited or default pipeline.
    * **`pipeline`** - The name of the pipeline this override should be applied
    to (`release`, `pullRequest`, or `feature`). If unspecified, this override
    will be applied to all pipelines.
    * **`stage`** - The name of the stage this override should be applied to.
    If unspecified, this override will be applied to all stages.
    * **`name`** - The name of the step this override should be applied to. If
    unspecified, this override will be applied to all steps.
    * **`step`** - A single [step](#configuration-for-steps) which will be used
    to override the named step or, if no step name is given, all steps in the
    specified stage. If neither `step` nor `steps` is given, all steps in
    matching stages in matching pipelines will be removed.
    * **`steps`** - One or more [steps](#configuration-for-steps) which will be
    used to override the named step or, if no name is given, all steps in the
    specified stage.
    * **`type`** - Whether the `step` or `steps` should replace the named step,
    be prepended before the named step, or be appended after the named step.
    Possible values are `replace`, `before`, or `after`.
    * **[`agent`](#agent)** - An agent definition that will replace the
    existing agent definition for matching pipelines and stages. Step agents
    are not changed.
* **<a id='default'>`default`</a>** - A full [pipeline definition](#defining-an-individual-pipeline)
that will be used for the `pullRequest`, `release`, and `feature` pipelines if
they are not already specified.

### Build pack stages

* **[`preSteps`](#configuration-for-steps)** - A list of steps to run before
the main body of steps for this stage. `preSteps` is *not* inherited from parent
build packs.
* **[`steps`](#configuration-for-steps)** - The main body of steps to run for
this stage. If inheriting from a parent build pack, these steps will be appended
to the parent build pack's `steps` by default.
* **`replace`** - An optional boolean. If true, the inherited stage definition's
`steps` will be replaced, rather than appended to.

## Defining an Individual Pipeline

### Configuration for the Whole Pipeline

* **[`agent`](#agent)** - A default agent definition to use for any
[stages](#configuration-for-stages) without their own agents specified.
Overrides [build pack or project](#top-level-configuration) agent definition.
* **[`env`](#env)** - Environment variables set for the entire pipeline, which
can be overridden in individual stages and steps.
* **<a id='options'>`options`</a>** - Additional configuration for the entire
pipeline.
    * **<a id='timeout'>`timeout`</a>** - The maximum duration for execution
    of the pipeline, after which the build will be terminated.
        * **`time`** - How long to wait until timing out the build.
        * **`unit`** - The unit for `time`. Can be any of `seconds`, `minutes`,
        or `hours`. Defaults to `seconds` if unspecified.
    * **[`containerOptions`](#containerOptions)** - Default configuration for
    step containers within this pipeline, overriding any common settings with
    [build pack or project](#top-level-configuration) default configuration.
    * **`volumes`** - One or more [Kubernetes volumes](https://kubernetes.io/docs/concepts/storage/volumes/)
    which will be added to every stage in the pipeline, and can be mounted via
    `containerOptions`.
* **<a id='dir'>`dir`</a>** - Optional default working directory for stages and
steps in this pipeline. Can either be relative, under the `/workspace/source`
directory were the project source will be checked out, or absolute.
* **<a id='stages'>`stages`</a>** - A list of one or more [stages](#configuration-for-stages).

### Configuration for Stages

* **<a id='name'>`name`</a>** - The name of the stage. Required and must be
unique.
* **[`agent`](#agent)** - The agent definition to use for this stage,
overriding the agent specified for [the whole pipeline](#configuration-for-the-whole-pipeline)
if one is specified.
* **<a id='options'>`options`</a>** - Additional configuration for the stage.
    * **[`containerOptions`](#containerOptions)** - Default configuration for
    step containers within this stage, overriding any common settings with
    [the whole pipeline](#configuration-for-the-whole-pipeline) default
    configuration.
    * **`volumes`** - One or more [Kubernetes volumes](https://kubernetes.io/docs/concepts/storage/volumes/)
    which will be added to this stage's pod, and can be mounted via `containerOptions`.
* **[`env`](#env)** - Environment variables set for all steps or nested stages,
overriding any variables defined for [the whole pipeline](#configuration-for-the-whole-pipeline).
* **<a id='nestedstages'>`stages`</a>** - A list of stages to run sequentially
within this stage, inheriting this stage's configuration. Cannot be used with
either `steps` or `parallel`.
* **<a id='parallel'>`parallel`</a>** - A list of stages to run in parallel,
inheriting this stage's configuration. Cannot be used with either `steps` or
`stages`.
* **<a id='dir'>`dir`</a>** - Optional default working directory for steps and
nested stages. Can either be relative under the `/workspace/source` directory or
absolute.
* **[`steps`](#configuration-for-steps)** - A list of steps to run in this stage. Cannot be used
with either `stages` or `parallel`.

### Configuration for Steps

* **<a id='name'>`name`</a>** - A name for the step, used in logging and for
overrides.
* **<a id='command'>`command`</a>** - The command to execute in this step.
* **<a id='args'>`args`</a>** - An array of arguments to the command.
* **<a id='dir'>`dir`</a>** - Optional working directory for this step.
* **[`agent`](#agent)** - Optional agent configuration for this step.
* **<a id='loop'>`loop`</a>** - Repeats the nested [`steps`](#configuration-for-steps)
for each value in the specified list.
    * **`variable`** - The name of the environment variable to be set with the
    value for this loop iteration.
    * **`values`** - A list of strings to iterate over.
    * **[`steps`](#configuration-for-steps)** - One or more steps to run for
    each iteration of the loop.
* **[`env`](#env)** - Environment variables set for this step, adding to
inherited environment variables from the stage and pipeline.

## Common Directives

* **<a id='agent'>`agent`</a>** - What container image should be used.
    * **`image`** - A container image, either as a fully qualified image or a
    [pod template name](/docs/reference/components/pod-templates/).
    * **`label`** - Only used with static Jenkins masters - the Jenkins agent
    label to use.
* **<a id='env'>`env`</a>** - One or more environment variables.
    * **`name`** - The name of the environment variable.
    * **`value`** - The value of the environment variable.
* **<a id='containerOptions'>`containerOptions`</a>**
    * See [Kubernetes container configuration](https://kubernetes.io/docs/concepts/containers).
    `name`, `command`, `args`, `image`, and `workingDir` cannot be specified.
    * Common use cases for `containerOptions` include resource requests and
    limits, and volume mounts.

# Examples

## Full pipeline definition in `jenkins-x.yml`

```yaml
# If a build pack is specified, the `pipeline` in `release`, `pullRequest`, and `feature` will be ignored.
buildPack: none

pipelineConfig:
  pipelines:
    release:
    # While the legacy build pack built-in stages can be used in jenkins-x.yaml, pipeline is preferred.
      pipeline:
        # Define a default container image we'll use throughout the pipeline, unless an explicit agent is
        # specified on a stage or step.
        agent:
          image: "some/image@version" # or "maven" - this means "use the maven pod template"
        # Environment variables are either static key/value pairs or Kubernetes valueFrom EnvVarSources.
        # See https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.14/#envvarsource-v1-core
        # for more information on valueFrom.
        # Environment variables defined at the top level can be overridden in stages and individual
        # steps.
        environment:
          - name: SOME_VAR
            value: A value for the env var
          - name: SOME_OTHER_VAR
            value: Another var
          - name: SOME_API_KEY
            valueFrom:
              secretKeyRef:
                name: mysecret
                key: apikey
        # Options contains other configuration for the pipeline.
        options:
          # containerOptions allows specifying more advanced default configuration for the containers
          # used for all stages and steps in this scope, using the standard Kubernetes syntax for
          # containers.
          # See https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.14/#container-v1-core.
          # Not all fields can be configured - e.g., name, command, arguments, image, and dir are all
          # defined via the syntax - but everything else can be.
          # Like with environment variables, containerOptions at the top level can be overridden and
          # added to by stages.
          containerOptions:
            # Here we're setting the resource requests and limits for all step containers within this
            # pipeline.
            resources:
              requests:
                cpu: 0.1
                memory: 64Mi
              limits:
                cpu: 0.2
                memory: 128Mi
          # timeout allows you to set the maximum duration for builds of this pipeline.
          timeout:
            time: 15
            unit: minutes
        # A pipeline must contain at least one stage, and each stage must have a unique name.
        stages:
          - name: Stage With Steps And Options Etc
            # agent, options, and environment are valid on stages as well. For the parents of nested
            # sequential or parallel stages, their children inherit the parent's agent, options,
            # and environment.
            # options on a stage currently only can contain containerOptions.
            options:
              containerOptions:
                resources:
                  limits:
                    cpu: 0.4
                    memory: 256Mi
            # A stage must contain at least one of "steps", "stages", or "parallel"
            # Steps must contain at least one command to be executed or a loop.
            steps:
              - command: mvn
                # args are a YAML array, so can be specified either on multiple lines or in a []
                args:
                  - clean
                  - install
                dir: foo  # Optional, allows running this step in a subdirectory of the workspace, or
                          # a different absolute directory.
                # Steps can have their own images specified, overriding the stage and top-level images.
                agent:
                  image: some-other-image
              # A loop allows you to specify a list of potential values for an environment variable and a
              # set of one or more steps. Those steps will be run, sequentially, for each of the
              # potential values. Loops can also be nested for more complex combinations.
              - loop:
                  variable: LANGUAGE
                  values:
                    - maven
                    - gradle
                    - nodejs
                  steps:
                    - command: echo
                      args:
                        - hello
                        - ${LANGUAGE}
          - name: Stage with nested sequential stages
            # Any configuration of agent, options, or environment will apply to all child stages.
            environment:
              - name: SPECIFIC_TO_SEQUENTIAL_PARENT
                value: something
            # A list of nested stages to run sequentially. This is meant to allow for avoiding
            # copy-pasting configuration across a set of stages that need to have the same configuration
            # but where that configuration shouldn't be in place for *all* stages in the pipeline.
            stages:
              # ...insert stages here. =)
          - name: Stage with nested parallel stages
            # Works very similarly to sequential stages, except that the stages are executed in parallel,
            # rather than sequentially.
            parallel:
              # ...insert stages here. =)
```
