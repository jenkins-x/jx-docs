---
title: Pull Request Reviews
linktitle: Pull Request Reviews
description: How to get your pull request reviewed and how to review a pull request
authors: [pmuir]
type: docs
weight: 20
aliases:
    - /docs/contributing/code/pullrequestreview/
---

The pull request is the main place we gate changes in Jenkins X. It's here we:

* run the tests (`make test-slow-integration`)
* execute [end to end tests](https://github.com/jenkins-x/bdd-jx) against static jenkins and Tekton
* [check the change](https://github.com/jenkins-x/jx/blob/2d54b6ef9a276f148cbc7cb10169e83238f2d83e/hack/linter.sh) for linting issues
* [check the code](https://github.com/jenkins-x/jx/blob/2d54b6ef9a276f148cbc7cb10169e83238f2d83e/hack/gofmt.sh) for formatting issues
* validate that [all generated code](/community/code/#code-generation) (mocks, kubernetes clients, kubernetes openapi structs) are up to date
* validate that we can [generate the apidoc](//community/code/#code-generation)
* validate that your [commits are conventional](/community/code/#the-commit-message)

Our philosophy is to automate the checks as much as possible - there are some that must still be done by a human but we
plan to reduce those as far as possible.

These review guidelines apply to all github repos in https://github.com/jenkins-x, https://github.com/jenkins-x-charts,
https://github.com/jenkins-x-apps, https://github.com/jenkins-x-quickstarts and https://github.com/jenkins-x-buildpacks.
A repository with the `proof-of-concept` label does not have to follow these guidelines. If we decide that the proof
of concept is going to become the longterm solution the `proof-of-concept` label should be removed and the code in the
repository should be reviewed to ensure that these guidelines are met (and any remedial action needed added to the issue
tracker and scheduled).

# Getting your PR merged

In order to get your PR merged you'll need to get a pass on all the automated checks. You'll also need a maintainer to
approve the change using `/lgtm`. In order to get an `/lgtm` it helps to give a little bit of context to your PR in the
body of the PR - an essay is not necessary (or helpful!).

We believe that the person who knows the most about the change is the author of the change and that the role of the approver
is to try to spot any functional or non-functional problems that the change might introduce. We'll cover this in more
detail in "Approving a PR". If you are uncertain about a part (or all) of the change please do mention this either in
the PR or as an inline comment as this means the approver can focus on the right part.

All PRs are approved by a maintainer, and for all non-experimental repositories that maintainer must be a different
individual to the author.

And above all, remember that as a PR author it's your responsibility to get your PR merged!

# Approving a PR

Your five principal tasks as an approver are to:

* verify that the change is of overall benefit to Jenkins X
* spot potential functional or non-functional problems with a PR
* ensure any non-automated checks pass
* signal when a PR needs security review by applying the `needs-security-review` label and wait with the approval
until a security person reviews the changes and removes the label
* identify when a PR requires some documentation by adding the `needs-docs` label and also request to author
to create a follow up issue with label `area/docs`

Verifying that the change is of **overall benefit** is your most important responsibility as a PR approver. By default
we assume that changes are beneficial and that it is the responsibility of the approver to identify if the change would
be detrimental (rather than requiring the author to prove or assert benefit in all cases).

If, as a PR approver, you feel that a PR is detrimental to Jenkins X you should:

1) Place the PR on hold using the `/hold` command, with the comment "I want to discuss whether this PR is beneficial or
not before approving. I'll start a discussion in the #jenkins-x-dev channel shortly to discuss my concerns."
2) Once you have started a discussion, add a comment with a PR with a link to the discussion
3) Once you have have reached mutual agreement update the PR:
   * Summarize the discussion on the PR
   * If you agree that the PR is ok or mostly ok (but need some changes) follow the standard approval process outlined in
     this document
   * If you agree that the PR is not ok close it with a the comment "We've agreed to not merge this PR"

These sorts of discussions have the potential to become heated. Whilst we advise starting a discussion on slack we would
strongly encourage you to have a quick call with anyone interested if you can't quickly (quickly means a couple of
messages, a minute discussion or a few sentances) reach agreement with the PR author to hash out what to do. You may also
want to consider asking a third developer to act as a facilitator/moderator to help you stay on track with the discussion.

> This process is intentionally onerous on the approver as we feel change creates opportunity and that there must be a
> good reason to prevent change that you can justify and explain. That does not diminish the responsibility on every
> approver to ensure that a change is of benefit, and you will have the full support of all members of the project in
> challenging the benefit even if some of the members disagree with your challenge!

**Functional problems** are might potentially cause the code to not function as described on one of the PR, an attached issue,
an external document or PR against the docs repo. Examples might include missing prompts or questions, incomplete or
misleading helptext or an API that doesn't make sense.

**Non-functional problems** are that set of problems that don't affect the functioning of the program but are known to cause
problems. An exhaustive list of non-functional problems the reviewer should check for is maintained here, and this list
must be updated when new non-functional areas for review are identified.

* Too many files in a package. Go uses a lot of memory at compilation time and large packages can cause compilation to
  crash. This is particularly a problem when running a test suite as we like to run tests in parallel for speed. Approvers
  should use their discretion but as a rule of thumb any new functionality should go in it's own package and not be
  added to an existing package as a number (e.g. `kube`, `util`, `cmd`) are already far too large
* Duplicated functionality. The codebase is large, and has many dependencies. When writing a new feature it's often easy
  to miss existing functions or dependency that do what you need, and add a new function or dependency. Approvers should
  try to identify a duplicated dependencies or functions and ask for them to be consolidated.
* Excessive custom resource creation. Etcd struggles with too many custom resources being created (e.g. we saw 50k created)
  by some errant code in one day recently. Approvers should check that the code won't result in too many custom resources
  being created - think about the complexity (is it linear, polynomial, exponential etc.). If a lot of custom resources are
  being created, then ensure there is some form of garbage collection.
* Pushing secrets to source control. Validate that the code doesn't risk pushing secrets
* Non-intuitive behavior that doesn't have a comment. We don't require comments for code that is logical and makes sense
  but sometimes we have to write code in a certain way to deal with external circumstances. You can easily identify this
  kind of code - if your reactions is "WTF" then it probably needs a comment. On the other hand if your reaction is
  "I don't understand this" then that's not a good indication of non-intuitive code!

**Security review** should be requested for any changes in security sensitive areas such as secrets handling with or without
vault, authentication/authorization, cloud service accounts and permissions, commands dealing with credentials, changes to
RBAC rules in various helm charts, changes to TLS configuration and so on.

Non automated checks currently include:
* for a PR that includes a new feature, ensure that there is an associated PR for documentation
* That the commit message type (i.e. `fix`, `chore`, `feat` or `BREAKING CHANGE`) is correct as this will affect the release number used.
* Changes introduced to debug or test the PR being committed (e.g. changes to the test repo in use)

As an approver there are a number of traps it's very easy to fall into when reviewing a pull request. We regard these as
bad behaviors and a PR author or another community member should call out an approver if one of these behaviors is noticed:

* requesting stylistic changes - "That's not how **I** would have done it!", "Could you rename that variable/func/package
  to `XXX`". As an approver you normally have the ability to edit the PR directly, you should make any changes like this
  yourself.
* requesting trivial changes. As an approver you normally have the ability to edit the PR directly, you should make any
  changes like this yourself.
* Requesting clarification of how something works. This is unhelpful as PR discussions are essentially lost when the PR
  is merged. If you don't understand how something works, puzzle over it for 5 minutes, clone the branch, run a test and
  use your debugger. If you are still struggling then ask the author on slack and explain why you can't understand it. The
  author should then update the PR either with some comments or different code. You should also post a short summary back
  on to the PR, focusing on the "why" - in other words why were you confused and why did the change fix it.
* Discussions about a change. If you need to discuss a change, then use #jenkins-x-dev on slack or do a call
  (advertising it on slack ideally). Once you've got a conclusion make a quick note of that on the PR.
* Tangents. There are many problems in the codebase, but don't be tempted to try to solve all of them in a review. Focus
  on what problems this PR will cause.

Above all, remember that as an approver your role is not to make the code into something that you would have written
but to check it won't cause a problem.

# Future Enhancements Planned

* Switch config on all repos to use `lgtm` plugin not `approval` plugin, except those with the `proof-of-concept` label
* Consider using something like https://pullpanda.com/assigner to allocate reviewers automatically
* Add code coverage tools and implement a ratchet. For example, if the overall coverage is 40% then the coverage of the
  change would have to be 50%. We will decide the size of the ratchet as part of this. The goal here is to steadily
  improve the coverage
