#!/bin/bash

if [ -z "$GITHUB_ACTIONS" ]
then
  echo "not setting up git as not in a GitHub Action"
else
  echo "lets setup git"
  git config user.name github-actions
  git config user.email github-actions@github.com
fi

git clone https://github.com/jenkins-x-plugins/jx-plugin-doc

cd jx-plugin-doc
make build
cd ..

echo "build the tool"

ls -al jx-plugin-doc/build

DIR=$(pwd)

jx-plugin-doc/build/jx-plugin-doc $DIR

echo "run the generator"

git add content/en/v3/develop/reference/jx/
git status

if [ -z "$DISABLE_COMMIT" ]
then
    echo "adding generated content"
    git commit -a -m "chore: regenerated plugin docs"
    git push
else
    echo "disabled commiting changes"
fi