---
title: Securing Jenkins X
linktitle: Securing Jenkins X
description: Security addons for Jenkins X
weight: 30
menu:
  docs:
    parent: "Install and Setup"
    title: "Securing Jenkins X"
aliases:
    - /docs/resources/guides/managing-jx/common-tasks/security-features/
---

Jenkins X has a few useful addons that can aid with ensuring the ongoing security of your deployed applications. There are static and container security, as well as dynamic security addons available.

### Static security

The [Anchore Engine](https://github.com/anchore/anchore-engine) is used to provide image security, by examining contents of containers either in pull request/review state, or on running containers.

This was introduced [in this blog post](https://jenkins.io/blog/2018/05/08/jenkins-x-anchore/)

To enable this run the following command and let it prepare the services:

```sh
jx create addon anchore
```

This will launch the require engine and services, and make it available to run on any of your teams environments, and on any running preview applications.

To try it out, you can use the following command to report on any problems found:

```sh
jx get cve --environment=staging
```

Here is a video [showing it in action](https://youtu.be/rB8Sw0FqCQk). To remove this addon:

```sh
jx delete addon anchore
```



### Dynamic security

The Open Web Application Security Project publishes a tool called ZAP: the [Zed Attack Proxy](https://www.owasp.org/index.php/OWASP_Zed_Attack_Proxy_Project). This provides various tools including a baseline command that can be run against an application endpoint looking for a base set of problems.

In Jenkins X this can be run against a Preview Application (that each application gets) by creating a post-preview hook:

```sh
jx create addon owasp-zap
```

Any pull requests will then have their preview application run through the ZAP baseline scan, and should any failures be detected it will fail the CI pipeline automatically. The pipelines do not be changed to run this test, and they will apply to all pull requests for the team.

To remove the ZAP test:

```sh
jx delete post preview job --name owasp-zap
```

The post preview hook can also be configured with a command like:

```sh
jx create post preview job --name owasp --image owasp/zap2docker-weekly:latest -c "zap-baseline.py" -c "-I" -c "-t" -c "\$(JX_PREVIEW_URL)"
```

You can have multiple hooks configured, so if you had specific containers that had probes/tests you would like to run against every preview app (ie every pull request) you could add it this way.


[Preview Environments](/docs/reference/preview/)

