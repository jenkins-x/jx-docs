---
title: Golang upgrades
linktitle: Golang upgrades
description: Updating golang version for jenkins x
weight: 200
type: docs
no_list: true
---

Jenkins X codebase uses Golang/Go.
New versions of golang comes every 6 months, and golang supports only [2 versions](https://endoflife.date/go).
It is highly desireable to use the latest and greatest version of golang for Jenkins X as newer versions have performance improvements and get regular security updates.

To update golang version in Jenkins X follow these steps

- Open an issue in jx repository announcing the upgrade.
- Change the go version in the pipeline catalog repository.
  See this [PR](https://github.com/jenkins-x/jx3-pipeline-catalog/pull/1162) for which files to change.
- Update the catalog version in the version stream
  See this [PR](https://github.com/jenkins-x/jx3-versions/pull/3240) for which files to change.
- Update the library packages first (please follow this order)
  - [jx-kube-client](https://github.com/jenkins-x/jx-kube-client)
  - [go-scm](https://github.com/jenkins-x/go-scm)
  - [logrus-stackdriver-formatter](https://github.com/jenkins-x/logrus-stackdriver-formatter)
  - [jx-logging](https://github.com/jenkins-x/jx-logging)
  - [jx-api](https://github.com/jenkins-x/jx-api)
  - [jx-helpers](https://github.com/jenkins-x/jx-helpers)
  - [secretfacade](https://github.com/jenkins-x-plugins/secretfacade)
- Once these packages are upgraded, start the upgrade for the plugins and main jx repository
- Follow these steps to upgrade the version
  - Change the version in go.mod file
  - Upgrade any direct dependencies to other Jenkins X packages that you see in go.mod: If you for example find the line `github.com/jenkins-x/jx-logging/v3 v3.0.7` you run go get -u github.com/jenkins-x/jx-logging/v3
  - Run `go mod tidy` and ensure that it does not error out
  - Change `GO_VERSION` in makefile to the version you are upgrading to.
  - Check if there are any references to an older version and replace those.
  - Verify that
    - the build works by running `make build`
    - tests are working, by running `make test`
    - linting checks are working by running `golangci-lint run`
      - Use the same version that is used by Jenkins X. At the time of writing that is 1.58; you can see what [image version is referenced in the pipeline](https://github.com/jenkins-x/jx3-pipeline-catalog/blob/master/tasks/go/pullrequest.yaml).
      - If there is a configuration file for golangci-lint in the repository (`.golangci.yaml`) it is likely needed to be updated. See for example https://github.com/jenkins-x/jx-kube-client/blob/main/.golangci.yml for reference. 
