---
title: Installing the Operator
linktitle: Installing the Operator
description: Installing the Git Operator to install/upgrade Jenkins X
weight: 30
---

Jenkins X 3.x uses a [git operator](https://github.com/jenkins-x/jx-git-operator) to manage installing + upgrading of Jenkins X and any other components in any environment.


To install the operator run the following, passing in the git URL from the [git repository](/docs/v3/getting-started/) you created previously via [jx admin operator](https://github.com/jenkins-x/jx-admin/blob/master/docs/cmd/jx-admin_operator.md) command:


```bash 
export GIT_USER="myPipelineUsername"
export GIT_TOKEN="myPipelineUserToken"

jx admin operator --url=https://github.com/myorg/env-mycluster-dev.git
```

If you are inside a git clone of the git repository you can omit the `--url`  option:


```bash 
export GIT_USER="myPipelineUsername"
export GIT_TOKEN="myPipelineUserToken"

jx admin operator
```

This will use helm to install the [git operator](https://github.com/jenkins-x/jx-git-operator) which will trigger a Job to install Jenkins X (and re-trigger a Job whenever you commit to your git repository).

The terminal will display the logs as the boot `Job` runs. 

At any time you can tail the boot job logs via the [jx admin log](https://github.com/jenkins-x/jx-admin/blob/master/docs/cmd/jx-admin_log.md) command:

```bash 
jx admin log
```

Jenkins X will now install itself.

If you want to you can populate the [secrets](/docs/v3/guides/secrets/) once the `ExternalSecret` custom resources are created. 

<nav>
  <ul class="pagination">
    <li class="page-item"><a class="page-link" href="../config">Previous</a></li>
    <li class="page-item"><a class="page-link" href="../secrets">Next</a></li>
  </ul>
</nav>
