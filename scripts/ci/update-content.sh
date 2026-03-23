#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pushd content/en/community/labs/enhancements
  git checkout master
  git pull
popd
