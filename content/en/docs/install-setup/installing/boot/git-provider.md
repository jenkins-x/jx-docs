---
title: Configure Git Provider
linktitle: Configure Git Provider
description: Configure Git providers supported by Jenkins X
keywords: [git]
weight: 40
---

Jenkins X supports several different Git providers via webhooks (user-defined HTTP callbacks).
These webhooks trigger the Jenkins X Pipeline execution, based on repository events such as a push to the master branch or the creation of a pull request.

The default webhook handler for Jenkins X is [Lighthouse](/docs/reference/components/lighthouse/), which manages webhooks similarly to [Prow](https://github.com/kubernetes/test-infra/tree/master/prow).
However, contrary to Prow, which only supports GitHub, Lighthouse supports a variety of Git providers.

The following sections describe how you change the Boot configuration to use the various supported Git providers.
The configuration occurs in all cases via [`jx-requirements.yml`](/docs/install-setup/installing/boot/#requirements).

{{% alert %}}
After changing the configuration you need to make sure it gets applied by running the Boot pipeline.
Either by running `jx boot` locally or by creating a pull request against the development repository.
Refer to [changing your installation](/docs/install-setup/installing/boot/#changing-your-installation) for more information.
{{% /alert %}}

## GitHub

This is the default Git provider if you don't specify one.
Explicitly it is configured by _gitKind: github_ such as the following example:

```yaml
cluster:
  environmentGitOwner: myorg
  gitKind: github
```

## GitHub Enterprise

[GitHub Enterprise](https://github.com/enterprise) supports the same features as the github.com service but scaled for on-premises deployment on local networks.

The configuration is similar to the above but you need to specify the URL of the `gitServer` and `gitKind: github`. 
For example:

```yaml
cluster:
  environmentGitOwner: myorg
  gitKind: github
  gitServer: https://github.myserver.com
webhook: lighthouse
```

Ensure you specify [Lighthouse](/docs/install-setup/installing/boot/webhooks/#lighthouse) webhook handler by setting `webhook: lighthouse`.

## Bitbucket Server

For Bitbucket Server specify the URL of the `gitServer` and `gitKind: bitbucketserver`.

```yaml
cluster:
  environmentGitOwner: myorg
  gitKind: bitbucketserver
  gitServer: https://bitbucket.myserver.com
webhook: lighthouse
```

Ensure you specify [Lighthouse](/docs/install-setup/installing/boot/webhooks/#lighthouse) webhook handler by setting `webhook: lighthouse`.

## Bitbucket Cloud

For Bitbucket Cloud specify`gitKind: bitbucketcloud`.

```yaml
cluster:
  environmentGitOwner: myorg
  gitKind: bitbucketcloud
webhook: lighthouse
```

Ensure you specify [Lighthouse](/docs/install-setup/installing/boot/webhooks/#lighthouse) webhook handler by setting `webhook: lighthouse`.

## GitLab

For [GitLab](https://about.gitlab.com/stages-devops-lifecycle/source-code-management/) specify the URL of the `gitServer` and `gitKind: gitlab`.

```yaml
cluster:
  environmentGitOwner: myorg
  gitKind: gitlab
  gitServer: https://gitlab.com
webhook: lighthouse
```

Ensure you specify [Lighthouse](/docs/install-setup/installing/boot/webhooks/#lighthouse) webhook handler by setting `webhook: lighthouse`.
