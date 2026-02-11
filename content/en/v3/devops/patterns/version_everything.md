---
title: Version Everything
linktitle: Version Everything
description: Avoid snapshot or latest images
type: docs
weight: 20
---

Always version everything explicitly in git and never use `latest` or `SNAPSHOT` images or artifacts!
 
The reason is you never know when a `latest` or `SNAPSHOT` image or artifact will upgrade in any container/pod/process/step in any environment. Its basically random. So not versioning things means random failures.

If you explicitly version things in all repositories things are stable and repeatable. 

If you are worried about upgrading versions of things over time then look at either tools like [dependabot](https://dependabot.com/) or the [updatebot plugin](https://github.com/jenkins-x-plugins/jx-updatebot) which we use extensively throughout Jenkins X to upgrade versions of libraries, images, binaries etc.
