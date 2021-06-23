---
title: Lighthouse WebUI
linktitle: Lighthouse WebUI
type: docs
description: Read-only web UI view of Lighthouse events, jobs and merge status/history
weight: 100
aliases:
  - /v3/develop/ui/lighthouse
---

[Lighthouse](https://github.com/jenkins-x/lighthouse) is the Jenkins X component responsible for all interactions between your Git hosting provider (GitHub, Gitlab, ...) and your Kubernetes cluster. Amongst other things, it:
- receive and process webhook events
- trigger pipelines
- handle automatic merging of Pull Requests

Lighthouse comes with an optional Web UI: [lighthouse-webui-plugin](https://github.com/jenkins-x-plugins/lighthouse-webui-plugin) - see [the admin guide](/v3/admin/guides/lighthouse-webui/) to install it.

This UI gives you a read-only view of:
- the webhook events received and processed by Lighthouse: git push, PR events, comments, ...
- the Lighthouse Jobs (pipelines) created, and their states - with a direct link to the [pipeline visualizer](/v3/develop/ui/dashboard/) to see the logs
- the Lighthouse Merge Status and History: which PRs have been automatically merged by Lighthouse

This UI will help you understand what Lighthouse is doing, and in case of issue (pipeline not triggered, PR not being automatically merged, ...) it will help you find the root cause.


### Accessing the Lighthouse Web UI

Unless you [customize the chart](/v3/develop/apps/#customising-charts) to change the `Ingress` the default hostname will be `lighthouse.<YOUR_DOMAIN>`. You can find the exact hostname by running the following command:

```bash 
jx ns jx
kubectl get ing lighthouse-webui-plugin -o jsonpath="{.spec.rules[0].host}"
```

### Logging in to the Pipelines Visualizer

Unless you [customize the chart](/v3/develop/apps/#customising-charts) to change the `Ingress` the default will use _basic authentication_ to access the web UI to avoid your cluster internal state being visible on the internet.

The default username is `admin`. 

To find the generated random password to access the UI type:

```bash 
jx ns jx
kubectl get secret jx-basic-auth-user-password -o jsonpath="{.data.password}" | base64 --decode
```

That should display the randomly generated password.

If you type the username and password into your browser it should open the web UI.


### Viewing from a Pull Request

If you create a Pull Request on a git repository you have [created or imported](/v3/develop/create-project/) in Jenkins X you should see a link on the Pull Request. 

Here's an example - see the **Details** link on the right of the `Merge Status` line:

<img src="/images/lighthouse-webui-plugin/github-pr-status-link.png" class="img-thumbnail">

If you click the **Details** link that should open the [lighthouse-webui-plugin](https://github.com/jenkins-x-plugins/lighthouse-webui-plugin) UI in the "Merge Status" page.


### Lighthouse Events

By default, the Lighthouse Web UI will display all the webhook events:

![](/images/lighthouse-webui-plugin/events.png)


### Lighthouse Jobs

If you click on the **Jobs** link (top right), you will see all the pipelines triggered by Lighthouse:

![](/images/lighthouse-webui-plugin/jobs.png)


### Lighthouse Merge Status

If you click on the **Merge Status** link, you will see all the Pull Requests currently in the Lighthouse "Merge Pools" - candidates for automatic merge:

![](/images/lighthouse-webui-plugin/merge-status.png)


### Lighthouse Merge History

If you click on the **Merge History** link, you will see all the Pull Requests which have been automatically merged by Lighthouse:

![](/images/lighthouse-webui-plugin/merge-history.png)
