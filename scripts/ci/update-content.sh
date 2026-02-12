#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

pushd content/en/community/enhancements
  git checkout master
  git pull
  for r in proposals/*/README.md
  do
    mv $r ${r%/*}/_index.md
  done
popd
