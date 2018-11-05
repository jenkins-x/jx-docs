---
title: Contribute to the code
linktitle: Development
description: How to contribute to Jenkins X development.
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
categories: [contribute]
keywords: [dev,open source]
authors: [digitalcraftsman]
menu:
  docs:
    parent: "contribute"
    weight: 10
weight: 10
sections_weight: 10
draft: false
aliases: [/contribute/development/]
toc: true
---


# Introduction

Jenkins X is an open-source project and lives by the work of its [contributors](https://github.com/jenkins-x/jx/graphs/contributors). There are plenty of [open issues](https://github.com/jenkins-x/jx/issues), and we need your help to make Jenkins X even more awesome. You don't need to be a Go guru to contribute to the project's development.

# Assumptions

This contribution guide takes a step-by-step approach in hopes of helping newcomers. Therefore, we only assume the following:

* You are new to Git or open-source projects in general
* You are a fan of Jenkins X and enthusiastic about contributing to the project

{{% note %}}
If you're struggling at any point in this contribution guide, reach out to the Jenkins X community in [Jenkins X's Discussion forum](https://jenkins-x.io/community/).
{{% /note %}}

# Prerequisites

To contribute to Jenkins X jx binary, you will need:

 - [Git](https://git-scm.com) and a [GitHub](https://github.com) account
 - [Go](https://golang.org/) 1.9 or later, with support for compiling to `linux/amd64`
 - [dep](https://github.com/golang/dep)
 

## Install Go

The installation of Go should take only a few minutes. You have more than one option to get Go up and running on your machine.

If you are having trouble following the installation guides for go, check out [Go Bootcamp](http://www.golangbootcamp.com/book/get_setup) which contains setups for every platform or reach out to the Jenkins X community in the [Jenkins X Slack channels](/community/#slack).

### Install Go on macOS

If you are a macOS user and have [Homebrew](https://brew.sh/) installed on your machine, installing Go is as simple as the following command:

```shell
$ brew install go 
```

### Install Go via GVM

More experienced users can use the [Go Version Manager](https://github.com/moovweb/gvm) (GVM). GVM allows you to switch between different Go versions *on the same machine*. If you're a beginner, you probably don't need this feature. However, GVM makes it easy to upgrade to a new released Go version with just a few commands.

GVM comes in especially handy if you follow the development of Jenkins X over a longer period of time. Future versions of Jenkins X will usually be compiled with the latest version of Go. Sooner or later, you will have to upgrade if you want to keep up.

### Install Go on Windows

Simply install the latest version by downloading the [installer](https://golang.org/dl/).

### Set up your GOPATH

Once you're finished installing Go, let's confirm everything is working correctly. Open a terminal - or command line under Windows - and type the following:

```shell
$ go version
```

You should see something similar to the following written to the console (on macOS). Note that the version here reflects the most recent version of Go as of the last update for this page:

```
go version go1.11 darwin/amd64
```

Next, make sure that you set up your `GOPATH` [as described in the installation guide](https://github.com/golang/go/wiki/SettingGOPATH).

You can print the `GOPATH` with `echo $GOPATH`. You should see a non-empty string containing a valid path to your Go workspace; .e.g.:

```shell
$ echo $GOPATH
/Users/<yourusername>/Code/go
```

## Install Git on your system

Git is a [version control system](https://en.wikipedia.org/wiki/Version_control) to track the changes of source code.

You will need to have Git installed on your computer to contribute to Jenkins X development. Teaching Git is outside the scope of the Jenkins X docs, but if you're looking for an excellent reference to learn the basics of Git, we recommend the [Git book](https://git-scm.com/book/) if you are not sure where to begin.

Move back to the terminal and check if Git is already installed. Type in `git version` and press enter. You can skip the rest of this section if the command returned a version number. Otherwise [download](https://git-scm.com/downloads) the latest version and follow this [installation guide](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).

Finally, check again with `git version` if Git was installed successfully.

### Git Graphical Front Ends

There are several [GUI clients](https://git-scm.com/downloads/guis) that help you to operate Git. Not all are available for all operating systems and maybe differ in their usage. Thus, we will use the command line since the commands are everywhere the same.

### Install Hub on Your System (Optional)

Hub is a great tool for working with GitHub. The main site for it is [hub.github.com](https://hub.github.com/). Feel free to install this little Git wrapper.

On a Mac, you can install [Hub](https://github.com/github/hub) using [Homebrew](https://brew.sh):

```shell
$ brew install hub
```

Now we'll create an [alias in Bash](http://tldp.org/LDP/abs/html/aliases.html) so that typing `git` actually runs `Hub`:

```shell
$ echo "alias git='hub'" >> ~/.bash_profile
```

## Create a GitHub Account

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

```shell
$ mkdir -p $GOPATH/src/github.com/jenkins-x
$ cd $GOPATH/src/github.com/jenkins-x
$ git clone git@github.com:<username>/jx.git
$ cd jx
```

Add the conventional upstream `git` remote in order to fetch changes from jx's main master
branch and to create pull requests:

```shell
$ git remote add upstream https://github.com/jenkins-x/jx.git
```

Let's check if everything went right by listing all known remotes:

```shell
$ git remote -v
```

The output should look similar:

```
digitalcraftsman    git@github.com:digitalcraftsman/jx.git (fetch)
digitalcraftsman    git@github.com:digitalcraftsman/jx.git (push)
origin  https://github.com/jenkins-x/jx (fetch)
origin  https://github.com/jenkins-x/jx (push)
```

### Fork with Hub

Alternatively, you can use the Git wrapper Hub. Hub makes forking a repository easy:

```
hub fork
```

That command will log in to GitHub using your account, create a fork of the repository that you're currently working in, and add it as a remote to your working copy.

## Contribution Workflow

### Create a new branch

First, ensure that your local repository is up-to-date with the latest version of jx. More details on [GitHub help](https://help.github.com/articles/syncing-a-fork/)

```shell
$ git fetch upstream
$ git checkout master
$ git merge upstream/master
```

Now you can create a new branch for your change:

```shell
$ git checkout -b <BRANCH-NAME>
```

You can check on which branch your are with `git branch`. You should see a list of all local branches. The current branch is indicated with a little asterisk.

### General Development

#### Cross-platform Development

Bear in mind when developing that the code can (and will) run on different architectures/operating systems from your own. You may develop on a *nix platform, but other users will also be using Windows. Keep other platforms in mind when developing your code, eg:
* Not all platforms use the `HOME` environment variable for your home directory. Use [`user.Current`](https://golang.org/pkg/os/user/#Current)[`.HomeDir`](https://golang.org/pkg/os/user/#User) instead of looking up `$HOME` to get the user's home directory
* Different platforms use different places for temporary directories/files. Use [`ioutil.TempDir`](https://golang.org/pkg/io/ioutil/#TempDir) instead of creating directories/files under `/tmp`
* Be aware of path separators (*nix uses `/`, Windows uses `\`) - do not just concantenate strings when using filepaths; instead use [`filepath.Join`](https://golang.org/pkg/path/filepath/#Join) to concatenate file paths safely
* Be aware of default line endings (*nix uses `LF`, Windows uses `CRLF`) 

### Push commits

To push our commits to the fork on GitHub you need to specify a destination. A destination is defined by the remote and a branch name. Earlier, you defined that the remote url of our fork is the same as our GitHub handle, in this case `digitalcraftsman`. The branch should have the same as our local one. This makes it easy to identify corresponding branches.

```shell
$ git push --set-upstream origin <BRANCH-NAME>
```

Now Git knows the destination. Next time when you to push commits you just need to enter `git push`.

### Build your change

With the prerequisites installed and your fork of jx cloned, you can make changes to local jx source code and hack as much as you want.

Run `make` to build the `jx` binaries:

```shell
$ make build
```
See below to get some advises on how to [test](#testing) and [debug](#debugging).

### Squash and rebase

So you are happy with your development and are ready to prepare the PR. Before going further, let's squash and rebase your work.

This is a bit more advanced but required to ensure a proper Git history of Jenkins X. Git allows you to [rebase](https://git-scm.com/docs/git-rebase) commits. In other words: it allows you to rewrite the commit history.

Let's take an example. 

```shell
$ git rebase --interactive @~3
```

The `3` at the end of the command represents the number of commits that should be modified. An editor should open and present a list of last three commit messages:

```
pick 911c35b Add "How to contribute to Jenkins X" tutorial
pick 33c8973 Begin workflow
pick 3502f2e Refactoring and typo fixes
```

In the case above we should merge the last 2 commits in the commit of this tutorial (`Add "How to contribute to Jenkins X" tutorial`). You can "squash" commits, i.e. merge two or more commits into a single one.

All operations are written before the commit message. Replace `pick` with an operation. In this case `squash` or `s` for short:

```
pick 911c35b Add "How to contribute to Jenkins X" tutorial
squash 33c8973 Begin workflow
squash 3502f2e Refactoring and typo fixes
```

We also want to rewrite the commits message of the third last commit. We forgot "docs:" as prefix according to the code contribution guidelines. The operation to rewrite a commit is called `reword` (or `r` as shortcut).

You should end up with a similar setup:

```
reword 911c35b Add "How to contribute to Jenkins X" tutorial
squash 33c8973 Begin workflow
squash 3502f2e Refactoring and typo fixes
```

Close the editor. It should open again with a new tab. A text is instructing you to define a new commit message for the last two commits that should be merged (aka "squashed"). Save the file and close the editor again.

A last time a new tab opens. Enter a new commit message and save again. Your terminal should contain a status message. Hopefully this one:

```
Successfully rebased and updated refs/heads/<BRANCH-NAME>.
```

Check the commit log if everything looks as expected. Should an error occur you can abort this rebase with `git rebase --abort`.

In case you already pushed your work to your fork, you need to make a force push

```shell
$ git push --force
```
Last step, to ensure that your change would not conflict with other changes done in parallel by other contributors, you need to rebase your work on the latest changes done on jx master branch. Simply:

```shell
$ git checkout master #Move to local master branch
$ git fetch upstream #Retrieve change from jx master bracnch
$ git merge upstream/master #Merge the change into your local master
$ git checkout <BRANCH-NAME> #Move back to your local branch where you did your development
$ git rebase master

```
Handle any conflicts and make sure your code builds and all tests pass. Then force push your branch to your remote.

## Open a pull request

We made a lot of progress. Good work. In this step we finally open a pull request to submit our additions. Open the [Jenkins X master repository](https://github.com/jenkins-x/jx/) on GitHub in your browser.

You should find a green button labeled with "New pull request". But GitHub is clever and probably suggests you a pull request like in the beige box below:

![Open a pull request](/images/contribute/development/open-pull-request.png)

The new page summaries the most important information of your pull request. Scroll down and you find the additions of all your commits. Make sure everything looks as expected and click on "Create pull request".

Then Jenkins X itself and the maintainers will review your PR, potentially initiate discussion around your change and finally, merge it successfully in Jenkins X jx. Congratulations !

## Testing

The jx test suite is divided into three sections:
 - The standard unit test suite
 - Slow unit tests
 - Integration tests

To run the standard test suite:
```$ make test```

To run the standard test suite including slow running tests:
```$ make test-slow```

To run all tests including integration tests (NOTE These tests are not encapsulated):
```$ make test-slow-integration```

To get a nice HTML report on the tests:
```$ make test-report-html```

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
```shell
$ go generate ./...
```
or
```shell
$ make generate
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

```shell 
export JX_TEST_DEBUG=true
```

## Debugging

First you need to [install Delve](https://github.com/derekparker/delve/blob/master/Documentation/installation/README.md).

Then you should be able to run a debug version of a jx command:

```shell
dlv --listen=:2345 --headless=true --api-version=2 exec ./build/jx -- some arguments
```

Then, in your IDE you should be able to set a breakpoint and connect to `2345` e.g. in IntelliJ you create a new `Go Remote` execution and then hit `Debug`.

### Debugging jx with stdin

If you want to debug using `jx` with `stdin` to test out terminal interaction, you can start `jx` as usual from the command line then:

1. Find the `pid` of the jx command via something like `ps -elaf | grep jx`
2. Start Delve, attaching to the pid:

	```shell
	dlv --listen=:2345 --headless=true --api-version=2 attach SomePID
	```

### Debugging a unit test

You can run a single unit test via:

```shell
export TEST="TestSomething"
make test1
```

You can then start a Delve debug session on a unit test via:

```shell
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