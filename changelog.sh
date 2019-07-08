#!/usr/bin/env bash
jx step changelog  --verbose --version ${VERSION} --rev ${PULL_BASE_SHA}
