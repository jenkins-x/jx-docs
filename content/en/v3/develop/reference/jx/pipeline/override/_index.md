---
title: jx pipeline override
linktitle: override
type: docs
description: "Lets you pick a step to override locally in a pipeline ***Aliases**: edit,inline*"
aliases:
  - jx-pipeline_override
---

### Usage

```
jx pipeline override
```

### Synopsis

Lets you pick a step to override locally in a pipeline

### Examples

  ```bash
  # Override locally a step in a pipeline
  jx pipeline override
  
  # Override the 'script' property from the property in the catalog
  # so that you can locally modfiy the script without locally maintaining all of the other properties such as image, env, resources etc
  jx pipeline override -P script

  ```

### Options

```
  -b, --batch-mode               Runs in batch mode without prompting for user input
      --catalog-owner string     The github owner for the default catalog (default "jenkins-x")
      --catalog-repo string      The github repository name for the default catalog (default "jx3-pipeline-catalog")
  -d, --dir string               The directory to look for the .lighthouse and/or .git folders (default ".")
  -f, --file string              The pipeline file to render
      --git-kind string          the kind of git server to connect to
      --git-server string        the git server URL to create the scm client
      --git-token string         the git token used to operate on the git repository. If not specified it's loaded from the git credentials file
      --git-username string      the git username used to operate on the git repository. If not specified it's loaded from the git credentials file
  -h, --help                     help for override
      --log-level string         Sets the logging level. If not specified defaults to $JX_LOG_LEVEL
  -p, --pipeline string          The pipeline kind and name. e.g. 'presubmit/pr' or 'postsubmit/release'. If not specified you will be prompted to choose one
  -P, --properties stringArray   The property names to override in the step. e.g. 'script' will just override the script tag
  -a, --sha string               The default catalog SHA to use when resolving catalog pipelines to reuse (default "HEAD")
  -s, --step string              The name of the step to override
  -t, --trigger string           The path to the trigger file. If not specified you will be prompted to choose one
      --verbose                  Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warn, info, debug, trace
```

### Source

[jenkins-x-plugins/jx-pipeline](https://github.com/jenkins-x-plugins/jx-pipeline)
