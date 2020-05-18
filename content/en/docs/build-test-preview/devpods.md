---
title: Developing Using DevPods
linktitle: DevPods
description: Using Jenkins X to continuously deliver value to your customers
weight: 50
aliases:
    - /docs/resources/guides/using-jx/developing/devpods/
---

Jenkins X allows you to edit app code by using a Kubernetes Pod which we call `DevPod`.  This helps you develop inside the cloud with the same software tools, platform, container images and pod templates as the CI/CD pipelines. This helps keep everyone in the team and your CI/CD pipelines using the same platform and tools all the time to reduce waste and avoid those pesky 'it works on my laptop but not in production' issues.


There are a couple of ways that you as a developer can quickly become productive when editing an app, and add value ultra fast.

There are specific steps for each approach, and we provide you a visual representation of each workflow, as well as the specific steps to quickly get started.

{{< alert >}}
Keep in mind, this development workflow helps you make changes before even checking in your code to the repo, or submitting a formal pull request.  Really meant for you to validate your changes fast!

{{< /alert >}}

## Develop Using DevPods and a desktop IDE

In this scenario, you are using a desktop IDE such as VS Code or Intellij which in fact have [a plugin](/docs/resources/guides/using-jx/developing/ide/) for `Jenkins X`.  You are making **iterative** changes using your IDE and said changes are reflected immediately when you open the `url` assigned to your `DevPod`

<figure>
<img src="/images/developing/developer_workflow_ide.png" />
<figcaption>
<h5>Developer Workflow - Develop Using DevPods and an IDE</h5>
</figcaption>

{{< alert >}}
See [IDE](/docs/resources/guides/using-jx/developing/ide/#vs-code) for more details on using VSCode
{{< /alert >}}

To get started using this approach, simply execute the following command in the root of your app directory.  We are using a `NodeJS` app for this example, therefore we specify the language using the `-l` parameter.

```sh
jx create devpod -l nodejs --reuse --sync
```
A successful execution will ensures the following happened:

- Output the `URLs` available to access the `Pod`
- App folder will sync with the `Pod`
- An ssh session is initiated to the `Pod`

Once this happens, you must execute one more command within your ssh session to the Pod to ensure any changes are synchronized.

```sh
./watch.sh
```

{{< alert >}}
 From this point forward, any changes you make **(step 1 in diagram)**, trigger a Docker Image build, and you should see the output of that build command in your terminal as it happens.
{{< /alert >}}

Once you are happy with changes to your app, you go to **(step 2 in diagram)** and check-in your code, create a `Pull Request` at which point a `Jenkins X Pipeline` is triggered immediately to promote your changes to `Staging` enviornment.



## Develop Using DevPods and a Web-based IDE
If you prefer not to use an IDE on your desktop using a similar workflow as above.  To edit the app code, you use the well known [Theia](https://www.theia-ide.org/) IDE.

<figure>
<img src="/images/developing/developer_workflow_theia.png" />
<figcaption>
<h5>Developer Workflow - Develop Using DevPods and Web-based IDE Theia</h5>
</figcaption>

Using this approach, you execute the following on your terminal.

```sh

jx create devpod --verbose true

# some output us removed for brevity
Creating a DevPod of label: nodejs
Created pod me-nodejs - waiting for it to be ready...
Using helmBinary helm with feature flag: none
Updating Helm repository...
Helm repository update done.
...
Pod me-nodejs is now ready!
You can open other shells into this DevPod via jx create devpod

You can edit your app using Theia (a browser based IDE) at http://me-nodejs-theia.jx.yourdomain.com

Attempting to install Bash Completion into DevPod
Running command: kubectl exec -it -n jx -c theia me-nodejs -- /bin/sh -c mkdir -p /workspace
cd /workspace
...
[root@me-nodejs node-app]#
```

{{< alert >}}
 **NOTE**: We are not passing the `--sync` flag because we plan on using the web based IDE
{{< /alert >}}

A succesful execution of the command above, will ensure the following has happened:

- DevPod is created, and exposed for you to access app via URL
- Theia Docker container is running
- App folder is mounted to Theia Docker container at `/workspace` folder.
- You have a terminal session into the `DevPod`

To see your changes in real-time, you must also execute the following command within your terminal session connected to the Pod:

```sh
./watch.sh
```

### Promote to Staging
Once you are happy with the changes you made to the app, you can simply check-in your code and create a `pull request`.  This will trigger the pipeline to promote your changes to the `Staging` environment (**Step 2 and 3 in diagram**)

### Promote to Production
Most of the time,the Production environment in **Jenkins X** will have its `Promote` setting set to `MANUAL`.  Therefore, promoting your app can happen manually after stakeholders have reviewed the staging envionment, for example.

To promote the app to production, you can execute the following commands:

1. first get the app version from this output

```sh
jx get apps
```

2. promote app version 0.0.2 from staging to production

```sh
jx promote --version 0.0.2 --env production
```

# Additional Learning
