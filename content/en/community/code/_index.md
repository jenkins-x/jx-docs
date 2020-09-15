---
title: Contribute code
linktitle: Contribute Code
description: How to contribute code to Jenkins X development.
authors: [digitalcraftsman]
weight: 20
type: docs
no_list: true
aliases:
    - /docs/contributing/
---

## Introduction

Jenkins X is an open-source project and lives by the work of its [contributors](https://github.com/jenkins-x/jx/graphs/contributors). There are plenty of [open issues](https://github.com/jenkins-x/jx/issues), and we need your help to make Jenkins X even more awesome. You don't need to be a Go guru to contribute to the project's development.

## Assumptions

This contribution guide takes a step-by-step approach in hopes of helping newcomers. Therefore, we only assume the following:

* You are new to Git or open-source projects in general
* You are a fan of Jenkins X and enthusiastic about contributing to the project

{{< alert >}}
If you're struggling at any point in this contribution guide, reach out to the Jenkins X community in [Jenkins X's Discussion forum](/community/).
{{< /alert >}}

## Prerequisites

To contribute to Jenkins X jx binary, you will need:

* [Git](https://git-scm.com) and a [GitHub](https://github.com) account
* [Go](https://golang.org/) `1.13.8`, with support for compiling to `linux/amd64`
* [pre-commit](https://pre-commit.com/#install) - once installed, ensure you're at the root of the repository which contains a `.pre-commit-config.yaml` configuration file, then:

```sh
pre-commit install
```

### Install Go

We recommend `1.13.8` version of go as the pull request checks run against this version.

The installation of Go should take only a few minutes. You have more than one option to get Go up and running on your machine.

If you are having trouble following the installation guides for go, check out [Go Bootcamp](http://www.golangbootcamp.com/book/get_setup) which contains setups for every platform or reach out to the Jenkins X community in the [Jenkins X Slack channels](/community/#slack).

#### Install Go on macOS

If you are a macOS user and have [Homebrew](https://brew.sh/) installed on your machine, installing Go is as simple as the following command:

```sh
brew install go
```

#### Install Go via GVM

More experienced users can use the [Go Version Manager](https://github.com/moovweb/gvm) (GVM). GVM allows you to switch between different Go versions *on the same machine*. If you're a beginner, you probably don't need this feature. However, GVM makes it easy to upgrade to a new released Go version with just a few commands.

GVM comes in especially handy if you follow the development of Jenkins X over a longer period of time. Future versions of Jenkins X will usually be compiled with the latest version of Go. Sooner or later, you will have to upgrade if you want to keep up.

#### Install Go on Windows

Simply install the latest version by downloading the [installer](https://golang.org/dl/).

### Clearing your go module cache

If you have used an older version of go you may have old versions of go modules. So its good to run this command to clear your cache if you are having go build issues:

```sh
go clean -modcache
```

### Set up your GOPATH

Once you're finished installing Go, let's confirm everything is working correctly. Open a terminal - or command line under Windows - and type the following:

```sh
go version
```

You should see something similar to the following written to the console (on macOS). Note that the version here reflects the most recent version of Go as of the last update for this page:

```sh
go version go1.11 darwin/amd64
```

Next, make sure that you set up your `GOPATH` [as described in the installation guide](https://github.com/golang/go/wiki/SettingGOPATH).

You can print the `GOPATH` with `echo $GOPATH`. You should see a non-empty string containing a valid path to your Go workspace; .e.g.:

```sh
$ echo $GOPATH
/Users/<yourusername>/Code/go
```

### Install Git on your system

Git is a [version control system](https://en.wikipedia.org/wiki/Version_control) to track the changes of source code.

You will need to have Git installed on your computer to contribute to Jenkins X development. Teaching Git is outside the scope of the Jenkins X docs, but if you're looking for an excellent reference to learn the basics of Git, we recommend the [Git book](https://git-scm.com/book/) if you are not sure where to begin.

Move back to the terminal and check if Git is already installed. Type in `git version` and press enter. You can skip the rest of this section if the command returned a version number. Otherwise [download](https://git-scm.com/downloads) the latest version and follow this [installation guide](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).

Finally, check again with `git version` if Git was installed successfully.

#### Git Graphical Front Ends

There are several [GUI clients](https://git-scm.com/downloads/guis) that help you to operate Git. Not all are available for all operating systems and maybe differ in their usage. Thus, we will use the command line since the commands are everywhere the same.

#### Install Hub on Your System (Optional)

Hub is a great tool for working with GitHub. The main site for it is [hub.github.com](https://hub.github.com/). Feel free to install this little Git wrapper.

On a Mac, you can install [Hub](https://github.com/github/hub) using [Homebrew](https://brew.sh):

```sh
brew install hub
```

Now we'll create an [alias in Bash](http://tldp.org/LDP/abs/html/aliases.html) so that typing `git` actually runs `Hub`:

```sh
echo "alias git='hub'" >> ~/.bash_profile
```

### Create a GitHub Account

If you're going to contribute code, you'll need to have an account on GitHub. Go to [www.github.com/join](https://github.com/join) and set up a personal account.

## Set up your working copy

The working copy is set up locally on your computer. It's what you'll edit, compile, and end up pushing back to GitHub. The main steps are cloning the repository and creating your fork as a remote.

### Fork the repository

If you're not familiar with this term, GitHub's [help pages](https://help.github.com/articles/fork-a-repo/) provide again a simple explanation:

> A fork is a copy of a repository. Forking a repository allows you to freely experiment with changes without affecting the original project.

Open the [Jenkins X repository](https://github.com/jenkins-x/jx) on GitHub and click on the "Fork" button in the top right.

![Fork button](/images/contribute/development/forking-a-repository.png)

### Clone your fork locally

Now open your fork repository on GitHub and copy the remote url of your fork. You can choose between HTTPS and SSH as protocol that Git should use for the following operations. HTTPS works always [if you're not sure](https://help.github.com/articles/which-remote-url-should-i-use/).

![Copy remote url](/images/contribute/development/copy-remote-url.png)

Then go back to your terminal and clone your fork locally. Since jx is a Go package, it should be located at `$GOPATH/src/github.com/jenkins-x/jx`.

```sh
mkdir -p $GOPATH/src/github.com/jenkins-x
cd $GOPATH/src/github.com/jenkins-x
git clone git@github.com:<YOUR_USERNAME>/jx.git
cd jx
```

Add the conventional upstream `git` remote in order to fetch changes from jx's main master
branch and to create pull requests:

```sh
git remote add upstream https://github.com/jenkins-x/jx.git
```

Let's check if everything went right by listing all known remotes:

```sh
git remote -v
```

The output should look similar to:

```sh
origin    git@github.com:<YOUR_USERNAME>/jx.git (fetch)
origin    git@github.com:<YOUR_USERNAME>/jx.git (push)
upstream  https://github.com/jenkins-x/jx.git (fetch)
upstream  https://github.com/jenkins-x/jx.git (push)
```

### Fork with Hub

Alternatively, you can use the Git wrapper Hub. Hub makes forking a repository easy:

```sh
hub fork
```

That command will log in to GitHub using your account, create a fork of the repository that you're currently working in, and add it as a remote to your working copy.

## Contribution Workflow

### Create a new branch

First, ensure that your local repository is up-to-date with the latest version of jx. More details on [GitHub help](https://help.github.com/articles/syncing-a-fork/)

```sh
git fetch upstream
git checkout master
git merge upstream/master
```

Now you can create a new branch for your change:

```sh
git checkout -b <BRANCH-NAME>
```

You can check on which branch your are with `git branch`. You should see a list of all local branches. The current branch is indicated with a little asterisk.

### General Development

#### Cross-platform Development

Bear in mind when developing that the code can (and will) run on different architectures/operating systems from your own. You may develop on a *nix platform, but other users will also be using Windows. Keep other platforms in mind when developing your code, eg:

* Not all platforms use the `HOME` environment variable for your home directory. Use [`user.Current`](https://golang.org/pkg/os/user/#Current)[`.HomeDir`](https://golang.org/pkg/os/user/#User) instead of looking up `$HOME` to get the user's home directory
* Different platforms use different places for temporary directories/files. Use [`ioutil.TempDir`](https://golang.org/pkg/io/ioutil/#TempDir) instead of creating directories/files under `/tmp`
* Be aware of path separators (*nix uses `/`, Windows uses `\`) - do not just concatenate strings when using filepaths; instead use [`filepath.Join`](https://golang.org/pkg/path/filepath/#Join) to concatenate file paths safely
* Be aware of default line endings (*nix uses `LF`, Windows uses `CRLF`)

### Push commits

To push our commits to the fork on GitHub you need to specify a destination. A destination is defined by the remote and a branch name. Earlier, the remote url of our fork was given the default name of `origin`. The branch should be given the same name as our local one. This makes it easy to identify corresponding branches.

```sh
git push --set-upstream origin <BRANCH-NAME>
```

Now Git knows the destination. Next time when you to push commits you just need to enter `git push`.

### Build your change

With the prerequisites installed and your fork of jx cloned, you can make changes to local jx source code and hack as much as you want.

Run `make` to build the `jx` binaries:

```sh
make build
```

See below to get some advises on how to [test](#testing) and [debug](#debugging).

### Squash and rebase

So you are happy with your development and are ready to prepare the PR. Before going further, let's squash and rebase your work.

This is a bit more advanced but required to ensure a proper Git history of Jenkins X. Git allows you to [rebase](https://git-scm.com/docs/git-rebase) commits. In other words: it allows you to rewrite the commit history.

Let's take an example.

```sh
git rebase --interactive @~3
```

The `3` at the end of the command represents the number of commits that should be modified. An editor should open and present a list of last three commit messages:

```sh
pick 911c35b Add "How to contribute to Jenkins X" tutorial
pick 33c8973 Begin workflow
pick 3502f2e Refactoring and typo fixes
```

In the case above we should merge the last 2 commits in the commit of this tutorial (`Add "How to contribute to Jenkins X" tutorial`). You can "squash" commits, i.e. merge two or more commits into a single one.

All operations are written before the commit message. Replace `pick` with an operation. In this case `squash` or `s` for short:

```sh
pick 911c35b Add "How to contribute to Jenkins X" tutorial
squash 33c8973 Begin workflow
squash 3502f2e Refactoring and typo fixes
```

We also want to rewrite the commits message of the third last commit. We forgot "docs:" as prefix according to the code contribution guidelines. The operation to rewrite a commit is called `reword` (or `r` as shortcut).

You should end up with a similar setup:

```sh
reword 911c35b Add "How to contribute to Jenkins X" tutorial
squash 33c8973 Begin workflow
squash 3502f2e Refactoring and typo fixes
```

Close the editor. It should open again with a new tab. A text is instructing you to define a new commit message for the last two commits that should be merged (aka "squashed"). Save the file and close the editor again.

A last time a new tab opens. Enter a new commit message and save again. Your terminal should contain a status message. Hopefully this one:

```sh
Successfully rebased and updated refs/heads/<BRANCH-NAME>.
```

Check the commit log if everything looks as expected. Should an error occur you can abort this rebase with `git rebase --abort`.

In case you already pushed your work to your fork, you need to make a force push

```sh
git push --force
```

Last step, to ensure that your change would not conflict with other changes done in parallel by other contributors, you need to rebase your work on the latest changes done on jx master branch. Simply:

```sh
git checkout master #Move to local master branch
git fetch upstream #Retrieve change from jx master bracnch
git merge upstream/master #Merge the change into your local master
git checkout <BRANCH-NAME> #Move back to your local branch where you did your development
git rebase master
```

Handle any conflicts and make sure your code builds and all tests pass. Then force push your branch to your remote.

### Signoff

A [Developer Certificate of Origin](https://en.wikipedia.org/wiki/Developer_Certificate_of_Origin) is required for all
commits. It can be proivided using the [signoff](https://git-scm.com/docs/git-commit#Documentation/git-commit.txt---signoff)
option for `git commit` or by GPG signing the commit. The developer certificate is available at (https://developercertificate.org/).

Jenkins X enforces the DCO using the a [bot](https://github.com/probot/dco). You can view the details on the DCO check
by viewing the `Checks` tab in the GitHub pull request.

![DCO signoff check](https://user-images.githubusercontent.com/13410355/42352794-85fe1c9c-8071-11e8-834a-05a4aeb8cc90.png)

#### How to Sign Your Commits

There are a couple of ways to ensure your commits are signed. 
Described below are three different ways to sign your commits: using git signoff, using GPG, or using webhooks.

##### Git signoff
Git signoff adds a line to your commit message with the user.name and user.email values from your git config. 
Use git signoff by adding the `--signoff` or `-s` flag when creating your commit. 
This flag must be added to each commit you would like to sign.

```sh
git commit -m -s "docs: my commit message"
```

If you'd like to keep your personal email address private, you can use a GitHub-provided `no-reply` email address as your commit email address. 
GitHub provides [good instructions on setting your commit email address](https://docs.github.com/en/github/setting-up-and-managing-your-github-user-account/setting-your-commit-email-address).

##### GPG sign your commits
A more secure alternative is to GPG sign all your commits. 
This has the advantage that as well as stating your agreement to the DCO it also creates a trust mechanism for your commits. 
There is a good guide from GitHub on how to set this up:

1) If you don't already have a GPG key, then follow [this guide to create one](https://help.github.com/en/articles/generating-a-new-gpg-key).
2) Now you have a GPG key, tell [tell GitHub about your key so that it can verify your commits](https://help.github.com/en/articles/adding-a-new-gpg-key-to-your-github-account). 
Once you upload your public gpg key to your GitHub account, GitHub will mark commits that you sign with the `verified` label.
3) To sign commits locally, you can add the `-S` flag when creating your commit. 
For more information on signing commits locally, follow [this guide to see how to sign your commit](https://help.github.com/en/articles/signing-commits).

4) You can configure git to always use signed commits by running

```sh
git config --global user.signingkey <key id>
```

The process to find the key id is described in [this guide on checking for existing GPG keys](https://help.github.com/en/articles/checking-for-existing-gpg-keys).

5) Set up a keychain for your platform. 
This is entirely optional but means you don't need to type your passphrase every time and allows git to run headless. 
If you are using a Mac GPG Suite is a good way to do this. If you are on another platform please open a PR against this document and add your recommendations!

##### Use a webhook to sign your commits
Alternatively, you can use a hook to make sure all your commits messages are signed off. 
1) Run:
```sh
mkdir -p ~/.git-templates/hooks
```
```sh
git config --global init.templatedir ~/.git-templates
```

2) Then add this to `~/.git-templates/hooks/prepare-commit-msg`:

```bash
#!/bin/sh

COMMIT_MSG_FILE=$1  # The git commit file.
COMMIT_SOURCE=$2    # The current commit message.

# Add "Signed-off-by: <user> <email>" to every commit message.
SOB=$(git var GIT_COMMITTER_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
git interpret-trailers --in-place --trailer "$SOB" "$COMMIT_MSG_FILE"
if test -z "$COMMIT_SOURCE"; then
/usr/bin/perl -i.bak -pe 'print "\n" if !$first_line++' "$COMMIT_MSG_FILE"
fi
```

3) Make sure the file is executable:
```sh
chmod u+x ~/.git-templates/hooks/prepare-commit-msg
```

4) Run `git init` on the repo you want to use the hook on.

Note that this will not override the hooks already defined on your local repo. It adds the `Signed-off-by: ...` line
after the commit message has been created by the user.


### The commit message

Jenkins X uses [conventional commits](https://www.conventionalcommits.org/en/v1.0.0-beta.4/) as it's commit message format. These are particularly important as semantic releases are in use, and they use the commit messages to determine the type of changes in the codebase. Following formalized conventions for commit messages the semantic release automatically determines the next [semantic version](https://semver.org) number and generates a changelog based on the conventional commit.

Semantic releases originate in the [Angular Commit Message Conventions](https://github.com/angular/angular.js/blob/master/DEVELOPERS.md#-git-commit-guidelines), and the rules described there are the ones used by Jenkins X.

Here is an example of the release type that will be done based on a commit messages:

| Commit message                                                                                                                                                                                   | Release type               |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------|
| `fix(pencil): stop graphite breaking when too much pressure applied`                                                                                                                             | Patch Release              |
| `feat(pencil): add 'graphiteWidth' option`                                                                                                                                                       | ~~Minor~~ Feature Release  |
| `perf(pencil): remove graphiteWidth option`<br><br>`BREAKING CHANGE: The graphiteWidth option has been removed.`<br>`The default graphite width of 10mm is always used for performance reasons.` | ~~Major~~ Breaking Release |

### Open a pull request

We made a lot of progress. Good work. In this step we finally open a pull request to submit our additions. Open the [Jenkins X master repository](https://github.com/jenkins-x/jx/) on GitHub in your browser.

You should find a green button labeled with "New pull request". But GitHub is clever and probably suggests you a pull request like in the beige box below:

![Open a pull request](/images/contribute/development/open-pull-request.png)

The new page summaries the most important information of your pull request. Scroll down and you find the additions of all your commits. Make sure everything looks as expected and click on "Create pull request".

There are a number of automated checks that will run on your PR:

* Semantic Pull Request - validates that your commit messages meet the Conventional Commit format described above.
  Additionally your PR must also have a conventional message. The UX for this bot is a little odd as it doesn't go red
  if the messages are NOT correct, instead it goes yellow. You need it to go to a green tick!
* DCO - see [Signoff](#signoff)
* Hound - lints the code and comments inline with any issues. You need this to go to a green tick and and say "No violations found. Woof!"
* lint - runs a lot more lint checks but in a CI job so won't provide inline feedback. You need this to pass as a green tick. Check the log for any errors.
* bdd - runs the end to end test [create-spring](https://github.com/jenkins-x/bdd-jx/blob/master/test/spring/jx_create_spring.go) in a new team on an existing cluster using static jenkins. Check the logs for errors.
* tekton - runs the end to end test [create-spring](https://github.com/jenkins-x/bdd-jx/blob/master/test/spring/jx_create_spring.go), [test-quickstart-golang-http](https://github.com/jenkins-x/bdd-jx/blob/master/test/quickstart/helpers.go#L50) and [test-import-golang-http-from-jenkis-x-yml](https://github.com/jenkins-x/bdd-jx/blob/master/test/_import/jx_import.go#L37) in a new cluster using tekton. Check the logs for errors.
* integration - runs all the tests that are inline in jx codebase. Check the logs for errors.
* tide - performs the merge when all the checks pass. Don't worry about the state of this one, it doesn't add much info.
  Clicking on the details link is very helpful as it will take you to the dashboard where you can navigate to the "Tide"
  screen and check the status of your PR in the merge queue.

Then Jenkins X itself and the maintainers will review your PR, potentially initiate discussion around your change and finally, merge it successfully in Jenkins X jx. Congratulations !

### Getting a pull request merged

Now your pull request is submitted, you need to get it merged. If you aren't a regular contributor you'll need a maintainer to manually review your PR and issue a `/ok-to-test` command in a PR comment. This will trigger the automated tests. If the tests fail, you'll need to ask one of the maintainers to send you the failure log (in the future we will make these public but first we need to check we are masking all secrets).

If the tests pass you need to get a `/lgtm` from one of the reviewers (listed in the `OWNERS` file in the repository). You need a new LGTM every time you push changes. Once the tests pass and you have a LGTM for the latest changeset, your PR will be automatically merged.

Jenkins X (well, Tide, a component of Jenkins X) won't merge your changes until it has the tests passing against the *current* `HEAD` of `master` - but don't worry, whilst the tests *continue* to pass it will automatically merge your changeset into master and rerun the tests. As you can imagine, this can take a little while (a few hours) if the merge queue is long. Tide will also automatically attempt to batch up passing changes, but if the batch fails, it will resort to merging the changesets one by one.

If the retest against `HEAD` of `master` fail, then it will notify you on the pull request and you'll need to make some changes (and potentially get a new LGTM).

## Testing

The jx test suite is divided into three sections:
 - The standard unit test suite
 - Slow unit tests
 - Integration tests

To run the standard test suite:
```sh
make test
```

To run the standard test suite including slow running tests:
```sh
make test-slow
```

To run all tests including integration tests (NOTE These tests are not encapsulated):
```sh
make test-slow-integration
```

To get a nice HTML report on the tests:
```sh
make test-report-html
```

### Writing tests

#### Unit Tests

Unit tests should be isolated (see below what is an unencapsulated test), and should contain the `t.Parallel()` directive in order to keep things nice and speedy.

If you add a slow running (more than a couple of seconds) test, it needs to be wrapped like so:
```golang
if testing.Short() {
	t.Skip("skipping a_long_running_test")
} else {
	// Slow test goes here...
}
```
Slows tests can (and should) still include `t.Parallel()`.

Best practice for unit tests is to define the testing package appending _test to the name of your package, e.g. `mypackage_test` and then import `mypackage` inside your tests.
This encourages good package design and will enable you to define the exported package API in a composable way.

#### Integration Tests

To add an integration test, create a separate file for your integration tests using the naming convention `mypackage_integration_test.go` Use the same package declaration as your unit tests: `mypackage_test`. At the very top of the file before the package declaration add this custom build directive:

```golang
// +build integration
```
Note that there needs to be a blank line before you declare the package name.

This directive will ensure that integration tests are automatically separated from unit tests, and will not be run as part of the normal test suite.
You should **NOT** add `t.Parallel()` to an unencapsulated test as it may cause intermittent failures.

### What is an unencapsulated test?
A test is unencapsulated (not isolated) if it cannot be run (with repeatable success) without a certain surrounding state. Relying on external binaries that may not be present, writing or reading from the filesystem without care to specifically avoid collisions, or relying on other tests to run in a specific sequence for your test to pass are all examples of a test that you should carefully consider before committing. If you would like to easily check that your test is isolated before committing simply run: `make docker-test`, or if your test is marked as slow: `make docker-test-slow`. This will mount the jx project folder into a golang docker container that does not include any of your host machines environment. If your test passes here, then you can be happy that the test is encapsulated.

### Mocking / Stubbing
<a name="mocking--stubbing"></a>

Mocking or stubbing methods in your unit tests will get you a long way towards test isolation. Coupled with the use of interface based APIs you should be able to make your methods easily testable and useful to other packages that may need to import them.
[Pegomock](https://github.com/petergtz/pegomock) is our current mocking library of choice, mainly because it is very easy to use and doesn't require you to write your own mocks (Yay!)
We place all interfaces for each package in a file called `interface.go` in the relevant folder. So you can find all interfaces for `github.com/jenkins-x/jx/pkg/util` in `github.com/jenkins-x/jx/pkg/util/interface.go`
Generating/regenerating a mock for a given interface is easy, just go to the `interface.go` file that corresponds with the interface you would like to mock and add a comment directly above your interface definition that will look something like this:
```golang
// CommandInterface defines the interface for a Command
//go:generate pegomock generate github.com/jenkins-x/jx/pkg/util CommandInterface -o mocks/command_interface.go
type CommandInterface interface {
	DidError() bool
	DidFail() bool
	Error() error
	Run() (string, error)
	RunWithoutRetry() (string, error)
	SetName(string)
	SetDir(string)
	SetArgs([]string)
	SetTimeout(time.Duration)
	SetExponentialBackOff(*backoff.ExponentialBackOff)
}
```
In the example you can see that we pass the generator to use: `pegomock generate` the package path name: `github.com/jenkins-x/jx/pkg/util` the name of the interface: `CommandInterface` and finally an output directive to write the generated file to a mock sub-folder. To keep things nice and tidy it's best to write each mocked interface to a separate file in this folder. So in this case: `-o mocks/command_interface.go`

Now simply run:
```sh
go generate ./...
```
or
```sh
make generate-mocks
```

You now have a mock to test your new interface!
The new mock can now be imported into your test file and used for easy mocking/stubbing.
Here's an example:
```golang
package util_test

import (
	"errors"
	"testing"

	"github.com/jenkins-x/jx/pkg/util"
	mocks "github.com/jenkins-x/jx/pkg/util/mocks"
	. "github.com/petergtz/pegomock"
	"github.com/stretchr/testify/assert"
)

func TestJXBinaryLocationSuccess(t *testing.T) {
	t.Parallel()
	commandInterface := mocks.NewMockCommandInterface()
	When(commandInterface.RunWithoutRetry()).ThenReturn("/test/something/bin/jx", nil)

	res, err := util.JXBinaryLocation(commandInterface)
	assert.Equal(t, "/test/something/bin", res)
	assert.NoError(t, err, "Should not error")
}
```
Here we're importing the mock we need in our import declaration:
```golang
mocks "github.com/jenkins-x/jx/pkg/util/mocks"
```
Then inside the test we're instantiating `NewMockCommandInterface` which was automatically generated for us by pegomock.

Next we're stubbing something that we don't actually want to run when we execute our test. In this case we don't want to make a call to an external binary as that could break our tests isolation. We're using some handy matchers which are provided by pegomock, and importing using a `.` import to keep the syntax neat (You probably shouldn't do this outside of tests):
```golang
When(commandInterface.RunWithoutRetry()).ThenReturn("/test/something/bin/jx", nil)
```
Now when we can set up our  test using the mock interface and make assertions as normal.


### Debug logging

Lots of the test have debug output to try figure out when things fail. You can enable verbose debug logging for tests via:

```sh
export JX_TEST_DEBUG=true
```

## Debugging

First you need to [install Delve](https://github.com/derekparker/delve/blob/master/Documentation/installation/README.md).

Then build a version of `jx` that is optimised for debugging

```sh
DEBUG=on make build
```

Then you should be able to run a debug version of a jx command:

```sh
dlv --listen=:2345 --headless=true --api-version=2 exec ./build/jx -- some arguments
```

Then, in your IDE you should be able to set a breakpoint and connect to `2345` e.g. in IntelliJ you create a new `Go Remote` execution and then hit `Debug`.

### Debugging jx with stdin

If you want to debug using `jx` with `stdin` to test out terminal interaction, you can start `jx` as usual from the command line then:

1. Find the `pid` of the jx command via something like `ps -elaf | grep jx`
2. Start Delve, attaching to the pid:

	```sh
	dlv --listen=:2345 --headless=true --api-version=2 attach SomePID
	```

### Debugging jx boot pipeline

If you want to debug a pipeline, for example `install-vault` pipeline you'll have to change the args and command in `jenkins-x.yml` file in the boot config directory:

1. Change the command to `dlv`.
2. Add `dlv` args and `jx` as args.

```yml
- args:
- --listen=:2345
- --headless=true
- --api-version=2
- exec
- <PATH-TO-jx-binary>
- --
- step
- boot
- vault
- --provider-values-dir
- ../../kubeProviders
command: dlv
dir: /workspace/source/systems/vault
name: install-vault
```

### Debugging a unit test

You can run a single unit test via:

```sh
export TEST="TestSomething"
make test1
```

You can then start a Delve debug session on a unit test via:

```sh
export TEST="TestSomething"
make debugtest1
```

Then set breakpoints and debug in your IDE as described in [Debugging](#debugging).

### Using a helper script

If you create a bash file called `jxDebug` as the following (replacing `SomePid` with the actual `pid`):

```bash
#!/bin/sh
echo "Debugging jx"
dlv --listen=:2345 --headless=true --api-version=2 exec `which jx` -- $*
```

Then you can change your `jx someArgs` CLI to `jxDebug someArgs` then debug it!

### Enabling Kubernetes API tracing

In some cases it can be useful to see the REST API calls made to the Kubernetes cluster.
You can enable trace by setting the environment variable `TRACE_KUBE_API` to the value "on" or "1".
For example:

```sh
TRACE_KUBE_API=on jx get apps
```

## Try a new version of jx inside a pipeline

You can usually just run `jx` locally on your laptop and can simulate being in a pipeline using environment variables and run it inside a git clone of a sample project etc. However there are times you really want to test inside an actual running pipeline - here's how:

When you create a Pull Request and its approved for test we generate preview docker images you can use inside your jenkins server pipelines for maven/go/nodejs builders.

e.g. see the `SNAPSHOT-JX_PR-$ID-$BUILD_NUMBER` images for the [jenkinsxio/builder-maven](https://hub.docker.com/r/jenkinsxio/builder-maven/tags/) image

Once you have a preview docker image you can then edit the jenkins pod template for maven/go/nodejs to use your PR’s docker image to try out your changes to jx in a jenkins pipeline. To do this

* `jx console` to open the Jenkins console
* Manage Jenkins -> Configure System
* search for builder-(maven|go|nodejs) and use the new docker image version you just built (that ends in your `PR number-buildnumber`)
* now retrigger a pipeline

We don't yet do the same for serverless jenkins images am afraid - for that you'll have to make your own Docker image replacing the `jx` binary then edit the Prow configuration (`kubectl edit cm config`).


Another approach is you can make your own docker image, then pause a pipeline and `kubectl cp` your linux build of `jx` into the docker image and `kubectl exec` or `jx rsh` into the build pod and run the `jx` command there.

## Code Generation

Jenkins X makes use of code generation to create [Mocks](#mocking--stubbing), Kubernetes Custom Resource clients, [OpenAPI spec and API Documentation](/apidocs).
The generated files, except for the HTML docs, checked into version control.
There are several `make` targets resposible for code generation.
They can be found in `Makefile.codegen`.

* `make generate` runs all generation you need to do before commiting changes
* `make generate-mocks` - generates the [Pegomocks](https://github.com/petergtz/pegomock) only
* `make generate-client` - generates the Kubernetes Custom Resource clientset only.
* `make generate-openapi` generates the [OpenAPI](https://swagger.io/specification/) spec only
* `make generate-docs` generates the HTML apidocs, and is not committed

 {{< alert >}}
 Not all files under `pkg/client/clientset/versioned/typed/jenkins.io/v1` are generated.
 The expansion files are manually maintained and need to be kept when re-generating the clientset.
 See also [clientset generation](https://github.com/kubernetes/community/blob/master/contributors/devel/sig-api-machingenerating-clientset.md) in the Kuberenetes Community repository.
 {{< /alert >}}

If you get a conflict on any of these directories or files when committing, rebasing or merging your best bet is to discard the changeset you have, and regenerate:

* `pkg/client` (`make generate-client`)
* `docs/apidocs/openapi-spec` (`make generate-openapi`)
* `**/mocks/**` (`make generate-mocks`)

As part of the PR builds we run a job to validate that the code generation is up to date.
If the code generation is not up to date (running `make generate` produces a `git diff` or untracked files) then your PR will be blocked.
