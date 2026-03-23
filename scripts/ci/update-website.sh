#!/bin/bash

git clone https://github.com/jenkins-x/jx-api
cp jx-api/schema/core.jenkins-x.io/v4beta1/requirements.json jenkins-x-website/schemas/jx-requirements.json

pushd jenkins-x-website
  jx step git credentials
  git config credential.helper store
  git add *
  git commit --allow-empty -a -m "updated site"
  git push origin
popd

