---
title: Preview Environments
linktitle: Preview Environments
description: Preview your changes in temporary environments before you merge them
type: docs
weight: 200
---

If you are using [Trunk Based Development](/v3/devops/patterns/trunk_based_development/) you want to keep the main branch clean and ready to release at all times so you can quickly get important bug fixes out.

But how can you shift left and do more testing on changes before you are ready to merge to the main branch?

The idea of a `Preview Environment` is to spin up a temporary environment to deploy the code from a Pull Request before the change is merged to get fast feedback from your team on the change and to shift left and get more testing done before you agree to merge the change.

In Jenkins X we automate a [Preview Environment](/v3/develop/environments/preview/) is created on all Pull Requests which builds the preview image/chart, spins up a temporary namespace and deploys the application then comments on the Pull Request details.

### Using Previews for shift left system testing

You can also use [additional pipeline steps](/v3/develop/environments/preview/#additional-preview-steps) after the Preview has been deployed to run different kinds of system or integration testing.

You may also wish to [add additional dependencies](/v3/develop/environments/preview/#adding-more-resources) to your preview environment (defined in `preview/helmfile.yaml` in your repository).
