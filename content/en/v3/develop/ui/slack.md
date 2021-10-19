---
title: Slack
linktitle: Slack
type: docs
description: Slack bot for Jenkins X 
weight: 200
---

Many of us use chat to keep in touch with the developers and tools we work with. [Slack](https://www.slack.com/) is becoming popular in commercial settings and is already used throughout the Kubernetes open source ecosystem: including the [Jenkins X project slack channels](https://jenkins-x.io/community/#slack)

To get [slack](https://www.slack.com/) notifications of pipelines you can use the [jx-slack](https://github.com/jenkins-x-plugins/jx-slack) plugin.

## Creating the slack app 

Before you can install the [jx-slack](https://github.com/jenkins-x-plugins/jx-slack) plugin you need to create a Slack app.

* [create a new slack app](https://api.slack.com/apps?new_app=1) and fill in the details of the application name and associate it with the slack workspace you wish to use
* navigate to the **Features** / **OAuth & Permissions** page on the slack app site

<img src="/images/slack/slack-oauth-page.png" class="img-thumbnail" width="239" height="573">

* add the Scope **chat:write** to your bot so it can post messages to your slack workspace
* find your **Bot User OAuth Access Token** which should start with **xoxb-** you will need it later...
* invite the slack app you have created into whatever channels you want it to notify. e.g. inside the channel you can type `@` and start typing the slack app name to send it a message which will get Slack to prompt you to invite the bot user to the room.                                                                                    

## Installing

To install the [jx-slack](https://github.com/jenkins-x-plugins/jx-slack) plugin add the following to your `helmfiles/jx/helmfile.yaml` file in your dev cluster git repository in the `releases:` section:

```yaml 
- chart: jxgh/jx-slack
  name: jx-slack
  values:
  - jx-values.yaml
```

Once you have pushed the change to git and your [boot job has retriggered](/v3/about/how-it-works/#boot-job) (you can view this via `jx admin log`) you should see the `jx-slack` secret show up as being missing:

```bash 
jx secret verify 
```

You can populate your slack bot token via the following. **Note** that if you are using vault [you need to run the port forward first](/v3/admin/setup/secrets/vault/#using-vault):

```bash 
jx secret edit -f jx-slack
```

Enter the  **Bot User OAuth Access Token** you found in the [above steps](#creating-the-slack-app) which should start with **xoxb-** 

In a few seconds time you should see the `Secret` show up with the token populated...

```bash
kubectl get secret jx-slack -oyaml
```

Now that the secret is populated you should see the `jx-slack` pod show up:

```bash
kubectl get pod -l app=jx-slack
```

## Configuring Slack notifications

In your dev cluster repository the `.jx/gitops/source-config.yaml` file (see the [configuration guide](https://github.com/jenkins-x/jx-gitops/blob/master/docs/config.md#gitops.jenkins-x.io/v1alpha1.SourceConfig)) is used to configure which repositories are imported into Jenkins X. This file is [automatically updated](/v3/about/how-it-works/#importing--creating-quickstarts), via pull requests, when you [create or import projects](/v3/develop/create-project/).

You can configure the [slack](https://github.com/jenkins-x/jx-gitops/blob/master/docs/config.md#gitops.jenkins-x.io/v1alpha1.SlackNotify) configuration either globally, for a group of repositories or for a single repository.

You can use overriding: so have good global or group based defaults then override on a per repository basis where required. 

### Filters 

You can change the notification filters at any level (global, group or repository) to let you get the right level of notifications you need. 

Its common with chat to be too noisy; so you probably only need to be notified on a subset of events.

e.g. a good default is only be notified for releases only (so ignoring Pull Requests) and only for failures or the first success after a failure. This can be done via the `kind` and `pipeline` filters:

```yaml 
slack:
  channel: '#jenkins-x-pipelines'
  kind: failureOrNextSuccess
  pipeline: release
```

kind values and their behaviors are:
* `""`: no notifications
* never: never notify - no notifications
* always: always send a notification
* failure: notify only failures
* failureOrNextSuccess: notify only failures or first success after failure
* success: notify only on success

pipeline values and their behaviors are:
* `""`: no notifications
* all: notify on all pipelines
* release: only notify on release pipelines
* pullRequest: only notify on pullRequest pipelines

You can configure the `channel` globally or for different groups or repositories differently too. You can also filter by `branch`, pipeline `context` or `pullRequestLabel`.
     
## Example 

Here's an example of some messages sent to the channel for a repository. In this case its our BDD tests on the version stream.

As you can see a few tests fail then we get a successful pipeline.

You'll notice the links on the git owner, repository, and build number all resolve to links to your git provider or the associated pipeline page in the [Pipeline Visualiser](/v3/develop/ui/dashboard/) 

<img src="/images/slack/slack-bot.png" class="img-thumbnail" width="542" height="224">


## Other slack bots

We recommend the [Toast slack bot](https://toast.ninja/) as a way to get DM'd with changes to your Pull Requests and its not too noisy.

There is also the [github slack integration](https://slack.github.com/) which is quite good - though it can be quite noisy.

If you have found any other good slack bots please [let us know](http://localhost:1313/community/#slack) or click on the `Edit this page` link on the right of this page to submit a new link!
