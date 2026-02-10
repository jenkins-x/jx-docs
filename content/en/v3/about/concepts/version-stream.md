---
title: Version Stream
linktitle: Version Stream
type: docs
description: How we improve stability of JayeX and its Apps
weight: 60
---

JayeX is made up of a large number of command line _packages_, _images_ and helm _charts_, some of which are released by the JayeX community and others come from the wider open source ecosystem.

To improve the stability of JayeX when lots of packages and charts are changing all the time we have introduced the JayeX `Version Stream`

<figure>
<img src="/images/jx-version-stream-v1.png"/>
<figcaption>
<h5>Diagram depicts how a new JX version will be propagated through the components.</h5>
</figcaption>
</figure>

## How it works

The version stream is stored in the [jenkins-x/jx3-versions](https://github.com/jenkins-x/jx3-versions) git 
repository and stores the stable version of all packages and charts used by JayeX.

When you run a `jx` command, such as [jx gitops upgrade](/v3/develop/reference/jx/gitops/upgrade), it 
will ensure you have a local clone of the  [jenkins-x/jx3-versions](https://github.com/jenkins-x/jx3-versions) git
repository and then pull the stable version of any chart or package from that source.

The [jx](https://github.com/jenkins-x/jx) release now defaults to being released as a 
[prerelease](https://help.github.com/en/articles/creating-releases). Each release of jx is only updated to a full release
so long as that released version successfully makes its way to the jx3-versions repository where it also needs to pass
another round of BDD tests (_see [Continuous Integrating JX itself](/community/code/continuous-integrating-jx-itself/)
for more information_).

## Creating Pull Requests

Our command [jx updatebot pr](/v3/develop/reference/jx/updatebot/pr/) is used for automatically generating pull 
requests on the [jenkins-x/jx3-versions](https://github.com/jenkins-x/jx3-versions) git repository.

### Periodic updates

It's not always easy/possible to update upstream pipelines to push version changes to JayeX via a pull pequest. So 
we also have a periodic job to check for version upgrades for helm charts.

e.g. to upgrade the versions of all the JayeX maintained charts we essentially run the command:

```sh
jx updatebot pr -c .github/workflows/update-charts/updatebot.yaml
```
where updatebot.yaml contains:

```yaml
apiVersion: updatebot.jenkins-x.io/v1alpha1
kind: UpdateConfig
spec:
  rules:
    - urls:
        - https://github.com/jenkins-x/jx3-versions
      changes:
        - versionStream:
            kind: charts
            include:
            - cdf/*
            - jxgh/*
```