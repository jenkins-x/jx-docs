---
title: Installing the Operator
linktitle: Installing the Operator
description: Installing the Git Operator to install/upgrade Jenkins X
weight: 30
---

Jenkins X 3.x uses a [git operator](https://github.com/jenkins-x/jx-git-operator) to manage installing + upgrading of Jenkins X and any other components in any environment.


Usually if you have [created your git repository](repository) via the [jx admin create](repository) command then the operator will be installed for you.

If you create the git repository via some other means then you can run the `jx admin operator` command to install the operator for your repository.

```bash 
jx admin operator --url=https://github.com/myorg/env-mycluster-dev.git
```

If you are using a private git repository you can specify the user name and token to clone the git repository via `--git-username` and `--git-token` arguments or you can add them into the URL:

```bash 
jx admin operator --url=https://myusername:mytoken@github.com/myorg/env-mycluster-dev.git
```

This will use helm to install the [git operator](https://github.com/jenkins-x/jx-git-operator) which will trigger a Job whenever a change is merged to your git repository.


You can now populate the [secrets](/docs/v3/boot/getting-started/secrets/) 

<nav>
  <ul class="pagination">
    <li class="page-item"><a class="page-link" href="../config">Previous</a></li>
    <li class="page-item"><a class="page-link" href="../secrets">Next</a></li>
  </ul>
</nav>
