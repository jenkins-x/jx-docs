---
title: Changes to Pipelines
linktitle: Changes to Pipelines
type: docs
description: Describes how the pipelines have changed with the move to native Tekton
weight: 100
aliases:
  - /v3/guides/native-tekton
---

Migrating to native Tekton brings a number of changes to the way that Jenkins X pipelines are configured and run.
The main changes are:
- The lighthouse PipelineRun resolver (responsible for handling the `uses:sourceURI` syntax) has been replaced with 
[Tekton's git resolver](https://tekton.dev/docs/pipelines/git-resolver/).
- Pipelines are no longer confined to a single pod running multiple containers (1 task, many steps). Instead, each step
now runs as its own pod (many tasks, many steps). This is to allow for the use of taskRefs to inherit tasks. Tekton
doesn't currently allow for step inheritance.
- As each pipeline now contains many tasks, [Tekton's workspaces](https://tekton.dev/docs/pipelines/workspaces/) are 
used to share files between tasks.

For more information regarding how the new pipelines are configured, please see the [Tekton Docs](https://tekton.dev/docs/).

## Functionality Changes
We've tried to keep the functionality as close to the original as possible, however there are a few changes 
that are worth noting.

### Version Stream
The version stream functionality continues to exist as before, so any pipelines using the 
[pipeline catalog](https://github.com/jenkins-x/jx3-pipeline-catalog) will continue to have their version resolved by 
lighthouse and the `versionStream` defined in your cluster repository.

Example git resolver version stream usage:
```yaml
params:
  - name: url
    value: https://github.com/spring-financial-group/jx3-pipeline-catalog.git
  - name: revision
    value: versionStream
  - name: pathInRepo
    value: tasks/git-clone/git-clone.yaml
```

### Lighthouse Default Params
Lighthouse will continue to add and populate the [default params and environment variables](https://jenkins-x.io/v3/develop/reference/variables/#environment-variables) 
on PipelineRuns as before. However, due to taskRef resolution now being handled by Tekton, any standalone task will need 
to have these explicitly defined. Propagated params and workspaces are part of the [Tekton roadmap](https://github.com/tektoncd/community/blob/main/roadmap.md#roadmap)
so will hopefully be available in the future.

### Overwriting Inherited Tasks
Previously it was possible to overwrite certain fields of inherited steps/tasks by redefining them in the child PipelineRun.
Unfortunately, Tekton does not currently support this functionality. As a result, to overwrite an inherited task, you
will need to define an embedded task on the child PipelineRun and copy in the relevant fields.

Inherited Task:
```yaml
- name: build-make-linux
  runAfter:
    - jx-variables
  taskRef:
    params:
      - name: url
        value: https://github.com/jenkins-x/jx3-pipeline-catalog.git
      - name: revision
        value: versionStream
      - name: pathInRepo
        value: tasks/go/pullrequest/build-make-linux.yaml
    resolver: git
  workspaces:
    - name: output
      workspace: pipeline-ws
```

Embedded Task:
```yaml
- name: build-make-linux
  runAfter:
    - jx-variables
  taskSpec:
    stepTemplate:
      workingDir: /workspace/source
    steps:
      - image: golang:1.19.3@sha256:7ffa70183b7596e6bc1b78c132dbba9a6e05a26cd30eaa9832fecad64b83f029
        name: build-make-linux
        resources: {}
        script: |
          #!/bin/sh
          make linux
    workspaces:
      - description: The workspace used to store the cloned git repository and the generated
          files
        mountPath: /workspace
        name: output
  workspaces:
    - name: output
      workspace: pipeline-ws
```

### Pipeline Catalog
The structure of the pipeline catalog has changed slightly. The `/tasks` directory will now only contain the tasks 
themselves, with the PipelineRun definitions now only residing in the `/packs` directory.
