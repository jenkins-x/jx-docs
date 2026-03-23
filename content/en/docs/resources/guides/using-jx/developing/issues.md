---
title: Issues
linktitle: Issues
description: Working with issues
weight: 80
---

Jenkins X defaults to using the issue tracker in your git provider for creating and browsing issues.

e.g. if you are inside the source code of a github project then you can type [jx create issue](/commands/jx_create_issue/):

```sh
jx create issue -t "lets make things more awesome"
```

And a new issue will be created on github.

You can list open the issues on your project via [jx get issues](/commands/jx_get_issues/):

```sh
jx get issues
```

### Using a different issue tracker

If you wish to use, say, JIRA on a project you first need to add a JIRA service.

You can register your JIRA service via [jx create tracker server](/commands/jx_create_tracker_server/):

```sh
jx create tracker server jira https://mycompany.atlassian.net/
```

You can then view your issue tracker server via [jx get tracker](/commands/jx_get_tracker/):

```sh
jx get tracker
```

Then add a user and token via:

```sh
jx create tracker token -n jira  myEmailAddress
```

### configure the issue tracker on a project

In the source code of your project then use [jx edit config](/commands/jx_edit_config/):

```sh
jx edit config -k issues
```

Then

* if you have multiple issue trackers, pick the one you wish to use for the project
* enter the name of the project in the issue tracker (e.g. the upper case name of the JIRA project)

A file called `jenkins-x.yml` will be modified in your project source code which should be added to your git repository.







