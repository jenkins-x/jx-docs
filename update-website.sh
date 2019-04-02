#!/bin/bash

pushd jenkins-x-website
  jx step git credentials
  git config credential.helper store
  git add -A
  git commit --allow-empty -a -m "updated site"
  git push origin
popd

