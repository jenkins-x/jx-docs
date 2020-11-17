---
title: Dashboard
linktitle: Dashboard
type: docs
description: Read only dashboard view of pipelines and logs
weight: 100
aliases:
  - /docs/v3/develop/ui/dashboard
---

It's a common requirement to want to view pipelines running, their logs or to be able to click on a Pull Request on your git provider and view the pipeline log for that commit on that Pull Request.

To implement this we include the [jx-pipelines-visualizer](https://github.com/jenkins-x/jx-pipelines-visualizer) application inside Jenkins X.

This provides a simple read only web UI for viewing pipelines and pipeline logs and its linked automatically with any Pull Request you create on repositories managed by Jenkins X.

### Accessing the Pipelines Visualizer

If you [have a recent jx binary](/docs/v3/guides/upgrade/#cli) run:

```bash 
jx dash
``` 

and it will open the dashboard using the basic authentication login and password.

### Viewing from a Pull Request

If you create a Pull Request on a git repository you have [created or imported](/docs/v3/develop/create-project/) in Jenkins X you should see a link on the Pull Request. 

Here's an example - see the **Details** link on the right of the Pull Request pipeline:

<img src="/images/quickstart/pr-link.png" class="img-thumbnail">

If you click the **Details** link that should open the [jx-pipelines-visualizer](https://github.com/jenkins-x/jx-pipelines-visualizer) UI for this pipeline build.

### Logging in to the Pipelines Visualizer

Unless you [customize the chart](/docs/v3/develop/apps/#customising-charts) to change the `Ingress` the default will use _basic authentication_ to access the web UI to avoid your pipeline logs being visible on the internet.

The default username is `admin`. 

To find the generated random password to access the UI type:

```bash 
jx ns jx
kubectl get secret jx-basic-auth-user-password -o jsonpath="{.data.password}" | base64 --decode
```

That should display the randomly generated password.

If you type the username and password into your browser it should open the dashboard.


