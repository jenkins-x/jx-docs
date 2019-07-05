#!/usr/bin/env bash
jx step changelog  --verbose --header-file docs/dev/changelog-header.md --version ${VERSION} --rev ${PULL_BASE_SHA}
