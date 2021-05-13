---
title: jx gitops git merge
linktitle: merge
type: docs
description: "Merge a number of SHAs into the HEAD of the main branch"
aliases:
  - jx-gitops_git_merge
---

### Usage

```bash
jx gitops git merge
```

### Synopsis

Merge a number of SHAs into the HEAD of the main branch.

### Details

This command merges a list of commits into a specified branch. If the branch does not exist among local branches, then
it is first created.

If both `--pull-refs` and `--sha` flags are specified then only those commits specified by `--sha` are merged into the
base branch.

If `--include-comment` or `--exclude-comment` flags are specified, then `--pull-number` flag needs to be set as well.
If only one of `--include-comment` or `--exclude-comment`, then only that one is used to filter commits while other is
ignored. If both are specified, then only those commits which satisfy ``--include-comment` and do not satisfy the
`--exclude-comment` regex are added. Only those commits which are reachable by from pull request and are not reachable
by base branch are included to be merged into the base branch.

### Examples

  ```bash
  jx-gitops git merge

  ```
  
### Options

```text
      --base-branch string       The branch to merge to. If not specified then either $PULL_BASE_REF is used or the first entry in $PULL_REFS is used 
      --base-sha string          The SHA to use on the base branch. Iff not specified then $PULL_BASE_SHA is used or the first entry in $PULL_REFS is used
      --dir string               The directory in which the git repo is checked out (default ".")
  -e, --email string             the git user email to use if one is not setup
      --exclude-comment string   the regular expression to filter commit comment to exclude in the merge
      --fake-in-cluster          for testing: lets you fake running this command inside a kubernetes cluster so that it can create the file: $XDG_CONFIG_HOME/git/credentials or $HOME/git/credentials
  -h, --help                     help for merge
      --include-comment string   the regular expression to filter commit comment to include in the merge
  -n, --name string              the git user name to use if one is not setup
      --pull-number string       The Pull Request number to use when filtering commits to merge
      --pull-refs string         The PullRefs to parse
      --remote string            The name of the remote (default "origin")
      --sha stringArray          The SHA(s) to merge, if not specified then the value of the env var $PULL_REFS is parsed
```

### Source

[jenkins-x-plugins/jx-gitops](https://github.com/jenkins-x-plugins/jx-gitops)
