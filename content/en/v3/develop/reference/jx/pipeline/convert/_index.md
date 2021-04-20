---
title: jx pipeline convert
linktitle: convert
type: docs
description: "Converts the pipelines to use the 'image: uses:sourceURI' include mechanism"
aliases:
  - jx-pipeline_convert
---

### Usage

```
jx pipeline convert
```

### Synopsis

Converts the pipelines to use the 'image: uses:sourceURI' include mechanism
  
So that pipelines are smaller, simpler and easier to upgrade pipelines with the version stream

### Examples

  ```bash
  # Convert a repository created using the alpha/beta of v3
  # to use the nice new uses: syntax
  jx pipeline convert
  
  # Convert a pipeline catalog to the uses syntax and layout
  jx pipeline convert --catalog

  ```
### Options

```
  -b, --batch-mode             Runs in batch mode without prompting for user input
  -c, --catalog                If converting a catalog we look in the packs folder to recursively find all '.lighthouse' folders
      --catalog-owner string   The github owner for the default catalog (default "jenkins-x")
      --catalog-repo string    The github repository name for the default catalog (default "jx3-pipeline-catalog")
  -d, --dir string             The directory to look for the .lighthouse and/or .git folders (default ".")
      --git-kind string        the kind of git server to connect to
      --git-server string      the git server URL to create the scm client
      --git-token string       the git token used to operate on the git repository. If not specified it's loaded from the git credentials file
      --git-username string    the git username used to operate on the git repository. If not specified it's loaded from the git credentials file
  -h, --help                   help for convert
      --log-level string       Sets the logging level. If not specified defaults to $JX_LOG_LEVEL
  -s, --sha string             The default catalog SHA to use when resolving catalog pipelines to reuse
      --tasks-dir string       The directory name to store the original tasks before we convert to uses: notation (default "tasks")
      --use-kpt-ref            Keep the kpt ref value in the uses git URI (default true)
      --use-sha string         The catalog SHA to use in the converted pipelines. If not specified defaults to @versionStream
      --verbose                Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warn, info, debug, trace
```



### Source

[jenkins-x-plugins/jx-pipeline](https://github.com/jenkins-x-plugins/jx-pipeline)
