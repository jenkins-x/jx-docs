---
title: jx admin operator
linktitle: operator
type: docs
description: "installs the git operator in a cluster ***Aliases**: boot*"
aliases:
  - jx-admin_operator
---

### Usage

```
jx admin operator
```

### Synopsis

Installs the git operator in a cluster

### Examples

  * installs the git operator from inside a git clone and prompt for the user/token if required
  
  ```bash
  jx-admin operator
  ```
  
  * installs the git operator from inside a git clone specifying the user/token
  
  ```bash
  jx-admin operator --username mygituser --token mygittoken
  ```
  
  * installs the git operator with the given git clone URL
  
  ```bash
  jx-admin operator --url https://github.com/myorg/environment-mycluster-dev.git --username myuser --token myuser
  ```
  
  * display what helm command will install the git operator
  
  ```bash
  jx-admin operator --dry-run
  ```

### Options

```
  -b, --batch-mode                  Runs in batch mode without prompting for user input
      --chart string                the chart name to use to install the git operator (default "jxgh/jx-git-operator")
      --chart-version string        override the helm chart version used for the git operator
  -d, --dir string                  the directory to discover the git URL if no url option is specified (default ".")
      --dry-run                     if enabled just display the helm command that will run but don't actually do anything
  -h, --help                        help for operator
      --max-log-duration duration   how long to wait for a boot Job pod to be ready to view its log (default 30m0s)
      --name string                 the helm release name t ouse (default "jxgo")
  -n, --namespace string            the namespace to install the git operator (default "jx-git-operator")
      --no-log                      to disable viewing the logs of the boot Job pods
      --no-switch-namespace         to disable switching to the installation namespace after installing the operator
      --set stringArray             one or more helm set arguments to pass through the git operator chart. Equivalent to running 'helm install --set some.name=value'
      --setup stringArray           a git configuration command to configure git inside the git operator pod to deal with things like insecure docker registries etc. e.g. supply 'git config --global http.sslVerify false' to disable TLS verification
      --token string                specify the git token the operator will use to clone the environment git repository if there is no password in the git URL. If not specified defaults to $GIT_TOKEN
  -u, --url string                  the git URL for the environment to boot using the operator. This is optional - the git operator Secret can be created later
      --username string             specify the git user name the operator will use to clone the environment git repository if there is no username in the git URL. If not specified defaults to $GIT_USERNAME
```



### Source

[jenkins-x-plugins/jx-admin](https://github.com/jenkins-x-plugins/jx-admin)
