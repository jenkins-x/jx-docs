---
title: Deployment lifecycle
linktitle: Deployment lifecycle
type: docs
description: How Jenkins X deploys your code
weight: 400
aliases:
  - /v3/about/concepts/deployment-lifecycle
---

Ever wondered how the code you commit to your source control repository ends up deployed in production by Jenkins X?
Well, this document is an attempt to answer that question.

Please go over documentation regarding [source repositories](../source-repository), [environments](../environments) and [pipeline activities](../pipeline-activity) before reading this section.

After you have [installed Jenkins X in a kubernetes cluster](/v3/admin/) and created a [quickstart or imported an existing repository](/v3/develop/create-project/), you should see a folder structure which resembles this:

```text
├── charts
│   └── app
│       ├── Chart.yaml
│       ├── .helmignore
│       ├── Kptfile
│       ├── Makefile
│       ├── README.md
│       ├── templates
│       │   ├── canary.yaml
│       │   ├── deployment.yaml
│       │   ├── _helpers.tpl
│       │   ├── hpa.yaml
│       │   ├── ingress.yaml
│       │   ├── ksvc.yaml
│       │   ├── NOTES.txt
│       │   ├── sa.yaml
│       │   └── service.yaml
│       └── values.yaml
├── Dockerfile
├── .gitignore
├── go.mod
├── go.sum
├── .lighthouse
│   └── jenkins-x
│       ├── pullrequest.yaml
│       ├── release.yaml
│       └── triggers.yaml
├── main.go
├── Makefile
├── OWNERS
├── OWNERS_ALIASES
└── preview
    ├── helmfile.yaml
    ├── Kptfile
    └── values.yaml.gotmpl
```

The Jenkins X pipeline files are all located in the `.lighthouse/jenkins-x` folder.
Inside this folder, you should see these files:

- triggers.yaml: Defines the rules for triggering pipelines defined in the pull request and release yaml files
- pullrequest.yaml: Runs the steps when you open a pull request against the base branch of the repository
- release.yaml: Runs the steps when a change is made to the base branch of the repository

An example of a triggers.yaml is as follows:

```yaml
apiVersion: config.lighthouse.jenkins-x.io/v1alpha1
kind: TriggerConfig
spec:
  presubmits:
    - name: pr
      context: "pr"
      always_run: true
      optional: false
      source: "pullrequest.yaml"
  postsubmits:
    - name: release
      context: "release"
      source: "release.yaml"
      branches:
        - ^main$
        - ^master$
```

There are two types of trigger configurations

- Presubmit: Determines what to run when a pull request is opened against the base branch
- Postsubmit: Determines what to run when commits are pushed to the base branch.

The source field sets the location of the files which have the pipeline definitions.

An example of a pullrequest file is as follows:

```yaml
apiVersion: tekton.dev/v1beta1
kind: PipelineRun
metadata:
  creationTimestamp: null
  name: pullrequest
spec:
  pipelineSpec:
    tasks:
      - name: from-build-pack
        resources: {}
        taskSpec:
          metadata: {}
          stepTemplate:
            image: uses:jenkins-x/jx3-pipeline-catalog/tasks/go/pullrequest.yaml@versionStream
            name: ""
            resources:
              # override limits for all containers here
              limits: {}
            workingDir: /workspace/source
          steps:
            - image: uses:jenkins-x/jx3-pipeline-catalog/tasks/git-clone/git-clone-pr.yaml@versionStream
              name: ""
              resources: {}
            - name: jx-variables
              resources:
                # override requests for the pod here
                requests:
                  cpu: 400m
                  memory: 600Mi
            - name: build-make-linux
              resources: {}
            - name: build-container-build
              resources: {}
  podTemplate: {}
  serviceAccountName: tekton-bot
  timeout: 1h0m0s
status: {}
```

Jenkins X allows the end users to write pipelines in native tekton format.
Here we are defining a tekton pipelinerun with one task named `from-build-pack` which has a few steps.
Refer to tekton documentation to learn more about [pipelineruns](https://tekton.dev/docs/pipelines/pipelineruns/) and [tasks](https://tekton.dev/docs/pipelines/tasks/).

The thing that is different from tekton is the `uses` key.

```yaml
- image: uses:jenkins-x/jx3-pipeline-catalog/tasks/git-clone/git-clone-pr.yaml@versionStream
  name: ""
  resources: {}
```

Jenkins X resolves this step at runtime as follows:

- It looks for a file git-clone-pr.yaml under tasks/git-clone in the `jx3-pipeline-catalog` repository in the jenkins-x organization in github.
  In this case, the steps defined [here](https://github.com/jenkins-x/jx3-pipeline-catalog/blob/master/tasks/git-clone/git-clone-pr.yaml) are added to the pipeline run.
- It looks at the portion after `@`.
  - If this is set to `versionstream`, it looks at the `LIGHTHOUSE_VERSIONSTREAM_JENKINS_X_JX3_PIPELINE_CATALOG` environment variable set in the lighthouse webhook pod to retrieve the sha. This sha belongs to a commit in the base branch of the `jx3-pipeline-catalog` repository
  - If this is not set to `versionstream`, it uses the sha to get the version of the git-clone-pr.yaml file.
  - If sha is missing, an error is returned.

When a pull request is opened against the base branch of the repository, the lighthouse webhook component of Jenkins X will create a lighthouse job and subsequently a tekton pipelinerun.

The tekton pipelinerun created after a PR is opened looks like this (some fields are removed for simplicity):

```yaml
apiVersion: tekton.dev/v1beta1
kind: PipelineRun
metadata:
  ...
spec:
  params:
  - name: BUILD_ID
    value: ""
  ...
  pipelineSpec:
    params:
    - description: the specification of the job
      name: JOB_SPEC
      type: string
    ...
    tasks:
    - name: from-build-pack
      params:
      - name: BUILD_ID
        value: $(params.BUILD_ID)
      ...
      resources: {}
      taskSpec:
        metadata: {}
        params:
        - description: the unique build number
          name: BUILD_ID
          type: string
        ...
        spec: null
        stepTemplate:
          env:
          - name: HOME
            value: /tekton/home
          ...
          envFrom:
          - secretRef:
              name: jx-boot-job-env-vars
              optional: true
          name: ""
          resources: {}
          workingDir: /workspace/source
        steps:
        - envFrom:
          - secretRef:
              name: jx-boot-job-env-vars
              optional: true
          image: gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/git-init:v0.27.0
          name: git-clone
          resources: {}
          script: |
            #!/bin/sh
            export SUBDIR="source"
            echo "git cloning url: $REPO_URL version $PULL_PULL_REF:$(echo $JOB_NAME | tr '[:lower:]' '[:upper:]')-$PULL_NUMBER@$PULL_PULL_SHA to dir: $SUBDIR"
            git config --global --add user.name ${GIT_AUTHOR_NAME:-jenkins-x-bot}
            git config --global --add user.email ${GIT_AUTHOR_EMAIL:-jenkins-x@googlegroups.com}
            git config --global credential.helper store
            git clone $REPO_URL $SUBDIR
            cd $SUBDIR
            git fetch origin $PULL_PULL_REF:$(echo $JOB_NAME | tr '[:lower:]' '[:upper:]')-$PULL_NUMBER
            git checkout $(echo $JOB_NAME | tr '[:lower:]' '[:upper:]')-$PULL_NUMBER
            git reset --hard $PULL_PULL_SHA
            echo "checked out revision: $PULL_PULL_REF:$(echo $JOB_NAME | tr '[:lower:]' '[:upper:]')-$PULL_NUMBER@$PULL_PULL_SHA to dir: $SUBDIR"
          workingDir: /workspace
        - envFrom:
          - secretRef:
              name: jx-boot-job-env-vars
              optional: true
          image: ghcr.io/jenkins-x/jx-boot:3.2.402
          name: git-merge
          resources: {}
          script: |
            #!/usr/bin/env sh
            jx gitops git merge
          workingDir: /workspace/source
        - image: ghcr.io/jenkins-x/jx-boot:3.2.402
          name: jx-variables
          resources:
            requests:
              cpu: 400m
              memory: 600Mi
          script: |
            #!/usr/bin/env sh
            jx gitops variables
            jx gitops pr variables
        - image: golang:1.23.2
          name: build-make-linux
          resources: {}
          script: |
            #!/bin/sh
            make linux
        - image: gcr.io/kaniko-project/executor:v1.6.0-debug
          name: build-container-build
          resources: {}
          script: |
            #!/busybox/sh
            source .jx/variables.sh
            cp /tekton/creds-secrets/tekton-container-registry-auth/.dockerconfigjson /kaniko/.docker/config.json
            /kaniko/executor $KANIKO_FLAGS --context=/workspace/source --dockerfile=${DOCKERFILE_PATH:-Dockerfile} --destination=$PUSH_CONTAINER_REGISTRY/$DOCKER_REGISTRY_ORG/$APP_NAME:$VERSION
        workspaces:
        - description: The git repo will be cloned onto the volume backing this workspace
          mountPath: /workspace
          name: output
      workspaces:
      - name: output
        workspace: output
    workspaces:
    - description: The git repo will be cloned onto the volume backing this workspace
      name: output
  podTemplate: {}
  serviceAccountName: tekton-bot
  timeout: 1h0m0s
  workspaces:
  - emptyDir: {}
    name: output
status:
  ...
  taskRuns:
    jx-test-pr-13-pr-scfbz-from-build-pack-bx72q:
      pipelineTaskName: from-build-pack
      status:
        ...
```

Another component of Jenkins X, the `jx-build-controller` running in the dev namespace (jx by default) watches newly created tekton pipelineruns and creates Jenkins X pipeline activities from them.

The pipeline activity generated from the tekton pipelinerun looks as follows:

```yaml
apiVersion: jenkins.io/v1
kind: PipelineActivity
metadata:
  ...
spec:
  ...
  steps:
    - kind: Stage
      stage:
        ...
        steps:
          - completedTimestamp: "2022-07-02T23:52:12Z"
            name: Git Clone
            startedTimestamp: "2022-07-02T23:52:10Z"
            status: Succeeded
          - completedTimestamp: "2022-07-02T23:52:14Z"
            name: Git Merge
            startedTimestamp: "2022-07-02T23:52:13Z"
            status: Succeeded
          - completedTimestamp: "2022-07-02T23:52:16Z"
            name: Jx Variables
            startedTimestamp: "2022-07-02T23:52:14Z"
            status: Succeeded
          - completedTimestamp: "2022-07-02T23:52:34Z"
            name: Build Make Linux
            startedTimestamp: "2022-07-02T23:52:16Z"
            status: Succeeded
          - completedTimestamp: "2022-07-02T23:53:16Z"
            name: Build Container Build
            startedTimestamp: "2022-07-02T23:52:34Z"
            status: Succeeded
```

Once this pull request is approved and merged into the base branch, a release pipeline is started (as configured in the triggers file).

The release pipeline has a promote step, which looks like this:

```yaml
- name: promote-jx-promote
  resources: {}
```

which resolves to this

```yaml
- image: ghcr.io/jenkins-x-plugins/jx-promote:0.4.0
  name: promote-jx-promote
  resources: {}
  script: |
    #!/usr/bin/env sh
    source .jx/variables.sh
    jx promote -b --all --timeout 1h --no-poll
```

This opens a pull request (PR) in the cluster git repository.
Normally two PRs are opened, one for the staging environment and one for the production environment.
The staging environment PR is merged automatically if the pipeline passes, thereby promoting the application to the staging environment.
The production environment PR needs to be merged manually.
Once the production PR is merged, Jenkins X will promote your code to production.
