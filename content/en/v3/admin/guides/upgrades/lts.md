---
title: LTS
linktitle: LTS
type: docs
description: Long Term Support (LTS) version stream
weight: 40
aliases:
 - /v3/guides/upgrades/lts
---
 
Jenkins X uses [version streams](/about/concepts/version-stream/) as a quality gate when promoting plugins, charts, cli packages, container images etc.  This results in a release of Jenkins X.
 
The default version stream for Jenkins X 3.x is https://github.com/jenkins-x/jx3-versions.  The Jenkins X own infrastructure runs a number of end to end BDD tests for different base install options which covers the core of Jenkins X.  Provided these tests pass on from a Pull Request it will be merged and users can upgrade their [CLI](/v3/guides/upgrades/cli) and [Cluster](/v3/guides/upgrades/cluster) bringing in the versions that make that release. 
 
As Jenkins X uses Continuous Delivery all the way through the stack it means there can be a lot of releases, even many on a daily basis.  While we are advocates of Continuous Delivery it can be hard for users to consume the number of releases so often.  For teams that are in need of more mature features when they are released it can also bring some risk upgrading from the latest daily release of an open source project.
 
The Long Term Support (LTS) version stream (https://github.com/jenkins-x/jx3-lts-versions/) is designed to help with these two scenarios.  It is a replica of the latest default version stream described above but will release on a slower cadence.  This means users can switch their installations to track the LTS version stream and bring in changes when it suits them.  They will see a collection of changes which will have improved documentation and maturity given the feedback from users tracking the latest version stream.  Jenkins X own infrastructure uses the latest version stream and automatically upgrades on every release, this is another way we can build confidence in the quality of an LTS release.
 
## LTS
 
To switch your installation clone your cluster git repository
 
```bash
jx gitops versionstream --lts
```
This will modify and commit a change to your local `./versionStream/Kptfile`, it will now point at the LTS version stream.
 
Next we need to make sure your local `jx` CLI is aligned with the version in the LTS version stream.
 
From within the same directory as above run:
```bash
jx upgrade cli
```
 
Next we will get the LTS version stream and align the `helmfile.yaml` with the correct versions.
```bash
jx gitops upgrade
```
 
Now review changes, commit and push to your cluster remote git repository.
 
## Latest
 
To switch back to the latest version stream repeat the steps above with the `--latest` flag instead.
e.g.
```bash
jx gitops versionstream --latest
jx upgrade cli
jx gitops upgrade
```
 
## Custom
 
The monthly cadence of the LTS version stream may still be too frequent if you desire.  For this you can fork the LTS version stream, point your installation at the fork and manage syncing your fork with the LTS at whatever cadence suits you best.
 
To use a custom fork repeat the steps above with the `--custom` flag and git details instead.
e.g.
```bash
jx gitops versionstream --custom --url https://github.com/foo/bar --ref master --directory versionStream
jx upgrade cli
jx gitops upgrade
```
 
If it helps [this](https://github.com/jenkins-x/jx3-versions/blob/a82a00258e293d7457d6da15d7037363cfd3841d/.lighthouse/jenkins-x/release/promote-vs.sh#L53-L58) is where we automatically create a pull request on the LTS version stream when we release the latest version stream.  You can do the same when updating your custom fork.
 
e.g.
```
git clone https://github.com/foo/bar.git
cd "jx3-lts-versions"
git checkout -b foo
jx gitops upgrade --commit-message "chore: version stream upgrade $VERSION"
git push origin foo
jx create pullrequest -t "chore: version stream upgrade $VERSION"
```