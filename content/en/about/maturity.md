---
title: Feature Maturity
linktitle: Feature Maturity
description: Definitions and processes around how features mature or are deprecated
weight: 50
---

# Maturity levels and Definitions

Features will usually go through the following levels of maturity (though some may never be deprecated)

1. Experimental
1. Stable
1. Production
1. Deprecated

Each of the levels are detailed below, including the gates that a feature must pass through in order to "level up"

## Experimental

{{% alert %}}
TL;DR: Use at your own risk
{{% /alert %}}

This would be the initial level for most new features. It's likely the first push of something that at least works for the contributor. Features at this level is not really expected to live up to any requirements, and could just as well be a suggestion of how to tackle a certain issue. It could also be a really well structured, thought out, polished thing that mostly just need to be vetted by others before being elevated in maturity.

Main takeaway for this level of maturity is that there's a risk things will change (config/scope/behavior/etc) and it's probably not something you should rely on in a production environment unless you feel you know what you're doing.

## Stable

{{% alert %}}
TL;DR: Feature complete; needs more testing/documentation
{{% /alert %}}

After having been in Experimental for some amount of time, and the feature have gotten feedback from others etc., it should eventually reach a feature complete state, where it can be expected to work in most circumstances. Automated testing might still be on the light side and the documentation might also need to be fleshed out some more.

For a feature to reach this level, it should have reached a point where various "contracts" (configuration, APIs, etc.) are not expected to change; at least not drastically. It should also have some automated testing and documentation; at least for the main flows. What should remain is mostly just bug-fixes, testing, and fully fleshing out the documentation.

## Production

{{% alert %}}
TL;DR: Production level. Well tested and documented
{{% /alert %}}

This is the final level of maturity, and as a consumer of a stable feature you should expect it to be solid, well tested in various setups/environments, and well documented.

Production level features can certainly change, but changes should be announced in the changelog and potentially the blog and be clearly expressed in a version number as well (major/minor/patch version bumps where appropriate). If a production level feature have changed (changed config setting, a new option, etc.) it should be easy for a user to be aware of this, prior to upgrading to the new version that includes the changes.

## Deprecated

{{% alert %}}
TL;DR: This will be removed soon. Don't use
{{% /alert %}}

Eventually some features will be deprecated for whatever reason (a better approach was found, the problem it solved is no longer a problem, etc.). This should not happen over night though, and deprecations should be announced in the changelog and the blog with at least a month of notice.
Once a feature has been announced as deprecated, it will be marked as such (see below for more details) and the final removal will be clearly expressed in a version number as well (major/minor version bumps where appropriate).

# Experimental Features

To help make it clear which features are experimental and which are stable/production level, you can refer to either the documentation (this site) or the `jx --help` command.

The documentation site will have flags like this:

{{% alert color="warning" %}}
Experimental
{{% /alert %}}

The `--help` command will include the information in the description of a command, like this:

```cmd
Installing:
  profile          Set your jx profile
  boot             (Experimental) Boots up Jenkins X in a Kubernetes cluster using GitOps and a Jenkins X Pipeline
  install          (Stable) Install Jenkins X in the current Kubernetes cluster
  .
  .
```

Production level features/commands will not be specifically flagged.

{{% alert color="warning" %}}
At this point in time, these flags have not been universally applied. If in doubt, ask in the `#jenkins-x-user` slack channel
{{% /alert %}}

## Accessing Experimental Features

As you could get yourself into a bit of a bind with some experimental features, you need to specifically allow the use of them; if not, they will simply be ignored.

To enable experimental features, do one of the following (depending on where you need to access them)

### JX Boot

Update your JX Boot configuration to include `allow-experimental: true`

### jx CLI

Add `--allow-experimental` to the command that uses experimental features

# Deprecated Features

To highlight deprecated features and make it easy to see which to avoid, the documentation (this site) will include a warning like this:

{{% alert color="warning" %}}
Deprecated in jx since 2.0.134. Will be removed on 2nd December 2019.
{{% /alert %}}

in pages that concern deprecated features. The warning will note the version where the feature will stop/stopped being included.

Similarly to experimental and stable commands, the `jx --help` command will denote deprecated commands with `(DEPRECATED)` in the command description.