#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pushd content/en/docs/labs/enhancements
  git checkout master
  git pull
popd
