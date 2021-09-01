---
title: jx kube-test run
linktitle: run
type: docs
description: "Runs all of the kubernetes tests"
aliases:
  - jx-kube-test_run
---

### Usage

```
jx kube test run
```

### Synopsis

Runs all of the kubernetes tests

### Examples

  ```bash
  # runs the kubernetes tests
  jx kube test run

  ```

### Options

```
  -b, --batch-mode                   Runs in batch mode without prompting for user input
      --chart-dir string             the directory to look for helm charts if no .jx/kube-test/settings.yaml file is found
      --conftest-args stringArray    specifies any optional conftest command line arguments to pass
      --conftest-binary string       specifies the conftest binary location to use. If not specified we download the plugin
      --conftest-version string      specifies the conftest version to use. If not specified we download the plugin (default "0.24.0")
  -d, --dir string                   the directory to look for helm, helmfile or kustomize files (default ".")
      --helm-args stringArray        specifies any optional helm command line arguments to pass
      --helm-binary string           specifies the helm binary location to use. If not specified we download the plugin
      --helm-version string          specifies the helm version to use. If not specified we download the plugin (default "3.5.4")
  -h, --help                         help for run
      --kubescore-args stringArray   specifies any optional kubescore command line arguments to pass
      --kubescore-binary string      specifies the kubescore binary location to use. If not specified we download the plugin
      --kubescore-version string     specifies the kubescore version to use. If not specified we download the plugin (default "1.11.0")
      --kubeval-args stringArray     specifies any optional kubeval command line arguments to pass
      --kubeval-binary string        specifies the kubeval binary location to use. If not specified we download the plugin
      --kubeval-version string       specifies the kubeval version to use. If not specified we download the plugin (default "0.16.5")
      --log-level string             Sets the logging level. If not specified defaults to $JX_LOG_LEVEL
  -o, --output string                the file to generate
      --polaris-args stringArray     specifies any optional polaris command line arguments to pass
      --polaris-binary string        specifies the polaris binary location to use. If not specified we download the plugin
      --polaris-version string       specifies the polaris version to use. If not specified we download the plugin (default "3.2.1")
  -r, --recurse                      should we recurse through the chart dir to find charts if no .jx/kube-test/settings.yaml file is found
  -s, --settings string              the settings file to use. If not specified will look in .jx/kube-test/settings.yaml in the directory
      --source-dir string            the directory to look for kubernetes resources to validate
      --verbose                      Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warn, info, debug, trace
  -w, --work-dir string              the work directory used to generate the output. If not specified a new temporary dir is created
```

### Source

[jenkins-x-plugins/jx-kube-test](https://github.com/jenkins-x-plugins/jx-kube-test)
